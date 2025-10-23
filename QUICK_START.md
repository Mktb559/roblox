# Quick Start Guide - Daily Claim System

Setup cepat dalam **5 minit**! ⚡

## 1. Enable API Services ⚙️

Game Settings → Security → ✅ Enable Studio Access to API Services

## 2. Copy 3 Files 📁

### File 1: Configuration (ReplicatedStorage)
```
ReplicatedStorage
  └── DailyRewardsConfig (ModuleScript)
      └── [Copy code dari: src/ReplicatedStorage/DailyRewardsConfig.lua]
```

### File 2: Server Logic (ServerScriptService)
```
ServerScriptService
  └── DailyClaimServer (Script)
      └── [Copy code dari: src/ServerScriptService/DailyClaimServer.lua]
```

### File 3: UI Client (StarterGui)
```
StarterGui
  └── DailyClaimUI (ScreenGui)
      └── DailyClaimClient (LocalScript)
          └── [Copy code dari: src/StarterGui/DailyClaimClient.lua]
```

## 3. Test! 🎮

1. Press **F5** (Play)
2. Wait 2 seconds
3. Popup muncul!
4. Click **CLAIM**
5. Check Coins dalam leaderboard ✅

---

## Rewards Structure 💰

| Day | Reward |
|-----|--------|
| 1   | 100    |
| 2   | 200    |
| 3   | 350    |
| 4   | 500    |
| 5   | 750    |
| 6   | 1,000  |
| 7   | 2,000  |

**Total: 4,900 coins!**

---

## Troubleshooting 🔧

**Popup tak muncul?**
→ Check Output window untuk errors

**Data tak save?**
→ Make sure API Services enabled

**Coins tak bertambah?**
→ Make sure server script dalam ServerScriptService (bukan ReplicatedStorage)

---

**Need detailed help?** Check `UI_SETUP.md` 📖

**Happy claiming! 🎉**
