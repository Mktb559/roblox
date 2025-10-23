--[[
    Weather System

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

-- Load configuration
local WeatherConfig = require(ReplicatedStorage:WaitForChild("WeatherConfig"))

-- Check if weather system enabled
if not WeatherConfig.WeatherSettings.Enabled then
    print("⏸️ Weather System is DISABLED in config")
    return
end

-- Variables
local currentWeather = "Clear"
local rainPart = nil
local rainEmitter = nil

--[[
    Create rain effect (particle emitter attached to invisible part above map)
]]
local function createRainEffect()
    -- Remove existing rain if any
    if rainPart then
        rainPart:Destroy()
        rainPart = nil
        rainEmitter = nil
    end

    -- Create an invisible part high above the map
    rainPart = Instance.new("Part")
    rainPart.Name = "RainCloud"
    rainPart.Anchored = true
    rainPart.CanCollide = false
    rainPart.Transparency = 1
    rainPart.Size = Vector3.new(2048, 1, 2048)  -- Large area to cover map
    rainPart.Position = Vector3.new(0, 500, 0)   -- High up
    rainPart.Parent = Workspace

    -- Create particle emitter for rain
    rainEmitter = Instance.new("ParticleEmitter")
    rainEmitter.Name = "RainEmitter"
    rainEmitter.Parent = rainPart

    return rainEmitter
end

--[[
    Update rain effect based on weather settings
]]
local function updateRainEffect(weatherType)
    local settings = WeatherConfig.WeatherSettings.Weather[weatherType]

    if not settings or not settings.ParticleRate then
        -- No rain for this weather type
        if rainPart then
            rainPart:Destroy()
            rainPart = nil
            rainEmitter = nil
        end
        return
    end

    -- Create rain if doesn't exist
    if not rainEmitter then
        rainEmitter = createRainEffect()
    end

    -- Configure rain particles
    rainEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
    rainEmitter.Color = ColorSequence.new(Color3.fromRGB(200, 200, 255))
    rainEmitter.Size = settings.ParticleSize
    rainEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.5),
        NumberSequenceKeypoint.new(1, 1)
    })
    rainEmitter.Lifetime = NumberRange.new(2, 3)
    rainEmitter.Rate = settings.ParticleRate
    rainEmitter.Rotation = NumberRange.new(0, 0)
    rainEmitter.RotSpeed = NumberRange.new(0, 0)
    rainEmitter.Speed = NumberRange.new(settings.ParticleSpeed, settings.ParticleSpeed + 10)
    rainEmitter.SpreadAngle = Vector2.new(5, 5)
    rainEmitter.VelocityInheritance = 0
    rainEmitter.Acceleration = Vector3.new(0, -10, 0)
    rainEmitter.EmissionDirection = Enum.NormalId.Bottom
    rainEmitter.Enabled = true

    print("🌧️ Rain effect updated for: " .. weatherType)
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
    updateRainEffect(weatherType)

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

print("🌦️ Weather System loaded!")
print("Available weather types: Clear, Rain, Storm, Fog")
print("Use _G.ChangeWeather('Rain') to manually change weather")
