-- Quick Furniture Builder Plugin untuk Roblox Studio (FIXED!)
-- Made by DuaBit Studio ⚡
-- Spawn furniture templates dengan cepat!

local toolbar = plugin:CreateToolbar("Furniture Builder")
local button = toolbar:CreateButton(
	"Quick Furniture",
	"Spawn furniture templates dengan cepat",
	"rbxassetid://6031097225"
)

-- Furniture Templates
local furnitureTemplates = {
	-- CHAIRS
	{
		Name = "Modern Chair",
		Category = "Chairs",
		Icon = "🪑",
		Color = Color3.fromRGB(139, 69, 19),
		Build = function(position)
			local model = Instance.new("Model")
			model.Name = "ModernChair"

			-- Seat
			local seat = Instance.new("Seat")
			seat.Name = "Seat"
			seat.Size = Vector3.new(2, 0.4, 2)
			seat.Position = position + Vector3.new(0, 1.2, 0)
			seat.Color = Color3.fromRGB(139, 69, 19)
			seat.Material = Enum.Material.Wood
			seat.Parent = model

			-- Backrest
			local back = Instance.new("Part")
			back.Name = "Backrest"
			back.Size = Vector3.new(2, 2, 0.3)
			back.Position = position + Vector3.new(0, 2.2, -0.85)
			back.Color = Color3.fromRGB(139, 69, 19)
			back.Material = Enum.Material.Wood
			back.Parent = model

			-- Legs
			for x = -1, 1, 2 do
				for z = -1, 1, 2 do
					local leg = Instance.new("Part")
					leg.Name = "Leg"
					leg.Size = Vector3.new(0.3, 1.2, 0.3)
					leg.Position = position + Vector3.new(x * 0.7, 0.6, z * 0.7)
					leg.Color = Color3.fromRGB(101, 67, 33)
					leg.Material = Enum.Material.Wood
					leg.Parent = model
				end
			end

			return model
		end
	},

	{
		Name = "Office Chair",
		Category = "Chairs",
		Icon = "💺",
		Color = Color3.fromRGB(50, 50, 50),
		Build = function(position)
			local model = Instance.new("Model")
			model.Name = "OfficeChair"

			-- Seat
			local seat = Instance.new("Seat")
			seat.Name = "Seat"
			seat.Size = Vector3.new(2.2, 0.5, 2.2)
			seat.Position = position + Vector3.new(0, 1.5, 0)
			seat.Color = Color3.fromRGB(50, 50, 50)
			seat.Material = Enum.Material.Fabric
			seat.Parent = model

			-- Backrest
			local back = Instance.new("Part")
			back.Name = "Backrest"
			back.Size = Vector3.new(2, 2.5, 0.4)
			back.Position = position + Vector3.new(0, 2.75, -0.9)
			back.Color = Color3.fromRGB(50, 50, 50)
			back.Material = Enum.Material.Fabric
			back.Parent = model

			-- Base (cylinder)
			local base = Instance.new("Part")
			base.Name = "Base"
			base.Size = Vector3.new(0.3, 1.2, 0.3)
			base.Position = position + Vector3.new(0, 0.6, 0)
			base.Color = Color3.fromRGB(70, 70, 70)
			base.Material = Enum.Material.Metal
			base.Shape = Enum.PartType.Cylinder
			base.Orientation = Vector3.new(0, 0, 90)
			base.Parent = model

			-- Wheels
			for i = 1, 5 do
				local angle = (i / 5) * math.pi * 2
				local wheel = Instance.new("Part")
				wheel.Name = "Wheel"
				wheel.Size = Vector3.new(0.4, 0.4, 0.4)
				wheel.Position = position + Vector3.new(math.cos(angle) * 0.8, 0.2, math.sin(angle) * 0.8)
				wheel.Color = Color3.fromRGB(30, 30, 30)
				wheel.Material = Enum.Material.SmoothPlastic
				wheel.Shape = Enum.PartType.Ball
				wheel.Parent = model
			end

			return model
		end
	},

	-- TABLES
	{
		Name = "Dining Table",
		Category = "Tables",
		Icon = "🍽️",
		Color = Color3.fromRGB(160, 82, 45),
		Build = function(position)
			local model = Instance.new("Model")
			model.Name = "DiningTable"

			-- Tabletop
			local top = Instance.new("Part")
			top.Name = "Tabletop"
			top.Size = Vector3.new(6, 0.4, 3)
			top.Position = position + Vector3.new(0, 2.5, 0)
			top.Color = Color3.fromRGB(160, 82, 45)
			top.Material = Enum.Material.Wood
			top.Parent = model

			-- Legs
			for x = -1, 1, 2 do
				for z = -1, 1, 2 do
					local leg = Instance.new("Part")
					leg.Name = "Leg"
					leg.Size = Vector3.new(0.4, 2.4, 0.4)
					leg.Position = position + Vector3.new(x * 2.5, 1.2, z * 1.2)
					leg.Color = Color3.fromRGB(139, 69, 19)
					leg.Material = Enum.Material.Wood
					leg.Parent = model
				end
			end

			return model
		end
	},

	{
		Name = "Coffee Table",
		Category = "Tables",
		Icon = "☕",
		Color = Color3.fromRGB(101, 67, 33),
		Build = function(position)
			local model = Instance.new("Model")
			model.Name = "CoffeeTable"

			-- Tabletop
			local top = Instance.new("Part")
			top.Name = "Tabletop"
			top.Size = Vector3.new(4, 0.3, 2.5)
			top.Position = position + Vector3.new(0, 1.2, 0)
			top.Color = Color3.fromRGB(101, 67, 33)
			top.Material = Enum.Material.Wood
			top.Parent = model

			-- Glass top
			local glass = Instance.new("Part")
			glass.Name = "Glass"
			glass.Size = Vector3.new(3.5, 0.1, 2)
			glass.Position = position + Vector3.new(0, 1.4, 0)
			glass.Color = Color3.fromRGB(200, 220, 255)
			glass.Material = Enum.Material.Glass
			glass.Transparency = 0.5
			glass.Parent = model

			-- Legs
			for x = -1, 1, 2 do
				for z = -1, 1, 2 do
					local leg = Instance.new("Part")
					leg.Name = "Leg"
					leg.Size = Vector3.new(0.3, 1.1, 0.3)
					leg.Position = position + Vector3.new(x * 1.6, 0.55, z * 1)
					leg.Color = Color3.fromRGB(70, 50, 30)
					leg.Material = Enum.Material.Wood
					leg.Parent = model
				end
			end

			return model
		end
	},

	{
		Name = "Desk",
		Category = "Tables",
		Icon = "🖥️",
		Color = Color3.fromRGB(80, 50, 30),
		Build = function(position)
			local model = Instance.new("Model")
			model.Name = "Desk"

			-- Desktop
			local top = Instance.new("Part")
			top.Name = "Desktop"
			top.Size = Vector3.new(5, 0.3, 2.5)
			top.Position = position + Vector3.new(0, 2.5, 0)
			top.Color = Color3.fromRGB(80, 50, 30)
			top.Material = Enum.Material.Wood
			top.Parent = model

			-- Left panel
			local leftPanel = Instance.new("Part")
			leftPanel.Name = "LeftPanel"
			leftPanel.Size = Vector3.new(0.3, 2.4, 2.5)
			leftPanel.Position = position + Vector3.new(-2.35, 1.2, 0)
			leftPanel.Color = Color3.fromRGB(80, 50, 30)
			leftPanel.Material = Enum.Material.Wood
			leftPanel.Parent = model

			-- Right panel
			local rightPanel = Instance.new("Part")
			rightPanel.Name = "RightPanel"
			rightPanel.Size = Vector3.new(0.3, 2.4, 2.5)
			rightPanel.Position = position + Vector3.new(2.35, 1.2, 0)
			rightPanel.Color = Color3.fromRGB(80, 50, 30)
			rightPanel.Material = Enum.Material.Wood
			rightPanel.Parent = model

			-- Drawers
			for i = 0, 2 do
				local drawer = Instance.new("Part")
				drawer.Name = "Drawer"
				drawer.Size = Vector3.new(1.8, 0.5, 2)
				drawer.Position = position + Vector3.new(-1.1, 1.8 - i * 0.6, 0.2)
				drawer.Color = Color3.fromRGB(70, 45, 25)
				drawer.Material = Enum.Material.Wood
				drawer.Parent = model

				-- Handle
				local handle = Instance.new("Part")
				handle.Name = "Handle"
				handle.Size = Vector3.new(0.6, 0.1, 0.1)
				handle.Position = position + Vector3.new(-1.1, 1.8 - i * 0.6, 1.3)
				handle.Color = Color3.fromRGB(150, 150, 150)
				handle.Material = Enum.Material.Metal
				handle.Parent = model
			end

			return model
		end
	},

	-- BEDS
	{
		Name = "Single Bed",
		Category = "Beds",
		Icon = "🛏️",
		Color = Color3.fromRGB(70, 130, 180),
		Build = function(position)
			local model = Instance.new("Model")
			model.Name = "SingleBed"

			-- Mattress
			local mattress = Instance.new("Part")
			mattress.Name = "Mattress"
			mattress.Size = Vector3.new(4, 0.8, 6)
			mattress.Position = position + Vector3.new(0, 1, 0)
			mattress.Color = Color3.fromRGB(70, 130, 180)
			mattress.Material = Enum.Material.Fabric
			mattress.Parent = model

			-- Bed frame
			local frame = Instance.new("Part")
			frame.Name = "Frame"
			frame.Size = Vector3.new(4.2, 0.4, 6.2)
			frame.Position = position + Vector3.new(0, 0.4, 0)
			frame.Color = Color3.fromRGB(101, 67, 33)
			frame.Material = Enum.Material.Wood
			frame.Parent = model

			-- Headboard
			local headboard = Instance.new("Part")
			headboard.Name = "Headboard"
			headboard.Size = Vector3.new(4.2, 2, 0.3)
			headboard.Position = position + Vector3.new(0, 1.6, -3)
			headboard.Color = Color3.fromRGB(101, 67, 33)
			headboard.Material = Enum.Material.Wood
			headboard.Parent = model

			-- Pillow
			local pillow = Instance.new("Part")
			pillow.Name = "Pillow"
			pillow.Size = Vector3.new(2.5, 0.4, 1.5)
			pillow.Position = position + Vector3.new(0, 1.6, -2)
			pillow.Color = Color3.fromRGB(255, 255, 255)
			pillow.Material = Enum.Material.Fabric
			pillow.Parent = model

			-- Blanket
			local blanket = Instance.new("Part")
			blanket.Name = "Blanket"
			blanket.Size = Vector3.new(3.8, 0.2, 4)
			blanket.Position = position + Vector3.new(0, 1.5, 0.5)
			blanket.Color = Color3.fromRGB(100, 150, 200)
			blanket.Material = Enum.Material.Fabric
			blanket.Parent = model

			return model
		end
	},

	{
		Name = "Double Bed",
		Category = "Beds",
		Icon = "🛌",
		Color = Color3.fromRGB(139, 69, 19),
		Build = function(position)
			local model = Instance.new("Model")
			model.Name = "DoubleBed"

			-- Mattress
			local mattress = Instance.new("Part")
			mattress.Name = "Mattress"
			mattress.Size = Vector3.new(6, 0.8, 6.5)
			mattress.Position = position + Vector3.new(0, 1, 0)
			mattress.Color = Color3.fromRGB(250, 250, 250)
			mattress.Material = Enum.Material.Fabric
			mattress.Parent = model

			-- Bed frame
			local frame = Instance.new("Part")
			frame.Name = "Frame"
			frame.Size = Vector3.new(6.3, 0.5, 6.8)
			frame.Position = position + Vector3.new(0, 0.4, 0)
			frame.Color = Color3.fromRGB(139, 69, 19)
			frame.Material = Enum.Material.Wood
			frame.Parent = model

			-- Headboard
			local headboard = Instance.new("Part")
			headboard.Name = "Headboard"
			headboard.Size = Vector3.new(6.3, 2.5, 0.4)
			headboard.Position = position + Vector3.new(0, 1.8, -3.3)
			headboard.Color = Color3.fromRGB(139, 69, 19)
			headboard.Material = Enum.Material.Wood
			headboard.Parent = model

			-- Footboard
			local footboard = Instance.new("Part")
			footboard.Name = "Footboard"
			footboard.Size = Vector3.new(6.3, 1, 0.4)
			footboard.Position = position + Vector3.new(0, 1, 3.3)
			footboard.Color = Color3.fromRGB(139, 69, 19)
			footboard.Material = Enum.Material.Wood
			footboard.Parent = model

			-- Pillows
			for x = -1, 1, 2 do
				local pillow = Instance.new("Part")
				pillow.Name = "Pillow"
				pillow.Size = Vector3.new(2, 0.4, 1.5)
				pillow.Position = position + Vector3.new(x * 1.5, 1.6, -2.2)
				pillow.Color = Color3.fromRGB(255, 255, 255)
				pillow.Material = Enum.Material.Fabric
				pillow.Parent = model
			end

			-- Blanket
			local blanket = Instance.new("Part")
			blanket.Name = "Blanket"
			blanket.Size = Vector3.new(5.5, 0.2, 5)
			blanket.Position = position + Vector3.new(0, 1.5, 0.3)
			blanket.Color = Color3.fromRGB(120, 80, 150)
			blanket.Material = Enum.Material.Fabric
			blanket.Parent = model

			return model
		end
	},

	-- CABINETS
	{
		Name = "Wardrobe",
		Category = "Cabinets",
		Icon = "👔",
		Color = Color3.fromRGB(101, 67, 33),
		Build = function(position)
			local model = Instance.new("Model")
			model.Name = "Wardrobe"

			-- Main body
			local body = Instance.new("Part")
			body.Name = "Body"
			body.Size = Vector3.new(4, 6, 2)
			body.Position = position + Vector3.new(0, 3, 0)
			body.Color = Color3.fromRGB(101, 67, 33)
			body.Material = Enum.Material.Wood
			body.Parent = model

			-- Left door
			local leftDoor = Instance.new("Part")
			leftDoor.Name = "LeftDoor"
			leftDoor.Size = Vector3.new(1.9, 5.5, 0.2)
			leftDoor.Position = position + Vector3.new(-1, 3, 1.1)
			leftDoor.Color = Color3.fromRGB(90, 60, 30)
			leftDoor.Material = Enum.Material.Wood
			leftDoor.Parent = model

			-- Right door
			local rightDoor = Instance.new("Part")
			rightDoor.Name = "RightDoor"
			rightDoor.Size = Vector3.new(1.9, 5.5, 0.2)
			rightDoor.Position = position + Vector3.new(1, 3, 1.1)
			rightDoor.Color = Color3.fromRGB(90, 60, 30)
			rightDoor.Material = Enum.Material.Wood
			rightDoor.Parent = model

			-- Handles
			for x = -1, 1, 2 do
				local handle = Instance.new("Part")
				handle.Name = "Handle"
				handle.Size = Vector3.new(0.2, 0.8, 0.2)
				handle.Position = position + Vector3.new(x * 0.5, 3, 1.3)
				handle.Color = Color3.fromRGB(180, 180, 180)
				handle.Material = Enum.Material.Metal
				handle.Parent = model
			end

			-- Top shelf
			local topShelf = Instance.new("Part")
			topShelf.Name = "TopShelf"
			topShelf.Size = Vector3.new(3.8, 0.2, 1.8)
			topShelf.Position = position + Vector3.new(0, 5, 0)
			topShelf.Color = Color3.fromRGB(101, 67, 33)
			topShelf.Material = Enum.Material.Wood
			topShelf.Parent = model

			return model
		end
	},

	{
		Name = "Bookshelf",
		Category = "Cabinets",
		Icon = "📚",
		Color = Color3.fromRGB(139, 90, 43),
		Build = function(position)
			local model = Instance.new("Model")
			model.Name = "Bookshelf"

			-- Back panel
			local back = Instance.new("Part")
			back.Name = "BackPanel"
			back.Size = Vector3.new(4, 6, 0.2)
			back.Position = position + Vector3.new(0, 3, -0.9)
			back.Color = Color3.fromRGB(139, 90, 43)
			back.Material = Enum.Material.Wood
			back.Parent = model

			-- Left panel
			local left = Instance.new("Part")
			left.Name = "LeftPanel"
			left.Size = Vector3.new(0.2, 6, 2)
			left.Position = position + Vector3.new(-1.9, 3, 0)
			left.Color = Color3.fromRGB(139, 90, 43)
			left.Material = Enum.Material.Wood
			left.Parent = model

			-- Right panel
			local right = Instance.new("Part")
			right.Name = "RightPanel"
			right.Size = Vector3.new(0.2, 6, 2)
			right.Position = position + Vector3.new(1.9, 3, 0)
			right.Color = Color3.fromRGB(139, 90, 43)
			right.Material = Enum.Material.Wood
			right.Parent = model

			-- Shelves
			for i = 0, 4 do
				local shelf = Instance.new("Part")
				shelf.Name = "Shelf"
				shelf.Size = Vector3.new(3.6, 0.2, 2)
				shelf.Position = position + Vector3.new(0, i * 1.4 + 0.2, 0)
				shelf.Color = Color3.fromRGB(139, 90, 43)
				shelf.Material = Enum.Material.Wood
				shelf.Parent = model

				-- Add some books
				if i > 0 and i < 4 then
					for j = 1, 3 do
						local book = Instance.new("Part")
						book.Name = "Book"
						book.Size = Vector3.new(0.3, 1, 0.8)
						book.Position = position + Vector3.new(-1.2 + j * 0.8, i * 1.4 + 0.7, 0)
						book.Color = Color3.fromRGB(math.random(100, 255), math.random(50, 200), math.random(50, 200))
						book.Material = Enum.Material.SmoothPlastic
						book.Parent = model
					end
				end
			end

			return model
		end
	},

	{
		Name = "Drawer Cabinet",
		Category = "Cabinets",
		Icon = "🗄️",
		Color = Color3.fromRGB(80, 80, 80),
		Build = function(position)
			local model = Instance.new("Model")
			model.Name = "DrawerCabinet"

			-- Main body
			local body = Instance.new("Part")
			body.Name = "Body"
			body.Size = Vector3.new(2, 3, 1.5)
			body.Position = position + Vector3.new(0, 1.5, 0)
			body.Color = Color3.fromRGB(80, 80, 80)
			body.Material = Enum.Material.Metal
			body.Parent = model

			-- Drawers
			for i = 0, 3 do
				local drawer = Instance.new("Part")
				drawer.Name = "Drawer"
				drawer.Size = Vector3.new(1.8, 0.6, 1.3)
				drawer.Position = position + Vector3.new(0, 2.7 - i * 0.75, 0.1)
				drawer.Color = Color3.fromRGB(70, 70, 70)
				drawer.Material = Enum.Material.Metal
				drawer.Parent = model

				-- Handle
				local handle = Instance.new("Part")
				handle.Name = "Handle"
				handle.Size = Vector3.new(0.8, 0.1, 0.1)
				handle.Position = position + Vector3.new(0, 2.7 - i * 0.75, 0.8)
				handle.Color = Color3.fromRGB(150, 150, 150)
				handle.Material = Enum.Material.Metal
				handle.Parent = model
			end

			return model
		end
	},
}

-- Widget GUI
local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float,
	false,
	false,
	350,
	500,
	300,
	400
)

local widget = plugin:CreateDockWidgetPluginGui("QuickFurnitureWidget", widgetInfo)
widget.Title = "Quick Furniture Builder"

-- Create GUI
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
mainFrame.Parent = widget

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Text = "🪑 Quick Furniture Builder"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Brand
local brand = Instance.new("TextLabel")
brand.Size = UDim2.new(1, -20, 0, 20)
brand.Position = UDim2.new(0, 10, 0, 45)
brand.BackgroundTransparency = 1
brand.Text = "by DuaBit Studio ⚡"
brand.TextColor3 = Color3.fromRGB(100, 150, 255)
brand.TextSize = 12
brand.Font = Enum.Font.GothamBold
brand.Parent = mainFrame

-- Category tabs (FIXED!)
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, -20, 0, 40)
tabFrame.Position = UDim2.new(0, 10, 0, 70)
tabFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 8)
tabCorner.Parent = tabFrame

-- FIX: Use UIPadding instead of UIListLayout padding!
local tabPadding = Instance.new("UIPadding")
tabPadding.PaddingLeft = UDim.new(0, 5)
tabPadding.PaddingRight = UDim.new(0, 5)
tabPadding.PaddingTop = UDim.new(0, 5)
tabPadding.PaddingBottom = UDim.new(0, 5)
tabPadding.Parent = tabFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 5)  -- Gap between tabs
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Parent = tabFrame

-- Scroll frame for furniture
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -130)
scrollFrame.Position = UDim2.new(0, 10, 0, 120)
scrollFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 8
scrollFrame.Parent = mainFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 10)
scrollCorner.Parent = scrollFrame

local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0, 150, 0, 120)
gridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
gridLayout.SortOrder = Enum.SortOrder.Name
gridLayout.Parent = scrollFrame

-- Current category
local currentCategory = "Chairs"

-- Function to spawn furniture
local function spawnFurniture(template)
	local camera = workspace.CurrentCamera
	local spawnPosition = camera.CFrame.Position + camera.CFrame.LookVector * 10
	spawnPosition = Vector3.new(spawnPosition.X, 0, spawnPosition.Z)

	local furniture = template.Build(spawnPosition)
	furniture.Parent = workspace

	-- Weld all parts together
	local primaryPart = furniture:FindFirstChildWhichIsA("BasePart")
	if primaryPart then
		furniture.PrimaryPart = primaryPart
		for _, part in ipairs(furniture:GetDescendants()) do
			if part:IsA("BasePart") and part ~= primaryPart then
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = primaryPart
				weld.Part1 = part
				weld.Parent = part
			end
		end
	end

	game:GetService("Selection"):Set({furniture})
	print("✅ " .. template.Name .. " telah di-spawn!")
end

-- Function to update furniture display
local function updateDisplay(category)
	currentCategory = category

	-- Clear current items
	for _, child in ipairs(scrollFrame:GetChildren()) do
		if child:IsA("GuiButton") then
			child:Destroy()
		end
	end

	-- Add furniture buttons
	for _, template in ipairs(furnitureTemplates) do
		if template.Category == category then
			local btn = Instance.new("TextButton")
			btn.BackgroundColor3 = template.Color
			btn.BorderSizePixel = 0
			btn.Text = ""
			btn.Parent = scrollFrame

			local btnCorner = Instance.new("UICorner")
			btnCorner.CornerRadius = UDim.new(0, 10)
			btnCorner.Parent = btn

			-- Icon
			local icon = Instance.new("TextLabel")
			icon.Size = UDim2.new(1, 0, 0, 50)
			icon.Position = UDim2.new(0, 0, 0, 10)
			icon.BackgroundTransparency = 1
			icon.Text = template.Icon
			icon.TextSize = 40
			icon.Parent = btn

			-- Name
			local name = Instance.new("TextLabel")
			name.Size = UDim2.new(1, -10, 0, 50)
			name.Position = UDim2.new(0, 5, 1, -55)
			name.BackgroundTransparency = 1
			name.Text = template.Name
			name.TextColor3 = Color3.fromRGB(255, 255, 255)
			name.TextSize = 14
			name.Font = Enum.Font.GothamBold
			name.TextWrapped = true
			name.TextYAlignment = Enum.TextYAlignment.Top
			name.Parent = btn

			btn.MouseButton1Click:Connect(function()
				spawnFurniture(template)
			end)
		end
	end

	-- Update canvas size
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y + 10)
end

-- Create category tabs (FIXED SIZE!)
local categories = {"Chairs", "Tables", "Beds", "Cabinets"}

-- Calculate proper size: (frame width - padding) / number of tabs - gap
-- Frame width when shown = 330 (350 - 20)
-- Inner width = 330 - 10 (left+right padding) = 320
-- 4 tabs with 3 gaps of 5px = 15px
-- Each tab = (320 - 15) / 4 = 76.25px

for i, category in ipairs(categories) do
	local tab = Instance.new("TextButton")
	-- FIXED: Use offset size to fit properly!
	tab.Size = UDim2.new(0, 75, 1, -10)  -- Fixed width 75px, height fill minus padding
	tab.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
	tab.BorderSizePixel = 0
	tab.Text = category
	tab.TextColor3 = Color3.fromRGB(200, 200, 200)
	tab.TextSize = 13
	tab.Font = Enum.Font.GothamBold
	tab.TextWrapped = true
	tab.Parent = tabFrame

	local tabCorner2 = Instance.new("UICorner")
	tabCorner2.CornerRadius = UDim.new(0, 6)
	tabCorner2.Parent = tab

	tab.MouseButton1Click:Connect(function()
		-- Update all tabs
		for _, t in ipairs(tabFrame:GetChildren()) do
			if t:IsA("TextButton") then
				if t == tab then
					t.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
					t.TextColor3 = Color3.fromRGB(255, 255, 255)
				else
					t.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
					t.TextColor3 = Color3.fromRGB(200, 200, 200)
				end
			end
		end
		updateDisplay(category)
	end)

	-- Set initial active tab
	if category == currentCategory then
		tab.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
		tab.TextColor3 = Color3.fromRGB(255, 255, 255)
	end
end

-- Initial display
updateDisplay(currentCategory)

-- Update canvas size when grid layout changes
gridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y + 10)
end)

-- Toggle widget
button.Click:Connect(function()
	widget.Enabled = not widget.Enabled
end)

print("🪑 Quick Furniture Builder Plugin loaded! Ready to build!")
print("⚡ Made by DuaBit Studio")
print("✅ Layout FIXED - No more overflow!")
