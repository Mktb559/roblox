-- House Build Plugin - Step by Step Building System
-- Made by DuaBit Studio ⚡
-- Sistem untuk setup house building dengan step-by-step & cash system

local toolbar = plugin:CreateToolbar("House Builder")
local button = toolbar:CreateButton(
	"House Builder",
	"Setup step-by-step building system untuk rumah",
	"rbxassetid://6031100782"
)

-- Storage untuk building steps
local buildingSteps = {}
local selectedPart = nil
local previewFolder = nil

-- Widget GUI
local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float,
	false,
	false,
	400,
	600,
	350,
	500
)

local widget = plugin:CreateDockWidgetPluginGui("HouseBuildWidget", widgetInfo)
widget.Title = "House Builder Setup"

-- Create Main GUI
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
mainFrame.Parent = widget

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Text = "🏠 House Build Setup"
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

-- Instructions
local instructions = Instance.new("TextLabel")
instructions.Size = UDim2.new(1, -20, 0, 40)
instructions.Position = UDim2.new(0, 10, 0, 70)
instructions.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
instructions.BorderSizePixel = 0
instructions.Text = "1. Select part\n2. Fill form\n3. Add step\n4. Generate code!"
instructions.TextColor3 = Color3.fromRGB(200, 200, 200)
instructions.TextSize = 11
instructions.Font = Enum.Font.Gotham
instructions.TextYAlignment = Enum.TextYAlignment.Top
instructions.Parent = mainFrame

local instCorner = Instance.new("UICorner")
instCorner.CornerRadius = UDim.new(0, 8)
instCorner.Parent = instructions

-- Selected Part Display
local selectedLabel = Instance.new("TextLabel")
selectedLabel.Size = UDim2.new(1, -20, 0, 30)
selectedLabel.Position = UDim2.new(0, 10, 0, 120)
selectedLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
selectedLabel.BorderSizePixel = 0
selectedLabel.Text = "Selected: None"
selectedLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
selectedLabel.TextSize = 13
selectedLabel.Font = Enum.Font.GothamBold
selectedLabel.Parent = mainFrame

local selCorner = Instance.new("UICorner")
selCorner.CornerRadius = UDim.new(0, 6)
selCorner.Parent = selectedLabel

-- Input Frame
local inputFrame = Instance.new("Frame")
inputFrame.Size = UDim2.new(1, -20, 0, 200)
inputFrame.Position = UDim2.new(0, 10, 0, 160)
inputFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
inputFrame.BorderSizePixel = 0
inputFrame.Parent = mainFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputFrame

-- Helper function to create input field
local function createInputField(parent, labelText, yPos, defaultValue)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 100, 0, 30)
	label.Position = UDim2.new(0, 10, 0, yPos)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.TextSize = 12
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = parent

	local input = Instance.new("TextBox")
	input.Size = UDim2.new(1, -120, 0, 30)
	input.Position = UDim2.new(0, 110, 0, yPos)
	input.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
	input.BorderSizePixel = 0
	input.Text = defaultValue or ""
	input.TextColor3 = Color3.fromRGB(255, 255, 255)
	input.TextSize = 12
	input.Font = Enum.Font.Gotham
	input.PlaceholderText = "Enter " .. labelText:lower()
	input.ClearTextOnFocus = false
	input.Parent = parent

	local inputCorner2 = Instance.new("UICorner")
	inputCorner2.CornerRadius = UDim.new(0, 4)
	inputCorner2.Parent = input

	return input
end

-- Input fields
local nameInput = createInputField(inputFrame, "Button Name:", 10, "Floor")
local stepInput = createInputField(inputFrame, "Step Order:", 50, "1")
local priceInput = createInputField(inputFrame, "Price:", 90, "100")

-- Color picker button
local colorLabel = Instance.new("TextLabel")
colorLabel.Size = UDim2.new(0, 100, 0, 30)
colorLabel.Position = UDim2.new(0, 10, 0, 130)
colorLabel.BackgroundTransparency = 1
colorLabel.Text = "Color:"
colorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
colorLabel.TextSize = 12
colorLabel.Font = Enum.Font.Gotham
colorLabel.TextXAlignment = Enum.TextXAlignment.Left
colorLabel.Parent = inputFrame

local colorButton = Instance.new("TextButton")
colorButton.Size = UDim2.new(0, 50, 0, 30)
colorButton.Position = UDim2.new(0, 110, 0, 130)
colorButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
colorButton.BorderSizePixel = 0
colorButton.Text = ""
colorButton.Parent = inputFrame

local colorCorner = Instance.new("UICorner")
colorCorner.CornerRadius = UDim.new(0, 4)
colorCorner.Parent = colorButton

-- Material dropdown
local matLabel = Instance.new("TextLabel")
matLabel.Size = UDim2.new(0, 100, 0, 30)
matLabel.Position = UDim2.new(0, 10, 0, 170)
matLabel.BackgroundTransparency = 1
matLabel.Text = "Material:"
matLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
matLabel.TextSize = 12
matLabel.Font = Enum.Font.Gotham
matLabel.TextXAlignment = Enum.TextXAlignment.Left
matLabel.Parent = inputFrame

local matInput = createInputField(inputFrame, "", 170, "Plastic")
matInput.Position = UDim2.new(0, 110, 0, 170)
matInput.PlaceholderText = "e.g. Wood, Brick, Concrete"

-- Add Step Button
local addButton = Instance.new("TextButton")
addButton.Size = UDim2.new(1, -20, 0, 40)
addButton.Position = UDim2.new(0, 10, 0, 370)
addButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
addButton.BorderSizePixel = 0
addButton.Text = "➕ Add Building Step"
addButton.TextColor3 = Color3.fromRGB(255, 255, 255)
addButton.TextSize = 14
addButton.Font = Enum.Font.GothamBold
addButton.Parent = mainFrame

local addCorner = Instance.new("UICorner")
addCorner.CornerRadius = UDim.new(0, 8)
addCorner.Parent = addButton

-- Steps List
local stepsFrame = Instance.new("ScrollingFrame")
stepsFrame.Size = UDim2.new(1, -20, 0, 120)
stepsFrame.Position = UDim2.new(0, 10, 0, 420)
stepsFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
stepsFrame.BorderSizePixel = 0
stepsFrame.ScrollBarThickness = 6
stepsFrame.Parent = mainFrame

local stepsCorner = Instance.new("UICorner")
stepsCorner.CornerRadius = UDim.new(0, 8)
stepsCorner.Parent = stepsFrame

local stepsLayout = Instance.new("UIListLayout")
stepsLayout.Padding = UDim.new(0, 5)
stepsLayout.SortOrder = Enum.SortOrder.LayoutOrder
stepsLayout.Parent = stepsFrame

-- Generate Code Button
local generateButton = Instance.new("TextButton")
generateButton.Size = UDim2.new(1, -20, 0, 40)
generateButton.Position = UDim2.new(0, 10, 1, -50)
generateButton.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
generateButton.BorderSizePixel = 0
generateButton.Text = "🎯 Generate Building Code"
generateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
generateButton.TextSize = 14
generateButton.Font = Enum.Font.GothamBold
generateButton.Parent = mainFrame

local genCorner = Instance.new("UICorner")
genCorner.CornerRadius = UDim.new(0, 8)
genCorner.Parent = generateButton

-- Update selected part display
local function updateSelectedDisplay()
	if selectedPart then
		selectedLabel.Text = "Selected: " .. selectedPart.Name
		selectedLabel.TextColor3 = Color3.fromRGB(100, 255, 150)

		-- Auto-fill from selected part
		if nameInput.Text == "" or nameInput.Text == "Floor" then
			nameInput.Text = selectedPart.Name
		end
		colorButton.BackgroundColor3 = selectedPart.Color
		matInput.Text = selectedPart.Material.Name
	else
		selectedLabel.Text = "Selected: None (Select a part in workspace)"
		selectedLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
	end
end

-- Update steps list display
local function updateStepsList()
	-- Clear existing
	for _, child in ipairs(stepsFrame:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end

	-- Sort by step order
	table.sort(buildingSteps, function(a, b)
		return a.stepOrder < b.stepOrder
	end)

	-- Add step items
	for i, step in ipairs(buildingSteps) do
		local stepItem = Instance.new("Frame")
		stepItem.Size = UDim2.new(1, -10, 0, 35)
		stepItem.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
		stepItem.BorderSizePixel = 0
		stepItem.LayoutOrder = i
		stepItem.Parent = stepsFrame

		local stepCorner2 = Instance.new("UICorner")
		stepCorner2.CornerRadius = UDim.new(0, 6)
		stepCorner2.Parent = stepItem

		-- Step number
		local stepNum = Instance.new("TextLabel")
		stepNum.Size = UDim2.new(0, 30, 1, 0)
		stepNum.Position = UDim2.new(0, 5, 0, 0)
		stepNum.BackgroundTransparency = 1
		stepNum.Text = step.stepOrder
		stepNum.TextColor3 = Color3.fromRGB(100, 150, 255)
		stepNum.TextSize = 14
		stepNum.Font = Enum.Font.GothamBold
		stepNum.Parent = stepItem

		-- Color indicator
		local colorBox = Instance.new("Frame")
		colorBox.Size = UDim2.new(0, 20, 0, 20)
		colorBox.Position = UDim2.new(0, 40, 0, 7.5)
		colorBox.BackgroundColor3 = step.color
		colorBox.BorderSizePixel = 0
		colorBox.Parent = stepItem

		local colorCorner2 = Instance.new("UICorner")
		colorCorner2.CornerRadius = UDim.new(0, 4)
		colorCorner2.Parent = colorBox

		-- Name
		local stepName = Instance.new("TextLabel")
		stepName.Size = UDim2.new(1, -160, 1, 0)
		stepName.Position = UDim2.new(0, 65, 0, 0)
		stepName.BackgroundTransparency = 1
		stepName.Text = step.buttonName
		stepName.TextColor3 = Color3.fromRGB(255, 255, 255)
		stepName.TextSize = 12
		stepName.Font = Enum.Font.Gotham
		stepName.TextXAlignment = Enum.TextXAlignment.Left
		stepName.TextTruncate = Enum.TextTruncate.AtEnd
		stepName.Parent = stepItem

		-- Price
		local priceLabel = Instance.new("TextLabel")
		priceLabel.Size = UDim2.new(0, 60, 1, 0)
		priceLabel.Position = UDim2.new(1, -95, 0, 0)
		priceLabel.BackgroundTransparency = 1
		priceLabel.Text = "$" .. step.price
		priceLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
		priceLabel.TextSize = 12
		priceLabel.Font = Enum.Font.GothamBold
		priceLabel.Parent = stepItem

		-- Delete button
		local deleteBtn = Instance.new("TextButton")
		deleteBtn.Size = UDim2.new(0, 30, 0, 25)
		deleteBtn.Position = UDim2.new(1, -35, 0, 5)
		deleteBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
		deleteBtn.BorderSizePixel = 0
		deleteBtn.Text = "✕"
		deleteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		deleteBtn.TextSize = 14
		deleteBtn.Font = Enum.Font.GothamBold
		deleteBtn.Parent = stepItem

		local delCorner = Instance.new("UICorner")
		delCorner.CornerRadius = UDim.new(0, 4)
		delCorner.Parent = deleteBtn

		deleteBtn.MouseButton1Click:Connect(function()
			-- Remove from table
			table.remove(buildingSteps, i)
			-- Make part visible again
			if step.part then
				step.part.Transparency = 0
			end
			updateStepsList()
		end)
	end

	-- Update canvas size
	stepsFrame.CanvasSize = UDim2.new(0, 0, 0, stepsLayout.AbsoluteContentSize.Y + 10)
end

-- Listen for selection changes
local Selection = game:GetService("Selection")
Selection.SelectionChanged:Connect(function()
	local selected = Selection:Get()
	if #selected == 1 and selected[1]:IsA("BasePart") then
		selectedPart = selected[1]
		updateSelectedDisplay()
	end
end)

-- Color button click
colorButton.MouseButton1Click:Connect(function()
	if selectedPart then
		colorButton.BackgroundColor3 = selectedPart.Color
	end
end)

-- Add step button
addButton.MouseButton1Click:Connect(function()
	if not selectedPart then
		warn("⚠️ Please select a part first!")
		return
	end

	-- Validate inputs
	local stepOrder = tonumber(stepInput.Text)
	local price = tonumber(priceInput.Text)

	if not stepOrder then
		warn("⚠️ Step Order must be a number!")
		return
	end

	if not price then
		warn("⚠️ Price must be a number!")
		return
	end

	-- Check if part already added
	for _, step in ipairs(buildingSteps) do
		if step.part == selectedPart then
			warn("⚠️ This part is already added!")
			return
		end
	end

	-- Save original properties
	local stepData = {
		part = selectedPart,
		buttonName = nameInput.Text,
		stepOrder = stepOrder,
		price = price,
		color = colorButton.BackgroundColor3,
		material = matInput.Text,
		position = selectedPart.Position,
		cframe = selectedPart.CFrame,
		size = selectedPart.Size,
		partName = selectedPart.Name
	}

	-- Add to steps
	table.insert(buildingSteps, stepData)

	-- Make part semi-transparent to show it's configured
	selectedPart.Transparency = 0.5

	print("✅ Added step: " .. stepData.buttonName)

	-- Update displays
	updateStepsList()

	-- Clear selection and increment step
	selectedPart = nil
	Selection:Set({})
	stepInput.Text = tostring(stepOrder + 1)
	nameInput.Text = ""
	updateSelectedDisplay()
end)

-- Generate code button
generateButton.MouseButton1Click:Connect(function()
	if #buildingSteps == 0 then
		warn("⚠️ No building steps added yet!")
		return
	end

	-- Sort steps
	table.sort(buildingSteps, function(a, b)
		return a.stepOrder < b.stepOrder
	end)

	-- Create folder for storing original parts
	local storageFolder = Instance.new("Folder")
	storageFolder.Name = "HouseBuildParts_ORIGINAL"
	storageFolder.Parent = game.ServerStorage

	-- Clone and store all parts
	for _, step in ipairs(buildingSteps) do
		if step.part then
			local clone = step.part:Clone()
			clone.Name = "Step_" .. step.stepOrder .. "_" .. step.partName
			clone.Transparency = 0
			clone.Parent = storageFolder

			-- Make original part invisible
			step.part.Transparency = 1
			step.part.CanCollide = false
		end
	end

	-- Generate LocalScript code
	local code = [[-- House Building System - Auto Generated
-- Made by DuaBit Studio ⚡
-- Generated using House Build Plugin

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- IMPORTANT: Adjust these paths based on your game structure
local UnifiedSaveSystem = require(game.ServerStorage:WaitForChild("UnifiedSaveSystem"))

-- Building Configuration
local buildingSteps = {
]]

	-- Add steps data
	for _, step in ipairs(buildingSteps) do
		code = code .. string.format([[
	{
		stepOrder = %d,
		buttonName = "%s",
		price = %d,
		partName = "Step_%d_%s",
		color = Color3.fromRGB(%d, %d, %d),
		material = Enum.Material.%s,
		position = Vector3.new(%f, %f, %f),
		cframe = CFrame.new(%f, %f, %f) * CFrame.Angles(%f, %f, %f),
		size = Vector3.new(%f, %f, %f)
	},
]],
			step.stepOrder,
			step.buttonName,
			step.price,
			step.stepOrder,
			step.partName,
			step.color.R * 255,
			step.color.G * 255,
			step.color.B * 255,
			step.material,
			step.position.X, step.position.Y, step.position.Z,
			step.cframe.X, step.cframe.Y, step.cframe.Z,
			step.cframe:ToEulerAnglesXYZ()
		)
	end

	code = code .. [[
}

-- Track player building progress
local playerProgress = {}

-- Function to check if player has enough money
local function hasMoney(player, amount)
	local data = UnifiedSaveSystem:GetPlayerData(player)
	if data and data.Money then
		return data.Money >= amount
	end
	return false
end

-- Function to deduct money
local function deductMoney(player, amount)
	local data = UnifiedSaveSystem:GetPlayerData(player)
	if data and data.Money then
		data.Money = data.Money - amount
		UnifiedSaveSystem:UpdatePlayerData(player, "Money", data.Money)
		return true
	end
	return false
end

-- Function to build part
local function buildPart(player, stepOrder)
	-- Initialize player progress
	if not playerProgress[player.UserId] then
		playerProgress[player.UserId] = 0
	end

	-- Check if this is the next step
	if playerProgress[player.UserId] + 1 ~= stepOrder then
		return false, "You must build in order! Next step: " .. (playerProgress[player.UserId] + 1)
	end

	-- Find step data
	local stepData = nil
	for _, step in ipairs(buildingSteps) do
		if step.stepOrder == stepOrder then
			stepData = step
			break
		end
	end

	if not stepData then
		return false, "Invalid building step!"
	end

	-- Check money
	if not hasMoney(player, stepData.price) then
		return false, "Not enough money! Need $" .. stepData.price
	end

	-- Deduct money
	if not deductMoney(player, stepData.price) then
		return false, "Failed to deduct money!"
	end

	-- Get original part from ServerStorage
	local originalPart = ServerStorage.HouseBuildParts_ORIGINAL:FindFirstChild(stepData.partName)
	if not originalPart then
		return false, "Part not found in storage!"
	end

	-- Clone and place part
	local newPart = originalPart:Clone()
	newPart.CFrame = stepData.cframe
	newPart.Anchored = true
	newPart.Parent = workspace

	-- Update progress
	playerProgress[player.UserId] = stepOrder

	-- Check if house is complete
	if stepOrder == #buildingSteps then
		return true, "🎉 House complete! Congratulations!", true
	end

	return true, "✅ Built " .. stepData.buttonName .. "! Next: Step " .. (stepOrder + 1), false
end

-- Create RemoteEvent for client-server communication
local buildEvent = Instance.new("RemoteEvent")
buildEvent.Name = "BuildHousePart"
buildEvent.Parent = ReplicatedStorage

-- Handle build requests
buildEvent.OnServerEvent:Connect(function(player, stepOrder)
	local success, message, isComplete = buildPart(player, stepOrder)
	buildEvent:FireClient(player, success, message, isComplete)
end)

print("🏠 House Building System loaded!")
print("📊 Total steps: " .. #buildingSteps)

-- Optional: Create GUI for players
local function createBuildingGUI(player)
	local playerGui = player:WaitForChild("PlayerGui")

	-- Create ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "HouseBuildingGUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	-- Main Frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 300, 0, 400)
	mainFrame.Position = UDim2.new(1, -320, 0.5, -200)
	mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = mainFrame

	-- Title
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -20, 0, 40)
	title.Position = UDim2.new(0, 10, 0, 10)
	title.BackgroundTransparency = 1
	title.Text = "🏠 Build Your House"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 18
	title.Font = Enum.Font.GothamBold
	title.Parent = mainFrame

	-- Scroll frame for buttons
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Size = UDim2.new(1, -20, 1, -100)
	scrollFrame.Position = UDim2.new(0, 10, 0, 60)
	scrollFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
	scrollFrame.BorderSizePixel = 0
	scrollFrame.ScrollBarThickness = 6
	scrollFrame.Parent = mainFrame

	local scrollCorner = Instance.new("UICorner")
	scrollCorner.CornerRadius = UDim.new(0, 8)
	scrollCorner.Parent = scrollFrame

	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 8)
	listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	listLayout.Parent = scrollFrame

	-- Create buttons for each step
	for _, step in ipairs(buildingSteps) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, -20, 0, 50)
		btn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
		btn.BorderSizePixel = 0
		btn.Text = ""
		btn.Parent = scrollFrame

		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 8)
		btnCorner.Parent = btn

		-- Step number
		local stepLabel = Instance.new("TextLabel")
		stepLabel.Size = UDim2.new(0, 40, 1, 0)
		stepLabel.Position = UDim2.new(0, 5, 0, 0)
		stepLabel.BackgroundTransparency = 1
		stepLabel.Text = step.stepOrder
		stepLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
		stepLabel.TextSize = 20
		stepLabel.Font = Enum.Font.GothamBold
		stepLabel.Parent = btn

		-- Color indicator
		local colorBox = Instance.new("Frame")
		colorBox.Size = UDim2.new(0, 30, 0, 30)
		colorBox.Position = UDim2.new(0, 50, 0, 10)
		colorBox.BackgroundColor3 = step.color
		colorBox.BorderSizePixel = 0
		colorBox.Parent = btn

		local colorCorner2 = Instance.new("UICorner")
		colorCorner2.CornerRadius = UDim.new(0, 6)
		colorCorner2.Parent = colorBox

		-- Name and price
		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, -180, 0, 25)
		nameLabel.Position = UDim2.new(0, 90, 0, 5)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = step.buttonName
		nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		nameLabel.TextSize = 14
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.Parent = btn

		local priceLabel = Instance.new("TextLabel")
		priceLabel.Size = UDim2.new(1, -180, 0, 20)
		priceLabel.Position = UDim2.new(0, 90, 0, 25)
		priceLabel.BackgroundTransparency = 1
		priceLabel.Text = "$" .. step.price
		priceLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
		priceLabel.TextSize = 12
		priceLabel.Font = Enum.Font.Gotham
		priceLabel.TextXAlignment = Enum.TextXAlignment.Left
		priceLabel.Parent = btn

		-- Build button
		local buildBtn = Instance.new("TextButton")
		buildBtn.Size = UDim2.new(0, 70, 0, 35)
		buildBtn.Position = UDim2.new(1, -80, 0, 7.5)
		buildBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
		buildBtn.BorderSizePixel = 0
		buildBtn.Text = "Build"
		buildBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		buildBtn.TextSize = 13
		buildBtn.Font = Enum.Font.GothamBold
		buildBtn.Parent = btn

		local buildCorner = Instance.new("UICorner")
		buildCorner.CornerRadius = UDim.new(0, 6)
		buildCorner.Parent = buildBtn

		-- Handle click
		buildBtn.MouseButton1Click:Connect(function()
			buildBtn.Text = "..."
			buildEvent:FireServer(step.stepOrder)
		end)

		-- Listen for response
		buildEvent.OnClientEvent:Connect(function(success, message, isComplete)
			if success then
				buildBtn.Text = "✅"
				buildBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
				buildBtn.Active = false

				-- Show message
				local msgLabel = Instance.new("TextLabel")
				msgLabel.Size = UDim2.new(1, 0, 0, 30)
				msgLabel.Position = UDim2.new(0, 0, 0, -35)
				msgLabel.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
				msgLabel.BorderSizePixel = 0
				msgLabel.Text = message
				msgLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				msgLabel.TextSize = 12
				msgLabel.Font = Enum.Font.GothamBold
				msgLabel.Parent = mainFrame

				local msgCorner = Instance.new("UICorner")
				msgCorner.CornerRadius = UDim.new(0, 6)
				msgCorner.Parent = msgLabel

				wait(2)
				msgLabel:Destroy()

				if isComplete then
					-- Celebrate!
					wait(1)
					screenGui:Destroy()
				end
			else
				buildBtn.Text = "Build"

				-- Show error
				local errLabel = Instance.new("TextLabel")
				errLabel.Size = UDim2.new(1, 0, 0, 30)
				errLabel.Position = UDim2.new(0, 0, 0, -35)
				errLabel.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
				errLabel.BorderSizePixel = 0
				errLabel.Text = message
				errLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				errLabel.TextSize = 12
				errLabel.Font = Enum.Font.GothamBold
				errLabel.Parent = mainFrame

				local errCorner = Instance.new("UICorner")
				errCorner.CornerRadius = UDim.new(0, 6)
				errCorner.Parent = errLabel

				wait(2)
				errLabel:Destroy()
			end
		end)
	end

	-- Update canvas size
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
end

-- Create GUI for players when they join
Players.PlayerAdded:Connect(function(player)
	createBuildingGUI(player)
end)

-- Create for existing players
for _, player in ipairs(Players:GetPlayers()) do
	createBuildingGUI(player)
end
]]

	-- Save code to workspace
	local scriptObj = Instance.new("Script")
	scriptObj.Name = "HouseBuildingSystem_Generated"
	scriptObj.Source = code
	scriptObj.Parent = game.ServerScriptService

	print("🎯 Generated code saved to ServerScriptService!")
	print("📊 Total steps configured: " .. #buildingSteps)
	print("✅ House building system ready!")
	print("")
	print("📝 Next steps:")
	print("1. Original parts stored in ServerStorage/HouseBuildParts_ORIGINAL")
	print("2. Building script in ServerScriptService/HouseBuildingSystem_Generated")
	print("3. Make sure UnifiedSaveSystem is available!")
	print("4. Test in game!")

	-- Show success dialog
	local successFrame = Instance.new("Frame")
	successFrame.Size = UDim2.new(0, 350, 0, 200)
	successFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
	successFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
	successFrame.BorderSizePixel = 0
	successFrame.ZIndex = 100
	successFrame.Parent = mainFrame

	local successCorner = Instance.new("UICorner")
	successCorner.CornerRadius = UDim.new(0, 12)
	successCorner.Parent = successFrame

	local successTitle = Instance.new("TextLabel")
	successTitle.Size = UDim2.new(1, -20, 0, 50)
	successTitle.Position = UDim2.new(0, 10, 0, 10)
	successTitle.BackgroundTransparency = 1
	successTitle.Text = "🎉 Success!"
	successTitle.TextColor3 = Color3.fromRGB(100, 255, 150)
	successTitle.TextSize = 24
	successTitle.Font = Enum.Font.GothamBold
	successTitle.Parent = successFrame

	local successMsg = Instance.new("TextLabel")
	successMsg.Size = UDim2.new(1, -20, 0, 100)
	successMsg.Position = UDim2.new(0, 10, 0, 60)
	successMsg.BackgroundTransparency = 1
	successMsg.Text = "Building system generated!\n\n✅ " .. #buildingSteps .. " steps configured\n✅ Parts stored in ServerStorage\n✅ Script ready in ServerScriptService"
	successMsg.TextColor3 = Color3.fromRGB(200, 200, 200)
	successMsg.TextSize = 12
	successMsg.Font = Enum.Font.Gotham
	successMsg.TextYAlignment = Enum.TextYAlignment.Top
	successMsg.TextWrapped = true
	successMsg.Parent = successFrame

	local okBtn = Instance.new("TextButton")
	okBtn.Size = UDim2.new(0, 100, 0, 35)
	okBtn.Position = UDim2.new(0.5, -50, 1, -45)
	okBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
	okBtn.BorderSizePixel = 0
	okBtn.Text = "OK"
	okBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	okBtn.TextSize = 14
	okBtn.Font = Enum.Font.GothamBold
	okBtn.Parent = successFrame

	local okCorner = Instance.new("UICorner")
	okCorner.CornerRadius = UDim.new(0, 6)
	okCorner.Parent = okBtn

	okBtn.MouseButton1Click:Connect(function()
		successFrame:Destroy()
	end)
end)

-- Toggle widget
button.Click:Connect(function()
	widget.Enabled = not widget.Enabled
end)

-- Initialize
updateSelectedDisplay()
updateStepsList()

print("🏠 House Build Plugin loaded!")
print("⚡ Made by DuaBit Studio")
print("📝 Ready to setup step-by-step building system!")
