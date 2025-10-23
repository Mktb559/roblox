--[[
    Day/Night Cycle System

    Automatically cycles through different times of day with
    smooth lighting transitions.

    Location: ServerScriptService > DayNightCycle
]]

local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Load configuration
local WeatherConfig = require(ReplicatedStorage:WaitForChild("WeatherConfig"))

-- Check if time cycle enabled
if not WeatherConfig.TimeSettings.Enabled then
    print("⏸️ Day/Night Cycle is DISABLED in config")
    return
end

-- Variables
local currentTimePeriod = nil
local targetLightingSettings = nil

--[[
    Apply lighting settings with smooth transition
]]
local function applyLightingSettings(settings)
    -- Gradually change lighting (for smooth transitions)
    local tweenSpeed = WeatherConfig.TimeSettings.TransitionSpeed

    -- Set properties that don't need tweening
    Lighting.FogEnd = settings.FogEnd
    Lighting.FogColor = settings.FogColor

    -- Smoothly transition Brightness, Ambient, OutdoorAmbient
    -- Note: In production, you might want to use TweenService for smoother transitions
    Lighting.Brightness = settings.Brightness
    Lighting.Ambient = settings.Ambient
    Lighting.OutdoorAmbient = settings.OutdoorAmbient
end

--[[
    Update lighting based on current time of day
]]
local function updateLighting()
    local currentTime = Lighting.ClockTime
    local timePeriod = WeatherConfig.GetTimePeriod(currentTime)

    -- Only update if time period changed
    if timePeriod ~= currentTimePeriod then
        currentTimePeriod = timePeriod

        local settings = WeatherConfig.TimeSettings.Lighting[timePeriod]
        if settings then
            applyLightingSettings(settings)

            -- Optional: Broadcast time change
            if WeatherConfig.Notifications.ShowTimeChanges then
                local message = WeatherConfig.Notifications.Messages[timePeriod]
                if message then
                    print("🕐 " .. message)
                    -- You can also fire a RemoteEvent here to show UI notifications
                end
            end

            print("🌍 Time Period: " .. timePeriod .. " (" .. math.floor(currentTime) .. ":00)")
        end
    end
end

--[[
    Main cycle loop
]]
local function startCycle()
    -- Set initial time
    Lighting.ClockTime = WeatherConfig.TimeSettings.StartTime

    -- Calculate how fast time should move
    -- CycleDuration is in minutes for full 24-hour cycle
    local cycleDuration = WeatherConfig.MinutesToSeconds(WeatherConfig.TimeSettings.CycleDuration)
    local timeIncrement = (24 / cycleDuration) -- How much to add to ClockTime each second

    print("✅ Day/Night Cycle started!")
    print("⏱️ Cycle Duration: " .. WeatherConfig.TimeSettings.CycleDuration .. " minutes")
    print("🌅 Starting Time: " .. WeatherConfig.TimeSettings.StartTime .. ":00")

    -- Initial lighting update
    updateLighting()

    -- Main loop
    while true do
        wait(1)  -- Update every second

        -- Increment time
        Lighting.ClockTime = Lighting.ClockTime + timeIncrement

        -- Wrap around 24 hours
        if Lighting.ClockTime >= 24 then
            Lighting.ClockTime = Lighting.ClockTime - 24
        end

        -- Update lighting based on new time
        updateLighting()
    end
end

-- Start the cycle
spawn(startCycle)

print("🌞🌙 Day/Night Cycle System loaded!")
