# Weather & Time Cycle System - Setup Guide

Complete automatic Day/Night cycle dan Weather system untuk Roblox Studio! 🌞🌙⛈️

---

## 🎯 Features

### Day/Night Cycle:
- ✅ Automatic time progression (customizable speed)
- ✅ Smooth lighting transitions
- ✅ 4 time periods: Dawn, Day, Dusk, Night
- ✅ Realistic lighting untuk setiap period
- ✅ Customizable cycle duration

### Weather System:
- ✅ 4 weather types: Clear, Rain, Storm, Fog
- ✅ Random weather changes based on probability
- ✅ Realistic rain particles
- ✅ Dynamic fog and lighting
- ✅ Customizable weather duration

---

## 📦 Installation

### Quick Setup (5 Minutes)

**Step 1: Copy 3 Files**

Copy ke Roblox Studio:

1. **WeatherConfig.lua** → ReplicatedStorage (ModuleScript)
   - From: `src/ReplicatedStorage/WeatherConfig.lua`

2. **DayNightCycle.lua** → ServerScriptService (Script)
   - From: `src/ServerScriptService/DayNightCycle.lua`

3. **WeatherSystem.lua** → ServerScriptService (Script)
   - From: `src/ServerScriptService/WeatherSystem.lua`

**Step 2: Test!**

1. Press **F5** (Play)
2. Watch time cycle automatically
3. Wait for weather changes
4. Check Output window untuk status

---

## ⚙️ Configuration

Edit settings dalam **WeatherConfig** (ReplicatedStorage):

### Time Cycle Settings

```lua
WeatherConfig.TimeSettings = {
    Enabled = true,           -- Enable/disable time cycle
    CycleDuration = 10,       -- Minutes untuk 1 full day (10 = 10 minit real-time)
    StartTime = 6,            -- Starting hour (6 = 6 AM)
    TransitionSpeed = 0.05,   -- Transition smoothness
}
```

**Examples:**
- `CycleDuration = 5` → Very fast day/night (5 minit)
- `CycleDuration = 20` → Slow, realistic (20 minit)
- `CycleDuration = 60` → Very slow (1 hour real-time)

### Weather Settings

```lua
WeatherConfig.WeatherSettings = {
    Enabled = true,          -- Enable/disable weather
    ChangeInterval = 3,      -- Change weather every 3 minutes

    -- Probability (must total 1.0)
    WeatherTypes = {
        Clear = 0.5,         -- 50% chance
        Rain = 0.25,         -- 25% chance
        Storm = 0.15,        -- 15% chance
        Fog = 0.1,           -- 10% chance
    },
}
```

**Customize Probability:**
- Make it always sunny: `Clear = 1.0, Rain = 0, Storm = 0, Fog = 0`
- More rain: `Clear = 0.3, Rain = 0.5, Storm = 0.2, Fog = 0`
- Balanced: `Clear = 0.4, Rain = 0.3, Storm = 0.2, Fog = 0.1`

---

## 🎨 Customization

### Change Lighting Per Time Period

Edit dalam WeatherConfig:

```lua
WeatherConfig.TimeSettings.Lighting = {
    Day = {
        Ambient = Color3.fromRGB(180, 180, 180),      -- Brighter
        OutdoorAmbient = Color3.fromRGB(127, 127, 127),
        Brightness = 2,                                -- Bright sun
        FogEnd = 2000,                                 -- Far visibility
        FogColor = Color3.fromRGB(200, 200, 200),
    },

    Night = {
        Ambient = Color3.fromRGB(50, 50, 70),         -- Dark blue tint
        OutdoorAmbient = Color3.fromRGB(60, 60, 100),
        Brightness = 0.5,                              -- Dark
        FogEnd = 500,                                  -- Limited visibility
        FogColor = Color3.fromRGB(30, 30, 50),
    },
}
```

### Change Weather Effects

Edit weather-specific settings:

```lua
WeatherConfig.WeatherSettings.Weather = {
    Rain = {
        FogEnd = 800,                    -- Reduced visibility
        Brightness = 1.5,                 -- Slightly darker
        CloudCover = 0.7,                 -- More clouds

        -- Rain intensity
        ParticleRate = 500,               -- Rain drops per second
        ParticleSpeed = 50,               -- Fall speed
    },

    Storm = {
        ParticleRate = 1000,              -- Heavy rain (more drops)
        ParticleSpeed = 80,               -- Faster rain
        Brightness = 0.8,                 -- Much darker
    },
}
```

---

## 🎮 How It Works

### Time Cycle Flow:

```
Game Start
    ↓
Set Time to 6 AM (StartTime)
    ↓
Every Second:
    ClockTime += increment
    ↓
Check Time Period (Dawn/Day/Dusk/Night)
    ↓
Update Lighting Settings
    ↓
[Repeat]
```

**Time Periods:**
- 🌅 **Dawn**: 5 AM - 7 AM (Sunrise)
- ☀️ **Day**: 7 AM - 5 PM (Bright)
- 🌆 **Dusk**: 5 PM - 7 PM (Sunset)
- 🌙 **Night**: 7 PM - 5 AM (Dark)

### Weather Cycle Flow:

```
Game Start
    ↓
Set Weather to Clear
    ↓
Wait ChangeInterval (e.g., 3 minutes)
    ↓
Random Weather (based on probability)
    ↓
Apply Weather Effects:
    - Update Lighting
    - Enable/Disable Rain Particles
    - Change Fog
    ↓
[Repeat]
```

---

## 🛠️ Advanced Usage

### Manual Weather Control

Use dalam Command Bar atau Script:

```lua
-- Change weather manually
_G.ChangeWeather("Rain")    -- Start rain
_G.ChangeWeather("Clear")   -- Clear sky
_G.ChangeWeather("Storm")   -- Heavy storm
_G.ChangeWeather("Fog")     -- Foggy
```

### Disable Specific Features

**Disable Time Cycle** (weather only):
```lua
-- In WeatherConfig
WeatherConfig.TimeSettings.Enabled = false
```

**Disable Weather** (time cycle only):
```lua
-- In WeatherConfig
WeatherConfig.WeatherSettings.Enabled = false
```

### Notifications

Show weather changes to players:

```lua
WeatherConfig.Notifications = {
    ShowWeatherChanges = true,   -- Show weather messages
    ShowTimeChanges = true,      -- Show time period messages

    Messages = {
        Clear = "☀️ Weather cleared up!",
        Rain = "🌧️ It's starting to rain...",
        Dawn = "🌅 Dawn is breaking...",
        -- Customize messages here
    }
}
```

---

## 🌟 Examples

### Fast Day/Night for Testing:
```lua
CycleDuration = 2  -- 2 minutes untuk full day
ChangeInterval = 0.5  -- Weather changes every 30 seconds
```

### Realistic Slow Cycle:
```lua
CycleDuration = 30  -- 30 minutes untuk full day
ChangeInterval = 10  -- Weather changes every 10 minutes
```

### Always Rainy:
```lua
WeatherTypes = {
    Clear = 0,
    Rain = 0.7,
    Storm = 0.3,
    Fog = 0,
}
```

### Desert Theme (No Rain):
```lua
WeatherTypes = {
    Clear = 0.8,   -- Mostly clear
    Rain = 0,      -- No rain
    Storm = 0,     -- No storm
    Fog = 0.2,     -- Occasional fog/sandstorm
}
```

---

## 📊 Performance

**Optimized for performance:**
- ✅ Time updates every 1 second (low CPU)
- ✅ Weather changes on interval (not constant checks)
- ✅ Single rain emitter (efficient particles)
- ✅ No excessive RemoteEvents

**Recommended Settings:**
- Particle Rate: 500-1000 (good balance)
- Cycle Duration: 10-30 minutes
- Weather Interval: 3-5 minutes

---

## ⚠️ Troubleshooting

### Issue: Time not changing

**Check:**
1. `TimeSettings.Enabled = true` in config?
2. DayNightCycle script dalam ServerScriptService?
3. Check Output window untuk errors

**Fix:**
Make sure WeatherConfig loaded first (dalam ReplicatedStorage)

### Issue: Rain not appearing

**Check:**
1. `WeatherSettings.Enabled = true`?
2. WeatherSystem script dalam ServerScriptService?
3. Weather actually changed to Rain/Storm?

**Fix:**
Manually trigger rain: `_G.ChangeWeather("Rain")`

### Issue: Too dark at night

**Fix:**
Increase night brightness:
```lua
Night = {
    Brightness = 1.0,  -- Increase from 0.5
}
```

### Issue: Weather changes too fast/slow

**Fix:**
Adjust interval:
```lua
ChangeInterval = 5,  -- Change every 5 minutes
```

### Issue: Rain particles look weird

**Fix:**
Adjust particle settings:
```lua
Rain = {
    ParticleRate = 300,     -- Reduce rate
    ParticleSpeed = 40,     -- Adjust speed
    ParticleSize = NumberSequence.new(0.1, 0.3),  -- Smaller particles
}
```

---

## 🎯 Testing Checklist

After installation:

- [ ] Time cycles automatically (watch ClockTime)
- [ ] Lighting changes between day/night
- [ ] Weather changes randomly
- [ ] Rain particles appear during Rain/Storm
- [ ] Fog appears during Fog weather
- [ ] Output shows status messages
- [ ] No errors dalam Output window

---

## 📝 File Structure

```
ReplicatedStorage/
  └── WeatherConfig (ModuleScript)

ServerScriptService/
  ├── DayNightCycle (Script)
  └── WeatherSystem (Script)
```

---

## 🔧 Integration with Other Systems

### Works With:
- ✅ Daily Claim System
- ✅ UnifiedSaveSystem
- ✅ Any money/game systems
- ✅ Custom maps

### No Conflicts:
- Uses standard Roblox Lighting service
- Doesn't interfere dengan player data
- Safe to use with any game mode

---

## 💡 Tips

1. **Start dengan fast cycle untuk testing** (CycleDuration = 2)
2. **Adjust brightness** based on your map aesthetics
3. **Test all weather types** using `_G.ChangeWeather()`
4. **Watch Output window** untuk debug info
5. **Customize colors** untuk match your game theme

---

## 🌈 Creative Ideas

### Seasonal Themes:
- **Summer**: More Clear, less Rain
- **Monsoon**: More Storm, more Rain
- **Winter**: More Fog, Clear (can add snow particles)

### Special Events:
- **Blood Moon**: Red tint during Night
- **Eclipse**: Very dark during Day
- **Aurora**: Special lighting at Night

### Biome-Specific:
- **Desert**: No rain, more fog (sandstorms)
- **Tropical**: More rain, fast cycles
- **Arctic**: Fog only, always bright (midnight sun)

---

**Enjoy your dynamic world! 🌍✨**

Need help? Check Output window atau test dengan manual commands!
