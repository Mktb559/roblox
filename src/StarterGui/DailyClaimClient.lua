--[[
    Daily Claim Client Script (LocalScript)

    Handles:
    - UI creation dan display
    - User interactions
    - Communication dengan server
    - Animations

    Place this dalam: StarterGui > ScreenGui > LocalScript
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Wait untuk events dan config
local eventsFolder = ReplicatedStorage:WaitForChild("DailyClaimEvents")
local RequestDataEvent = eventsFolder:WaitForChild("RequestDailyClaimData")
local ClaimRewardEvent = eventsFolder:WaitForChild("ClaimDailyReward")
local DailyRewardsConfig = require(ReplicatedStorage:WaitForChild("DailyRewardsConfig"))

-- Variables
local mainGui
local claimStatus
local allRewards
local hasShownPopup = false

--[[
    Create main ScreenGui
]]
local function CreateScreenGui()
    -- Check kalau dah ada
    local existing = playerGui:FindFirstChild("DailyClaimUI")
    if existing then
        existing:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DailyClaimUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    return screenGui
end

--[[
    Create background overlay (blur/darken effect)
]]
local function CreateOverlay(parent)
    local overlay = Instance.new("Frame")
    overlay.Name = "Overlay"
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.5
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 1
    overlay.Parent = parent

    return overlay
end

--[[
    Create main popup frame
]]
local function CreatePopupFrame(parent)
    local popup = Instance.new("Frame")
    popup.Name = "PopupFrame"
    popup.Size = UDim2.new(0, 600, 0, 450)
    popup.Position = UDim2.new(0.5, 0, 0.5, 0)
    popup.AnchorPoint = Vector2.new(0.5, 0.5)
    popup.BackgroundColor3 = DailyRewardsConfig.UI.SecondaryColor
    popup.BorderSizePixel = 0
    popup.ZIndex = 2
    popup.Parent = parent

    -- Rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = popup

    -- Shadow effect
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ZIndex = 1
    shadow.Parent = popup

    return popup
end

--[[
    Create title text
]]
local function CreateTitle(parent)
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -40, 0, 60)
    title.Position = UDim2.new(0, 20, 0, 20)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = DailyRewardsConfig.UI.Title
    title.TextSize = 32
    title.TextColor3 = DailyRewardsConfig.UI.TextColor
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.ZIndex = 3
    title.Parent = parent

    return title
end

--[[
    Create day card untuk display reward
]]
local function CreateDayCard(parent, day, reward, currentDay, canClaim)
    local card = Instance.new("Frame")
    card.Name = "Day" .. day
    card.Size = UDim2.new(0, 75, 0, 100)
    card.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    card.BorderSizePixel = 0
    card.ZIndex = 3
    card.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = card

    -- Highlight kalau current day
    if day == currentDay then
        card.BackgroundColor3 = DailyRewardsConfig.UI.PrimaryColor

        -- Glow effect
        local stroke = Instance.new("UIStroke")
        stroke.Color = DailyRewardsConfig.UI.AccentColor
        stroke.Thickness = 3
        stroke.Parent = card
    elseif day < currentDay then
        -- Already claimed
        card.BackgroundColor3 = DailyRewardsConfig.UI.SuccessColor
    else
        -- Coming soon
        card.BackgroundTransparency = 0.5
    end

    -- Day number
    local dayLabel = Instance.new("TextLabel")
    dayLabel.Size = UDim2.new(1, 0, 0, 25)
    dayLabel.Position = UDim2.new(0, 0, 0, 5)
    dayLabel.BackgroundTransparency = 1
    dayLabel.Font = Enum.Font.GothamBold
    dayLabel.Text = "Day " .. day
    dayLabel.TextSize = 14
    dayLabel.TextColor3 = DailyRewardsConfig.UI.TextColor
    dayLabel.ZIndex = 4
    dayLabel.Parent = card

    -- Reward amount
    local rewardLabel = Instance.new("TextLabel")
    rewardLabel.Size = UDim2.new(1, -10, 0, 40)
    rewardLabel.Position = UDim2.new(0, 5, 0, 30)
    rewardLabel.BackgroundTransparency = 1
    rewardLabel.Font = Enum.Font.GothamBlack
    rewardLabel.Text = reward
    rewardLabel.TextSize = 20
    rewardLabel.TextColor3 = DailyRewardsConfig.UI.AccentColor
    rewardLabel.ZIndex = 4
    rewardLabel.Parent = card

    -- Coins text
    local coinsLabel = Instance.new("TextLabel")
    coinsLabel.Size = UDim2.new(1, 0, 0, 20)
    coinsLabel.Position = UDim2.new(0, 0, 0, 70)
    coinsLabel.BackgroundTransparency = 1
    coinsLabel.Font = Enum.Font.Gotham
    coinsLabel.Text = "Coins"
    coinsLabel.TextSize = 12
    coinsLabel.TextColor3 = DailyRewardsConfig.UI.TextColor
    coinsLabel.TextTransparency = 0.3
    coinsLabel.ZIndex = 4
    coinsLabel.Parent = card

    -- Status icon untuk claimed days
    if day < currentDay then
        local checkmark = Instance.new("TextLabel")
        checkmark.Size = UDim2.new(0, 30, 0, 30)
        checkmark.Position = UDim2.new(1, -35, 0, 5)
        checkmark.BackgroundTransparency = 1
        checkmark.Font = Enum.Font.GothamBold
        checkmark.Text = "✓"
        checkmark.TextSize = 24
        checkmark.TextColor3 = Color3.fromRGB(255, 255, 255)
        checkmark.ZIndex = 5
        checkmark.Parent = card
    end

    return card
end

--[[
    Create rewards grid
]]
local function CreateRewardsGrid(parent, rewards, currentDay, canClaim)
    local grid = Instance.new("Frame")
    grid.Name = "RewardsGrid"
    grid.Size = UDim2.new(1, -40, 0, 120)
    grid.Position = UDim2.new(0, 20, 0, 100)
    grid.BackgroundTransparency = 1
    grid.ZIndex = 3
    grid.Parent = parent

    -- Create layout
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Padding = UDim.new(0, 10)
    layout.Parent = grid

    -- Create cards untuk each day
    for day = 1, DailyRewardsConfig.MaxDays do
        local reward = rewards[day] or 0
        CreateDayCard(grid, day, reward, currentDay, canClaim and day == currentDay)
    end

    return grid
end

--[[
    Create claim button
]]
local function CreateClaimButton(parent, canClaim)
    local button = Instance.new("TextButton")
    button.Name = "ClaimButton"
    button.Size = UDim2.new(0, 250, 0, 60)
    button.Position = UDim2.new(0.5, 0, 0, 350)
    button.AnchorPoint = Vector2.new(0.5, 0)
    button.BackgroundColor3 = canClaim and DailyRewardsConfig.UI.SuccessColor or Color3.fromRGB(100, 100, 100)
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Font = Enum.Font.GothamBlack
    button.Text = canClaim and DailyRewardsConfig.UI.ClaimButtonText or "Already Claimed"
    button.TextSize = 24
    button.TextColor3 = DailyRewardsConfig.UI.TextColor
    button.ZIndex = 3
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = button

    -- Disable kalau cannot claim
    if not canClaim then
        button.Active = false
    end

    -- Hover effect
    if canClaim then
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 265, 0, 65)
            }):Play()
        end)

        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 250, 0, 60)
            }):Play()
        end)
    end

    return button
end

--[[
    Create close button
]]
local function CreateCloseButton(parent, callback)
    local button = Instance.new("TextButton")
    button.Name = "CloseButton"
    button.Size = UDim2.new(0, 40, 0, 40)
    button.Position = UDim2.new(1, -50, 0, 10)
    button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Font = Enum.Font.GothamBold
    button.Text = "X"
    button.TextSize = 20
    button.TextColor3 = DailyRewardsConfig.UI.TextColor
    button.ZIndex = 3
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    button.MouseButton1Click:Connect(callback)

    return button
end

--[[
    Show popup dengan animation
]]
local function ShowPopup()
    if not claimStatus or not allRewards then
        warn("No claim data available")
        return
    end

    -- Create UI
    mainGui = CreateScreenGui()
    local overlay = CreateOverlay(mainGui)
    local popup = CreatePopupFrame(mainGui)

    -- Set initial scale untuk animation
    popup.Size = UDim2.new(0, 0, 0, 0)

    -- Create UI elements
    CreateTitle(popup)
    CreateRewardsGrid(popup, allRewards, claimStatus.CurrentDay, claimStatus.CanClaim)
    local claimButton = CreateClaimButton(popup, claimStatus.CanClaim)
    local closeButton = CreateCloseButton(popup, function()
        ClosePopup()
    end)

    -- Popup animation
    TweenService:Create(popup, TweenInfo.new(DailyRewardsConfig.UI.PopupAnimationSpeed, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 600, 0, 450)
    }):Play()

    -- Handle claim button click
    if claimStatus.CanClaim then
        claimButton.MouseButton1Click:Connect(function()
            claimButton.Active = false
            claimButton.Text = "Claiming..."
            ClaimRewardEvent:FireServer()
        end)
    end
end

--[[
    Close popup dengan animation
]]
function ClosePopup()
    if mainGui then
        local popup = mainGui:FindFirstChild("PopupFrame")
        if popup then
            TweenService:Create(popup, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()

            wait(0.3)
        end

        mainGui:Destroy()
        mainGui = nil
    end
end

--[[
    Handle claim response dari server
]]
ClaimRewardEvent.OnClientEvent:Connect(function(success, data)
    if success then
        print("Claimed successfully! Reward:", data, "coins")

        -- Update UI
        if mainGui then
            local popup = mainGui:FindFirstChild("PopupFrame")
            if popup then
                local button = popup:FindFirstChild("ClaimButton")
                if button then
                    button.Text = "✓ Claimed " .. data .. " Coins!"
                    button.BackgroundColor3 = DailyRewardsConfig.UI.SuccessColor

                    -- Close after 2 seconds
                    wait(2)
                    ClosePopup()
                end
            end
        end
    else
        warn("Failed to claim:", data)
    end
end)

--[[
    Handle data response dari server
]]
RequestDataEvent.OnClientEvent:Connect(function(status, rewards)
    claimStatus = status
    allRewards = rewards

    -- Show popup kalau belum shown dan boleh claim
    if not hasShownPopup then
        hasShownPopup = true

        -- Delay sikit untuk better UX
        wait(1)
        ShowPopup()
    end
end)

--[[
    Initialize - request data dari server
]]
wait(2)  -- Wait untuk player fully loaded
RequestDataEvent:FireServer()

print("Daily Claim UI initialized!")
