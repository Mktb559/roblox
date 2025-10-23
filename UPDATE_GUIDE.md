# Update Guide - Tukar dari Coins ke Money

Kalau UI anda masih show "Coins", anda perlu **UPDATE code dalam Roblox Studio** dengan code yang baru.

---

## Quick Fix - Update 1 File Sahaja! ⚡

Anda hanya perlu update **1 line** dalam configuration file:

### Step 1: Buka DailyRewardsConfig dalam Roblox Studio

1. Buka Roblox Studio
2. Dalam Explorer, pergi ke **ReplicatedStorage**
3. Double-click **DailyRewardsConfig** (ModuleScript)

### Step 2: Find Line 34

Cari line yang ada:
```lua
DailyRewardsConfig.CurrencyName = "Coins"
```

### Step 3: Change kepada:
```lua
DailyRewardsConfig.CurrencyName = "Money"
```

### Step 4: Save & Test

1. Save file (Ctrl+S atau Cmd+S)
2. Click **Stop** kalau game tengah running
3. Click **Play** (F5)
4. Popup sekarang sepatutnya show "**Money**" instead of "Coins"! ✅

---

## Atau: Update Semua Files (Full Update)

Kalau nak make sure everything up-to-date, update semua 3 files:

### File 1: DailyRewardsConfig.lua
Location: **ReplicatedStorage → DailyRewardsConfig**

1. Delete ALL content dalam ModuleScript
2. Copy SEMUA code dari: `src/ReplicatedStorage/DailyRewardsConfig.lua`
3. Paste dalam ModuleScript
4. Save

### File 2: DailyClaimServer.lua
Location: **ServerScriptService → DailyClaimServer**

1. Delete ALL content dalam Script
2. Copy SEMUA code dari: `src/ServerScriptService/DailyClaimServer.lua`
3. Paste dalam Script
4. Save

### File 3: DailyClaimClient.lua
Location: **StarterGui → DailyClaimUI → DailyClaimClient**

1. Delete ALL content dalam LocalScript
2. Copy SEMUA code dari: `src/StarterGui/DailyClaimClient.lua`
3. Paste dalam LocalScript
4. Save

---

## Verify Update Berjaya

After update, test:

1. Click **Play** (F5)
2. Popup muncul
3. Check cards - sepatutnya show "**Money**" (bukan "Coins")
4. Click CLAIM
5. Check leaderboard - sepatutnya show "**Money: [amount]**"

Kalau semua show "Money", ✅ **UPDATE BERJAYA!**

---

## Kenapa Perlu Update?

- Code dalam GitHub repository dah updated
- Tapi code dalam Roblox Studio anda **TIDAK auto-sync**
- You need to **manually copy** new code ke Roblox Studio

---

## Troubleshooting

**Masih show "Coins" after update?**

1. Make sure anda save file (Ctrl+S)
2. **Stop** game (Shift+F5)
3. **Close** Roblox Studio completely
4. **Reopen** Roblox Studio
5. **Play** again (F5)

**Variable name masih "coinsLabel" dalam code?**

- Itu OK! Variable name dalam code boleh kekal "coinsLabel"
- Yang penting adalah **value** yang di-assign: `DailyRewardsConfig.CurrencyName`
- Variable name adalah internal, user tak nampak

---

## Masa Depan: Easy Updates

Untuk make updates easier, anda boleh:

1. **Use Rojo** - Sync files dari computer to Roblox Studio automatically
2. **Use Git** - Pull latest changes dari GitHub
3. **Manual copy** - Copy paste macam guide di atas (paling simple)

---

**Done! Sekarang system anda guna Money instead of Coins! 💰**
