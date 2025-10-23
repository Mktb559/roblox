# Roblox Daily Claim System

## Overview
System Daily Claim untuk Roblox Studio dengan 7-day reward progression.

**⚠️ Already have a money system (e.g., UnifiedSaveSystem)?**
👉 See [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md) for seamless integration!

## Features
- ✅ Daily claim popup automatically bila player join
- ✅ Progressive rewards dari Day 1 sampai Day 7
- ✅ Data persistence menggunakan DataStoreService
- ✅ Beautiful UI dengan animations
- ✅ Streak system - reset kalau miss 1 hari

## Reward Structure
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

## Installation

### Step 1: Create Folder Structure
Dalam Roblox Studio, create folders ini:
```
ServerScriptService/
  └── DailyClaimServer.lua

ReplicatedStorage/
  └── DailyRewardsConfig.lua

StarterGui/
  └── DailyClaimUI (ScreenGui)
      └── DailyClaimClient.lua (LocalScript)
```

### Step 2: Enable DataStore
1. Game Settings → Security
2. Enable "Enable Studio Access to API Services"

### Step 3: Copy Scripts
1. Copy content dari `src/ServerScriptService/DailyClaimServer.lua` → ServerScriptService
2. Copy content dari `src/ReplicatedStorage/DailyRewardsConfig.lua` → ReplicatedStorage
3. Copy content dari `src/StarterGui/DailyClaimClient.lua` → StarterGui (dalam LocalScript)

### Step 4: Setup UI
Ikut instructions dalam `UI_SETUP.md` untuk create UI elements.

## How It Works

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
