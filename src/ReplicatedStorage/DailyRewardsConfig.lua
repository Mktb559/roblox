--[[
    Daily Rewards Configuration Module

    Defines reward amounts untuk setiap hari dalam daily claim system.
    Edit values di bawah untuk adjust reward amounts.
]]

local DailyRewardsConfig = {}

-- Reward amounts untuk setiap hari (Day 1 sampai Day 7)
DailyRewardsConfig.Rewards = {
    [1] = 100,    -- Day 1: Starter reward
    [2] = 200,    -- Day 2: Double
    [3] = 350,    -- Day 3: Good progress
    [4] = 500,    -- Day 4: Solid reward
    [5] = 750,    -- Day 5: Getting better
    [6] = 1000,   -- Day 6: Nice amount
    [7] = 2000    -- Day 7: BIG REWARD untuk complete week!
}

-- Maximum days dalam streak
DailyRewardsConfig.MaxDays = 7

-- Time required antara claims (dalam seconds)
-- 86400 seconds = 24 hours
DailyRewardsConfig.ClaimCooldown = 86400

-- Grace period untuk maintain streak (dalam seconds)
-- 172800 seconds = 48 hours (24 hours + 24 hours grace)
-- Kalau player miss lebih dari ini, streak reset
DailyRewardsConfig.StreakResetTime = 172800

-- Currency name (change kalau guna custom currency)
DailyRewardsConfig.CurrencyName = "Money"

-- UI Settings
DailyRewardsConfig.UI = {
    -- Colors
    PrimaryColor = Color3.fromRGB(75, 150, 255),      -- Blue
    SecondaryColor = Color3.fromRGB(50, 50, 50),      -- Dark gray
    AccentColor = Color3.fromRGB(255, 200, 50),       -- Gold
    SuccessColor = Color3.fromRGB(50, 200, 100),      -- Green
    TextColor = Color3.fromRGB(255, 255, 255),        -- White

    -- Animation settings
    PopupAnimationSpeed = 0.5,  -- Duration untuk popup animation (seconds)
    ButtonHoverScale = 1.1,     -- Scale kalau hover button

    -- Text
    Title = "Daily Rewards",
    ClaimButtonText = "CLAIM!",
    ClaimedButtonText = "CLAIMED",
    ComingSoonText = "Coming Soon",
}

-- Helper function untuk get reward amount based on day
function DailyRewardsConfig.GetReward(day)
    if day < 1 or day > DailyRewardsConfig.MaxDays then
        warn("Invalid day:", day)
        return 0
    end
    return DailyRewardsConfig.Rewards[day] or 0
end

-- Helper function untuk get total rewards untuk complete streak
function DailyRewardsConfig.GetTotalRewards()
    local total = 0
    for _, reward in pairs(DailyRewardsConfig.Rewards) do
        total = total + reward
    end
    return total
end

return DailyRewardsConfig
