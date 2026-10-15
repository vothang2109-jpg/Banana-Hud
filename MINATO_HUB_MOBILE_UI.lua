-- MINATO HUB MOBILE - UI-only starter
-- Intended for Roblox Studio in a LocalScript under StarterPlayerScripts.
-- The controls below change UI state and show feedback; they do NOT automate Blox Fruits.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("MinatoHubMobile")
if old then old:Destroy() end

local theme = {
    bg = Color3.fromRGB(9, 7, 17),
    panel = Color3.fromRGB(19, 14, 33),
    card = Color3.fromRGB(31, 22, 49),
    purple = Color3.fromRGB(139, 73, 255),
    pale = Color3.fromRGB(204, 170, 255),
    text = Color3.fromRGB(245, 240, 255),
    muted = Color3.fromRGB(160, 146, 183),
    green = Color3.fromRGB(76, 220, 145)
}

local pages = {
    "Home", "Farm", "Quest / Items", "Auto Fishing", "Sea Event",
    "Race V4", "Islands", "Raid / Fruits", "Stats", "Teleport",
    "Visual", "Shop", "Misc", "Status"
}

local entries = {
    Home = {"Welcome to MINATO HUB MOBILE", "UI demo ready"},
    Farm = {
        "Auto Farm Level", "Auto Factory", "Auto Farm Nearest", "Farm Bones",
        "Check Bone", "Auto Farm Bones", "Auto Kill Soul Reaper",
        "Auto Trade Bones", "Auto Pray", "Auto Try Luck",
        "Auto Farm Chest And Berry", "Auto Collect Berry",
        "Auto Farm Chest [Tween]", "Auto Farm Chest [Bypass]",
        "Auto Kill Boss Selected", "Auto Farm Material", "Auto Farm Mastery"
    },
    ["Quest / Items"] = {
        "Auto Quest Sea Bartilo", "Auto Quest Sea 3", "Auto Kill Dark Beard",
        "Auto Kill Cursed Captain", "Auto Buy Haki", "Auto Buy Haki Colors",
        "Auto Buy Legendary Sword", "Auto Get Longsword", "Auto Get Gravity Blade",
        "Auto Get Flail", "Auto Get Rengoku", "Auto Get Dragon Trident"
    },
    ["Auto Fishing"] = {
        "Auto Fish", "Use Rod Skill", "Save Fish Position", "Auto Buy Baits",
        "Auto Quest", "Take Quest Only When Fishing", "Auto Sell Fish", "Instant Catch"
    },
    ["Sea Event"] = {
        "Auto Drive Boats", "Auto Farm Sea Beast", "Auto Farm Shark",
        "Auto Farm Piranha", "Auto Farm Fish Crew", "Auto Kill Terror Shark",
        "Safe Mode", "Auto Use Skills"
    },
    ["Race V4"] = {
        "Auto Upgrade Race V2 / V3", "Teleport V4", "Teleport To Great Tree",
        "Teleport Temple Of Time", "Teleport Lever Pull", "Teleport To The Clock",
        "Auto Race Door", "Auto Trial Human Ghost", "Auto Trial All Race"
    },
    Islands = {
        "Find Leviathan Island", "Tween Leviathan Island", "Buy Leviathan Chip",
        "Craft Volcanic Magnet", "Auto Find Prehistoric", "Auto Defend Prehistoric",
        "Auto Kill Golem", "Auto Collect Bone", "Auto Collect Egg",
        "ESP Kitsune Island", "Auto Azure Ember", "Tween Mirage Island",
        "ESP Mirage Island", "Auto Tween To Gear"
    },
    ["Raid / Fruits"] = {
        "Auto Random Fruits", "Auto Store Fruits", "Auto Drop Fruits",
        "Teleport To Fruit Spawn", "Auto Teleport Fruits", "Open Fruit Shop",
        "Open Mirage Shop", "Check Stock Fruits"
    },
    Stats = {"Melee", "Defense", "Sword", "Gun", "Fruit"},
    Teleport = {"Spawn Location", "Select Island", "Sea 1", "Sea 2", "Sea 3"},
    Visual = {
        "Display Flowers", "ESP Legendary Sword Dealer", "ESP My Boat",
        "ESP Players", "ESP Fruits", "ESP Berry", "ESP Chests", "ESP Islands",
        "Aim Gun", "Aim Tap", "Aim Skills", "FPS Boost", "White Screen",
        "Meteor Rain", "Devil Fruit Rain"
    },
    Shop = {"Open Shop", "Open Fruit Shop", "Open Mirage Shop"},
    Misc = {"Notifications", "Safe Mode", "Large UI", "Medium UI", "Small UI"},
    Status = {"Show Current Status", "Reset UI Toggles"}
}

local screen = Instance.new("ScreenGui")
screen.Name = "MinatoHubMobile"
screen.ResetOnSpawn = false
screen.IgnoreGuiInset = true
screen.DisplayOrder = 100
screen.Parent = playerGui

local function create(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties) do object[key] = value end
    object.Parent = parent
    return object
end

local function addCorner(object, radius)
    create("UICorner", {CornerRadius = UDim.new(0, radius)}, object)
end

local function addStroke(object, color, thickness)
    create("UIStroke", {Color = color, Thickness = thickness or 1}, object)
end

local function makeLabel(parent, text, size, color, font)
    return create("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = color or theme.text,
        TextSize = size or 14,
        Font = font or Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        Size = UDim2.new(1, 0, 0, 32)
    }, parent)
end

local root = create("Frame", {
    Name = "Window",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.93, 0, 0.78, 0),
    BackgroundColor3 = theme.bg,
    BorderSizePixel = 0
}, screen)
root.ClipsDescendants = true
addCorner(root, 14)
addStroke(root, theme.purple, 2)
create("UISizeConstraint", {
    MinSize = Vector2.new(300, 340),
    MaxSize = Vector2.new(720, 680)
}, root)

local top = create("Frame", {
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = theme.panel,
    BorderSizePixel = 0
}, root)
local topTitle = makeLabel(top, "  ✦ MINATO HUB MOBILE", 17, theme.pale, Enum.Font.GothamBold)
topTitle.Position = UDim2.new(0, 4, 0, 4)
topTitle.Size = UDim2.new(1, -55, 1, -8)

local closeButton = create("TextButton", {
    Text = "×", TextSize = 25, Font = Enum.Font.GothamBold,
    TextColor3 = theme.text, BackgroundColor3 = theme.card,
    Size = UDim2.fromOffset(34, 34), Position = UDim2.new(1, -41, 0, 7),
    BorderSizePixel = 0
}, top)
addCorner(closeButton, 8)

local sidebar = create("ScrollingFrame", {
    Position = UDim2.new(0, 7, 0, 55),
    Size = UDim2.new(0, 112, 1, -62),
    BackgroundColor3 = theme.panel, BorderSizePixel = 0,
    ScrollBarThickness = 3, ScrollBarImageColor3 = theme.purple,
    CanvasSize = UDim2.new()
}, root)
addCorner(sidebar, 9)
create("UIPadding", {
    PaddingTop = UDim.new(0, 6), PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5)
}, sidebar)
local sideLayout = create("UIListLayout", {
    Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder
}, sidebar)

local content = create("ScrollingFrame", {
    Position = UDim2.new(0, 126, 0, 55),
    Size = UDim2.new(1, -133, 1, -62),
    BackgroundColor3 = theme.bg, BorderSizePixel = 0,
    ScrollBarThickness = 3, ScrollBarImageColor3 = theme.purple,
    CanvasSize = UDim2.new()
}, root)
create("UIPadding", {
    PaddingTop = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4),
    PaddingRight = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8)
}, content)
local contentLayout = create("UIListLayout", {
    Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder
}, content)

local currentPage = "Home"
local states = {}
local statusText
local renderPage

local function refreshCanvas()
    task.defer(function()
        sidebar.CanvasSize = UDim2.new(0, 0, 0, sideLayout.AbsoluteContentSize.Y + 12)
        content.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 15)
    end)
end

local function clearPage()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("GuiObject") and child ~= contentLayout then
            child:Destroy()
        end
    end
end

local function addCard(text, action)
    local button = create("TextButton", {
        Size = UDim2.new(1, -3, 0, 42),
        BackgroundColor3 = theme.card, BorderSizePixel = 0,
        Text = "  " .. text, TextColor3 = theme.text,
        TextSize = 13, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = true
    }, content)
    addCorner(button, 8)
    button.Activated:Connect(action)
    return button
end

local function addToggle(text)
    local row = create("Frame", {
        Size = UDim2.new(1, -3, 0, 43),
        BackgroundColor3 = theme.card, BorderSizePixel = 0
    }, content)
    addCorner(row, 8)

    local caption = makeLabel(row, text, 12, theme.text)
    caption.Position = UDim2.new(0, 9, 0, 2)
    caption.Size = UDim2.new(1, -68, 1, -4)

    local toggle = create("TextButton", {
        Size = UDim2.fromOffset(42, 23),
        Position = UDim2.new(1, -50, 0.5, -11),
        BackgroundColor3 = theme.muted, Text = "",
        BorderSizePixel = 0
    }, row)
    addCorner(toggle, 15)

    local knob = create("Frame", {
        Size = UDim2.fromOffset(17, 17),
        Position = UDim2.new(0, 3, 0.5, -8),
        BackgroundColor3 = theme.text, BorderSizePixel = 0
    }, toggle)
    addCorner(knob, 12)

    local key = currentPage .. ":" .. text
    states[key] = states[key] or false

    local function update()
        local enabled = states[key]
        TweenService:Create(toggle, TweenInfo.new(0.12), {
            BackgroundColor3 = enabled and theme.purple or theme.muted
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.12), {
            Position = enabled and UDim2.new(1, -20, 0.5, -8)
                or UDim2.new(0, 3, 0.5, -8)
        }):Play()
    end

    toggle.Activated:Connect(function()
        states[key] = not states[key]
        update()
        if statusText then
            statusText.Text = text .. ": " .. (states[key] and "ON" or "OFF")
        end
        print("[MINATO HUB UI]", text, states[key] and "ON" or "OFF")
    end)
    update()
end

renderPage = function(page)
    currentPage = page
    clearPage()
    local heading = makeLabel(content, "✦  " .. page, 19, theme.pale, Enum.Font.GothamBold)
    heading.Size = UDim2.new(1, -3, 0, 36)

    if page == "Home" then
        local welcome = create("Frame", {
            Size = UDim2.new(1, -3, 0, 92),
            BackgroundColor3 = theme.panel, BorderSizePixel = 0
        }, content)
        addCorner(welcome, 10)
        addStroke(welcome, theme.purple, 1)
        local w = makeLabel(welcome, "MINATO HUB MOBILE\nPurple Edition • UI Ready", 16, theme.pale, Enum.Font.GothamBold)
        w.Position = UDim2.fromOffset(10, 8)
        w.Size = UDim2.new(1, -20, 1, -16)
        addCard("Show current UI status", function()
            if statusText then statusText.Text = "UI loaded • " .. #pages .. " pages" end
        end)
    elseif page == "Status" then
        statusText = makeLabel(content, "Status: GUI ready", 13, theme.green)
        statusText.Size = UDim2.new(1, -3, 0, 40)
        addCard("Reset all UI toggles", function()
            for key in pairs(states) do states[key] = false end
            statusText.Text = "UI toggle states reset (reopen page to refresh)"
        end)
    end

    for _, item in ipairs(entries[page] or {}) do
        if page == "Home" then
            addCard(item, function()
                if statusText then statusText.Text = item end
                print("[MINATO HUB UI]", item)
            end)
        elseif page == "Stats" or page == "Teleport" or page == "Shop" then
            addCard(item, function()
                if statusText then statusText.Text = "Selected: " .. item end
                print("[MINATO HUB UI] Selected:", item)
            end)
        else
            addToggle(item)
        end
    end
    refreshCanvas()
end

for index, page in ipairs(pages) do
    local nav = create("TextButton", {
        LayoutOrder = index, Size = UDim2.new(1, -2, 0, 35),
        BackgroundColor3 = page == "Home" and theme.purple or theme.card,
        BorderSizePixel = 0, Text = page, TextColor3 = theme.text,
        TextSize = 11, Font = Enum.Font.GothamMedium, TextWrapped = true
    }, sidebar)
    addCorner(nav, 7)
    nav.Activated:Connect(function()
        for _, item in ipairs(sidebar:GetChildren()) do
            if item:IsA("TextButton") then
                item.BackgroundColor3 = item == nav and theme.purple or theme.card
            end
        end
        renderPage(page)
    end)
end

local floating = create("TextButton", {
    Name = "MButton", Size = UDim2.fromOffset(52, 52),
    Position = UDim2.new(0, 14, 0.45, 0),
    BackgroundColor3 = theme.panel, BorderSizePixel = 0,
    Text = "M", TextColor3 = theme.pale, TextSize = 25,
    Font = Enum.Font.GothamBold
}, screen)
addCorner(floating, 26)
addStroke(floating, theme.purple, 2)

local hidden = false
floating.Activated:Connect(function()
    hidden = not hidden
    root.Visible = not hidden
end)
closeButton.Activated:Connect(function()
    root.Visible = false
    hidden = true
end)

-- Drag the floating button on touch or mouse.
local dragging, dragStart, startPosition = false, nil, nil
floating.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = floating.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        floating.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

renderPage("Home")
refreshCanvas()
print("MINATO HUB MOBILE UI loaded.")
