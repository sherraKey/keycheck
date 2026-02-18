local Players = game:GetService("Players")
local Player = Players.LocalPlayer 
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ================= AUTHORIZATION LOGIC =================

local function checkAuthorization()
    -- Load authorized users from remote website using loadstring
    local authorizedUsers = loadstring(game:HttpGet("https://raw.githubusercontent.com/sherraKey/keycheck/refs/heads/main/Inj34Keys"))()
    
    -- Check if current user is in the authorized list
    local isAuthorized = false
    for _, username in ipairs(authorizedUsers) do
        if Player.Name == username then
            isAuthorized = true
            break
        end
    end
    
    if not isAuthorized then
        return false, "You don't have an access, contact fb: dalvstore"
    end
    
    return true, "Authorized"
end

-- Execute authorization check
local isAuthorized, reason = checkAuthorization()

if not isAuthorized then
    -- Create a simple unauthorized message
    local UnauthorizedScreenGui = Instance.new("ScreenGui")
    UnauthorizedScreenGui.Name = "UnauthorizedMessage"
    UnauthorizedScreenGui.Parent = PlayerGui
    
    local UnauthorizedFrame = Instance.new("Frame")
    UnauthorizedFrame.Size = UDim2.new(0, 350, 0, 200)
    UnauthorizedFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
    UnauthorizedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    UnauthorizedFrame.BorderSizePixel = 0
    UnauthorizedFrame.Parent = UnauthorizedScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = UnauthorizedFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    Title.Text = "UNAUTHORIZED"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 22
    Title.Font = Enum.Font.GothamBold
    Title.Parent = UnauthorizedFrame
    
    local Message = Instance.new("TextLabel")
    Message.Size = UDim2.new(0.9, 0, 0, 80)
    Message.Position = UDim2.new(0.05, 0, 0.3, 0)
    Message.BackgroundTransparency = 1
    Message.Text = "You don't have an access, contact fb: dalvstore"
    Message.TextColor3 = Color3.fromRGB(255, 255, 255)
    Message.TextSize = 14
    Message.TextWrapped = true
    Message.Parent = UnauthorizedFrame
    
    -- Button container
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Size = UDim2.new(1, 0, 0, 30)
    ButtonContainer.Position = UDim2.new(0, 0, 0.8, 0)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = UnauthorizedFrame
    
    -- BUY button
    local BuyButton = Instance.new("TextButton")
    BuyButton.Size = UDim2.new(0.4, 0, 1, 0)
    BuyButton.Position = UDim2.new(0.05, 0, 0, 0)
    BuyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    BuyButton.BorderSizePixel = 0
    BuyButton.Text = "BUY"
    BuyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    BuyButton.TextSize = 14
    BuyButton.Font = Enum.Font.GothamBold
    BuyButton.Parent = ButtonContainer
    
    local BuyButtonCorner = Instance.new("UICorner")
    BuyButtonCorner.CornerRadius = UDim.new(0, 6)
    BuyButtonCorner.Parent = BuyButton
    
    -- CLOSE button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0.4, 0, 1, 0)
    CloseButton.Position = UDim2.new(0.55, 0, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "CLOSE"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = ButtonContainer
    
    local CloseButtonCorner = Instance.new("UICorner")
    CloseButtonCorner.CornerRadius = UDim.new(0, 6)
    CloseButtonCorner.Parent = CloseButton
    
    -- Function to copy the buy button
    BuyButton.MouseButton1Click:Connect(function()
        setclipboard("https://sociabuzz.com/dalvstore/tribe")
        
        -- Show notification
        local NotificationService = game:GetService("StarterGui")
        NotificationService:SetCore("SendNotification", {
            Title = "Link copied",
            Text = "Paste on your browser to buy the script",
            Duration = 5,
            Icon = "rbxassetid://4483345998" -- Default notification icon
        })
        
        -- Also print to console for debugging
        print("Link copied to clipboard: https://sociabuzz.com/dalvstore/tribe")
    end)
    
    -- CLOSE button click event
    CloseButton.MouseButton1Click:Connect(function()
        UnauthorizedScreenGui:Destroy()
    end)
    
    return -- Stop script execution
end

-- If authorized, continue with the rest of the script
print("Authorized! ")
-- ... rest of your script remains exactly the same ...
-- ================= MAIN SCRIPT (ONLY EXECUTES IF AUTHORIZED) =================

local Leaderstats = Player:WaitForChild("leaderstats", 5)
local MoneyStat = Leaderstats and Leaderstats:WaitForChild("Money", 5)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MoneyGenerator"
ScreenGui.Parent = PlayerGui
ScreenGui.DisplayOrder = 9999  -- HIGHEST PRIORITY - will appear on top of other GUIs
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Create a container for the entire interface (tabs + panel)
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 370, 0, 280)
MainContainer.Position = UDim2.new(0.5, -185, 0.5, -140)
MainContainer.BackgroundTransparency = 1
MainContainer.Parent = ScreenGui
MainContainer.ZIndex = 1

-- Make the entire container draggable
MainContainer.Active = true
MainContainer.Draggable = true

-- ================= TABS (OUTSIDE THE PANEL) =================

-- Tab Container (Left of the panel)
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 65, 0, 140)
TabContainer.Position = UDim2.new(0, 5, 0, 70)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainContainer
TabContainer.ZIndex = 2

-- NEW Tab 0 Button - WARNING WITH BLACK BORDER
local Tab0Border = Instance.new("Frame")
Tab0Border.Size = UDim2.new(0, 69, 0, 39)  -- 4px larger for 2px border on each side
Tab0Border.Position = UDim2.new(0, -2, 0, 0)  -- Adjusted to center
Tab0Border.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Black color
Tab0Border.BorderSizePixel = 0
Tab0Border.ZIndex = 1
Tab0Border.Parent = TabContainer

local Tab0BorderCorner = Instance.new("UICorner")
Tab0BorderCorner.CornerRadius = UDim.new(0, 8)
Tab0BorderCorner.Parent = Tab0Border

local Tab0Button = Instance.new("TextButton")
Tab0Button.Size = UDim2.new(1, -4, 1, -4)  -- 2px border on each side
Tab0Button.Position = UDim2.new(0, 2, 0, 2)
Tab0Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Tab0Button.BorderSizePixel = 0
Tab0Button.Text = "WARNING"
Tab0Button.TextColor3 = Color3.fromRGB(200, 200, 200)
Tab0Button.TextSize = 10
Tab0Button.Font = Enum.Font.GothamBold
Tab0Button.TextWrapped = true
Tab0Button.Name = "Tab0Button"
Tab0Button.ZIndex = 2
Tab0Button.Parent = Tab0Border

local Tab0Corner = Instance.new("UICorner")
Tab0Corner.CornerRadius = UDim.new(0, 6)
Tab0Corner.Parent = Tab0Button

-- Tab 1 Button - injector with premium text WITH BLACK BORDER
local Tab1Border = Instance.new("Frame")
Tab1Border.Size = UDim2.new(0, 69, 0, 39)  -- 4px larger for 2px border on each side
Tab1Border.Position = UDim2.new(0, -2, 0, 45)  -- Adjusted to center
Tab1Border.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Black color
Tab1Border.BorderSizePixel = 0
Tab1Border.ZIndex = 1
Tab1Border.Parent = TabContainer

local Tab1BorderCorner = Instance.new("UICorner")
Tab1BorderCorner.CornerRadius = UDim.new(0, 8)
Tab1BorderCorner.Parent = Tab1Border

local Tab1Button = Instance.new("TextButton")
Tab1Button.Size = UDim2.new(1, -4, 1, -4)  -- 2px border on each side
Tab1Button.Position = UDim2.new(0, 2, 0, 2)
Tab1Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)  -- Inactive color
Tab1Button.BorderSizePixel = 0
Tab1Button.Text = ""  -- Text will be handled by child labels
Tab1Button.TextColor3 = Color3.fromRGB(200, 200, 200)  -- Inactive text color
Tab1Button.TextSize = 12
Tab1Button.Font = Enum.Font.GothamBold
Tab1Button.TextWrapped = true
Tab1Button.Name = "Tab1Button"
Tab1Button.ZIndex = 2
Tab1Button.Parent = Tab1Border

local Tab1Corner = Instance.new("UICorner")
Tab1Corner.CornerRadius = UDim.new(0, 6)
Tab1Corner.Parent = Tab1Button

-- "injector" text inside Tab1Button
local InjectorText = Instance.new("TextLabel")
InjectorText.Size = UDim2.new(1, 0, 0, 20)
InjectorText.Position = UDim2.new(0, 0, 0, 2)
InjectorText.BackgroundTransparency = 1
InjectorText.Text = "INJECTOR"
InjectorText.TextColor3 = Color3.fromRGB(200, 200, 200)  -- Inactive color
InjectorText.TextSize = 12
InjectorText.Font = Enum.Font.GothamBold
InjectorText.TextXAlignment = Enum.TextXAlignment.Center
InjectorText.TextYAlignment = Enum.TextYAlignment.Top
InjectorText.Name = "InjectorText"
InjectorText.ZIndex = 3
InjectorText.Parent = Tab1Button

-- "premium" text inside Tab1Button
local PremiumText = Instance.new("TextLabel")
PremiumText.Size = UDim2.new(1, 0, 0, 15)
PremiumText.Position = UDim2.new(0, 0, 0, 20)
PremiumText.BackgroundTransparency = 1
PremiumText.Text = "premium"
PremiumText.TextColor3 = Color3.fromRGB(150, 150, 150)  -- Lighter gray for premium text
PremiumText.TextSize = 9
PremiumText.Font = Enum.Font.Gotham
PremiumText.TextXAlignment = Enum.TextXAlignment.Center
PremiumText.TextYAlignment = Enum.TextYAlignment.Top
PremiumText.Name = "PremiumText"
PremiumText.ZIndex = 3
PremiumText.Parent = Tab1Button

-- Tab 2 Button - CODE WITH BLACK BORDER
local Tab2Border = Instance.new("Frame")
Tab2Border.Size = UDim2.new(0, 69, 0, 39)  -- 4px larger for 2px border on each side
Tab2Border.Position = UDim2.new(0, -2, 0, 90)  -- Adjusted to center
Tab2Border.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Black color
Tab2Border.BorderSizePixel = 0
Tab2Border.ZIndex = 1
Tab2Border.Parent = TabContainer

local Tab2BorderCorner = Instance.new("UICorner")
Tab2BorderCorner.CornerRadius = UDim.new(0, 8)
Tab2BorderCorner.Parent = Tab2Border

local Tab2Button = Instance.new("TextButton")
Tab2Button.Size = UDim2.new(1, -4, 1, -4)  -- 2px border on each side
Tab2Button.Position = UDim2.new(0, 2, 0, 2)
Tab2Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Tab2Button.BorderSizePixel = 0
Tab2Button.Text = "CODE"
Tab2Button.TextColor3 = Color3.fromRGB(200, 200, 200)
Tab2Button.TextSize = 12
Tab2Button.Font = Enum.Font.GothamBold
Tab2Button.TextWrapped = true
Tab2Button.Name = "Tab2Button"
Tab2Button.ZIndex = 2
Tab2Button.Parent = Tab2Border

local Tab2Corner = Instance.new("UICorner")
Tab2Corner.CornerRadius = UDim.new(0, 6)
Tab2Corner.Parent = Tab2Button

-- ================= MAIN PANEL =================

-- OUTER FRAME with cyan border
local OuterFrame = Instance.new("Frame")
OuterFrame.Size = UDim2.new(0, 280, 0, 280)
OuterFrame.Position = UDim2.new(0, 75, 0, 0)
OuterFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
OuterFrame.BorderSizePixel = 0
OuterFrame.Visible = true
OuterFrame.ZIndex = 2
OuterFrame.Parent = MainContainer

local OuterCorner = Instance.new("UICorner")
OuterCorner.CornerRadius = UDim.new(0, 12)
OuterCorner.Parent = OuterFrame

-- Version text
local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(0, 60, 0, 15)
VersionText.Position = UDim2.new(1, -65, 1, -18)
VersionText.BackgroundTransparency = 1
VersionText.Text = "Premium V2.03EN"
VersionText.TextColor3 = Color3.fromRGB(180, 180, 180)
VersionText.TextSize = 10
VersionText.Font = Enum.Font.Gotham
VersionText.TextXAlignment = Enum.TextXAlignment.Right
VersionText.ZIndex = 4
VersionText.Parent = OuterFrame

-- Main inner panel
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, -4, 1, -4)
MainFrame.Position = UDim2.new(0, 2, 0, 2)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 3
MainFrame.Parent = OuterFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Title Background
local TitleBg = Instance.new("Frame")
TitleBg.Size = UDim2.new(1, 0, 0, 34)
TitleBg.Position = UDim2.new(0, 0, 0, 0)
TitleBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBg.BorderSizePixel = 0
TitleBg.ZIndex = 4
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

-- Title Shadow - RENAMED TO "DALVSTORE"
local TitleShadow = Instance.new("TextLabel")
TitleShadow.Size = UDim2.new(1, -65, 0, 34)
TitleShadow.Position = UDim2.new(0, 35, 0, 3)
TitleShadow.BackgroundTransparency = 1
TitleShadow.Text = "DALVSTORE"
TitleShadow.TextColor3 = Color3.fromRGB(60, 0, 90)
TitleShadow.TextTransparency = 0.7
TitleShadow.TextSize = 16
TitleShadow.Font = Enum.Font.SourceSansBold
TitleShadow.TextXAlignment = Enum.TextXAlignment.Left
TitleShadow.ZIndex = 3
TitleShadow.Parent = MainFrame

-- Main Title - RENAMED TO "DALVSTORE"
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -65, 0, 34)
Title.Position = UDim2.new(0, 34, 0, 2)
Title.BackgroundTransparency = 1
Title.Text = "DALVSTORE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 4

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

Title.Parent = MainFrame

-- ================= CONTENT AREA =================

-- Content Area (inside the panel)
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(0, 250, 0, 200)
ContentArea.Position = UDim2.new(0, 15, 0, 45)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 4
ContentArea.Parent = MainFrame

-- ================= TAB 0 CONTENT (Warning) =================

local Tab0Content = Instance.new("Frame")
Tab0Content.Size = UDim2.new(1, 0, 1, 0)
Tab0Content.Position = UDim2.new(0, 0, 0, 0)
Tab0Content.BackgroundTransparency = 1
Tab0Content.Visible = false
Tab0Content.Name = "Tab0Content"
Tab0Content.ZIndex = 4
Tab0Content.Parent = ContentArea

-- Warning Main Frame
local WarningFrame = Instance.new("Frame")
WarningFrame.Size = UDim2.new(1, 0, 1, 0)
WarningFrame.Position = UDim2.new(0, 0, 0, 0)
WarningFrame.BackgroundTransparency = 1
WarningFrame.ZIndex = 4
WarningFrame.Parent = Tab0Content

-- Warning Title Header
local WarningTitle = Instance.new("TextLabel")
WarningTitle.Size = UDim2.new(1, 0, 0, 30)
WarningTitle.Position = UDim2.new(0, 0, 0, 0)
WarningTitle.BackgroundTransparency = 1
WarningTitle.Text = "WARNING"
WarningTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
WarningTitle.TextSize = 18
WarningTitle.Font = Enum.Font.GothamBold
WarningTitle.TextXAlignment = Enum.TextXAlignment.Center
WarningTitle.ZIndex = 4
WarningTitle.Parent = WarningFrame

-- Warning Description
local WarningDesc = Instance.new("TextLabel")
WarningDesc.Size = UDim2.new(1, 0, 0, 40)
WarningDesc.Position = UDim2.new(0, 0, 0, 35)
WarningDesc.BackgroundTransparency = 1
WarningDesc.Text = "SAFE usage guide to avoid being reported by other people."
WarningDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
WarningDesc.TextSize = 12
WarningDesc.Font = Enum.Font.Gotham
WarningDesc.TextWrapped = true
WarningDesc.TextXAlignment = Enum.TextXAlignment.Center
WarningDesc.ZIndex = 4
WarningDesc.Parent = WarningFrame

-- Warning List Frame (Scrollable)
local WarningListFrame = Instance.new("ScrollingFrame")
WarningListFrame.Size = UDim2.new(1, 0, 0, 125)
WarningListFrame.Position = UDim2.new(0, 0, 0, 80)
WarningListFrame.BackgroundTransparency = 1
WarningListFrame.BorderSizePixel = 0
WarningListFrame.ScrollBarThickness = 5
WarningListFrame.CanvasSize = UDim2.new(0, 0, 0, 180)
WarningListFrame.ZIndex = 4
WarningListFrame.Parent = WarningFrame

-- Remove automatic scrolling
WarningListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- Warning List Container
local WarningList = Instance.new("Frame")
WarningList.Size = UDim2.new(1, 0, 0, 180)
WarningList.Position = UDim2.new(0, 0, 0, 0)
WarningList.BackgroundTransparency = 1
WarningList.ZIndex = 4
WarningList.Parent = WarningListFrame

-- Warning 1
local Warning1 = Instance.new("TextLabel")
Warning1.Size = UDim2.new(1, -10, 0, 40)
Warning1.Position = UDim2.new(0, 5, 0, 0)
Warning1.BackgroundTransparency = 1
Warning1.Text = "1. In the first week after update, only open 3 newest wings"
Warning1.TextColor3 = Color3.fromRGB(220, 220, 220)
Warning1.TextSize = 11
Warning1.Font = Enum.Font.Gotham
Warning1.TextWrapped = true
Warning1.TextXAlignment = Enum.TextXAlignment.Left
Warning1.ZIndex = 4
Warning1.Parent = WarningList

-- Warning 2
local Warning2 = Instance.new("TextLabel")
Warning2.Size = UDim2.new(1, -10, 0, 50)
Warning2.Position = UDim2.new(0, 5, 0, 45)
Warning2.BackgroundTransparency = 1
Warning2.Text = "2. If the injected amount is still not enough to buy a wing (even if the number matches) inject by entering the number from one jump ability result multiplied by 100"
Warning2.TextColor3 = Color3.fromRGB(220, 220, 220)
Warning2.TextSize = 11
Warning2.Font = Enum.Font.Gotham
Warning2.TextWrapped = true
Warning2.TextXAlignment = Enum.TextXAlignment.Left
Warning2.ZIndex = 4
Warning2.Parent = WarningList

-- Warning 3
local Warning3 = Instance.new("TextLabel")
Warning3.Size = UDim2.new(1, -10, 0, 30)
Warning3.Position = UDim2.new(0, 5, 0, 100)
Warning3.BackgroundTransparency = 1
Warning3.Text = "3. Keep injecting using that number until the wing is bought"
Warning3.TextColor3 = Color3.fromRGB(220, 220, 220)
Warning3.TextSize = 11
Warning3.Font = Enum.Font.Gotham
Warning3.TextWrapped = true
Warning3.TextXAlignment = Enum.TextXAlignment.Left
Warning3.ZIndex = 4
Warning3.Parent = WarningList

-- Warning 4
local Warning4 = Instance.new("TextLabel")
Warning4.Size = UDim2.new(1, -10, 0, 60)
Warning4.Position = UDim2.new(0, 5, 0, 135)
Warning4.BackgroundTransparency = 1
Warning4.Text = "4. Don't push wins too quickly and attract attention from top leaderboard players, (The most sensitive player in this game is player who's in leaderboard)."
Warning4.TextColor3 = Color3.fromRGB(220, 220, 220)
Warning4.TextSize = 11
Warning4.Font = Enum.Font.Gotham
Warning4.TextWrapped = true
Warning4.TextXAlignment = Enum.TextXAlignment.Left
Warning4.ZIndex = 4
Warning4.Parent = WarningList

-- Important Note - FIXED SENTENCE
local ImportantNote = Instance.new("TextLabel")
ImportantNote.Size = UDim2.new(1, -10, 0, 70)
ImportantNote.Position = UDim2.new(0, 5, 0, 200)
ImportantNote.BackgroundTransparency = 1
ImportantNote.Text = "The main point is don't overdo it.\n\nPlayer bans can only be done from reports with valid real evidence."
ImportantNote.TextColor3 = Color3.fromRGB(255, 150, 150)
ImportantNote.TextSize = 11
ImportantNote.Font = Enum.Font.GothamBold
ImportantNote.TextWrapped = true
ImportantNote.TextXAlignment = Enum.TextXAlignment.Center
ImportantNote.ZIndex = 4
ImportantNote.Parent = WarningList

-- Update canvas size
WarningListFrame.CanvasSize = UDim2.new(0, 0, 0, 280)

-- ================= TAB 1 CONTENT (Injector) =================

local Tab1Content = Instance.new("Frame")
Tab1Content.Size = UDim2.new(1, 0, 1, 0)
Tab1Content.Position = UDim2.new(0, 0, 0, 0)
Tab1Content.BackgroundTransparency = 1
Tab1Content.Visible = true
Tab1Content.Name = "Tab1Content"
Tab1Content.ZIndex = 4
Tab1Content.Parent = ContentArea

-- Input frame for Tab 1
local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(0, 230, 0, 90)
InputFrame.Position = UDim2.new(0, 10, 0, 0)
InputFrame.BackgroundTransparency = 1
InputFrame.ZIndex = 4
InputFrame.Parent = Tab1Content

-- Amount input
local AmountLabel = Instance.new("TextLabel")
AmountLabel.Size = UDim2.new(0, 70, 0, 25)
AmountLabel.Position = UDim2.new(0, 0, 0, 0)
AmountLabel.BackgroundTransparency = 1
AmountLabel.Text = "Amount:"
AmountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountLabel.TextSize = 13
AmountLabel.TextXAlignment = Enum.TextXAlignment.Left
AmountLabel.ZIndex = 4
AmountLabel.Parent = InputFrame

-- Amount textbox
local AmountBox = Instance.new("TextBox")
AmountBox.Size = UDim2.new(0, 80, 0, 30)
AmountBox.Position = UDim2.new(0, 70, 0, 0)
AmountBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AmountBox.BorderSizePixel = 0
AmountBox.Text = "400"
AmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountBox.TextSize = 15
AmountBox.PlaceholderText = "Amount"
AmountBox.ZIndex = 4
AmountBox.Parent = InputFrame

-- Symbol selection
local SymbolLabel = Instance.new("TextLabel")
SymbolLabel.Size = UDim2.new(0, 70, 0, 25)
SymbolLabel.Position = UDim2.new(0, 0, 0, 45)
SymbolLabel.BackgroundTransparency = 1
SymbolLabel.Text = "Symbol:"
SymbolLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SymbolLabel.TextSize = 13
SymbolLabel.TextXAlignment = Enum.TextXAlignment.Left
SymbolLabel.ZIndex = 4
SymbolLabel.Parent = InputFrame

local SymbolBox = Instance.new("TextBox")
SymbolBox.Size = UDim2.new(0, 80, 0, 30)
SymbolBox.Position = UDim2.new(0, 70, 0, 45)
SymbolBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SymbolBox.BorderSizePixel = 0
SymbolBox.Text = "K"
SymbolBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SymbolBox.TextSize = 15
SymbolBox.ZIndex = 4
SymbolBox.Parent = InputFrame

-- Symbol arrows
local UpButton = Instance.new("TextButton")
UpButton.Size = UDim2.new(0, 25, 0, 12)
UpButton.Position = UDim2.new(0, 155, 0, 45)
UpButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
UpButton.BorderSizePixel = 0
UpButton.Text = "▲"
UpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpButton.TextSize = 10
UpButton.ZIndex = 4
UpButton.Parent = InputFrame

local DownButton = Instance.new("TextButton")
DownButton.Size = UDim2.new(0, 25, 0, 12)
DownButton.Position = UDim2.new(0, 155, 0, 60)
DownButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
DownButton.BorderSizePixel = 0
DownButton.Text = "▼"
DownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DownButton.TextSize = 10
DownButton.ZIndex = 4
DownButton.Parent = InputFrame

-- Total Frame
local TotalFrame = Instance.new("Frame")
TotalFrame.Size = UDim2.new(1, 0, 0, 35)
TotalFrame.Position = UDim2.new(0, 0, 0, 100)
TotalFrame.BackgroundTransparency = 1
TotalFrame.ZIndex = 4
TotalFrame.Parent = Tab1Content

local TotalLabelTitle = Instance.new("TextLabel")
TotalLabelTitle.Size = UDim2.new(0, 50, 1, 0)
TotalLabelTitle.BackgroundTransparency = 1
TotalLabelTitle.Text = "Total:"
TotalLabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
TotalLabelTitle.TextSize = 13
TotalLabelTitle.TextXAlignment = Enum.TextXAlignment.Left
TotalLabelTitle.ZIndex = 4
TotalLabelTitle.Parent = TotalFrame

-- Total Box
local TotalValueBox = Instance.new("TextBox")
TotalValueBox.Size = UDim2.new(1, -50, 1, 0)
TotalValueBox.Position = UDim2.new(0, 50, 0, 0)
TotalValueBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TotalValueBox.BorderSizePixel = 0
TotalValueBox.Text = "Loading..."
TotalValueBox.TextColor3 = Color3.fromRGB(255, 215, 0)
TotalValueBox.TextSize = 13
TotalValueBox.Font = Enum.Font.Gotham
TotalValueBox.TextEditable = false
TotalValueBox.ClearTextOnFocus = false
TotalValueBox.ZIndex = 4
TotalValueBox.Parent = TotalFrame

-- Result display
local ResultLabel = Instance.new("TextLabel")
ResultLabel.Size = UDim2.new(1, 0, 0, 25)
ResultLabel.Position = UDim2.new(0, 0, 0, 145)
ResultLabel.BackgroundTransparency = 1
ResultLabel.Text = "" 
ResultLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ResultLabel.TextSize = 14
ResultLabel.TextXAlignment = Enum.TextXAlignment.Center
ResultLabel.ZIndex = 4
ResultLabel.Parent = Tab1Content

-- Generate button for Tab 1
local GenerateButton = Instance.new("TextButton")
GenerateButton.Size = UDim2.new(0, 220, 0, 35)
GenerateButton.Position = UDim2.new(0, 15, 0, 175)
GenerateButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
GenerateButton.BorderSizePixel = 0
GenerateButton.Text = "GENERATE"
GenerateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GenerateButton.TextSize = 15
GenerateButton.Font = Enum.Font.GothamBold
GenerateButton.ZIndex = 4
GenerateButton.Parent = Tab1Content

-- ================= TAB 2 CONTENT (Code) =================

local Tab2Content = Instance.new("Frame")
Tab2Content.Size = UDim2.new(1, 0, 1, 0)
Tab2Content.Position = UDim2.new(0, 0, 0, 0)
Tab2Content.BackgroundTransparency = 1
Tab2Content.Visible = false
Tab2Content.Name = "Tab2Content"
Tab2Content.ZIndex = 4
Tab2Content.Parent = ContentArea

-- Auto Box Main Frame
local AutoBoxFrame = Instance.new("Frame")
AutoBoxFrame.Size = UDim2.new(1, 0, 1, 0)
AutoBoxFrame.Position = UDim2.new(0, 0, 0, 0)
AutoBoxFrame.BackgroundTransparency = 1
AutoBoxFrame.ZIndex = 4
AutoBoxFrame.Parent = Tab2Content

-- Claim Codes Button
local ClaimCodesButton = Instance.new("TextButton")
ClaimCodesButton.Size = UDim2.new(0, 220, 0, 35)
ClaimCodesButton.Position = UDim2.new(0, 15, 0, 30)
ClaimCodesButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
ClaimCodesButton.BorderSizePixel = 0
ClaimCodesButton.Text = "CLAIM ALL CODES"
ClaimCodesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClaimCodesButton.TextSize = 14
ClaimCodesButton.Font = Enum.Font.GothamBold
ClaimCodesButton.ZIndex = 4
ClaimCodesButton.Parent = AutoBoxFrame

local ClaimCodesCorner = Instance.new("UICorner")
ClaimCodesCorner.CornerRadius = UDim.new(0, 6)
ClaimCodesCorner.Parent = ClaimCodesButton

-- Start/Stop Open Box Button
local AutoBoxButton = Instance.new("TextButton")
AutoBoxButton.Size = UDim2.new(0, 220, 0, 35)
AutoBoxButton.Position = UDim2.new(0, 15, 0, 75)
AutoBoxButton.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
AutoBoxButton.BorderSizePixel = 0
AutoBoxButton.Text = "START OPEN BOX"
AutoBoxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBoxButton.TextSize = 14
AutoBoxButton.Font = Enum.Font.GothamBold
AutoBoxButton.Name = "AutoBoxButton"
AutoBoxButton.ZIndex = 4
AutoBoxButton.Parent = AutoBoxFrame

local AutoBoxCorner = Instance.new("UICorner")
AutoBoxCorner.CornerRadius = UDim.new(0, 6)
AutoBoxCorner.Parent = AutoBoxButton

-- Status indicator for Open Box
local AutoBoxStatus = Instance.new("Frame")
AutoBoxStatus.Size = UDim2.new(0, 12, 0, 12)
AutoBoxStatus.Position = UDim2.new(1, -20, 0.5, -6)
AutoBoxStatus.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
AutoBoxStatus.BorderSizePixel = 0
AutoBoxStatus.Name = "AutoBoxStatus"
AutoBoxStatus.ZIndex = 5
AutoBoxStatus.Parent = AutoBoxButton

local AutoBoxStatusCorner = Instance.new("UICorner")
AutoBoxStatusCorner.CornerRadius = UDim.new(1, 0)
AutoBoxStatusCorner.Parent = AutoBoxStatus

-- Open Box Info Label
local AutoBoxInfo = Instance.new("TextLabel")
AutoBoxInfo.Size = UDim2.new(0, 220, 0, 80)
AutoBoxInfo.Position = UDim2.new(0, 15, 0, 120)
AutoBoxInfo.BackgroundTransparency = 1
AutoBoxInfo.Text = "Start open box to automatically open all souvenir boxes without animation."
AutoBoxInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
AutoBoxInfo.TextSize = 12
AutoBoxInfo.Font = Enum.Font.Gotham
AutoBoxInfo.TextWrapped = true
AutoBoxInfo.TextXAlignment = Enum.TextXAlignment.Center
AutoBoxInfo.ZIndex = 4
AutoBoxInfo.Parent = AutoBoxFrame

-- ================= CONTROL BUTTONS (Minimize/Close) =================

-- Minimize button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -60, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "—" 
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14
MinimizeButton.ZIndex = 5
MinimizeButton.Parent = MainFrame

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12
CloseButton.ZIndex = 5
CloseButton.Parent = MainFrame

-- Mini Icon
local MiniIcon = Instance.new("TextButton")
MiniIcon.Size = UDim2.new(0, 45, 0, 45)
MiniIcon.Position = UDim2.new(0, 10, 0, 10)
MiniIcon.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
MiniIcon.BorderSizePixel = 0
MiniIcon.Text = "🚀"
MiniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniIcon.TextSize = 18
MiniIcon.Visible = false
MiniIcon.ZIndex = 9999
MiniIcon.Parent = ScreenGui

MiniIcon.Active = true
MiniIcon.Draggable = true

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 6)
MiniCorner.Parent = MiniIcon

-- ================= LOGIC SECTION =================

local commonSuffixes = {"", "K", "M", "B", "T", "q", "Q"}
local currentSuffixIndex = 54

function generateSuffix(index)
    if index <= #commonSuffixes then
        return commonSuffixes[index]
    end
    local customIndex = index - #commonSuffixes
    local length = 2 
    local maxForLength = 26
    while customIndex > maxForLength do
        customIndex = customIndex - maxForLength
        length = length + 1
        maxForLength = 26
    end
    local charIndex = customIndex
    local charCode = 96 + charIndex
    local char = string.char(charCode)
    return char:rep(length)
end

function getTotalSuffixes()
    return #commonSuffixes + 26 + 26 + 26 + 26
end

function getSuffixExponent(suffix)
    if suffix == nil or suffix == "" then return 0 end
    local commonMap = { K = 3, M = 6, B = 9, T = 12, q = 15, Q = 18 }
    if commonMap[suffix] then return commonMap[suffix] end
    
    local firstChar = suffix:sub(1, 1):lower()
    local suffixLength = #suffix
    for i = 2, suffixLength do
        if suffix:sub(i, i):lower() ~= firstChar then return 0 end
    end
    
    local charIndex = string.byte(firstChar) - 96
    local baseExponent = 18 
    local stepsFromA = charIndex - 1
    local lengthBonus = (suffixLength - 2) * 78 
    return baseExponent + (stepsFromA * 3) + lengthBonus + 3
end

function parseMoneyString(val)
    if type(val) == "number" then return val end
    if type(val) ~= "string" then return 0 end
    local numStr, suffix = val:match("([%d%.]+)([%a]*)")
    if not numStr then return 0 end
    local number = tonumber(numStr) or 0
    local exponent = getSuffixExponent(suffix)
    return number * (10 ^ exponent)
end

function formatValueToSuffix(value)
    if value == 0 then return "0" end
    if value < 1000 then return string.format("%.2f", value) end
    
    local exponent = math.floor(math.log10(value))
    local tier = math.floor(exponent / 3)
    local suffixIndex = tier
    local suffixStr = generateSuffix(suffixIndex + 1)
    
    local divisor = 10 ^ (tier * 3)
    local displayNum = value / divisor
    
    return string.format("%.2f%s", displayNum, suffixStr)
end

function calculateN(number, suffix)
    local baseNumber = tonumber(number)
    if not baseNumber or baseNumber <= 0 then
        return "Error: Amount must be a number > 0"
    end
    local exponent = getSuffixExponent(suffix)
    local multiplier = 10 ^ exponent
    local actualValue = baseNumber * multiplier
    local n = actualValue / 40
    return math.floor(n + 0.5)
end

function getScriptValue(num)
    if num > 10^15 then
        local sciNotation = string.format("%.2e", num)
        local base, exponentStr = sciNotation:match("([%d%.]+)e([%d%-]+)")
        if base and exponentStr then
            local exponent = tonumber(exponentStr)
            if exponent >= 0 then return base .. "e+" .. exponentStr
            else return base .. "e-" .. math.abs(exponent) end
        end
    end
    return tostring(num)
end

-- ================= TAB SWITCHING =================

local function switchToTab(tabNumber)
    -- Reset all tabs to inactive state
    Tab0Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Tab0Button.TextColor3 = Color3.fromRGB(200, 200, 200)
    Tab1Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Tab2Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Tab2Button.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    -- Reset injector text color
    InjectorText.TextColor3 = Color3.fromRGB(200, 200, 200)
    PremiumText.TextColor3 = Color3.fromRGB(150, 150, 150)
    
    -- Hide all content
    Tab0Content.Visible = false
    Tab1Content.Visible = false
    Tab2Content.Visible = false
    
    -- Activate selected tab
    if tabNumber == 0 then
        Tab0Content.Visible = true
        Tab0Button.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
        Tab0Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif tabNumber == 1 then
        Tab1Content.Visible = true
        Tab1Button.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
        InjectorText.TextColor3 = Color3.fromRGB(255, 255, 255)
        PremiumText.TextColor3 = Color3.fromRGB(180, 180, 180)
    elseif tabNumber == 2 then
        Tab2Content.Visible = true
        Tab2Button.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
        Tab2Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

-- Tab button events
Tab0Button.MouseButton1Click:Connect(function()
    switchToTab(0)
end)

Tab1Button.MouseButton1Click:Connect(function()
    switchToTab(1)
end)

Tab2Button.MouseButton1Click:Connect(function()
    switchToTab(2)
end)

-- ================= UPDATERS =================

function updateSymbol()
    SymbolBox.Text = generateSuffix(currentSuffixIndex)
    updateCalculations()
end

function updateCalculations()
    local inputNum = tonumber(AmountBox.Text) or 0
    local inputSuffix = SymbolBox.Text
    local inputRawValue = 0
    
    local n = calculateN(inputNum, inputSuffix)
    
    if type(n) == "number" then
        ResultLabel.Text = ""
        inputRawValue = inputNum * (10 ^ getSuffixExponent(inputSuffix))
    else
        ResultLabel.Text = n
        ResultLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        inputRawValue = 0
    end
    
    local currentMoneyRaw = 0
    if MoneyStat then
        currentMoneyRaw = parseMoneyString(MoneyStat.Value)
    end
    
    local totalRaw = currentMoneyRaw + inputRawValue
    TotalValueBox.Text = formatValueToSuffix(totalRaw)
end

-- ================= AUTO BOX LOGIC =================

local autoBoxRunning = false
local autoBoxThread = nil

local function claimAllCodes()
    local Msg = game:GetService("ReplicatedStorage"):WaitForChild("ServerMsg")
    local RemoteFunction = Msg:WaitForChild("Code")

    local codes = {"FALLENSTAR","BALI","THANKSGIVING","MOUNTRUSHMORE","SYDNEY","HALLOWEEN","LUXURY","SPOOKY","TAIWAN","SHANGHAI","ATLANTIS","BRAZIL","ALIEN","TORONTO","GIANT","IRONMAN","500MVISITS","70MVISIT","ADMIN","SPACE","ANGEL","DEMON","EVEREST","PIXEL","TITAN"}

    local successes = 0
    local failures = 0

    for i, code in ipairs(codes) do
        local args = {code}
        
        local success, result = pcall(function()
            return RemoteFunction:InvokeServer(unpack(args))
        end)
        
        if success then
            successes = successes + 1
        else
            failures = failures + 1
        end
        
        wait(1)
    end
end

local function toggleAutoBox()
    if autoBoxRunning then
        -- Stop open box
        autoBoxRunning = false
        AutoBoxButton.Text = "START OPEN BOX"
        AutoBoxStatus.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    else
        -- Start open box
        autoBoxRunning = true
        AutoBoxButton.Text = "STOP OPEN BOX"
        AutoBoxStatus.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        
        autoBoxThread = coroutine.create(function()
            while autoBoxRunning do
                for i = 16000100, 16000120 do
                    if not autoBoxRunning then break end
                    
                    local args = {
                        "OpenSouvenirBox",
                        i
                    }
                    
                    local success, result = pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
                    end)
                    
                    wait(0.2)
                end
            end
        end)
        
        coroutine.resume(autoBoxThread)
    end
end

-- ================= EVENT CONNECTIONS =================

-- Tab 1 events
UpButton.MouseButton1Click:Connect(function()
    currentSuffixIndex = math.min(currentSuffixIndex + 1, getTotalSuffixes())
    updateSymbol()
end)

DownButton.MouseButton1Click:Connect(function()
    currentSuffixIndex = math.max(currentSuffixIndex - 1, 1)
    updateSymbol()
end)

AmountBox:GetPropertyChangedSignal("Text"):Connect(updateCalculations)
SymbolBox:GetPropertyChangedSignal("Text"):Connect(updateCalculations)

if MoneyStat then
    MoneyStat.Changed:Connect(function()
        updateCalculations()
    end)
else
    TotalValueBox.Text = "Money stat not found"
end

GenerateButton.MouseButton1Click:Connect(function()
    local number = tonumber(AmountBox.Text) or 400
    local suffix = SymbolBox.Text
    local n = calculateN(number, suffix)
    
    if type(n) == "number" then
        local scriptValue = getScriptValue(n)
        local scriptToExecute = string.format([[
local args = {
7000001,
-%s
}
game:GetService("ReplicatedStorage"):WaitForChild("Tool"):WaitForChild("DrawUp"):WaitForChild("Msg"):WaitForChild("DrawHero"):InvokeServer(unpack(args))
]], scriptValue)
        
        loadstring(scriptToExecute)()
        
        ResultLabel.Text = "Successfully generate"
        ResultLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        wait(2)
        updateCalculations()
    else
        ResultLabel.Text = "Error: Invalid input"
        ResultLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- Tab 2 events
ClaimCodesButton.MouseButton1Click:Connect(claimAllCodes)
AutoBoxButton.MouseButton1Click:Connect(toggleAutoBox)

-- Control buttons
MinimizeButton.MouseButton1Click:Connect(function()
    MainContainer.Visible = false
    MiniIcon.Visible = true
end)

MiniIcon.MouseButton1Click:Connect(function()
    MainContainer.Visible = true
    MiniIcon.Visible = false
end)

CloseButton.MouseButton1Click:Connect(function()
    -- Stop auto box if running
    if autoBoxRunning then
        autoBoxRunning = false
    end
    ScreenGui:Destroy()
end)

-- Initialize
updateSymbol()
switchToTab(1)  -- Start with Tab 1 (injector) active by default