--[[
    Weather & Time Cycle Configuration Module

    Customize day/night cycle dan weather system settings
]]

local WeatherConfig = {}

-- ============================================
-- TIME CYCLE SETTINGS
-- ============================================

WeatherConfig.TimeSettings = {
    -- Enable/Disable time cycle
    Enabled = true,

    -- Cycle duration dalam minit (real-time minutes untuk complete 24-hour cycle)
    -- 10 = 10 minit real-time untuk 1 full day cycle
    CycleDuration = 10,  -- Minutes

    -- Starting time (dalam Roblox format: 0-24)
    -- 6 = 6 AM (pagi)
    StartTime = 6,

    -- Smooth transition speed
    -- Higher = faster transitions, Lower = smoother
    TransitionSpeed = 0.05,

    -- Time-specific lighting settings
    Lighting = {
        -- Dawn (5 AM - 7 AM)
        Dawn = {
            Ambient = Color3.fromRGB(150, 150, 150),
            OutdoorAmbient = Color3.fromRGB(180, 140, 120),
            Brightness = 1.5,
            FogEnd = 1000,
            FogColor = Color3.fromRGB(192, 192, 192),
        },

        -- Day (7 AM - 5 PM)
        Day = {
            Ambient = Color3.fromRGB(180, 180, 180),
            OutdoorAmbient = Color3.fromRGB(127, 127, 127),
            Brightness = 2,
            FogEnd = 2000,
            FogColor = Color3.fromRGB(200, 200, 200),
        },

        -- Dusk (5 PM - 7 PM)
        Dusk = {
            Ambient = Color3.fromRGB(100, 100, 120),
            OutdoorAmbient = Color3.fromRGB(150, 100, 80),
            Brightness = 1.5,
            FogEnd = 800,
            FogColor = Color3.fromRGB(180, 120, 100),
        },

        -- Night (7 PM - 5 AM)
        Night = {
            Ambient = Color3.fromRGB(50, 50, 70),
            OutdoorAmbient = Color3.fromRGB(60, 60, 100),
            Brightness = 0.5,
            FogEnd = 500,
            FogColor = Color3.fromRGB(30, 30, 50),
        },
    }
}

-- ============================================
-- WEATHER SYSTEM SETTINGS
-- ============================================

WeatherConfig.WeatherSettings = {
    -- Enable/Disable weather system
    Enabled = true,

    -- Weather change interval (dalam minit)
    -- Berapa minit sebelum tukar weather
    ChangeInterval = 3,  -- Minutes

    -- Weather types dan probability (total must be 1.0)
    WeatherTypes = {
        Clear = 0.5,      -- 50% chance (Sunny/Clear)
        Rain = 0.25,      -- 25% chance
        Storm = 0.15,     -- 15% chance (Heavy rain + dark sky)
        Fog = 0.1,        -- 10% chance
    },

    -- Weather-specific settings
    Weather = {
        Clear = {
            FogEnd = 2000,
            FogColor = Color3.fromRGB(200, 200, 200),
            Brightness = 2,
            Ambient = Color3.fromRGB(180, 180, 180),
            CloudCover = 0.3,
        },

        Rain = {
            FogEnd = 800,
            FogColor = Color3.fromRGB(150, 150, 150),
            Brightness = 1.5,
            Ambient = Color3.fromRGB(130, 130, 140),
            CloudCover = 0.7,

            -- Rain particles settings
            ParticleRate = 500,
            ParticleSpeed = 50,
            ParticleSize = NumberSequence.new(0.2, 0.5),
        },

        Storm = {
            FogEnd = 400,
            FogColor = Color3.fromRGB(80, 80, 90),
            Brightness = 0.8,
            Ambient = Color3.fromRGB(70, 70, 80),
            CloudCover = 0.95,

            -- Storm particles (heavier rain)
            ParticleRate = 1000,
            ParticleSpeed = 80,
            ParticleSize = NumberSequence.new(0.3, 0.7),
        },

        Fog = {
            FogEnd = 300,
            FogColor = Color3.fromRGB(180, 180, 180),
            Brightness = 1.2,
            Ambient = Color3.fromRGB(150, 150, 150),
            CloudCover = 0.8,
        },
    }
}

-- ============================================
-- NOTIFICATION SETTINGS
-- ============================================

WeatherConfig.Notifications = {
    -- Show weather changes di chat
    ShowWeatherChanges = true,

    -- Show time changes di chat
    ShowTimeChanges = false,

    -- Messages
    Messages = {
        Clear = "☀️ Weather cleared up!",
        Rain = "🌧️ It's starting to rain...",
        Storm = "⛈️ A storm is brewing!",
        Fog = "🌫️ Fog is rolling in...",
        Dawn = "🌅 Dawn is breaking...",
        Day = "☀️ The sun is shining bright!",
        Dusk = "🌆 The sun is setting...",
        Night = "🌙 Night has fallen...",
    }
}

-- ============================================
-- HELPER FUNCTIONS
-- ============================================

-- Get time period based on hour
function WeatherConfig.GetTimePeriod(hour)
    if hour >= 5 and hour < 7 then
        return "Dawn"
    elseif hour >= 7 and hour < 17 then
        return "Day"
    elseif hour >= 17 and hour < 19 then
        return "Dusk"
    else
        return "Night"
    end
end

-- Convert minutes to seconds
function WeatherConfig.MinutesToSeconds(minutes)
    return minutes * 60
end

-- Get random weather type based on probability
function WeatherConfig.GetRandomWeather()
    local random = math.random()
    local cumulative = 0

    for weatherType, probability in pairs(WeatherConfig.WeatherSettings.WeatherTypes) do
        cumulative = cumulative + probability
        if random <= cumulative then
            return weatherType
        end
    end

    return "Clear"  -- Fallback
end

return WeatherConfig
