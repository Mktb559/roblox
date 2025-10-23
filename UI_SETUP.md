# Daily Claim UI Setup Guide

Panduan lengkap untuk setup Daily Claim System dalam Roblox Studio.

## Prerequisites

1. Roblox Studio installed
2. Basic knowledge tentang Roblox Studio interface
3. Project/game yang dah ada (atau create new)

---

## Step-by-Step Installation

### Step 1: Enable API Services

Sebelum start, MUST enable DataStore API:

1. Buka **Game Settings** (Home tab → Game Settings)
2. Pergi ke **Security** tab
3. Enable **"Enable Studio Access to API Services"**
4. Click **Save**

⚠️ **PENTING:** Tanpa ini, DataStore tak akan berfungsi!

---

### Step 2: Create Folder Structure

Dalam Explorer window, create folders ini kalau belum ada:

1. **ServerScriptService** (should exist by default)
2. **ReplicatedStorage** (should exist by default)
3. **StarterGui** (should exist by default)

---

### Step 3: Add Configuration Module

1. Dalam **ReplicatedStorage**, click **+** button
2. Insert **ModuleScript**
3. Rename kepada `DailyRewardsConfig`
4. Double-click untuk open
5. **DELETE semua default code**
6. Copy semua code dari file `src/ReplicatedStorage/DailyRewardsConfig.lua`
7. Paste dalam ModuleScript
8. Save (Ctrl+S atau Cmd+S)

---

### Step 4: Add Server Script

1. Dalam **ServerScriptService**, click **+** button
2. Insert **Script** (bukan LocalScript!)
3. Rename kepada `DailyClaimServer`
4. Double-click untuk open
5. **DELETE semua default code**
6. Copy semua code dari file `src/ServerScriptService/DailyClaimServer.lua`
7. Paste dalam Script
8. Save

---

### Step 5: Add Client Script

1. Dalam **StarterGui**, click **+** button
2. Insert **ScreenGui**
3. Rename kepada `DailyClaimUI` (optional tapi recommended)
4. Click pada ScreenGui yang baru created
5. Click **+** button pada ScreenGui
6. Insert **LocalScript**
7. Rename kepada `DailyClaimClient`
8. Double-click untuk open
9. **DELETE semua default code**
10. Copy semua code dari file `src/StarterGui/DailyClaimClient.lua`
11. Paste dalam LocalScript
12. Save

**Final hierarchy sepatutnya macam ini:**
```
StarterGui
  └── DailyClaimUI (ScreenGui)
      └── DailyClaimClient (LocalScript)
```

---

## Step 6: Verify Setup

Check Explorer window, struktur sepatutnya macam ini:

```
Workspace
  ...
ServerScriptService
  └── DailyClaimServer (Script)
ReplicatedStorage
  └── DailyRewardsConfig (ModuleScript)
StarterGui
  └── DailyClaimUI (ScreenGui)
      └── DailyClaimClient (LocalScript)
```

---

## Step 7: Test the System

### Method 1: Play Solo

1. Click **Play** button (F5) untuk test
2. Wait 2-3 seconds
3. Popup sepatutnya muncul dengan 7 days rewards
4. Click **CLAIM** button
5. Check leaderboard - "Coins" sepatutnya bertambah
6. Click **Stop** (Shift+F5)

### Method 2: Play dengan Multiple Players (Recommended)

1. Change **Clients and Servers** dari "1 Player" kepada "2 Players" atau lebih
2. Click Play
3. Test dalam each client window
4. Verify rewards working

---

## Common Issues & Solutions

### Issue 1: "DailyRewardsConfig is not a valid member of ReplicatedStorage"

**Solution:**
- Make sure ModuleScript nama betul: `DailyRewardsConfig`
- Make sure dalam **ReplicatedStorage** (bukan folder lain)
- Try restart Roblox Studio

### Issue 2: Popup tidak muncul

**Solution:**
- Check Output window untuk errors (View → Output)
- Make sure LocalScript dalam **StarterGui** (bukan ServerScriptService)
- Make sure API Services enabled
- Try add `wait(3)` dalam client script before RequestDataEvent:FireServer()

### Issue 3: Coins tidak bertambah

**Solution:**
- Check kalau ada folder "leaderstats" dalam player
- Check server script output untuk errors
- Make sure server script dalam **ServerScriptService**

### Issue 4: Data tidak save

**Solution:**
- **MUST enable API Services** dalam Game Settings → Security
- Check kalau ada error dalam Output window
- Dalam Studio, DataStore might not persist between sessions (this is normal)
- Publish game dan test dalam actual game untuk proper DataStore testing

### Issue 5: "Unable to cast value to Object"

**Solution:**
- Make sure script types betul:
  - Server script = **Script** (dalam ServerScriptService)
  - Client script = **LocalScript** (dalam StarterGui)
  - Config = **ModuleScript** (dalam ReplicatedStorage)

---

## Testing DataStore Persistence

⚠️ **IMPORTANT:** DataStore dalam Studio mode might not persist properly!

Untuk proper testing:

1. **Publish game** (File → Publish to Roblox)
2. Make game public atau private
3. Play game dari Roblox website (bukan Studio)
4. Claim reward
5. Leave game
6. Rejoin game
7. Check kalau day progression saved

---

## Customization

### Change Reward Amounts

Edit file `DailyRewardsConfig` dalam ReplicatedStorage:

```lua
DailyRewardsConfig.Rewards = {
    [1] = 200,    -- Change Day 1 reward
    [2] = 400,    -- Change Day 2 reward
    -- etc...
}
```

### Change UI Colors

Edit dalam `DailyRewardsConfig.UI`:

```lua
DailyRewardsConfig.UI = {
    PrimaryColor = Color3.fromRGB(75, 150, 255),    -- Main color
    AccentColor = Color3.fromRGB(255, 200, 50),     -- Highlight color
    -- etc...
}
```

### Change Claim Cooldown

Edit dalam `DailyRewardsConfig`:

```lua
-- Change dari 24 hours kepada 12 hours
DailyRewardsConfig.ClaimCooldown = 43200  -- 12 hours dalam seconds
```

---

## Advanced Features

### Add Sound Effects

Dalam LocalScript (`DailyClaimClient`), dalam claim success handler:

```lua
ClaimRewardEvent.OnClientEvent:Connect(function(success, data)
    if success then
        -- Add sound effect
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://YOUR_SOUND_ID"
        sound.Parent = game.SoundService
        sound:Play()

        -- Rest of code...
    end
end)
```

### Add Particle Effects

Tambah celebration effect bila claim:

```lua
-- Create particle emitter dalam PopupFrame
local particles = Instance.new("ParticleEmitter")
particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
particles.Rate = 50
particles.Lifetime = NumberRange.new(1, 2)
particles.Parent = popup
```

---

## Support & Troubleshooting

Kalau ada issues:

1. Check **Output window** untuk error messages
2. Verify semua scripts dalam location yang betul
3. Make sure API Services enabled
4. Try restart Roblox Studio
5. Check code untuk typos

---

## Next Steps

Selepas setup berjaya:

- ✅ Test dengan multiple players
- ✅ Customize rewards dan colors
- ✅ Publish game dan test DataStore persistence
- ✅ Add more features (leaderboards, achievements, etc.)

---

**Congratulations! 🎉**

Your Daily Claim System sekarang ready untuk digunakan!

Players akan automatic nampak popup bila join game, dan boleh claim rewards setiap hari.
