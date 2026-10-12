--[[
    Project: Blox Fruits Ultimate Hub - Pure ASCII / English for Executor Compatibility
    Target: Solara, Wave, Delta, Celery, Fluxus, etc.
]]--

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Cleanup existing GUI
local guiParent = (gethui and gethui()) or CoreGui
if guiParent:FindFirstChild("BluxHUD_BloxFruits_Clean") then
    guiParent["BluxHUD_BloxFruits_Clean"]:Destroy()
end

-- Global Configuration Table
getgenv().BloxConfig = getgenv().BloxConfig or {}
local Options = getgenv().BloxConfig

-- Asset Loader Protocol for Custom Background
local imgUrl = "https://zaygip.vercel.app/api/chat?action=raw_image&id=d472a07394d3fabb4e712bbd6ec19a47"
local fileName = "blux_bg_d472a073.png"
local bgAsset = ""

local function resolveAsset()
    local getAsset = getcustomasset or getsynasset
    if not getAsset or not writefile or not readfile or not isfile then
        return ""
    end
    
    local success = pcall(function()
        if isfile(fileName) then
            local content = readfile(fileName)
            if content:find("<!DOCTYPE") or content:find("<html") or #content < 50 then
                delfile(fileName)
            end
        end
        
        if not isfile(fileName) then
            local response = game:HttpGet(imgUrl)
            if response and not response:find("<!DOCTYPE") and not response:find("<html") and #response > 50 then
                writefile(fileName, response)
            end
        end
    end)
    
    if success and isfile(fileName) then
        local p, res = pcall(function()
            return getAsset(fileName)
        end)
        if p then return res end
    end
    return ""
end

bgAsset = resolveAsset()

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BluxHUD_BloxFruits_Clean"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = guiParent

-- Floating Square Toggle Button with "B"
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleUI"
ToggleButton.Size = UDim2.new(0, 48, 0, 48)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -24)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 18, 26)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "B"
ToggleButton.TextColor3 = Color3.fromRGB(0, 162, 255)
ToggleButton.TextSize = 24
ToggleButton.Active = true
ToggleButton.ZIndex = 10
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 162, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleButton

-- Draggable Toggle Button Logic
local tDragging, tInput, tStart, tPos
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        tDragging = true
        tStart = input.Position
        tPos = ToggleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                tDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        tInput = input
    end
end)

RunService.RenderStepped:Connect(function()
    if tDragging and tInput then
        local delta = tInput.Position - tStart
        ToggleButton.Position = UDim2.new(tPos.X.Scale, tPos.X.Offset + delta.X, tPos.Y.Scale, tPos.Y.Offset + delta.Y)
    end
end)

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 820, 0, 540)
MainFrame.Position = UDim2.new(0.5, -410, 0.5, -270)
MainFrame.BackgroundTransparency = 1
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Visible = true
MainFrame.ZIndex = 1
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Background ImageLabel
local BgImage = Instance.new("ImageLabel")
BgImage.Name = "BgImage"
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.Image = bgAsset
BgImage.ScaleType = Enum.ScaleType.Crop
BgImage.ZIndex = 1
BgImage.Parent = MainFrame

local BgCorner = Instance.new("UICorner")
BgCorner.CornerRadius = UDim.new(0, 12)
BgCorner.Parent = BgImage

-- Darkening Overlay
local DarkOverlay = Instance.new("Frame")
DarkOverlay.Name = "DarkOverlay"
DarkOverlay.Size = UDim2.new(1, 0, 1, 0)
DarkOverlay.BackgroundColor3 = Color3.fromRGB(10, 13, 20)
DarkOverlay.BackgroundTransparency = 0.25
DarkOverlay.BorderSizePixel = 0
DarkOverlay.ZIndex = 2
DarkOverlay.Parent = MainFrame

local OverlayCorner = Instance.new("UICorner")
OverlayCorner.CornerRadius = UDim.new(0, 12)
OverlayCorner.Parent = DarkOverlay

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 162, 255)
MainStroke.Thickness = 1.5
MainStroke.ZIndex = 2
MainStroke.Parent = MainFrame

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 19, 28)
TopBar.BackgroundTransparency = 0.15
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 3
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopBar.Parent = TopBar

local TopCover = Instance.new("Frame")
TopCover.Size = UDim2.new(1, 0, 0, 10)
TopCover.Position = UDim2.new(0, 0, 1, -10)
TopCover.BackgroundColor3 = Color3.fromRGB(15, 19, 28)
TopCover.BackgroundTransparency = 0.15
TopCover.BorderSizePixel = 0
TopCover.ZIndex = 3
TopCover.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -140, 1, 0)
TitleLabel.Position = UDim2.new(0, 16, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "BLOX FRUITS ULTIMATE | CUSTOM BACKGROUND & FULL MENU"
TitleLabel.TextColor3 = Color3.fromRGB(240, 245, 255)
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 3
TitleLabel.Parent = TopBar

-- Close Button (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(230, 50, 50)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
CloseBtn.ZIndex = 3
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Minimize Button (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -74, 0.5, -15)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 16
MinimizeBtn.ZIndex = 3
MinimizeBtn.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    for _, child in pairs(MainFrame:GetChildren()) do
        if child.Name == "Sidebar" or child.Name == "Container" then
            child.Visible = not isMinimized
        end
    end
    if isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 820, 0, 45)}):Play()
        MinimizeBtn.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 820, 0, 540)}):Play()
        MinimizeBtn.Text = "-"
    end
end)

-- Main Frame Dragging Logic
local mDragging, mInput, mStart, mPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        mDragging = true
        mStart = input.Position
        mPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                mDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        mInput = input
    end
end)

RunService.RenderStepped:Connect(function()
    if mDragging and mInput then
        local delta = mInput.Position - mStart
        MainFrame.Position = UDim2.new(mPos.X.Scale, mPos.X.Offset + delta.X, mPos.Y.Scale, mPos.Y.Offset + delta.Y)
    end
end)

-- Sidebar
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 190, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundTransparency = 1
Sidebar.BorderSizePixel = 0
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 650)
Sidebar.ScrollBarThickness = 2
Sidebar.ZIndex = 3
Sidebar.Parent = MainFrame

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 6)
SidebarLayout.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.PaddingLeft = UDim.new(0, 8)
SidebarPadding.PaddingRight = UDim.new(0, 8)
SidebarPadding.Parent = Sidebar

-- Container
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(1, -190, 1, -45)
Container.Position = UDim2.new(0, 190, 0, 45)
Container.BackgroundTransparency = 1
Container.ZIndex = 3
Container.Parent = MainFrame

local tabs = {
    "1. Farm",
    "2. Quest | Items",
    "3. Auto Fishing",
    "4. Sea Event",
    "5. Race V4",
    "6. Islands",
    "7. Raid/Fruits",
    "8. Stats",
    "9. Teleport",
    "10. Visual"
}

local tabFrames = {}
local tabButtons = {}

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Name = tabName .. "Btn"
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = i == 1 and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(15, 19, 28)
    btn.BackgroundTransparency = i == 1 and 0.1 or 0.4
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = tabName
    btn.TextColor3 = i == 1 and Color3.fromRGB(15, 18, 26) or Color3.fromRGB(200, 210, 230)
    btn.TextSize = 13
    btn.ZIndex = 3
    btn.Parent = Sidebar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = tabName .. "Scroll"
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.Visible = (i == 1)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 1800)
    scroll.ScrollBarThickness = 4
    scroll.ZIndex = 3
    scroll.Parent = Container
    
    local scrollLayout = Instance.new("UIListLayout")
    scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
    scrollLayout.Padding = UDim.new(0, 8)
    scrollLayout.Parent = scroll
    
    local scrollPadding = Instance.new("UIPadding")
    scrollPadding.PaddingTop = UDim.new(0, 12)
    scrollPadding.PaddingLeft = UDim.new(0, 12)
    scrollPadding.PaddingRight = UDim.new(0, 12)
    scrollPadding.Parent = scroll
    
    tabFrames[tabName] = scroll
    tabButtons[tabName] = btn
    
    btn.MouseButton1Click:Connect(function()
        for name, frame in pairs(tabFrames) do
            frame.Visible = (name == tabName)
            tabButtons[name].BackgroundColor3 = Color3.fromRGB(15, 19, 28)
            tabButtons[name].BackgroundTransparency = 0.4
            tabButtons[name].TextColor3 = Color3.fromRGB(200, 210, 230)
        end
        btn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
        btn.BackgroundTransparency = 0.1
        btn.TextColor3 = Color3.fromRGB(15, 18, 26)
    end)
end

-- Toggle Builder Component
local function createToggle(parent, text, flag, callback)
    Options[flag] = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(15, 19, 28)
    frame.BackgroundTransparency = 0.35
    frame.BorderSizePixel = 0
    frame.ZIndex = 3
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(45, 55, 75)
    stroke.Thickness = 1
    stroke.ZIndex = 3
    stroke.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 235, 245)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 3
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 44, 0, 22)
    toggleBtn.Position = UDim2.new(1, -54, 0.5, -11)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 55, 75)
    toggleBtn.Text = ""
    toggleBtn.ZIndex = 3
    toggleBtn.Parent = frame
    
    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBtn
    
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 18, 0, 18)
    indicator.Position = UDim2.new(0, 2, 0.5, -9)
    indicator.BackgroundColor3 = Color3.fromRGB(200, 210, 230)
    indicator.ZIndex = 3
    indicator.Parent = toggleBtn
    
    local iCorner = Instance.new("UICorner")
    iCorner.CornerRadius = UDim.new(1, 0)
    iCorner.Parent = indicator
    
    toggleBtn.MouseButton1Click:Connect(function()
        Options[flag] = not Options[flag]
        local state = Options[flag]
        
        if state then
            TweenService:Create(toggleBtn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0, 162, 255)}):Play()
            TweenService:Create(indicator, TweenInfo.new(0.25), {Position = UDim2.new(1, -20, 0.5, -9), BackgroundColor3 = Color3.fromRGB(15, 18, 26)}):Play()
        else
            TweenService:Create(toggleBtn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(45, 55, 75)}):Play()
            TweenService:Create(indicator, TweenInfo.new(0.25), {Position = UDim2.new(0, 2, 0.5, -9), BackgroundColor3 = Color3.fromRGB(200, 210, 230)}):Play()
        end
        
        if callback then
            pcall(function() callback(state) end)
        end
    end)
end

-- ==================== POPULATING ALL 10 TABS ====================

-- 1. Farm
createToggle(tabFrames["1. Farm"], "Auto Farm Level", "AutoFarmLevel", function(v) task.spawn(function() while Options.AutoFarmLevel do print("Farm Level...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Factory", "AutoFactory", function(v) task.spawn(function() while Options.AutoFactory do print("Auto Factory...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Farm Nearest", "AutoFarmNearest", function(v) task.spawn(function() while Options.AutoFarmNearest do print("Farm Nearest...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Farm Bones", "FarmBones", function(v) task.spawn(function() while Options.FarmBones do print("Farm Bones...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Farm Bones", "AutoFarmBones", function(v) task.spawn(function() while Options.AutoFarmBones do print("Auto Farm Bones...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Kill Soul Reaper", "AutoSoulReaper", function(v) task.spawn(function() while Options.AutoSoulReaper do print("Kill Soul Reaper...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Trade Bones", "AutoTradeBones", function(v) task.spawn(function() while Options.AutoTradeBones do print("Trade Bones...") task.wait(3) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Pray", "AutoPray", function(v) task.spawn(function() while Options.AutoPray do print("Auto Pray...") task.wait(5) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Try Luck", "AutoTryLuck", function(v) task.spawn(function() while Options.AutoTryLuck do print("Auto Try Luck...") task.wait(5) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Farm Chest And Berry", "AutoChestBerry", function(v) task.spawn(function() while Options.AutoChestBerry do print("Farm Chest & Berry...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Collect Berry", "AutoCollectBerry", function(v) task.spawn(function() while Options.AutoCollectBerry do print("Collect Berry...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Farm Chest [Tween]", "AutoChestTween", function(v) task.spawn(function() while Options.AutoChestTween do print("Chest Tween...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Farm Chest [Bypass]", "AutoChestBypass", function(v) task.spawn(function() while Options.AutoChestBypass do print("Chest Bypass...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Kill Boss Selected", "AutoKillBoss", function(v) task.spawn(function() while Options.AutoKillBoss do print("Kill Boss...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Farm Material", "AutoFarmMaterial", function(v) task.spawn(function() while Options.AutoFarmMaterial do print("Farm Material...") task.wait(1) end end) end)
createToggle(tabFrames["1. Farm"], "Auto Farm Mastery", "AutoFarmMastery", function(v) task.spawn(function() while Options.AutoFarmMastery do print("Farm Mastery...") task.wait(1) end end) end)

-- 2. Quest | Items
createToggle(tabFrames["2. Quest | Items"], "Auto Quest Sea Bartilo", "BartiloQuest", function(v) task.spawn(function() while Options.BartiloQuest do print("Bartilo Quest...") task.wait(2) end end) end)
createToggle(tabFrames["2. Quest | Items"], "Auto Quest Sea 3", "Sea3Quest", function(v) task.spawn(function() while Options.Sea3Quest do print("Sea 3 Quest...") task.wait(2) end end) end)
createToggle(tabFrames["2. Quest | Items"], "Auto Kill Dark Beard", "DarkBeard", function(v) task.spawn(function() while Options.DarkBeard do print("Dark Beard...") task.wait(2) end end) end)
createToggle(tabFrames["2. Quest | Items"], "Auto Kill Cursed Captain", "CursedCaptain", function(v) task.spawn(function() while Options.CursedCaptain do print("Cursed Captain...") task.wait(2) end end) end)
createToggle(tabFrames["2. Quest | Items"], "Auto Buy Haki", "BuyHaki", function(v) task.spawn(function() while Options.BuyHaki do print("Buy Haki...") task.wait(5) end end) end)
createToggle(tabFrames["2. Quest | Items"], "Auto Buy Haki Colors", "BuyHakiColors", function(v) task.spawn(function() while Options.BuyHakiColors do print("Buy Haki Colors...") task.wait(5) end end) end)
createToggle(tabFrames["2. Quest | Items"], "Auto Buy Legendary Sword", "LegendarySword", function(v) task.spawn(function() while Options.LegendarySword do print("Buy Legendary Sword...") task.wait(5) end end) end)
createToggle(tabFrames["2. Quest | Items"], "Auto Get Longsword", "GetLongsword", function(v) task.spawn(function() while Options.GetLongsword do print("Get Longsword...") task.wait(2) end end) end)
createToggle(tabFrames["2. Quest | Items"], "Auto Get Sword Gravity Blade", "GetGravityBlade", function(v) task.spawn(function() while Options.GetGravityBlade do print("Get Gravity Blade...") task.wait(2) end end) end)
createToggle(tabFrames["2. Quest | Items"], "Auto Get Sword Flail", "GetFlail", function(v) task.spawn(function() while Options.GetFlail do print("Get Flail...") task.wait(2) end end) end)
createToggle(tabFrames["2. Quest | Items"], "Auto Get Sword Rengoku", "GetRengoku", function(v) task.spawn(function() while Options.GetRengoku do print("Get Rengoku...") task.wait(2) end end) end)
createToggle(tabFrames["2. Quest | Items"], "Auto Get Sword Dragon Trident", "GetDragonTrident", function(v) task.spawn(function() while Options.GetDragonTrident do print("Get Dragon Trident...") task.wait(2) end end) end)

-- 3. Auto Fishing
createToggle(tabFrames["3. Auto Fishing"], "Auto Fish", "AutoFish", function(v) task.spawn(function() while Options.AutoFish do print("Auto Fish...") task.wait(1) end end) end)
createToggle(tabFrames["3. Auto Fishing"], "Auto use skill of the rod", "RodSkill", function(v) task.spawn(function() while Options.RodSkill do print("Rod Skill...") task.wait(2) end end) end)
createToggle(tabFrames["3. Auto Fishing"], "Save Fish Position", "SaveFishPos", function(v) if v then print("Saved Fish Position") end end)
createToggle(tabFrames["3. Auto Fishing"], "Auto Buy Baits", "BuyBaits", function(v) task.spawn(function() while Options.BuyBaits do print("Buy Baits...") task.wait(5) end end) end)
createToggle(tabFrames["3. Auto Fishing"], "Auto Quest [Skip Get, Complete]", "FishQuest", function(v) task.spawn(function() while Options.FishQuest do print("Fish Quest...") task.wait(2) end end) end)
createToggle(tabFrames["3. Auto Fishing"], "Take Quest Only When Fishing", "TakeQuestFish", function(v) task.spawn(function() while Options.TakeQuestFish do print("Take Quest Fishing...") task.wait(2) end end) end)
createToggle(tabFrames["3. Auto Fishing"], "Auto Sell Fish", "SellFish", function(v) task.spawn(function() while Options.SellFish do print("Sell Fish...") task.wait(3) end end) end)
createToggle(tabFrames["3. Auto Fishing"], "Instant Catch", "InstantCatch", function(v) task.spawn(function() while Options.InstantCatch do print("Instant Catch...") task.wait(0.5) end end) end)

-- 4. Sea Event
createToggle(tabFrames["4. Sea Event"], "Auto Drive Boats", "DriveBoat", function(v) task.spawn(function() while Options.DriveBoat do print("Drive Boat...") task.wait(1) end end) end)
createToggle(tabFrames["4. Sea Event"], "Auto Farm Sea Beast", "FarmSB", function(v) task.spawn(function() while Options.FarmSB do print("Farm Sea Beast...") task.wait(1) end end) end)
createToggle(tabFrames["4. Sea Event"], "Auto Farm Shark", "FarmShark", function(v) task.spawn(function() while Options.FarmShark do print("Farm Shark...") task.wait(1) end end) end)
createToggle(tabFrames["4. Sea Event"], "Auto Farm Piranha", "FarmPiranha", function(v) task.spawn(function() while Options.FarmPiranha do print("Farm Piranha...") task.wait(1) end end) end)
createToggle(tabFrames["4. Sea Event"], "Auto Farm Fish Crew", "FarmFishCrew", function(v) task.spawn(function() while Options.FarmFishCrew do print("Farm Fish Crew...") task.wait(1) end end) end)
createToggle(tabFrames["4. Sea Event"], "Auto Kill Terror Shark", "TerrorShark", function(v) task.spawn(function() while Options.TerrorShark do print("Kill Terror Shark...") task.wait(1) end end) end)
createToggle(tabFrames["4. Sea Event"], "Safe Mode", "SafeMode", function(v) task.spawn(function() while Options.SafeMode do print("Safe Mode...") task.wait(0.5) end end) end)
createToggle(tabFrames["4. Sea Event"], "Auto Use Skills", "SeaSkills", function(v) task.spawn(function() while Options.SeaSkills do print("Sea Skills...") task.wait(1) end end) end)

-- 5. Race V4
createToggle(tabFrames["5. Race V4"], "Auto Upgrade Race V2 / V3", "UpgradeRace", function(v) task.spawn(function() while Options.UpgradeRace do print("Upgrade Race...") task.wait(2) end end) end)
createToggle(tabFrames["5. Race V4"], "Teleport To Top Greattree", "TpGreattree", function(v) if v then print("TP Greattree") end end)
createToggle(tabFrames["5. Race V4"], "Teleport Temple Of Time", "TpTemple", function(v) if v then print("TP Temple") end end)
createToggle(tabFrames["5. Race V4"], "Teleport Lever Pull", "TpLever", function(v) if v then print("TP Lever") end end)
createToggle(tabFrames["5. Race V4"], "Teleport To The Clock", "TpClock", function(v) if v then print("TP Clock") end end)
createToggle(tabFrames["5. Race V4"], "Auto Race Door", "RaceDoor", function(v) task.spawn(function() while Options.RaceDoor do print("Race Door...") task.wait(1) end end) end)
createToggle(tabFrames["5. Race V4"], "Buy Ancient One Quest", "AncientOne", function(v) if v then print("Ancient One Quest") end end)
createToggle(tabFrames["5. Race V4"], "Auto Trial Human Ghost", "TrialGhost", function(v) task.spawn(function() while Options.TrialGhost do print("Trial Ghost...") task.wait(2) end end) end)
createToggle(tabFrames["5. Race V4"], "Auto Trial All Race", "AutoTrial", function(v) task.spawn(function() while Options.AutoTrial do print("Auto Trial All...") task.wait(2) end end) end)

-- 6. Islands
createToggle(tabFrames["6. Islands"], "Find Leviathan Island", "FindLevi", function(v) task.spawn(function() while Options.FindLevi do print("Find Leviathan...") task.wait(2) end end) end)
createToggle(tabFrames["6. Islands"], "Tween Leviathan Island", "TweenLevi", function(v) task.spawn(function() while Options.TweenLevi do print("Tween Leviathan...") task.wait(1) end end) end)
createToggle(tabFrames["6. Islands"], "Buy Leviathan Chip", "BuyLeviChip", function(v) if v then print("Buy Leviathan Chip") end end)
createToggle(tabFrames["6. Islands"], "Craft Volcanic Magnet", "CraftMagnet", function(v) if v then print("Craft Magnet") end end)
createToggle(tabFrames["6. Islands"], "Auto Find Prehistoric", "FindPrehistoric", function(v) task.spawn(function() while Options.FindPrehistoric do print("Find Prehistoric...") task.wait(2) end end) end)
createToggle(tabFrames["6. Islands"], "Auto Tween Prehistoric Island", "TweenPrehistoric", function(v) task.spawn(function() while Options.TweenPrehistoric do print("Tween Prehistoric...") task.wait(1) end end) end)
createToggle(tabFrames["6. Islands"], "Auto Defend Prehistoric", "DefendPrehistoric", function(v) task.spawn(function() while Options.DefendPrehistoric do print("Defend Prehistoric...") task.wait(1) end end) end)
createToggle(tabFrames["6. Islands"], "Auto Kill Golem", "KillGolem", function(v) task.spawn(function() while Options.KillGolem do print("Kill Golem...") task.wait(1) end end) end)
createToggle(tabFrames["6. Islands"], "Auto Kill Aura Golem", "KillAuraGolem", function(v) task.spawn(function() while Options.KillAuraGolem do print("Kill Aura Golem...") task.wait(1) end end) end)
createToggle(tabFrames["6. Islands"], "Auto Collect Bone & Egg", "CollectBoneEgg", function(v) task.spawn(function() while Options.CollectBoneEgg do print("Collect Bone & Egg...") task.wait(1) end end) end)
createToggle(tabFrames["6. Islands"], "Auto Collect Bone", "CollectBone", function(v) task.spawn(function() while Options.CollectBone do print("Collect Bone...") task.wait(1) end end) end)
createToggle(tabFrames["6. Islands"], "Auto Collect Egg", "CollectEgg", function(v) task.spawn(function() while Options.CollectEgg do print("Collect Egg...") task.wait(1) end end) end)
createToggle(tabFrames["6. Islands"], "Esp Kitsune Island", "EspKitsune", function(v) task.spawn(function() while Options.EspKitsune do print("ESP Kitsune...") task.wait(2) end end) end)
createToggle(tabFrames["6. Islands"], "Fly To Kitsune Island", "FlyKitsune", function(v) task.spawn(function() while Options.FlyKitsune do print("Fly Kitsune...") task.wait(1) end end) end)
createToggle(tabFrames["6. Islands"], "Auto Azuer Ember", "AzureEmber", function(v) task.spawn(function() while Options.AzureEmber do print("Azure Ember...") task.wait(1) end end) end)
createToggle(tabFrames["6. Islands"], "Tween Mirage Island", "TweenMirage", function(v) task.spawn(function() while Options.TweenMirage do print("Tween Mirage...") task.wait(2) end end) end)
createToggle(tabFrames["6. Islands"], "Esp Mirage Island", "EspMirage", function(v) task.spawn(function() while Options.EspMirage do print("ESP Mirage...") task.wait(2) end end) end)
createToggle(tabFrames["6. Islands"], "Look Moon + Auto V3", "MirageMoon", function(v) task.spawn(function() while Options.MirageMoon do print("Look Moon V3...") task.wait(1) end end) end)
createToggle(tabFrames["6. Islands"], "Auto Tween To Gear", "TweenGear", function(v) task.spawn(function() while Options.TweenGear do print("Tween Gear...") task.wait(1) end end) end)

-- 7. Raid/Fruits
createToggle(tabFrames["7. Raid/Fruits"], "Auto Random Fruits", "RandomFruit", function(v) task.spawn(function() while Options.RandomFruit do print("Random Fruit...") task.wait(5) end end) end)
createToggle(tabFrames["7. Raid/Fruits"], "Auto Store Fruits", "StoreFruit", function(v) task.spawn(function() while Options.StoreFruit do print("Store Fruit...") task.wait(2) end end) end)
createToggle(tabFrames["7. Raid/Fruits"], "Auto Drop Fruits", "DropFruit", function(v) task.spawn(function() while Options.DropFruit do print("Drop Fruit...") task.wait(2) end end) end)
createToggle(tabFrames["7. Raid/Fruits"], "Auto Teleport Fruits", "TpFruit", function(v) task.spawn(function() while Options.TpFruit do print("TP Fruit...") task.wait(1) end end) end)
createToggle(tabFrames["7. Raid/Fruits"], "Open Fruit Shop", "FruitShop", function(v) if v then print("Open Fruit Shop") end end)
createToggle(tabFrames["7. Raid/Fruits"], "Open Mirage Shop", "MirageShop", function(v) if v then print("Open Mirage Shop") end end)
createToggle(tabFrames["7. Raid/Fruits"], "Check Stock Fruits", "StockFruit", function(v) task.spawn(function() while Options.StockFruit do print("Check Stock...") task.wait(10) end end) end)

-- 8. Stats
createToggle(tabFrames["8. Stats"], "Auto Status (Melee/Defense/Sword/...)", "AutoStats", function(v) task.spawn(function() while Options.AutoStats do print("Auto Stats...") task.wait(1) end end) end)

-- 9. Teleport
createToggle(tabFrames["9. Teleport"], "Auto Tween To Island", "TweenIsland", function(v) task.spawn(function() while Options.TweenIsland do print("Tween Island...") task.wait(2) end end) end)
createToggle(tabFrames["9. Teleport"], "Teleport Sea 1", "TpSea1", function(v) if v then print("TP Sea 1") end end)
createToggle(tabFrames["9. Teleport"], "Teleport Sea 2", "TpSea2", function(v) if v then print("TP Sea 2") end end)
createToggle(tabFrames["9. Teleport"], "Teleport Sea 3", "TpSea3", function(v) if v then print("TP Sea 3") end end)

-- 10. Visual
createToggle(tabFrames["10. Visual"], "Toggle: Display Flowers", "EspFlowers", function(v) task.spawn(function() while Options.EspFlowers do print("ESP Flowers...") task.wait(1) end end) end)
createToggle(tabFrames["10. Visual"], "ESP Legendary Sword Dealer", "EspDealer", function(v) task.spawn(function() while Options.EspDealer do print("ESP Dealer...") task.wait(2) end end) end)
createToggle(tabFrames["10. Visual"], "ESP My Boat", "EspBoat", function(v) task.spawn(function() while Options.EspBoat do print("ESP Boat...") task.wait(1) end end) end)
createToggle(tabFrames["10. Visual"], "ESP Players", "EspPlayers", function(v) task.spawn(function() while Options.EspPlayers do print("ESP Players...") task.wait(1) end end) end)
createToggle(tabFrames["10. Visual"], "ESP Fruits", "EspFruits", function(v) task.spawn(function() while Options.EspFruits do print("ESP Fruits...") task.wait(1) end end) end)
createToggle(tabFrames["10. Visual"], "ESP Berry", "EspBerry", function(v) task.spawn(function() while Options.EspBerry do print("ESP Berry...") task.wait(1) end end) end)
createToggle(tabFrames["10. Visual"], "ESP Chests", "EspChests", function(v) task.spawn(function() while Options.EspChests do print("ESP Chests...") task.wait(1) end end) end)
createToggle(tabFrames["10. Visual"], "ESP Islands", "EspIslands", function(v) task.spawn(function() while Options.EspIslands do print("ESP Islands...") task.wait(2) end end) end)
createToggle(tabFrames["10. Visual"], "Aim Gun", "AimGun", function(v) task.spawn(function() while Options.AimGun do print("Aim Gun...") task.wait(0.1) end end) end)
createToggle(tabFrames["10. Visual"], "Aim Tap", "AimTap", function(v) task.spawn(function() while Options.AimTap do print("Aim Tap...") task.wait(0.1) end end) end)
createToggle(tabFrames["10. Visual"], "Aim Skills", "AimSkills", function(v) task.spawn(function() while Options.AimSkills do print("Aim Skills...") task.wait(0.1) end end) end)
createToggle(tabFrames["10. Visual"], "Ignore Mobs", "IgnoreMobs", function(v) if v then print("Ignore Mobs Enabled") end end)
createToggle(tabFrames["10. Visual"], "FPS Boost", "FpsBoost", function(v)
    if v then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    else
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
    end
end)
createToggle(tabFrames["10. Visual"], "White Screen", "WhiteScreen", function(v) if v then print("White Screen Enabled") end end)
createToggle(tabFrames["10. Visual"], "Meteor Rain", "MeteorRain", function(v) task.spawn(function() while Options.MeteorRain do print("Meteor Rain...") task.wait(5) end end) end)
createToggle(tabFrames["10. Visual"], "Devil Fruit Rain", "FruitRain", function(v) task.spawn(function() while Options.FruitRain do print("Devil Fruit Rain...") task.wait(5) end end) end)

print("[Blox Fruits Hub] Initialization completed successfully!")