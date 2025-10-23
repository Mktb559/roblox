# Integration Guide - Daily Claim + UnifiedSaveSystem

Panduan untuk integrate Daily Claim System dengan existing money system anda (UnifiedSaveSystem).

---

## 🎯 Your Current Setup

Anda dah ada:
```lua
-- UnifiedSaveSystem.lua
local cash = Instance.new("IntValue")
cash.Name = "Cash"  -- ← Your currency name

_G.AddMoney = function(player, amount)  -- ← Your money function
```

---

## ✅ Automatic Integration!

**Good news!** Daily Claim System **AUTOMATICALLY integrates** dengan system anda! 🎉

### How It Works:

1. **Uses Your Existing "Cash"**
   - Config set to `CurrencyName = "Cash"` (matches your system)
   - Won't create duplicate currency

2. **Uses Your _G.AddMoney Function**
   - Daily rewards akan call `_G.AddMoney(player, amount)`
   - Works with your save system automatically
   - Triggers your save queue

3. **No Conflicts**
   - Checks if leaderstats exists before creating
   - Uses existing Cash value instead of creating new one

---

## 🚀 Installation Steps

### Step 1: Install UnifiedSaveSystem (If Not Already)

Make sure your `UnifiedSaveSystem.lua` loaded **FIRST** before DailyClaimServer!

In **ServerScriptService**, order should be:
```
ServerScriptService/
  ├── UnifiedSaveSystem (loads first)
  └── DailyClaimServer (loads second)
```

**To ensure load order:**
1. Right-click `DailyClaimServer`
2. Rename to `ZZ_DailyClaimServer` (loads last due to alphabetical order)

OR

Add this at top of DailyClaimServer:
```lua
-- Wait for UnifiedSaveSystem to load
repeat wait() until _G.AddMoney ~= nil
print("✅ UnifiedSaveSystem detected!")
```

### Step 2: Install Daily Claim Scripts

Follow standard installation dari `QUICK_START.md`:

**Copy 3 files:**
1. `DailyRewardsConfig.lua` → ReplicatedStorage (ModuleScript)
2. `DailyClaimServer.lua` → ServerScriptService (Script)
3. `DailyClaimClient.lua` → StarterGui > ScreenGui > LocalScript

### Step 3: Configure Currency Name

In `DailyRewardsConfig` (ReplicatedStorage), make sure:

```lua
DailyRewardsConfig.CurrencyName = "Cash"  -- ✅ Matches your system
```

**Already set by default!** ✅

### Step 4: Test Integration

1. Press **F5** (Play)
2. Wait for popup
3. Click **CLAIM**
4. Check Output window:

Expected output:
```
✅ UnifiedSaveSystem (FIXED) loaded!
💾 Money + Tools will save together
✅ DailyClaimServer detected _G.AddMoney
💰 Loaded data for [PlayerName]
   Money: $500
🎁 Daily Claim popup shown
✅ Used _G.AddMoney to give reward
💾 Saved data for [PlayerName]
   Money: $600
```

---

## 🔍 Verification Checklist

After setup, verify:

- ✅ Popup shows "Cash" (not "Coins" or "Money")
- ✅ Clicking CLAIM increases Cash value
- ✅ Cash value saves (check UnifiedSaveSystem output)
- ✅ No duplicate currency in leaderboard
- ✅ No DataStore warnings

---

## 🛠️ How Integration Works (Technical)

### 1. Currency Detection

```lua
-- DailyClaimServer checks for existing leaderstats
local leaderstats = player:FindFirstChild("leaderstats")
if not leaderstats then
    -- Only creates if doesn't exist
    leaderstats = Instance.new("Folder")
end
```

✅ If UnifiedSaveSystem already created leaderstats → Uses existing one

### 2. Money System Integration

```lua
local function GiveReward(player, amount)
    -- Try global AddMoney first (UnifiedSaveSystem)
    if _G.AddMoney then
        return _G.AddMoney(player, amount)  -- ✅ Uses your system!
    end

    -- Fallback: Direct manipulation
    local cash = leaderstats:FindFirstChild("Cash")
    cash.Value = cash.Value + amount
end
```

**Priority:**
1. ✅ Use `_G.AddMoney` if exists (recommended)
2. ⚙️ Fallback to direct Cash.Value modification

### 3. Save System Compatibility

When using `_G.AddMoney`:
- ✅ Triggers your `queueSave()`
- ✅ Respects your save cooldown (60s)
- ✅ Uses your DataStore (`PlayerData_Unified_v3`)
- ✅ No duplicate saves
- ✅ No DataStore conflicts

---

## 📊 Reward Structure

With your system, players get:

| Day | Cash Reward |
|-----|-------------|
| 1   | $100        |
| 2   | $200        |
| 3   | $350        |
| 4   | $500        |
| 5   | $750        |
| 6   | $1,000      |
| 7   | $2,000      |

**Total: $4,900** untuk 7 hari streak!

Plus your starting money:
- Starting: $500
- After Day 1 claim: $600
- After complete 7 days: $5,400

---

## ⚠️ Troubleshooting

### Issue: Popup shows "Money" instead of "Cash"

**Fix:** Update `DailyRewardsConfig.lua` dalam Roblox Studio:
```lua
DailyRewardsConfig.CurrencyName = "Cash"
```

### Issue: Cash doesn't save

**Check:**
1. UnifiedSaveSystem loaded before DailyClaimServer?
2. API Services enabled?
3. Check Output for save confirmations

**Solution:**
Rename `DailyClaimServer` → `ZZ_DailyClaimServer` (loads last)

### Issue: Duplicate currency in leaderboard

**This shouldn't happen** because:
- DailyClaimServer checks for existing leaderstats
- Only creates "Cash" if it doesn't exist

**If it happens:**
Delete the duplicate manually in Explorer during runtime and restart.

### Issue: "_G.AddMoney is nil" error

**Cause:** DailyClaimServer loaded before UnifiedSaveSystem

**Fix:** Add wait at top of DailyClaimServer:
```lua
repeat wait() until _G.AddMoney ~= nil
```

Or rename to load last.

---

## 🎮 Player Experience

1. **Player joins game**
   - UnifiedSaveSystem loads their Cash
   - DailyClaimServer checks if can claim today

2. **Popup appears** (if can claim)
   - Shows 7 days with rewards
   - Current claimable day highlighted

3. **Player clicks CLAIM**
   - Calls `_G.AddMoney(player, 100)`
   - UnifiedSaveSystem queues save
   - Popup shows "✓ Claimed 100 Cash!"
   - Popup closes after 2 seconds

4. **Data saves**
   - UnifiedSaveSystem handles save (with cooldown)
   - Both Cash and DailyClaim data saved
   - No conflicts!

---

## 🔧 Advanced: Custom Integration

### Use Different Currency

Kalau nak guna currency lain:

```lua
-- DailyRewardsConfig.lua
DailyRewardsConfig.CurrencyName = "Gems"  -- Or whatever

-- Make sure UnifiedSaveSystem has matching currency:
local gems = Instance.new("IntValue")
gems.Name = "Gems"
```

### Disable _G.AddMoney Integration

Kalau nak direct manipulation sahaja:

In `DailyClaimServer.lua`, comment out:
```lua
local function GiveReward(player, amount)
    -- if _G.AddMoney then  -- ← Comment this
    --     return _G.AddMoney(player, amount)
    -- end

    -- Direct manipulation (always use this)
    local cash = leaderstats:FindFirstChild("Cash")
    cash.Value = cash.Value + amount
end
```

---

## ✅ Summary

**What You Need:**
1. Install Daily Claim scripts (3 files)
2. Make sure `CurrencyName = "Cash"` in config
3. Make sure UnifiedSaveSystem loads first

**What Happens:**
- ✅ Auto-detects your existing Cash system
- ✅ Uses your `_G.AddMoney` function
- ✅ Integrates with your save system
- ✅ No conflicts or duplicates
- ✅ Works seamlessly!

---

**Ready to go! Your Daily Claim + UnifiedSaveSystem will work perfectly together! 🚀**
