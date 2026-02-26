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
    Message.Text = "You don't have an access, contact fb: dalvstore"
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
            Icon = "rbxassetid://4483345998"
        })
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        UnauthorizedScreenGui:Destroy()
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Access Denied",
        Text = "You are not authorized to use this script",
        Duration = 5
    })
end

-- If not authorized, show popup and stop
if not isFullAuthorized then
    showUnauthorizedPopup()
    return
end

-- ================= MAIN SCRIPT (only runs for authorized users) =================
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
VersionText.Text = "Premium V2.03EN"
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
HatchDesc.Text = "Auto hatch last egg (make sure you have 10hatch gamepass)"
HatchDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
HatchDesc.TextSize = 11
HatchDesc.Font = Enum.Font.Gotham
HatchDesc.TextWrapped = true
HatchDesc.TextXAlignment = Enum.TextXAlignment.Center
HatchDesc.Parent = AutoFrame

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
MiniIcon.Size = UDim2.new(0, 45, 0, 45)
MiniIcon.Position = UDim2.new(0, 10, 0, 10)
MiniIcon.BackgroundTransparency = 1
MiniIcon.Image = "rbxassetid://90238157870123"
MiniIcon.ScaleType = Enum.ScaleType.Fit
MiniIcon.Visible = false
MiniIcon.ZIndex = 9999
MiniIcon.Parent = ScreenGui
MiniIcon.Active = true
MiniIcon.Draggable = true

-- ================= LOGIC =================
-- (All your helper functions – generateSuffix, getSuffixExponent, etc. – keep them)

-- ================= TAB SWITCHING =================
-- (Your switchToTab function and tab click handlers – keep them, but remove any conditional that checks isFullAuthorized because we already know it's true)

-- ================= UPDATERS =================
-- (Keep your updateSymbol, updateCalculations)

-- ================= AUTO BOX LOGIC =================
-- (Keep your claimAllCodes, toggleAutoBox)

-- ================= WINGS LOGIC (UPDATED) =================
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
                if id and child:IsA("NumberValue") then
                    -- Only add if value is 0 (skip if value is 1)
                    if child.Value == 0 then
                        table.insert(ids, id)
                    end
                end
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
        -- Hide ID range; show only "Unlocking..."
        WingsStatus.Text = "Unlocking..."
        local remote = game:GetService("ReplicatedStorage"):WaitForChild("Msg"):WaitForChild("RemoteEvent")
        
        -- Loop through each collected ID (only those with value 0)
        for _, id in ipairs(ids) do
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
    if not wingsRunning then unlockWings() end
end)

-- ================= HATCH LOGIC =================
-- (Keep your toggleHatch)

-- ================= AUTO CLIMB TOGGLE LOGIC =================
-- (Keep your updateClimbButton and click)

-- ================= 100x SPEED GP LOGIC =================
-- (Keep your speed logic)

-- ================= VIP TOGGLE LOGIC =================
-- (Keep your VIP logic)

-- ================= MINIMIZE/CLOSE HANDLERS =================
-- (For authorized users, normal minimize; no popup needed)
MinimizeButton.MouseButton1Click:Connect(function()
    MainContainer.Visible = false
    MiniIcon.Visible = true
end)

MiniIcon.MouseButton1Click:Connect(function()
    MainContainer.Visible = true
    MiniIcon.Visible = false
end)

CloseButton.MouseButton1Click:Connect(function()
    if autoBoxRunning then autoBoxRunning = false end
    if wingsRunning then wingsRunning = false end
    if hatchRunning then hatchRunning = false end
    ScreenGui:Destroy()
end)

-- ================= EVENT CONNECTIONS =================
-- (Keep all your other connections)

-- Initialize
updateSymbol()
switchToTab(1)