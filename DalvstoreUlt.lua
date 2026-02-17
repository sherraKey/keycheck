local Players = game:GetService("Players")
local Player = Players.LocalPlayer 
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ================= AUTHORIZATION LOGIC =================
local isFullAuthorized = false

local function checkAuthorization()
    local success, allUsers = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/benedettaera/Injector/refs/heads/main/Key"))()
    end)
    
    if not success or type(allUsers) ~= "table" then
        allUsers = {}
    end
    
    local maxUsers = 20
    local authorizedUsers = {}
    for i = 1, math.min(maxUsers, #allUsers) do
        authorizedUsers[i] = allUsers[i]
    end
    
    for _, username in ipairs(authorizedUsers) do
        if Player.Name == username then
            isFullAuthorized = true
            break
        end
    end
end

checkAuthorization()

-- ================= UNAUTHORIZED POPUP FUNCTION =================
local function showUnauthorizedPopup()
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
    Message.Text = "You don't have full access, contact fb: dalvstore"
    Message.TextColor3 = Color3.fromRGB(255, 255, 255)
    Message.TextSize = 14
    Message.TextWrapped = true
    Message.Parent = UnauthorizedFrame
    
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Size = UDim2.new(1, 0, 0, 30)
    ButtonContainer.Position = UDim2.new(0, 0, 0.8, 0)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = UnauthorizedFrame
    
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
    
    BuyButton.MouseButton1Click:Connect(function()
        setclipboard("https://sociabuzz.com/dalvstore/tribe")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Link copied",
            Text = "Paste on your browser to buy the script",
            Duration = 5,
            Icon = "rbxassetid://90238157870123"
        })
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        UnauthorizedScreenGui:Destroy()
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Access Restricted",
        Text = "You dont have full access",
        Duration = 5
    })
end

-- ================= MAIN SCRIPT (continues regardless) =================
local Leaderstats = Player:WaitForChild("leaderstats", 5)
local MoneyStat = Leaderstats and Leaderstats:WaitForChild("Money", 5)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MoneyGenerator"
ScreenGui.Parent = PlayerGui
ScreenGui.DisplayOrder = 9999
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 370, 0, 280)
MainContainer.Position = UDim2.new(0.5, -185, 0.5, -140)
MainContainer.BackgroundTransparency = 1
MainContainer.Parent = ScreenGui
MainContainer.ZIndex = 1
MainContainer.Active = true
MainContainer.Draggable = true

-- ================= TABS (5 tabs) =================
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 65, 0, 220)
TabContainer.Position = UDim2.new(0, 5, 0, 30)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainContainer
TabContainer.ZIndex = 2

local function createTabButton(parent, yPos, text, hasSubtext, subtext)
    local border = Instance.new("Frame")
    border.Size = UDim2.new(0, 69, 0, 39)
    border.Position = UDim2.new(0, -2, 0, yPos)
    border.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    border.BorderSizePixel = 0
    border.ZIndex = 1
    border.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = border

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 1, -4)
    btn.Position = UDim2.new(0, 2, 0, 2)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.BorderSizePixel = 0
    btn.Text = hasSubtext and "" or text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.TextWrapped = true
    btn.ZIndex = 2
    btn.Parent = border

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    if hasSubtext then
        local mainText = Instance.new("TextLabel")
        mainText.Size = UDim2.new(1, 0, 0, 20)
        mainText.Position = UDim2.new(0, 0, 0, 2)
        mainText.BackgroundTransparency = 1
        mainText.Text = text
        mainText.TextColor3 = Color3.fromRGB(200, 200, 200)
        mainText.TextSize = 12
        mainText.Font = Enum.Font.GothamBold
        mainText.TextXAlignment = Enum.TextXAlignment.Center
        mainText.TextYAlignment = Enum.TextYAlignment.Top
        mainText.ZIndex = 3
        mainText.Parent = btn

        local subLabel = Instance.new("TextLabel")
        subLabel.Size = UDim2.new(1, 0, 0, 15)
        subLabel.Position = UDim2.new(0, 0, 0, 20)
        subLabel.BackgroundTransparency = 1
        subLabel.Text = subtext
        subLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        subLabel.TextSize = 9
        subLabel.Font = Enum.Font.Gotham
        subLabel.TextXAlignment = Enum.TextXAlignment.Center
        subLabel.TextYAlignment = Enum.TextYAlignment.Top
        subLabel.ZIndex = 3
        subLabel.Parent = btn
    end

    return btn, border
end

local Tab0Button, Tab0Border = createTabButton(TabContainer, 0, "WARNING", false)
local Tab1Button, Tab1Border = createTabButton(TabContainer, 45, "INJECTOR", true, "premium")
local Tab2Button, Tab2Border = createTabButton(TabContainer, 90, "CODE", false)
local Tab3Button, Tab3Border = createTabButton(TabContainer, 135, "WINGS", false)
local Tab4Button, Tab4Border = createTabButton(TabContainer, 180, "AUTO", false)

if not isFullAuthorized then
    Tab0Button.Visible = false
    Tab0Border.Visible = false
    Tab1Button.Visible = false
    Tab1Border.Visible = false
    Tab3Button.Visible = false
    Tab3Border.Visible = false
end

-- ================= MAIN PANEL =================
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

local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(0, 60, 0, 15)
VersionText.Position = UDim2.new(1, -65, 1, -18)
VersionText.BackgroundTransparency = 1
VersionText.Text = "Premium V4.02EN"
VersionText.TextColor3 = Color3.fromRGB(180, 180, 180)
VersionText.TextSize = 10
VersionText.Font = Enum.Font.Gotham
VersionText.TextXAlignment = Enum.TextXAlignment.Right
VersionText.ZIndex = 4
VersionText.Parent = OuterFrame

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, -4, 1, -4)
MainFrame.Position = UDim2.new(0, 2, 0, 2)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 3
MainFrame.Parent = OuterFrame

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

-- Title
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

local FacebookLogoBg = Instance.new("Frame")
FacebookLogoBg.Name = "FacebookLogoBg"
FacebookLogoBg.Parent = TitleBg
FacebookLogoBg.BackgroundColor3 = Color3.fromRGB(24, 119, 242)
FacebookLogoBg.BorderSizePixel = 0
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
FacebookF.TextScaled = true
FacebookF.Size = UDim2.new(1.3, 0, 1.3, 0)
FacebookF.AnchorPoint = Vector2.new(0.5, 0.5)
FacebookF.Position = UDim2.new(0.5, 0, 0.55, 0)
FacebookF.TextXAlignment = Enum.TextXAlignment.Center
FacebookF.TextYAlignment = Enum.TextYAlignment.Center
FacebookF.ZIndex = 6

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
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(0, 250, 0, 200)
ContentArea.Position = UDim2.new(0, 15, 0, 45)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 4
ContentArea.Parent = MainFrame

-- ================= TAB CONTENT CONTAINERS =================
local Tab0Content = Instance.new("Frame")
Tab0Content.Size = UDim2.new(1, 0, 1, 0)
Tab0Content.BackgroundTransparency = 1
Tab0Content.Visible = false
Tab0Content.Parent = ContentArea

local Tab1Content = Instance.new("Frame")
Tab1Content.Size = UDim2.new(1, 0, 1, 0)
Tab1Content.BackgroundTransparency = 1
Tab1Content.Visible = true
Tab1Content.Parent = ContentArea

local Tab2Content = Instance.new("Frame")
Tab2Content.Size = UDim2.new(1, 0, 1, 0)
Tab2Content.BackgroundTransparency = 1
Tab2Content.Visible = false
Tab2Content.Parent = ContentArea

local Tab3Content = Instance.new("Frame")
Tab3Content.Size = UDim2.new(1, 0, 1, 0)
Tab3Content.BackgroundTransparency = 1
Tab3Content.Visible = false
Tab3Content.Parent = ContentArea

local Tab4Content = Instance.new("Frame")
Tab4Content.Size = UDim2.new(1, 0, 1, 0)
Tab4Content.BackgroundTransparency = 1
Tab4Content.Visible = false
Tab4Content.Parent = ContentArea

if not isFullAuthorized then
    Tab0Content.Visible = false
    Tab1Content.Visible = false
    Tab3Content.Visible = false
end

-- ================= TAB 0 CONTENT (Warning) =================
local WarningFrame = Instance.new("Frame")
WarningFrame.Size = UDim2.new(1, 0, 1, 0)
WarningFrame.BackgroundTransparency = 1
WarningFrame.Parent = Tab0Content

local WarningTitle = Instance.new("TextLabel")
WarningTitle.Size = UDim2.new(1, 0, 0, 30)
WarningTitle.BackgroundTransparency = 1
WarningTitle.Text = "WARNING"
WarningTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
WarningTitle.TextSize = 18
WarningTitle.Font = Enum.Font.GothamBold
WarningTitle.TextXAlignment = Enum.TextXAlignment.Center
WarningTitle.Parent = WarningFrame

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
WarningDesc.Parent = WarningFrame

local WarningListFrame = Instance.new("ScrollingFrame")
WarningListFrame.Size = UDim2.new(1, 0, 0, 125)
WarningListFrame.Position = UDim2.new(0, 0, 0, 80)
WarningListFrame.BackgroundTransparency = 1
WarningListFrame.BorderSizePixel = 0
WarningListFrame.ScrollBarThickness = 5
WarningListFrame.CanvasSize = UDim2.new(0, 0, 0, 280)
WarningListFrame.Parent = WarningFrame

local WarningList = Instance.new("Frame")
WarningList.Size = UDim2.new(1, 0, 0, 280)
WarningList.BackgroundTransparency = 1
WarningList.Parent = WarningListFrame

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
Warning1.Parent = WarningList

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
Warning2.Parent = WarningList

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
Warning3.Parent = WarningList

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
Warning4.Parent = WarningList

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
ImportantNote.Parent = WarningList

WarningListFrame.CanvasSize = UDim2.new(0, 0, 0, 280)

-- ================= TAB 1 CONTENT (Injector) =================
local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(0, 230, 0, 90)
InputFrame.Position = UDim2.new(0, 10, 0, 0)
InputFrame.BackgroundTransparency = 1
InputFrame.Parent = Tab1Content

local AmountLabel = Instance.new("TextLabel")
AmountLabel.Size = UDim2.new(0, 70, 0, 25)
AmountLabel.Position = UDim2.new(0, 0, 0, 0)
AmountLabel.BackgroundTransparency = 1
AmountLabel.Text = "Amount:"
AmountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountLabel.TextSize = 13
AmountLabel.TextXAlignment = Enum.TextXAlignment.Left
AmountLabel.Parent = InputFrame

AmountBox = Instance.new("TextBox")
AmountBox.Size = UDim2.new(0, 80, 0, 30)
AmountBox.Position = UDim2.new(0, 70, 0, 0)
AmountBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AmountBox.BorderSizePixel = 0
AmountBox.Text = "400"
AmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountBox.TextSize = 15
AmountBox.PlaceholderText = "Amount"
AmountBox.Parent = InputFrame

local SymbolLabel = Instance.new("TextLabel")
SymbolLabel.Size = UDim2.new(0, 70, 0, 25)
SymbolLabel.Position = UDim2.new(0, 0, 0, 45)
SymbolLabel.BackgroundTransparency = 1
SymbolLabel.Text = "Symbol:"
SymbolLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SymbolLabel.TextSize = 13
SymbolLabel.TextXAlignment = Enum.TextXAlignment.Left
SymbolLabel.Parent = InputFrame

SymbolBox = Instance.new("TextBox")
SymbolBox.Size = UDim2.new(0, 80, 0, 30)
SymbolBox.Position = UDim2.new(0, 70, 0, 45)
SymbolBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SymbolBox.BorderSizePixel = 0
SymbolBox.Text = "K"
SymbolBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SymbolBox.TextSize = 15
SymbolBox.Parent = InputFrame

UpButton = Instance.new("TextButton")
UpButton.Size = UDim2.new(0, 25, 0, 12)
UpButton.Position = UDim2.new(0, 155, 0, 45)
UpButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
UpButton.BorderSizePixel = 0
UpButton.Text = "▲"
UpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpButton.TextSize = 10
UpButton.Parent = InputFrame

DownButton = Instance.new("TextButton")
DownButton.Size = UDim2.new(0, 25, 0, 12)
DownButton.Position = UDim2.new(0, 155, 0, 60)
DownButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
DownButton.BorderSizePixel = 0
DownButton.Text = "▼"
DownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DownButton.TextSize = 10
DownButton.Parent = InputFrame

local TotalFrame = Instance.new("Frame")
TotalFrame.Size = UDim2.new(1, 0, 0, 35)
TotalFrame.Position = UDim2.new(0, 0, 0, 100)
TotalFrame.BackgroundTransparency = 1
TotalFrame.Parent = Tab1Content

local TotalLabelTitle = Instance.new("TextLabel")
TotalLabelTitle.Size = UDim2.new(0, 50, 1, 0)
TotalLabelTitle.BackgroundTransparency = 1
TotalLabelTitle.Text = "Total:"
TotalLabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
TotalLabelTitle.TextSize = 13
TotalLabelTitle.TextXAlignment = Enum.TextXAlignment.Left
TotalLabelTitle.Parent = TotalFrame

TotalValueBox = Instance.new("TextBox")
TotalValueBox.Size = UDim2.new(1, -50, 1, 0)
TotalValueBox.Position = UDim2.new(0, 50, 0, 0)
TotalValueBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TotalValueBox.BorderSizePixel = 0
TotalValueBox.Text = "Loading..."
TotalValueBox.TextColor3 = Color3.fromRGB(255, 215, 0)
TotalValueBox.TextSize = 13
TotalValueBox.Font = Enum.Font.Gotham
TotalValueBox.TextEditable = false
TotalValueBox.Parent = TotalFrame

ResultLabel = Instance.new("TextLabel")
ResultLabel.Size = UDim2.new(1, 0, 0, 25)
ResultLabel.Position = UDim2.new(0, 0, 0, 145)
ResultLabel.BackgroundTransparency = 1
ResultLabel.Text = ""
ResultLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ResultLabel.TextSize = 14
ResultLabel.TextXAlignment = Enum.TextXAlignment.Center
ResultLabel.Parent = Tab1Content

GenerateButton = Instance.new("TextButton")
GenerateButton.Size = UDim2.new(0, 220, 0, 35)
GenerateButton.Position = UDim2.new(0, 15, 0, 175)
GenerateButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
GenerateButton.BorderSizePixel = 0
GenerateButton.Text = "GENERATE"
GenerateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GenerateButton.TextSize = 15
GenerateButton.Font = Enum.Font.GothamBold
GenerateButton.Parent = Tab1Content

-- ================= TAB 2 CONTENT (Code) =================
local AutoBoxFrame = Instance.new("Frame")
AutoBoxFrame.Size = UDim2.new(1, 0, 1, 0)
AutoBoxFrame.BackgroundTransparency = 1
AutoBoxFrame.Parent = Tab2Content

ClaimCodesButton = Instance.new("TextButton")
ClaimCodesButton.Size = UDim2.new(0, 220, 0, 35)
ClaimCodesButton.Position = UDim2.new(0, 15, 0, 30)
ClaimCodesButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
ClaimCodesButton.BorderSizePixel = 0
ClaimCodesButton.Text = "CLAIM ALL CODES"
ClaimCodesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClaimCodesButton.TextSize = 14
ClaimCodesButton.Font = Enum.Font.GothamBold
ClaimCodesButton.Parent = AutoBoxFrame

local ClaimCodesCorner = Instance.new("UICorner")
ClaimCodesCorner.CornerRadius = UDim.new(0, 6)
ClaimCodesCorner.Parent = ClaimCodesButton

AutoBoxButton = Instance.new("TextButton")
AutoBoxButton.Size = UDim2.new(0, 220, 0, 35)
AutoBoxButton.Position = UDim2.new(0, 15, 0, 75)
AutoBoxButton.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
AutoBoxButton.BorderSizePixel = 0
AutoBoxButton.Text = "START OPEN BOX"
AutoBoxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBoxButton.TextSize = 14
AutoBoxButton.Font = Enum.Font.GothamBold
AutoBoxButton.Name = "AutoBoxButton"
AutoBoxButton.Parent = AutoBoxFrame

local AutoBoxCorner = Instance.new("UICorner")
AutoBoxCorner.CornerRadius = UDim.new(0, 6)
AutoBoxCorner.Parent = AutoBoxButton

AutoBoxStatus = Instance.new("Frame")
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
AutoBoxInfo.Parent = AutoBoxFrame

-- ================= TAB 3 CONTENT (Wings) =================
local WingsFrame = Instance.new("Frame")
WingsFrame.Size = UDim2.new(1, 0, 1, 0)
WingsFrame.BackgroundTransparency = 1
WingsFrame.Parent = Tab3Content

WingsButton = Instance.new("TextButton")
WingsButton.Size = UDim2.new(0, 220, 0, 45)
WingsButton.Position = UDim2.new(0, 15, 0, 40)
WingsButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
WingsButton.BorderSizePixel = 0
WingsButton.Text = "Unlock Exclusive Wings"
WingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
WingsButton.TextSize = 14
WingsButton.Font = Enum.Font.GothamBold
WingsButton.Parent = WingsFrame

local WingsButtonCorner = Instance.new("UICorner")
WingsButtonCorner.CornerRadius = UDim.new(0, 8)
WingsButtonCorner.Parent = WingsButton

local WingsDesc = Instance.new("TextLabel")
WingsDesc.Size = UDim2.new(0, 220, 0, 60)
WingsDesc.Position = UDim2.new(0, 15, 0, 100)
WingsDesc.BackgroundTransparency = 1
WingsDesc.Text = "To unlock exclusive wing, you need to make sure exclusive tab is appear in wing shop. otherwise it's not gonna work"
WingsDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
WingsDesc.TextSize = 12
WingsDesc.Font = Enum.Font.Gotham
WingsDesc.TextWrapped = true
WingsDesc.TextXAlignment = Enum.TextXAlignment.Center
WingsDesc.Parent = WingsFrame

WingsStatus = Instance.new("TextLabel")
WingsStatus.Size = UDim2.new(0, 220, 0, 30)
WingsStatus.Position = UDim2.new(0, 15, 0, 165)
WingsStatus.BackgroundTransparency = 1
WingsStatus.Text = ""
WingsStatus.TextColor3 = Color3.fromRGB(255, 255, 100)
WingsStatus.TextSize = 12
WingsStatus.Font = Enum.Font.Gotham
WingsStatus.TextWrapped = true
WingsStatus.TextXAlignment = Enum.TextXAlignment.Center
WingsStatus.Parent = WingsFrame

-- ================= TAB 4 CONTENT (AUTO) =================
local AutoFrame = Instance.new("Frame")
AutoFrame.Size = UDim2.new(1, 0, 1, 0)
AutoFrame.BackgroundTransparency = 1
AutoFrame.Parent = Tab4Content

HatchButton = Instance.new("TextButton")
HatchButton.Size = UDim2.new(0, 220, 0, 45)
HatchButton.Position = UDim2.new(0, 15, 0, 10)
HatchButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
HatchButton.BorderSizePixel = 0
HatchButton.Text = "Hatch last egg now"
HatchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HatchButton.TextSize = 14
HatchButton.Font = Enum.Font.GothamBold
HatchButton.Parent = AutoFrame

local HatchButtonCorner = Instance.new("UICorner")
HatchButtonCorner.CornerRadius = UDim.new(0, 8)
HatchButtonCorner.Parent = HatchButton

local HatchDesc = Instance.new("TextLabel")
HatchDesc.Size = UDim2.new(0, 220, 0, 30)
HatchDesc.Position = UDim2.new(0, 15, 0, 60)
HatchDesc.BackgroundTransparency = 1
HatchDesc.Text = "Auto hatch last egg (make sure you have 10hatch gamepass)
Super auto only working in world 2 and above"
HatchDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
HatchDesc.TextSize = 11
HatchDesc.Font = Enum.Font.Gotham
HatchDesc.TextWrapped = true
HatchDesc.TextXAlignment = Enum.TextXAlignment.Center
HatchDesc.Parent = AutoFrame

-- ================= Super Auto Climb Toggle =================
local ClimbRow = Instance.new("Frame")
ClimbRow.Size = UDim2.new(0, 220, 0, 30)
ClimbRow.Position = UDim2.new(0, 15, 0, 95)
ClimbRow.BackgroundTransparency = 1
ClimbRow.Parent = AutoFrame

local ClimbLabel = Instance.new("TextLabel")
ClimbLabel.Size = UDim2.new(0, 150, 1, 0)
ClimbLabel.BackgroundTransparency = 1
ClimbLabel.Text = "Super Auto Climb"
ClimbLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ClimbLabel.TextSize = 13
ClimbLabel.Font = Enum.Font.GothamBold
ClimbLabel.TextXAlignment = Enum.TextXAlignment.Left
ClimbLabel.Parent = ClimbRow

ClimbToggle = Instance.new("TextButton")
ClimbToggle.Size = UDim2.new(0, 50, 0, 25)
ClimbToggle.Position = UDim2.new(0, 160, 0, 2.5)
ClimbToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ClimbToggle.BorderSizePixel = 0
ClimbToggle.Text = "OFF"
ClimbToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ClimbToggle.TextSize = 12
ClimbToggle.Font = Enum.Font.GothamBold
ClimbToggle.Parent = ClimbRow

local ClimbToggleCorner = Instance.new("UICorner")
ClimbToggleCorner.CornerRadius = UDim.new(0, 6)
ClimbToggleCorner.Parent = ClimbToggle

-- ================= 100x Speed GP Toggle =================
local SpeedRow = Instance.new("Frame")
SpeedRow.Size = UDim2.new(0, 220, 0, 30)
SpeedRow.Position = UDim2.new(0, 15, 0, 130)
SpeedRow.BackgroundTransparency = 1
SpeedRow.Parent = AutoFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 150, 1, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "2x speed GP"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 13
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SpeedRow

SpeedToggle = Instance.new("TextButton")
SpeedToggle.Size = UDim2.new(0, 50, 0, 25)
SpeedToggle.Position = UDim2.new(0, 160, 0, 2.5)
SpeedToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
SpeedToggle.BorderSizePixel = 0
SpeedToggle.Text = "OFF"
SpeedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedToggle.TextSize = 12
SpeedToggle.Font = Enum.Font.GothamBold
SpeedToggle.Parent = SpeedRow

local SpeedToggleCorner = Instance.new("UICorner")
SpeedToggleCorner.CornerRadius = UDim.new(0, 6)
SpeedToggleCorner.Parent = SpeedToggle

-- ================= VIP Toggle =================
local VIPRow = Instance.new("Frame")
VIPRow.Size = UDim2.new(0, 220, 0, 30)
VIPRow.Position = UDim2.new(0, 15, 0, 165)
VIPRow.BackgroundTransparency = 1
VIPRow.Parent = AutoFrame

local VIPLabel = Instance.new("TextLabel")
VIPLabel.Size = UDim2.new(0, 150, 1, 0)
VIPLabel.BackgroundTransparency = 1
VIPLabel.Text = "VIP"
VIPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
VIPLabel.TextSize = 13
VIPLabel.Font = Enum.Font.GothamBold
VIPLabel.TextXAlignment = Enum.TextXAlignment.Left
VIPLabel.Parent = VIPRow

VIPToggle = Instance.new("TextButton")
VIPToggle.Size = UDim2.new(0, 50, 0, 25)
VIPToggle.Position = UDim2.new(0, 160, 0, 2.5)
VIPToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
VIPToggle.BorderSizePixel = 0
VIPToggle.Text = "OFF"
VIPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
VIPToggle.TextSize = 12
VIPToggle.Font = Enum.Font.GothamBold
VIPToggle.Parent = VIPRow

local VIPToggleCorner = Instance.new("UICorner")
VIPToggleCorner.CornerRadius = UDim.new(0, 6)
VIPToggleCorner.Parent = VIPToggle

-- ================= CONTROL BUTTONS =================
MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -60, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14
MinimizeButton.ZIndex = 5
MinimizeButton.Parent = MainFrame

CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12
CloseButton.ZIndex = 5
CloseButton.Parent = MainFrame

MiniIcon = Instance.new("ImageButton")
MiniIcon.Size = UDim2.new(0, 67, 0, 67)
MiniIcon.Position = UDim2.new(0, 35, 0, 430)
MiniIcon.BackgroundTransparency = 1
MiniIcon.Image = "rbxassetid://90238157870123"
MiniIcon.ScaleType = Enum.ScaleType.Fit
MiniIcon.Visible = false
MiniIcon.ZIndex = 9999
MiniIcon.Parent = ScreenGui
MiniIcon.Active = true
MiniIcon.Draggable = true

-- ================= LOGIC =================
local commonSuffixes = {"", "K", "M", "B", "T", "q", "Q"}
local currentSuffixIndex = 2  -- K

function generateSuffix(index)
    if index <= #commonSuffixes then return commonSuffixes[index] end
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
    local firstChar = suffix:sub(1,1):lower()
    local suffixLength = #suffix
    for i=2,suffixLength do
        if suffix:sub(i,i):lower() ~= firstChar then return 0 end
    end
    local charIndex = string.byte(firstChar) - 96
    local baseExponent = 18
    local stepsFromA = charIndex - 1
    local lengthBonus = (suffixLength - 2) * 78
    return baseExponent + (stepsFromA * 3) + lengthBonus + 3
end

function parseMoneyString(val)
    if type(val)=="number" then return val end
    if type(val)~="string" then return 0 end
    local numStr, suffix = val:match("([%d%.]+)([%a]*)")
    if not numStr then return 0 end
    local number = tonumber(numStr) or 0
    local exponent = getSuffixExponent(suffix)
    return number * (10^exponent)
end

function formatValueToSuffix(value)
    if value==0 then return "0" end
    if value<1000 then return string.format("%.2f", value) end
    local exponent = math.floor(math.log10(value))
    local tier = math.floor(exponent/3)
    local suffixStr = generateSuffix(tier+1)
    local divisor = 10^(tier*3)
    local displayNum = value/divisor
    return string.format("%.2f%s", displayNum, suffixStr)
end

function calculateN(number, suffix)
    local baseNumber = tonumber(number)
    if not baseNumber or baseNumber<=0 then return "Error: Amount must be a number > 0" end
    local exponent = getSuffixExponent(suffix)
    local multiplier = 10^exponent
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
    if Tab0Button.Visible then Tab0Button.BackgroundColor3 = Color3.fromRGB(80,80,80) end
    if Tab1Button.Visible then Tab1Button.BackgroundColor3 = Color3.fromRGB(80,80,80) end
    if Tab2Button.Visible then Tab2Button.BackgroundColor3 = Color3.fromRGB(80,80,80) end
    if Tab3Button.Visible then Tab3Button.BackgroundColor3 = Color3.fromRGB(80,80,80) end
    if Tab4Button.Visible then Tab4Button.BackgroundColor3 = Color3.fromRGB(80,80,80) end
    
    if Tab1Button.Visible then
        for _, lbl in ipairs(Tab1Button:GetChildren()) do
            if lbl:IsA("TextLabel") then
                if lbl.Text == "INJECTOR" then
                    lbl.TextColor3 = Color3.fromRGB(200,200,200)
                elseif lbl.Text == "premium" then
                    lbl.TextColor3 = Color3.fromRGB(150,150,150)
                end
            end
        end
    end

    Tab0Content.Visible = false
    Tab1Content.Visible = false
    Tab2Content.Visible = false
    Tab3Content.Visible = false
    Tab4Content.Visible = false

    if tabNumber == 0 and Tab0Button.Visible then
        Tab0Content.Visible = true
        Tab0Button.BackgroundColor3 = Color3.fromRGB(50,120,200)
    elseif tabNumber == 1 and Tab1Button.Visible then
        Tab1Content.Visible = true
        Tab1Button.BackgroundColor3 = Color3.fromRGB(50,120,200)
        for _, lbl in ipairs(Tab1Button:GetChildren()) do
            if lbl:IsA("TextLabel") then
                if lbl.Text == "INJECTOR" then
                    lbl.TextColor3 = Color3.fromRGB(255,255,255)
                elseif lbl.Text == "premium" then
                    lbl.TextColor3 = Color3.fromRGB(180,180,180)
                end
            end
        end
    elseif tabNumber == 2 and Tab2Button.Visible then
        Tab2Content.Visible = true
        Tab2Button.BackgroundColor3 = Color3.fromRGB(50,120,200)
    elseif tabNumber == 3 and Tab3Button.Visible then
        Tab3Content.Visible = true
        Tab3Button.BackgroundColor3 = Color3.fromRGB(50,120,200)
    elseif tabNumber == 4 and Tab4Button.Visible then
        Tab4Content.Visible = true
        Tab4Button.BackgroundColor3 = Color3.fromRGB(50,120,200)
    end
end

Tab0Button.MouseButton1Click:Connect(function()
    if not isFullAuthorized then showUnauthorizedPopup(); return end
    switchToTab(0)
end)
Tab1Button.MouseButton1Click:Connect(function()
    if not isFullAuthorized then showUnauthorizedPopup(); return end
    switchToTab(1)
end)
Tab2Button.MouseButton1Click:Connect(function()
    switchToTab(2)
end)
Tab3Button.MouseButton1Click:Connect(function()
    if not isFullAuthorized then showUnauthorizedPopup(); return end
    switchToTab(3)
end)
Tab4Button.MouseButton1Click:Connect(function()
    switchToTab(4)
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
    if type(n)=="number" then
        ResultLabel.Text = ""
        inputRawValue = inputNum * (10^getSuffixExponent(inputSuffix))
    else
        ResultLabel.Text = n
        ResultLabel.TextColor3 = Color3.fromRGB(255,100,100)
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
    for i, code in ipairs(codes) do
        pcall(function() RemoteFunction:InvokeServer(code) end)
        wait(1)
    end
end

local function toggleAutoBox()
    if autoBoxRunning then
        autoBoxRunning = false
        AutoBoxButton.Text = "START OPEN BOX"
        AutoBoxStatus.BackgroundColor3 = Color3.fromRGB(255,50,50)
    else
        autoBoxRunning = true
        AutoBoxButton.Text = "STOP OPEN BOX"
        AutoBoxStatus.BackgroundColor3 = Color3.fromRGB(50,255,50)
        autoBoxThread = coroutine.create(function()
            while autoBoxRunning do
                for i=16000100,16000120 do
                    if not autoBoxRunning then break end
                    pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("OpenSouvenirBox", i)
                    end)
                    wait(0.2)
                end
            end
        end)
        coroutine.resume(autoBoxThread)
    end
end

-- ================= WINGS LOGIC =================
local wingsRunning = false

local function unlockWings()
    wingsRunning = true
    WingsButton.Text = "Loading..."
    WingsButton.BackgroundColor3 = Color3.fromRGB(100,100,100)
    WingsButton.Active = false
    WingsStatus.Text = "Scanning bag..."
    task.spawn(function()
        local bag = Player:FindFirstChild("Bag")
        if not bag then
            WingsStatus.Text = "Bag folder not found!"
            wingsRunning = false
            WingsButton.Text = "Unlock Exclusive Wings"
            WingsButton.BackgroundColor3 = Color3.fromRGB(150,0,150)
            WingsButton.Active = true
            return
        end
        local ids = {}
        for _, child in ipairs(bag:GetChildren()) do
            local name = child.Name
            if type(name)=="string" and name:match("^13000%d+$") then
                local id = tonumber(name)
                if id then table.insert(ids, id) end
            end
        end
        if #ids == 0 then
            WingsStatus.Text = "No exclusive wings found in bag."
            wingsRunning = false
            WingsButton.Text = "Unlock Exclusive Wings"
            WingsButton.BackgroundColor3 = Color3.fromRGB(150,0,150)
            WingsButton.Active = true
            return
        end
        table.sort(ids)
        local smallest = ids[1]
        local largest = ids[#ids]
        WingsStatus.Text = string.format("Found IDs from %d to %d. Unlocking...", smallest, largest)
        local remote = game:GetService("ReplicatedStorage"):WaitForChild("Msg"):WaitForChild("RemoteEvent")
        for id = smallest, largest do
            if not wingsRunning then break end
            remote:FireServer("BuyWing", id)
            wait(0.1)
        end
        WingsStatus.Text = "Unlock process completed!"
        wingsRunning = false
        WingsButton.Text = "Unlock Exclusive Wings"
        WingsButton.BackgroundColor3 = Color3.fromRGB(150,0,150)
        WingsButton.Active = true
    end)
end

WingsButton.MouseButton1Click:Connect(function()
    if not isFullAuthorized then showUnauthorizedPopup(); return end
    if not wingsRunning then unlockWings() end
end)

-- ================= HATCH LOGIC =================
local hatchRunning = false
local hatchThread = nil

local function toggleHatch()
    if hatchRunning then
        hatchRunning = false
        HatchButton.Text = "Hatch last egg now"
        HatchButton.BackgroundColor3 = Color3.fromRGB(0,100,200)
    else
        hatchRunning = true
        HatchButton.Text = "Hatching..."
        HatchButton.BackgroundColor3 = Color3.fromRGB(100,100,100)
        hatchThread = coroutine.create(function()
            while hatchRunning do
                local args = {7000096, 10}
                game:GetService("ReplicatedStorage"):WaitForChild("Tool"):WaitForChild("DrawUp"):WaitForChild("Msg"):WaitForChild("DrawHero"):InvokeServer(unpack(args))
                wait(0.2)
            end
        end)
        coroutine.resume(hatchThread)
    end
end

HatchButton.MouseButton1Click:Connect(toggleHatch)

-- ================= AUTO CLIMB TOGGLE LOGIC =================
local function updateClimbButton()
    local setting = Player:FindFirstChild("Setting")
    if setting then
        local val = setting:FindFirstChild("isAutoCllect")
        if val and val.Value == 1 then
            ClimbToggle.Text = "ON"
            ClimbToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            ClimbToggle.Text = "OFF"
            ClimbToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end
    else
        ClimbToggle.Text = "OFF"
        ClimbToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end

ClimbToggle.MouseButton1Click:Connect(function()
    local settingFolder = Player:FindFirstChild("Setting")
    if not settingFolder then
        settingFolder = Instance.new("Folder")
        settingFolder.Name = "Setting"
        settingFolder.Parent = Player
    end
    local val = settingFolder:FindFirstChild("isAutoCllect")
    if not val then
        val = Instance.new("NumberValue")
        val.Name = "isAutoCllect"
        val.Parent = settingFolder
        val.Value = 0
    end
    val.Value = (val.Value == 1) and 0 or 1
    updateClimbButton()
end)

-- ================= 100x SPEED GP LOGIC =================
local originalSpeed = nil
local hundredSpeed = nil
local speedIsOn = false

local function updateSpeedButton()
    if speedIsOn then
        SpeedToggle.Text = "ON"
        SpeedToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        SpeedToggle.Text = "OFF"
        SpeedToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end

SpeedToggle.MouseButton1Click:Connect(function()
    local avatarSpeed = Player:FindFirstChild("AvatarSpeed")
    if not avatarSpeed then return end

    if not speedIsOn then
        originalSpeed = avatarSpeed.Value
        hundredSpeed = originalSpeed * 4
        avatarSpeed.Value = hundredSpeed
        speedIsOn = true
    else
        if avatarSpeed.Value == hundredSpeed then
            avatarSpeed.Value = originalSpeed
        end
        speedIsOn = false
        originalSpeed = nil
        hundredSpeed = nil
    end
    updateSpeedButton()
end)

-- ================= VIP TOGGLE LOGIC =================
local function updateVIPButton()
    local gamePassFolder = Player:FindFirstChild("GamePass")
    if gamePassFolder then
        local val = gamePassFolder:FindFirstChild("VIP")
        if val and val.Value == 1 then
            VIPToggle.Text = "ON"
            VIPToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            VIPToggle.Text = "OFF"
            VIPToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end
    else
        VIPToggle.Text = "OFF"
        VIPToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end

VIPToggle.MouseButton1Click:Connect(function()
    local gamePassFolder = Player:FindFirstChild("GamePass")
    if not gamePassFolder then
        gamePassFolder = Instance.new("Folder")
        gamePassFolder.Name = "GamePass"
        gamePassFolder.Parent = Player
    end
    local val = gamePassFolder:FindFirstChild("VIP")
    if not val then
        val = Instance.new("NumberValue")
        val.Name = "VIP"
        val.Parent = gamePassFolder
        val.Value = 0
    end
    val.Value = (val.Value == 1) and 0 or 1
    updateVIPButton()
end)

updateClimbButton()
updateSpeedButton()
updateVIPButton()

-- ================= MINIMIZE/CLOSE HANDLERS (UPDATED) =================
MinimizeButton.MouseButton1Click:Connect(function()
    if not isFullAuthorized then
        showUnauthorizedPopup()
        ScreenGui:Destroy()  -- Destroy the entire GUI
        return
    end
    MainContainer.Visible = false
    MiniIcon.Visible = true
end)

MiniIcon.MouseButton1Click:Connect(function()
    if not isFullAuthorized then
        showUnauthorizedPopup()
        ScreenGui:Destroy()
        return
    end
    MainContainer.Visible = true
    MiniIcon.Visible = false
end)

CloseButton.MouseButton1Click:Connect(function()
    if not isFullAuthorized then
        showUnauthorizedPopup()
    end
    if autoBoxRunning then autoBoxRunning = false end
    if wingsRunning then wingsRunning = false end
    if hatchRunning then hatchRunning = false end
    ScreenGui:Destroy()
end)

-- ================= EVENT CONNECTIONS =================
UpButton.MouseButton1Click:Connect(function()
    currentSuffixIndex = math.min(currentSuffixIndex+1, getTotalSuffixes())
    updateSymbol()
end)
DownButton.MouseButton1Click:Connect(function()
    currentSuffixIndex = math.max(currentSuffixIndex-1, 1)
    updateSymbol()
end)
AmountBox:GetPropertyChangedSignal("Text"):Connect(updateCalculations)
SymbolBox:GetPropertyChangedSignal("Text"):Connect(updateCalculations)
if MoneyStat then
    MoneyStat.Changed:Connect(updateCalculations)
else
    TotalValueBox.Text = "Money stat not found"
end

GenerateButton.MouseButton1Click:Connect(function()
    if not isFullAuthorized then showUnauthorizedPopup(); return end
    local number = tonumber(AmountBox.Text) or 400
    local suffix = SymbolBox.Text
    local n = calculateN(number, suffix)
    if type(n)=="number" then
        local scriptValue = getScriptValue(n)
        local scriptToExecute = string.format([[
local args = {7000001, -%s}
game:GetService("ReplicatedStorage"):WaitForChild("Tool"):WaitForChild("DrawUp"):WaitForChild("Msg"):WaitForChild("DrawHero"):InvokeServer(unpack(args))
]], scriptValue)
        loadstring(scriptToExecute)()
        ResultLabel.Text = "Successfully generate"
        ResultLabel.TextColor3 = Color3.fromRGB(100,255,100)
        wait(2)
        updateCalculations()
    else
        ResultLabel.Text = "Error: Invalid input"
        ResultLabel.TextColor3 = Color3.fromRGB(255,100,100)
    end
end)

ClaimCodesButton.MouseButton1Click:Connect(claimAllCodes)
AutoBoxButton.MouseButton1Click:Connect(toggleAutoBox)

-- Initialize
updateSymbol()
if isFullAuthorized then
    switchToTab(1)
else
    switchToTab(2)
end