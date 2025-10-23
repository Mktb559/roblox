# Roblox Studio Game Systems

Collection of game systems untuk Roblox Studio.

---

## 📦 Available Systems

### 1. 💰 Daily Claim System
7-day progressive reward system dengan beautiful UI.

**Features:**
- ✅ Daily claim popup automatically bila player join
- ✅ Progressive rewards dari Day 1 sampai Day 7
- ✅ Data persistence menggunakan DataStoreService
- ✅ Beautiful UI dengan animations
- ✅ Streak system - reset kalau miss 1 hari
- ✅ Integrates dengan existing money systems

👉 **Setup Guide:** [QUICK_START.md](QUICK_START.md)
👉 **Integration:** [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md)

### 2. 🌦️ Weather & Time Cycle System
Automatic day/night cycle dan dynamic weather system.

**Features:**
- ✅ Smooth day/night transitions (Dawn, Day, Dusk, Night)
- ✅ 4 weather types: Clear, Rain, Storm, Fog
- ✅ Realistic rain particles
- ✅ Customizable cycle duration dan weather probability
- ✅ Dynamic lighting dan fog effects
- ✅ Manual weather control

👉 **Setup Guide:** [WEATHER_SETUP.md](WEATHER_SETUP.md)

---

## 🚀 Quick Installation

**Already have a money system (e.g., UnifiedSaveSystem)?**
👉 See [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md) for seamless integration!

---

## 💰 Daily Claim - Reward Structure
| Day | Reward |
|-----|--------|
| Day 1 | $100 |
| Day 2 | $200 |
| Day 3 | $350 |
| Day 4 | $500 |
| Day 5 | $750 |
| Day 6 | $1,000 |
| Day 7 | $2,000 |

**Total: $4,900 untuk complete 7 hari!**

*Default currency: "Cash" (customizable in config)*

## 📥 Installation Overview

Each system has its own detailed setup guide:

### Daily Claim System:
- 📖 **Quick Start:** [QUICK_START.md](QUICK_START.md)
- 📖 **Detailed Setup:** [UI_SETUP.md](UI_SETUP.md)
- 📖 **Integration Guide:** [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md)

### Weather & Time System:
- 📖 **Complete Guide:** [WEATHER_SETUP.md](WEATHER_SETUP.md)

---

## 💰 Daily Claim - Installation

### Step 1: Enable DataStore
1. Game Settings → Security
2. Enable "Enable Studio Access to API Services"

### Step 2: Copy Scripts
1. Copy content dari `src/ServerScriptService/DailyClaimServer.lua` → ServerScriptService
2. Copy content dari `src/ReplicatedStorage/DailyRewardsConfig.lua` → ReplicatedStorage
3. Copy content dari `src/StarterGui/DailyClaimClient.lua` → StarterGui (dalam LocalScript)

### Step 3: Test
Ikut instructions dalam `QUICK_START.md` untuk complete setup.

---

## 🌦️ Weather & Time - Installation

See [WEATHER_SETUP.md](WEATHER_SETUP.md) for complete installation guide.

**Quick Setup:**
1. Copy `WeatherConfig.lua` → ReplicatedStorage (ModuleScript)
2. Copy `DayNightCycle.lua` → ServerScriptService (Script)
3. Copy `WeatherSystem.lua` → ServerScriptService (Script)
4. Press F5 and watch the magic! 🌞🌙⛈️

---

## 💰 Daily Claim - How It Works

1. **Player Join** → System check last claim time dari DataStore
2. **Calculate** → Check kalau dah 24 hours lepas
3. **Show Popup** → Display reward dan current day streak
4. **Claim Button** → Update data, give cash, close popup
5. **Save** → Persist data ke DataStore

## Configuration

Edit rewards dalam `DailyRewardsConfig.lua`:
```lua
DailyRewards = {
    [1] = 100,
    [2] = 200,
    -- etc
}
```

## Testing

Untuk test dalam Studio:
1. Enable API Services
2. Join game
3. Popup akan muncul automatically
4. Click "Claim" untuk test
5. Check output untuk logs

## Notes

- Streak reset kalau player miss lebih dari 24 hours
- Data saved per player menggunakan UserId
- Leaderboard "Cash" automatically created (or uses existing one)
- UI responsive untuk all screen sizes

## Support

Kalau ada issues atau questions, check Roblox Developer Forum atau documentation.
