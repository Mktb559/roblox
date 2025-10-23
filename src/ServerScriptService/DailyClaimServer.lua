--[[
    Daily Claim Server Script

    Handles:
    - Data persistence dengan DataStore
    - Reward distribution
    - Streak tracking
    - Anti-cheat validation
]]

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Load configuration
local DailyRewardsConfig = require(ReplicatedStorage:WaitForChild("DailyRewardsConfig"))

-- DataStore setup
local DailyClaimDataStore = DataStoreService:GetDataStore("DailyClaimData_v1")

-- Remote Events untuk communication dengan client
local RemoteEventsFolder = Instance.new("Folder")
RemoteEventsFolder.Name = "DailyClaimEvents"
RemoteEventsFolder.Parent = ReplicatedStorage

local RequestDataEvent = Instance.new("RemoteEvent")
RequestDataEvent.Name = "RequestDailyClaimData"
RequestDataEvent.Parent = RemoteEventsFolder

local ClaimRewardEvent = Instance.new("RemoteEvent")
ClaimRewardEvent.Name = "ClaimDailyReward"
ClaimRewardEvent.Parent = RemoteEventsFolder

-- Cache untuk player data (reduce DataStore calls)
local PlayerDataCache = {}

--[[
    Get player data dari DataStore
    Returns: {
        LastClaimTime = tick() value,
        CurrentDay = number (1-7),
        TotalClaimed = number
    }
]]
local function GetPlayerData(player)
    local userId = player.UserId
    local key = "Player_" .. userId

    -- Check cache first
    if PlayerDataCache[userId] then
        return PlayerDataCache[userId]
    end

    -- Load dari DataStore
    local success, data = pcall(function()
        return DailyClaimDataStore:GetAsync(key)
    end)

    if success and data then
        PlayerDataCache[userId] = data
        return data
    else
        -- Default data untuk new players
        local defaultData = {
            LastClaimTime = 0,
            CurrentDay = 1,
            TotalClaimed = 0
        }
        PlayerDataCache[userId] = defaultData
        return defaultData
    end
end

--[[
    Save player data ke DataStore
]]
local function SavePlayerData(player, data)
    local userId = player.UserId
    local key = "Player_" .. userId

    -- Update cache
    PlayerDataCache[userId] = data

    -- Save ke DataStore
    local success, err = pcall(function()
        DailyClaimDataStore:SetAsync(key, data)
    end)

    if not success then
        warn("Failed to save data for player", player.Name, "Error:", err)
    end

    return success
end

--[[
    Calculate current claim status untuk player
    Returns: {
        CanClaim = boolean,
        CurrentDay = number,
        NextReward = number,
        TimeUntilNextClaim = number,
        StreakBroken = boolean
    }
]]
local function CalculateClaimStatus(playerData)
    local currentTime = os.time()
    local timeSinceLastClaim = currentTime - playerData.LastClaimTime

    local status = {
        CanClaim = false,
        CurrentDay = playerData.CurrentDay,
        NextReward = 0,
        TimeUntilNextClaim = 0,
        StreakBroken = false
    }

    -- Check kalau streak broken (miss lebih dari grace period)
    if timeSinceLastClaim > DailyRewardsConfig.StreakResetTime and playerData.LastClaimTime > 0 then
        status.StreakBroken = true
        status.CurrentDay = 1  -- Reset to day 1
    end

    -- Check kalau boleh claim (24 hours dah lepas)
    if timeSinceLastClaim >= DailyRewardsConfig.ClaimCooldown or playerData.LastClaimTime == 0 then
        status.CanClaim = true
        status.NextReward = DailyRewardsConfig.GetReward(status.CurrentDay)
    else
        status.TimeUntilNextClaim = DailyRewardsConfig.ClaimCooldown - timeSinceLastClaim
    end

    return status
end

--[[
    Setup leaderboard untuk Currency
]]
local function SetupLeaderboard(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player
    end

    local coins = leaderstats:FindFirstChild(DailyRewardsConfig.CurrencyName)
    if not coins then
        coins = Instance.new("IntValue")
        coins.Name = DailyRewardsConfig.CurrencyName
        coins.Value = 0
        coins.Parent = leaderstats
    end

    return coins
end

--[[
    Give reward kepada player
]]
local function GiveReward(player, amount)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local coins = leaderstats:FindFirstChild(DailyRewardsConfig.CurrencyName)
        if coins then
            coins.Value = coins.Value + amount
            return true
        end
    end
    return false
end

--[[
    Handle player join
]]
Players.PlayerAdded:Connect(function(player)
    -- Setup leaderboard
    SetupLeaderboard(player)

    -- Load player data
    local playerData = GetPlayerData(player)
    print("Player", player.Name, "daily claim data loaded. Current day:", playerData.CurrentDay)
end)

--[[
    Handle player leave (save data)
]]
Players.PlayerRemoving:Connect(function(player)
    local userId = player.UserId

    -- Save data kalau ada dalam cache
    if PlayerDataCache[userId] then
        SavePlayerData(player, PlayerDataCache[userId])
        PlayerDataCache[userId] = nil
    end
end)

--[[
    Handle request untuk daily claim data dari client
]]
RequestDataEvent.OnServerEvent:Connect(function(player)
    local playerData = GetPlayerData(player)
    local status = CalculateClaimStatus(playerData)

    -- Send data balik ke client
    RequestDataEvent:FireClient(player, status, DailyRewardsConfig.Rewards)
end)

--[[
    Handle claim request dari client
]]
ClaimRewardEvent.OnServerEvent:Connect(function(player)
    local playerData = GetPlayerData(player)
    local status = CalculateClaimStatus(playerData)

    -- Validate kalau boleh claim
    if not status.CanClaim then
        warn("Player", player.Name, "attempted to claim but cannot claim yet")
        ClaimRewardEvent:FireClient(player, false, "Cannot claim yet!")
        return
    end

    -- Calculate reward
    local reward = status.NextReward

    -- Give reward
    local success = GiveReward(player, reward)

    if success then
        -- Update player data
        playerData.LastClaimTime = os.time()
        playerData.TotalClaimed = playerData.TotalClaimed + reward

        -- Increment day (reset to 1 kalau dah complete 7 days)
        if status.CurrentDay >= DailyRewardsConfig.MaxDays then
            playerData.CurrentDay = 1  -- Reset untuk start new cycle
        else
            playerData.CurrentDay = status.CurrentDay + 1
        end

        -- Save data
        SavePlayerData(player, playerData)

        -- Notify client
        ClaimRewardEvent:FireClient(player, true, reward)
        print("Player", player.Name, "claimed Day", status.CurrentDay, "reward:", reward, DailyRewardsConfig.CurrencyName)
    else
        ClaimRewardEvent:FireClient(player, false, "Failed to give reward")
    end
end)

--[[
    Auto-save loop (save semua player data setiap 5 minit)
]]
game:BindToClose(function()
    -- Save semua player data sebelum server shutdown
    for _, player in pairs(Players:GetPlayers()) do
        local userId = player.UserId
        if PlayerDataCache[userId] then
            SavePlayerData(player, PlayerDataCache[userId])
        end
    end
    wait(2)  -- Give time untuk DataStore save
end)

print("Daily Claim Server initialized!")
