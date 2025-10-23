# Daily Claim UI Preview

## UI Design Overview

Bila player join game, popup akan automatically muncul di tengah screen dengan design yang cantik dan modern.

---

## UI Components

### 1. Main Popup Frame
- **Size:** 600x450 pixels
- **Position:** Center of screen
- **Style:** Dark theme dengan rounded corners
- **Shadow:** Subtle shadow untuk depth effect

### 2. Title Bar
```
╔════════════════════════════════════════╗
║         DAILY REWARDS          [X]     ║
╚════════════════════════════════════════╝
```
- Large, bold title "DAILY REWARDS"
- Close button (X) di top-right corner

### 3. Rewards Grid (7 Day Cards)

```
╔═══╗  ╔═══╗  ╔═══╗  ╔═══╗  ╔═══╗  ╔═══╗  ╔═══╗
║Day║  ║Day║  ║Day║  ║Day║  ║Day║  ║Day║  ║Day║
║ 1 ║  ║ 2 ║  ║ 3 ║  ║ 4 ║  ║ 5 ║  ║ 6 ║  ║ 7 ║
║───║  ║───║  ║───║  ║───║  ║───║  ║───║  ║───║
║100║  ║200║  ║350║  ║500║  ║750║  ║1K ║  ║2K ║
║   ║  ║   ║  ║   ║  ║   ║  ║   ║  ║   ║  ║   ║
║✓  ║  ║✓  ║  ║✨ ║  ║   ║  ║   ║  ║   ║  ║   ║
╚═══╝  ╚═══╝  ╚═══╝  ╚═══╝  ╚═══╝  ╚═══╝  ╚═══╝
Claimed Claimed Current  Next   Next   Next   Next
```

#### Card States:

**Already Claimed (Green):**
- Background: Green color
- Checkmark (✓) di corner
- Grayed out

**Current Day (Blue with Gold Border):**
- Background: Bright blue
- Gold glow/stroke effect
- Highlighted dengan border
- This is the day user boleh claim NOW

**Coming Soon (Gray):**
- Background: Dark gray (semi-transparent)
- Dimmed appearance
- Cannot interact yet

### 4. Claim Button

```
╔═══════════════════════════════╗
║                               ║
║         CLAIM! 🎁            ║
║                               ║
╚═══════════════════════════════╝
```

**States:**

**Can Claim (Green):**
- Bright green background
- Text: "CLAIM!"
- Hover effect: Slight scale up
- Clickable

**Already Claimed Today (Gray):**
- Gray background
- Text: "Already Claimed"
- Not clickable

**After Claiming (Success):**
- Text changes to: "✓ Claimed 350 Coins!"
- Popup closes after 2 seconds

---

## Color Scheme

### Default Theme:

| Element | Color | RGB |
|---------|-------|-----|
| Primary (Current Day) | Blue | 75, 150, 255 |
| Secondary (Background) | Dark Gray | 50, 50, 50 |
| Accent (Coins) | Gold | 255, 200, 50 |
| Success (Claimed) | Green | 50, 200, 100 |
| Text | White | 255, 255, 255 |

---

## Animations

### 1. Popup Entrance
- Starts dari size 0x0 (invisible)
- Animates ke 600x450 (full size)
- Uses "Back" easing untuk bouncy effect
- Duration: 0.5 seconds

### 2. Button Hover
- Scale increases slightly (1.0 → 1.1)
- Smooth transition (0.2 seconds)

### 3. Claim Success
- Button text changes instantly
- Wait 2 seconds
- Popup shrinks ke 0x0 dan closes

---

## Screen Layout Example

```
┌─────────────────────────────────────────────────┐
│                  GAME SCREEN                    │
│                                                 │
│          ┌──────────────────────┐              │
│          │   DAILY REWARDS   [X]│              │
│          ├──────────────────────┤              │
│          │                      │              │
│          │  [Day Cards Grid]    │              │
│          │  □ □ ⬛ □ □ □ □      │              │
│          │                      │              │
│          │   ┌──────────┐       │              │
│          │   │  CLAIM!  │       │              │
│          │   └──────────┘       │              │
│          └──────────────────────┘              │
│                                                 │
│  Player Name                                    │
│  Coins: 850                                     │
└─────────────────────────────────────────────────┘
```

---

## Responsive Design

UI automatically adjust untuk different screen sizes:
- Mobile: Sama size, players boleh zoom
- Tablet: Optimized
- Desktop: Perfectly centered

---

## User Experience Flow

```
Player Joins Game
       ↓
[Wait 2 seconds]
       ↓
Popup Appears (Animated)
       ↓
Player Views Rewards
       ↓
Player Clicks "CLAIM"
       ↓
Button Text: "Claiming..."
       ↓
Server Validates
       ↓
[Success]
       ↓
Button Text: "✓ Claimed 350 Coins!"
Coins Added to Leaderboard
       ↓
[Wait 2 seconds]
       ↓
Popup Closes (Animated)
       ↓
Player Continues Playing
```

---

## Special Features

### Visual Feedback:
- ✅ Current day **glows** dengan gold border
- ✅ Claimed days show **checkmark**
- ✅ Coming days are **dimmed**
- ✅ Button has **hover effect**
- ✅ Smooth **animations**

### Smart System:
- ✅ Auto-detect kalau player dah claim today
- ✅ Track streak (7 days)
- ✅ Reset streak kalau miss >24 hours
- ✅ Save data dengan DataStore
- ✅ Show correct day based on history

---

## Customization Options

Easily customize dalam `DailyRewardsConfig`:

```lua
-- Change colors
UI.PrimaryColor = Color3.fromRGB(255, 100, 100)  -- Red theme

-- Change text
UI.Title = "HADIAH HARIAN"  -- Bahasa Melayu
UI.ClaimButtonText = "AMBIL SEKARANG!"

-- Change animation speed
UI.PopupAnimationSpeed = 1.0  -- Slower animation
```

---

## Accessibility

- Clear visual hierarchy
- Large, readable text
- High contrast colors
- Obvious interactive elements
- Smooth animations (not too fast)

---

**This UI designed untuk:**
- ✅ Look professional
- ✅ Easy untuk understand
- ✅ Fun dan engaging
- ✅ Mobile-friendly
- ✅ Encourage daily returns

Enjoy! 🎉
