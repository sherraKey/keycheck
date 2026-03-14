local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Create main screen GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MoneyGenerator"
ScreenGui.Parent = PlayerGui

-- Outer frame with cyan border
local OuterFrame = Instance.new("Frame")
OuterFrame.Size = UDim2.new(0, 280, 0, 280)
OuterFrame.Position = UDim2.new(0.5, -140, 0.5, -140)
OuterFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
OuterFrame.BorderSizePixel = 0
OuterFrame.Visible = true
OuterFrame.Parent = ScreenGui

local OuterCorner = Instance.new("UICorner")
OuterCorner.CornerRadius = UDim.new(0, 12)
OuterCorner.Parent = OuterFrame

-- Version text
local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(0, 60, 0, 15)
VersionText.Position = UDim2.new(1, -65, 1, -18)
VersionText.BackgroundTransparency = 1
VersionText.Text = "Unlimited"
VersionText.TextColor3 = Color3.fromRGB(180, 180, 180)
VersionText.TextSize = 10
VersionText.Font = Enum.Font.Gotham
VersionText.TextXAlignment = Enum.TextXAlignment.Right
VersionText.ZIndex = 2
VersionText.Parent = OuterFrame

-- Main inner panel
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, -4, 1, -4)
MainFrame.Position = UDim2.new(0, 2, 0, 2)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = OuterFrame

OuterFrame.Active = true
OuterFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Title Background
local TitleBg = Instance.new("Frame")
TitleBg.Size = UDim2.new(1, 0, 0, 34)
TitleBg.Position = UDim2.new(0, 0, 0, 0)
TitleBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBg.BorderSizePixel = 0
TitleBg.ZIndex = 2
TitleBg.Parent = MainFrame

local TitleBgCorner = Instance.new("UICorner")
TitleBgCorner.CornerRadius = UDim.new(0, 10)
TitleBgCorner.Parent = TitleBg

-- Facebook Logo
local FacebookLogoBg = Instance.new("Frame")
FacebookLogoBg.Name = "FacebookLogoBg"
FacebookLogoBg.Parent = TitleBg
FacebookLogoBg.BackgroundColor3 = Color3.fromRGB(24, 119, 242)
FacebookLogoBg.BorderSizePixel = 0
FacebookLogoBg.AnchorPoint = Vector2.new(0, 0)
FacebookLogoBg.Position = UDim2.new(0, 8, 0.5, -10)
FacebookLogoBg.Size = UDim2.new(0, 20, 0, 20)
FacebookLogoBg.ZIndex = 5

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0.15, 0)
LogoCorner.Parent = FacebookLogoBg

local FacebookF = Instance.new("TextLabel")
FacebookF.Name = "FacebookF"
FacebookF.Parent = FacebookLogoBg
FacebookF.BackgroundTransparency = 1
FacebookF.Text = "f"
FacebookF.TextColor3 = Color3.fromRGB(255, 255, 255)
FacebookF.Font = Enum.Font.GothamBold
FacebookF.RichText = true
FacebookF.TextScaled = true
FacebookF.TextSize = 1
FacebookF.Size = UDim2.new(1.3, 0, 1.3, 0)
FacebookF.AnchorPoint = Vector2.new(0.5, 0.5)
FacebookF.Position = UDim2.new(0.5, 0, 0.55, 0)
FacebookF.TextXAlignment = Enum.TextXAlignment.Center
FacebookF.TextYAlignment = Enum.TextYAlignment.Center
FacebookF.ZIndex = 6

-- Title Shadow
local TitleShadow = Instance.new("TextLabel")
TitleShadow.Size = UDim2.new(1, -65, 0, 34)
TitleShadow.Position = UDim2.new(0, 35, 0, 3)
TitleShadow.BackgroundTransparency = 1
TitleShadow.Text = "DALVSTORE"  -- Updated to uppercase
TitleShadow.TextColor3 = Color3.fromRGB(60, 0, 90)
TitleShadow.TextTransparency = 0.7
TitleShadow.TextSize = 16
TitleShadow.Font = Enum.Font.SourceSansBold
TitleShadow.TextXAlignment = Enum.TextXAlignment.Left
TitleShadow.ZIndex = 3
TitleShadow.Parent = MainFrame

-- Main Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -65, 0, 34)
Title.Position = UDim2.new(0, 34, 0, 2)
Title.BackgroundTransparency = 1
Title.Text = "DALVSTORE"  -- Updated to uppercase
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 4
Title.Parent = MainFrame

local TitleOutline = Instance.new("UIStroke")
TitleOutline.Color = Color3.fromRGB(180, 0, 255)
TitleOutline.Thickness = 1.2
TitleOutline.Transparency = 0.3
TitleOutline.Parent = Title

local TitleGlow = Instance.new("UIGradient")
TitleGlow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 255))
})
TitleGlow.Rotation = 45
TitleGlow.Parent = TitleOutline

local TitleInnerGlow = Instance.new("UIGradient")
TitleInnerGlow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 240, 240)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 240))
})
TitleInnerGlow.Rotation = 0
TitleInnerGlow.Parent = Title

-- ========== SOUVENIR MANAGER UI ==========

-- Current Job ID display
local jobIdLabel = Instance.new("TextLabel")
jobIdLabel.Size = UDim2.new(0.6, -10, 0, 25)
jobIdLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
jobIdLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
jobIdLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
jobIdLabel.Text = "Job ID: " .. game.JobId
jobIdLabel.Font = Enum.Font.SourceSans
jobIdLabel.TextSize = 14
jobIdLabel.TextXAlignment = Enum.TextXAlignment.Left
jobIdLabel.Parent = MainFrame

-- Copy Job ID button
local copyJobBtn = Instance.new("TextButton")
copyJobBtn.Size = UDim2.new(0.3, -5, 0, 25)
copyJobBtn.Position = UDim2.new(0.68, 0, 0.15, 0)
copyJobBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
copyJobBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyJobBtn.Text = "Copy"
copyJobBtn.Font = Enum.Font.SourceSansBold
copyJobBtn.TextSize = 14
copyJobBtn.Parent = MainFrame

-- Job ID entry textbox
local jobIdBox = Instance.new("TextBox")
jobIdBox.Size = UDim2.new(0.6, -10, 0, 25)
jobIdBox.Position = UDim2.new(0.05, 0, 0.28, 0)
jobIdBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
jobIdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jobIdBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
jobIdBox.PlaceholderText = "Enter Job ID to join..."
jobIdBox.Text = ""
jobIdBox.Font = Enum.Font.SourceSans
jobIdBox.TextSize = 14
jobIdBox.ClearTextOnFocus = false
jobIdBox.Parent = MainFrame

-- Join button
local joinBtn = Instance.new("TextButton")
joinBtn.Size = UDim2.new(0.3, -5, 0, 25)
joinBtn.Position = UDim2.new(0.68, 0, 0.28, 0)
joinBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
joinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
joinBtn.Text = "Join"
joinBtn.Font = Enum.Font.SourceSansBold
joinBtn.TextSize = 14
joinBtn.Parent = MainFrame

-- Claim Codes button (now also opens boxes)
local claimBtn = Instance.new("TextButton")
claimBtn.Size = UDim2.new(0.9, 0, 0, 35)
claimBtn.Position = UDim2.new(0.05, 0, 0.41, 0)
claimBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
claimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
claimBtn.Text = "Claim & Open souv"
claimBtn.Font = Enum.Font.SourceSansBold
claimBtn.TextSize = 16
claimBtn.Parent = MainFrame

-- Status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 70)
statusLabel.Position = UDim2.new(0.05, 0, 0.58, 0)
statusLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 200)
statusLabel.Text = "Ready"
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 14
statusLabel.TextWrapped = true
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.TextYAlignment = Enum.TextYAlignment.Top
statusLabel.Parent = MainFrame

-- Minimize and Close buttons
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -60, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14
MinimizeButton.ZIndex = 3
MinimizeButton.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12
CloseButton.ZIndex = 3
CloseButton.Parent = MainFrame

-- Mini Icon (when minimized)
local MiniIcon = Instance.new("TextButton")
MiniIcon.Size = UDim2.new(0, 45, 0, 45)
MiniIcon.Position = UDim2.new(0, 10, 0, 10)
MiniIcon.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
MiniIcon.BorderSizePixel = 0
MiniIcon.Text = "🏦"
MiniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniIcon.TextSize = 18
MiniIcon.Visible = false
MiniIcon.Parent = ScreenGui

MiniIcon.Active = true
MiniIcon.Draggable = true

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 6)
MiniCorner.Parent = MiniIcon

-- ========== FUNCTIONALITY ==========

local codes = {
	"FALLENSTAR", "BALI", "THANKSGIVING", "MOUNTRUSHMORE", "SYDNEY",
	"HALLOWEEN", "LUXURY", "SPOOKY", "TAIWAN", "SHANGHAI",
	"ATLANTIS", "BRAZIL", "ALIEN", "TORONTO", "GIANT",
	"IRONMAN", "70MVISIT", "ADMIN", "SPACE", "ANGEL",
	"DEMON", "EVEREST", "PIXEL", "TITAN", "INDIA", "HARVEST", "STPATRICKS"
}

local codeRemote = game:GetService("ReplicatedStorage"):WaitForChild("ServerMsg"):WaitForChild("Code")
local souvenirRemote = game:GetService("ReplicatedStorage"):WaitForChild("Msg"):WaitForChild("RemoteFunction")

local function setStatus(text)
	statusLabel.Text = text
end

-- Function to open boxes
local function openBoxes()
	task.spawn(function()
		local bag = Player:FindFirstChild("Bag")
		if not bag then
			setStatus("Souvenir box not found!")
			return
		end
		
		local boxItems = {}
		for _, child in ipairs(bag:GetChildren()) do
			if child:IsA("NumberValue") and child.Name:match("^16000%d+$") then
				local count = child.Value
				if count and count > 0 then
					table.insert(boxItems, {id = child.Name, count = count})
				end
			end
		end
		
		if #boxItems == 0 then
			setStatus("No souvenir boxes found.")
			return
		end
		
		setStatus("Opening " .. #boxItems .. " box types...")
		
		local totalOpened = 0
		for _, item in ipairs(boxItems) do
			local id = tonumber(item.id)
			if id then
				for i = 1, item.count do
					pcall(function()
						souvenirRemote:InvokeServer("OpenSouvenirBox", id)
					end)
					totalOpened = totalOpened + 1
					task.wait(0.1)
				end
			end
		end
		
		setStatus("Complete! Opened " .. totalOpened .. " boxes.")
	end)
end

-- Copy Job ID
copyJobBtn.MouseButton1Click:Connect(function()
	setStatus("Job ID copied to clipboard!")
	pcall(function()
		setclipboard(game.JobId)
	end)
end)

-- Join server
joinBtn.MouseButton1Click:Connect(function()
	local targetJob = jobIdBox.Text:match("%S+")
	if not targetJob or targetJob == "" then
		setStatus("Please enter a Job ID.")
		return
	end
	
	setStatus("Attempting to join server: " .. targetJob)
	local TeleportService = game:GetService("TeleportService")
	local placeId = game.PlaceId
	
	local success, err = pcall(function()
		TeleportService:TeleportToPlaceInstance(placeId, targetJob)
	end)
	
	if not success then
		setStatus("Teleport failed: " .. tostring(err))
	else
		setStatus("Teleporting...")
	end
end)

-- Combined Claim Codes + Open Boxes
claimBtn.MouseButton1Click:Connect(function()
	task.spawn(function()
		setStatus("Claiming codes...")
		for _, code in ipairs(codes) do
			pcall(function()
				codeRemote:InvokeServer(code)
			end)
			task.wait(0.05)
		end
		setStatus("Codes claimed. Opening boxes...")
		openBoxes()
	end)
end)

-- Minimize/Restore
MinimizeButton.MouseButton1Click:Connect(function()
	OuterFrame.Visible = false
	MiniIcon.Visible = true
end)

MiniIcon.MouseButton1Click:Connect(function()
	OuterFrame.Visible = true
	MiniIcon.Visible = false
end)

CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)