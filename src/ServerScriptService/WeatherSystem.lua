--[[
    Weather System (IMPROVED - Better Rain Effects!)

    Randomly cycles through different weather conditions:
    - Clear (Sunny)
    - Rain
    - Storm (Heavy rain + dark)
    - Fog

    Location: ServerScriptService > WeatherSystem
]]

local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- Load configuration
local WeatherConfig = require(ReplicatedStorage:WaitForChild("WeatherConfig"))

-- Check if weather system enabled
if not WeatherConfig.WeatherSettings.Enabled then
    print("⏸️ Weather System is DISABLED in config")
    return
end

-- Variables
local currentWeather = "Clear"
local playerRainParts = {}  -- Track rain parts per player

--[[
    Create rain effect for a specific player (follows them around)
]]
local function createPlayerRainEffect(player)
    local character = player.Character
    if not character then return nil end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return nil end

    -- Create an invisible part above player's head
    local rainPart = Instance.new("Part")
    rainPart.Name = "PlayerRainCloud"
    rainPart.Anchored = false
    rainPart.CanCollide = false
    rainPart.Transparency = 1
    rainPart.Size = Vector3.new(50, 1, 50)  -- Cover area around player
    rainPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 30, 0)
    rainPart.Parent = Workspace

    -- Create AlignPosition to make it follow player
    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = rainPart

    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = humanoidRootPart
    attachment1.Position = Vector3.new(0, 30, 0)  -- 30 studs above player

    local alignPosition = Instance.new("AlignPosition")
    alignPosition.Attachment0 = attachment0
    alignPosition.Attachment1 = attachment1
    alignPosition.MaxForce = 50000
    alignPosition.Responsiveness = 25
    alignPosition.Parent = rainPart

    -- Create particle emitter
    local rainEmitter = Instance.new("ParticleEmitter")
    rainEmitter.Name = "RainEmitter"
    rainEmitter.Parent = rainPart

    -- Configure rain to look like actual rain drops
    rainEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"  -- Better for rain
    rainEmitter.Color = ColorSequence.new(Color3.fromRGB(150, 180, 255))  -- Blue-ish white

    -- Rain drop size
    rainEmitter.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(1, 0.1)
    })

    -- Transparency (visible drops)
    rainEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.3),
        NumberSequenceKeypoint.new(0.5, 0.4),
        NumberSequenceKeypoint.new(1, 1)
    })

    rainEmitter.Lifetime = NumberRange.new(1.5, 2)
    rainEmitter.Rate = 300  -- Will be updated based on weather
    rainEmitter.Rotation = NumberRange.new(0, 0)
    rainEmitter.RotSpeed = NumberRange.new(0, 0)
    rainEmitter.Speed = NumberRange.new(40, 50)
    rainEmitter.SpreadAngle = Vector2.new(3, 3)  -- Slight spread
    rainEmitter.VelocityInheritance = 0
    rainEmitter.Acceleration = Vector3.new(0, -20, 0)  -- Gravity
    rainEmitter.EmissionDirection = Enum.NormalId.Bottom
    rainEmitter.Enabled = false  -- Start disabled
    rainEmitter.LightEmission = 0.2

    return {Part = rainPart, Emitter = rainEmitter}
end

--[[
    Setup rain for all current players
]]
local function setupRainForAllPlayers(weatherType)
    local settings = WeatherConfig.WeatherSettings.Weather[weatherType]

    if not settings or not settings.ParticleRate then
        -- Remove all rain
        for userId, rainData in pairs(playerRainParts) do
            if rainData and rainData.Part then
                rainData.Part:Destroy()
            end
        end
        playerRainParts = {}
        return
    end

    -- Create/update rain for each player
    for _, player in pairs(Players:GetPlayers()) do
        local userId = player.UserId

        -- Remove old rain part if exists
        if playerRainParts[userId] and playerRainParts[userId].Part then
            playerRainParts[userId].Part:Destroy()
        end

        -- Create new rain
        local rainData = createPlayerRainEffect(player)
        if rainData then
            -- Apply weather settings
            rainData.Emitter.Rate = settings.ParticleRate
            rainData.Emitter.Speed = NumberRange.new(settings.ParticleSpeed, settings.ParticleSpeed + 10)
            rainData.Emitter.Size = settings.ParticleSize
            rainData.Emitter.Enabled = true

            playerRainParts[userId] = rainData

            print("🌧️ Created rain effect for player:", player.Name)
        end
    end
end

--[[
    Apply weather settings to Lighting
]]
local function applyWeatherSettings(weatherType)
    local settings = WeatherConfig.WeatherSettings.Weather[weatherType]

    if not settings then
        warn("⚠️ No settings found for weather type:", weatherType)
        return
    end

    -- Apply lighting settings
    Lighting.FogEnd = settings.FogEnd
    Lighting.FogColor = settings.FogColor
    Lighting.Brightness = settings.Brightness
    Lighting.Ambient = settings.Ambient

    -- Apply cloud cover if supported
    if Lighting:FindFirstChild("Clouds") then
        Lighting.Clouds.Cover = settings.CloudCover
    else
        -- Create Clouds instance if doesn't exist
        local clouds = Instance.new("Clouds")
        clouds.Parent = Lighting
        clouds.Cover = settings.CloudCover
        clouds.Density = 0.5
    end

    print("🌤️ Weather settings applied for: " .. weatherType)
end

--[[
    Change weather to specified type
]]
local function changeWeather(weatherType)
    if weatherType == currentWeather then
        return  -- Already this weather
    end

    print("\n🌍 Weather changing: " .. currentWeather .. " → " .. weatherType)

    currentWeather = weatherType

    -- Apply weather effects
    applyWeatherSettings(weatherType)
    setupRainForAllPlayers(weatherType)

    -- Show notification
    if WeatherConfig.Notifications.ShowWeatherChanges then
        local message = WeatherConfig.Notifications.Messages[weatherType]
        if message then
            print(message)
            -- You can fire a RemoteEvent here to show UI notification to all players
        end
    end
end

--[[
    Handle player joining (create rain for them if raining)
]]
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(1)  -- Wait for character to fully load

        -- If currently raining, create rain for this player
        if currentWeather == "Rain" or currentWeather == "Storm" then
            local settings = WeatherConfig.WeatherSettings.Weather[currentWeather]
            if settings and settings.ParticleRate then
                local rainData = createPlayerRainEffect(player)
                if rainData then
                    rainData.Emitter.Rate = settings.ParticleRate
                    rainData.Emitter.Speed = NumberRange.new(settings.ParticleSpeed, settings.ParticleSpeed + 10)
                    rainData.Emitter.Size = settings.ParticleSize
                    rainData.Emitter.Enabled = true

                    playerRainParts[player.UserId] = rainData
                    print("🌧️ Created rain for new player:", player.Name)
                end
            end
        end
    end)
end)

--[[
    Handle player leaving (cleanup their rain)
]]
Players.PlayerRemoving:Connect(function(player)
    local userId = player.UserId
    if playerRainParts[userId] and playerRainParts[userId].Part then
        playerRainParts[userId].Part:Destroy()
        playerRainParts[userId] = nil
    end
end)

--[[
    Main weather cycle loop
]]
local function startWeatherCycle()
    print("✅ Weather System started!")
    print("🔄 Change Interval: " .. WeatherConfig.WeatherSettings.ChangeInterval .. " minutes")

    -- Set initial weather
    changeWeather("Clear")

    local changeInterval = WeatherConfig.MinutesToSeconds(WeatherConfig.WeatherSettings.ChangeInterval)

    -- Main loop
    while true do
        wait(changeInterval)

        -- Get random weather based on probability
        local newWeather = WeatherConfig.GetRandomWeather()
        changeWeather(newWeather)
    end
end

-- Start the weather cycle
spawn(startWeatherCycle)

-- Global function to manually change weather (optional)
_G.ChangeWeather = function(weatherType)
    if WeatherConfig.WeatherSettings.Weather[weatherType] then
        changeWeather(weatherType)
        return true
    else
        warn("Invalid weather type:", weatherType)
        return false
    end
end

print("🌦️ Weather System loaded! (IMPROVED)")
print("Available weather types: Clear, Rain, Storm, Fog")
print("Use _G.ChangeWeather('Rain') to manually change weather")
print("💧 Rain now follows players!")
