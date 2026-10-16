
--[[
    MINATO HUB MOBILE v1.0
    Purple / Black - Android Responsive UI
    Place: StarterPlayer > StarterPlayerScripts
    Type: LocalScript

    UI TEMPLATE ONLY:
    - Tabs, toggles, dropdowns and sliders work locally.
    - Gameplay actions are not connected to a game server.
    - No fake success messages.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("MinatoHubMobile")
if oldGui then oldGui:Destroy() end

local Theme = {
    Background = Color3.fromRGB(7, 6, 15),
    Panel = Color3.fromRGB(15, 12, 28),
    Card = Color3.fromRGB(21, 17, 39),
    Card2 = Color3.fromRGB(29, 22, 50),
    Purple = Color3.fromRGB(139, 73, 255),
    Light = Color3.fromRGB(190, 143, 255),
    White = Color3.fromRGB(244, 239, 255),
    Muted = Color3.fromRGB(157, 146, 183),
    Green = Color3.fromRGB(80, 220, 150),
    Red = Color3.fromRGB(255, 100, 125),
}

local function make(className, props, parent)
    local obj = Instance.new(className)
    for key, value in pairs(props or {}) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local function corner(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius or 10)
    }, obj)
end

local function stroke(obj, color, transparency)
    make("UIStroke", {
        Color = color or Theme.Purple,
        Thickness = 1,
        Transparency = transparency or 0.35
    }, obj)
end

local function label(parent, text, size, color, font)
    return make("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = color or Theme.White,
        TextSize = size or 13,
        Font = font or Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true,
    }, parent)
end

local gui = make("ScreenGui", {
    Name = "MinatoHubMobile",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 50,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

local root = make("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.94, 0.86),
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0,
}, gui)
corner(root, 14)
stroke(root, Theme.Purple, 0.12)

local rootConstraint = make("UISizeConstraint", {
    MinSize = Vector2.new(300, 300),
    MaxSize = Vector2.new(1100, 850),
}, root)

local rootScale = make("UIScale", {
    Scale = 1
}, root)

local header = make("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = Theme.Panel,
    BorderSizePixel = 0,
}, root)
corner(header, 14)

local title = label(header, "✦  MINATO HUB", 21, Theme.Light, Enum.Font.GothamBold)
title.Position = UDim2.fromOffset(14, 3)
title.Size = UDim2.new(0.62, -14, 0, 30)

local subtitle = label(header, "MOBILE  •  PURPLE EDITION", 9, Theme.Muted)
subtitle.Position = UDim2.fromOffset(16, 32)
subtitle.Size = UDim2.new(0.65, -16, 0, 17)

local closeButton = make("TextButton", {
    Name = "Close",
    Text = "×",
    TextSize = 24,
    Font = Enum.Font.GothamBold,
    TextColor3 = Theme.White,
    BackgroundColor3 = Theme.Card2,
    Size = UDim2.fromOffset(36, 36),
    Position = UDim2.new(1, -45, 0, 11),
}, header)
corner(closeButton, 10)

local minimizeButton = make("TextButton", {
    Name = "Minimize",
    Text = "−",
    TextSize = 23,
    Font = Enum.Font.GothamBold,
    TextColor3 = Theme.White,
    BackgroundColor3 = Theme.Card2,
    Size = UDim2.fromOffset(30, 30),
    Position = UDim2.new(1, -80, 0, 14),
}, header)
corner(minimizeButton, 9)

local body = make("Frame", {
    Name = "Body",
    Position = UDim2.fromOffset(0, 58),
    Size = UDim2.new(1, 0, 1, -58),
    BackgroundTransparency = 1,
}, root)

local sidebar = make("ScrollingFrame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 112, 1, -8),
    Position = UDim2.fromOffset(5, 4),
    BackgroundColor3 = Theme.Panel,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Theme.Purple,
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, body)
corner(sidebar, 10)

make("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, sidebar)

make("UIPadding", {
    PaddingTop = UDim.new(0, 7),
    PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 7),
}, sidebar)

local content = make("ScrollingFrame", {
    Name = "Content",
    Position = UDim2.new(0, 123, 0, 4),
    Size = UDim2.new(1, -128, 1, -8),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Theme.Purple,
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, body)

make("UIListLayout", {
    Padding = UDim.new(0, 9),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, content)

make("UIPadding", {
    PaddingTop = UDim.new(0, 2),
    PaddingLeft = UDim.new(0, 2),
    PaddingRight = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 10),
}, content)

local statusBar = make("TextLabel", {
    Name = "StatusBar",
    Text = "UI READY  •  GAMEPLAY NOT CONNECTED",
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextColor3 = Theme.Muted,
    TextXAlignment = Enum.TextXAlignment.Left,
    BackgroundColor3 = Theme.Panel,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 123, 1, -21),
    Size = UDim2.new(1, -128, 0, 18),
}, body)

-- Data format:
-- {type, name, options?}
-- Supported types: toggle, select, slider, button, info

local T = "toggle"
local S = "select"
local B = "button"
local I = "info"
local L = "slider"

local pages = {
    {
        name = "Farm",
        icon = "⚔",
        sections = {
            {"Farm Settings", {
                {S, "Select Tool", {"Melee", "Sword", "Gun", "Blox Fruit"}},
                {S, "UI Scale", {"Large", "Medium", "Small"}},
                {T, "Auto Farm Level"},
                {T, "Auto Factory"},
                {T, "Auto Farm Nearest"},
                {T, "Farm Bones"},
                {B, "Check Bone"},
                {T, "Auto Farm Bones"},
                {T, "Auto Kill Soul Reaper"},
                {T, "Auto Trade Bones"},
                {T, "Auto Pray"},
                {T, "Auto Try Luck"},
                {T, "Auto Farm Chest And Berry"},
                {T, "Auto Collect Berry"},
                {T, "Auto Farm Chest [Tween]"},
                {T, "Auto Farm Chest [Bypass]"},
            }},
            {"Boss Farm", {
                {I, "Boss Spawn Status: chưa kết nối dữ liệu game"},
                {S, "Boss List", {"Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Cursed Captain", "Dark Beard", "Other"}},
                {T, "Auto Kill Boss Selected"},
            }},
            {"Material", {
                {S, "Material List", {"Radioactive", "Mystic Droplet", "Vampire Fang", "Magma Ore", "Scrap Metal", "Leather", "Other"}},
                {T, "Auto Farm Material"},
            }},
            {"Mastery", {
                {S, "Select Farm Type", {"Level", "Mastery"}},
                {S, "Mastery Tool", {"Melee", "Sword", "Gun", "Blox Fruit"}},
                {S, "Select Skills", {"X", "C", "Z", "F"}},
                {L, "Use Skill on HP", 19, 100},
                {T, "Auto Farm Mastery"},
            }},
        }
    },
    {
        name = "Quest | Items",
        icon = "♜",
        sections = {
            {"Sea 2 / Sea 3", {
                {B, "Quest Sea 2"},
                {T, "Auto Quest Sea Bartilo"},
                {B, "Quest Sea 3"},
                {T, "Auto Quest Sea 3"},
            }},
            {"Bosses", {
                {T, "Auto Kill Dark Beard"},
                {T, "Auto Kill Cursed Captain"},
            }},
            {"Purchases", {
                {T, "Auto Buy Haki"},
                {T, "Auto Buy Haki Colors"},
                {T, "Auto Buy Legendary Sword"},
            }},
            {"Quest Sword", {
                {T, "Auto Get Longsword"},
                {T, "Auto Get Sword Gravity Blade"},
                {T, "Auto Get Sword Flail"},
                {T, "Auto Get Sword Rengoku"},
                {T, "Auto Get Sword Dragon Trident"},
            }},
        }
    },
    {
        name = "Auto Fishing",
        icon = "♧",
        sections = {
            {"Fishing", {
                {T, "Auto Fish"},
                {T, "Auto use skill of the rod"},
                {B, "Save Fish Position"},
                {S, "Select Bait", {"Basic Bait", "Unusual Bait", "Rare Bait", "Epic Bait", "Legendary Bait"}},
                {L, "Max Baits", 10, 100},
                {T, "Auto Buy Baits"},
                {B, "Buy Bait"},
            }},
            {"Quest", {
                {S, "Skip Quests", {"None", "Easy", "Medium", "Hard", "All"}},
                {T, "Auto Quest [Skip Get, Complete]"},
                {T, "Take Quest Only When Fishing"},
            }},
            {"Sell / Manual", {
                {S, "Select Fish Kind", {"All Fish", "Common", "Uncommon", "Rare", "Epic", "Legendary"}},
                {T, "Auto Sell Fish"},
                {T, "Instant Catch"},
            }},
            {"Settings", {
                {S, "Select Fishing Rod", {"Fishing Rod", "Advanced Rod", "Other Rod"}},
            }},
        }
    },
    {
        name = "Sea Event",
        icon = "♆",
        sections = {
            {"Boat", {
                {T, "Auto Drive Boats"},
                {S, "Select Boat", {"Brigade", "Sloop", "Beast Hunter", "Other"}},
                {S, "Sea Level", {"Infinite", "Low", "Medium", "High"}},
                {L, "Tween Speed", 300, 500},
                {L, "Tween Height", 0, 100},
            }},
            {"Sea Enemies", {
                {T, "Auto Farm Sea Beast"},
                {T, "Auto Farm Shark"},
                {T, "Auto Farm Piranha"},
                {T, "Auto Farm Fish Crew"},
                {T, "Auto Kill Terror Shark"},
                {T, "Safe Mode"},
                {T, "Auto Use Skills"},
            }},
            {"Combat Skills", {
                {S, "Select Tool", {"Sword", "Gun", "Melee", "Blox Fruit"}},
                {S, "Select Melee Skills", {"X", "C", "Z"}},
                {S, "Select Fruit Skills", {"X", "C", "Z", "F"}},
                {S, "Select Gun Skills", {"Z", "X"}},
            }},
        }
    },
    {
        name = "Race V4",
        icon = "♜",
        sections = {
            {"Race Upgrade", {
                {B, "Race Upgrade V2"},
                {B, "Race Upgrade V3"},
                {T, "Auto Upgrade Race V2"},
                {T, "Auto Upgrade Race V3"},
            }},
            {"Teleport V4", {
                {B, "Teleport To Top Greattree"},
                {B, "Teleport Temple Of Time"},
                {B, "Teleport Lever Pull"},
                {B, "Teleport To The Clock"},
            }},
            {"Trial V4", {
                {T, "Auto Race Door"},
                {B, "Buy Ancient One Quest"},
                {T, "Auto Trial Human Ghost"},
                {T, "Auto Trial All Race"},
            }},
        }
    },
    {
        name = "Islands",
        icon = "⌂",
        sections = {
            {"Leviathan Island • Sea 3", {
                {I, "Status: chưa kết nối dữ liệu đảo"},
                {B, "Find Leviathan Island"},
                {B, "Tween Leviathan Island"},
                {I, "Leviathan Chip: chưa kiểm tra"},
                {B, "Buy Leviathan Chip"},
            }},
            {"Volcanic / Prehistoric", {
                {B, "Craft Volcanic Magnet"},
                {I, "Prehistoric Island: chưa kiểm tra"},
                {T, "Auto Find Prehistoric"},
                {T, "Auto Tween Prehistoric Island"},
                {S, "Select Skills to Use", {"Sword", "Melee", "Gun"}},
                {T, "Auto Defend Prehistoric"},
                {T, "Auto Kill Golem"},
                {T, "Auto Kill Aura Golem"},
                {T, "Auto Collect Bone.Egg"},
                {T, "Auto Collect Bone"},
                {T, "Auto Collect Egg"},
            }},
            {"Kitsune Island", {
                {I, "Kitsune Island: chưa kiểm tra"},
                {T, "ESP Kitsune Island"},
                {B, "Fly To Kitsune Island"},
                {T, "Auto Azure Ember"},
            }},
            {"Mirage Island", {
                {I, "Mirage Island: chưa kiểm tra"},
                {B, "Tween Mirage Island"},
                {T, "ESP Mirage Island"},
                {T, "Look Moon + Auto V3"},
                {T, "Auto Tween To Gear"},
            }},
        }
    },
    {
        name = "Raid / Fruits",
        icon = "✿",
        sections = {
            {"Fruits", {
                {T, "Auto Random Fruits"},
                {T, "Auto Store Fruits"},
                {T, "Auto Drop Fruits"},
                {B, "Teleport To Fruit Spawn"},
                {T, "Auto Teleport Fruits"},
                {B, "Open Fruit Shop"},
                {B, "Open Mirage Shop"},
                {B, "Check Stock Fruits"},
            }},
        }
    },
    {
        name = "Stats",
        icon = "▥",
        sections = {
            {"Stat Settings", {
                {L, "Points Amount", 1, 1000},
                {T, "Auto Status"},
                {S, "Select Status", {"Melee", "Defense", "Sword", "Gun", "Fruit"}},
                {B, "Apply Selected Stat"},
            }},
        }
    },
    {
        name = "Teleport",
        icon = "⌖",
        sections = {
            {"Teleport Island", {
                {S, "Select Island", {"The Cafe", "Kingdom of Rose", "Green Zone", "Graveyard", "Hot and Cold", "Ice Castle", "Forgotten Island", "Castle on the Sea", "Great Tree", "Hydra Island", "Mansion", "Port Town", "Other"}},
                {T, "Auto Tween To Island"},
            }},
            {"Teleport Sea", {
                {B, "Sea 1"},
                {B, "Sea 2"},
                {B, "Sea 3"},
            }},
        }
    },
    {
        name = "Visual",
        icon = "◉",
        sections = {
            {"ESP", {
                {L, "ESP Size", 10, 30},
                {T, "Display Flowers"},
                {T, "ESP Legendary Sword Dealer"},
                {T, "ESP My Boat"},
                {T, "ESP Players"},
                {T, "ESP Fruits"},
                {T, "ESP Berry"},
                {T, "ESP Chests"},
                {T, "ESP Islands"},
            }},
            {"Aim", {
                {T, "Aim Gun"},
                {T, "Aim Tap"},
                {T, "Aim Skills"},
                {T, "Ignore Mobs"},
            }},
            {"Visual Settings", {
                {T, "FPS Boost"},
                {T, "White Screen"},
                {T, "Meteor Rain"},
                {T, "Devil Fruit Rain"},
            }},
        }
    },
}

local currentPage = 1
local states = {}
local controls = {}
local sidebarButtons = {}
local rebuilding = false

local function setStatus(text)
    statusBar.Text = text
end

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("GuiObject") and child.Name ~= "UIPadding" then
            child:Destroy()
        end
    end
end

local function makeCard(titleText)
    local card = make("Frame", {
        Name = "Section",
        Size = UDim2.new(1, -3, 0, 40),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
    }, content)
    corner(card, 10)
    stroke(card, Theme.Purple, 0.55)

    local heading = label(card, titleText, 14, Theme.Light, Enum.Font.GothamBold)
    heading.Position = UDim2.fromOffset(11, 5)
    heading.Size = UDim2.new(1, -22, 0, 28)

    local list = make("Frame", {
        Name = "Rows",
        Position = UDim2.fromOffset(8, 34),
        Size = UDim2.new(1, -16, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }, card)

    make("UIListLayout", {
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, list)

    make("UIPadding", {
        PaddingBottom = UDim.new(0, 8),
    }, list)

    return card, list
end

local function makeToggle(parent, itemKey, initial)
    local row = make("Frame", {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1,
    }, parent)

    local textLabel = label(row, itemKey, 11, Theme.White)
    textLabel.Position = UDim2.fromOffset(2, 0)
    textLabel.Size = UDim2.new(1, -60, 1, 0)

    local button = make("TextButton", {
        Name = "Toggle",
        Text = "",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -2, 0.5, 0),
        Size = UDim2.fromOffset(35, 19),
        BackgroundColor3 = Theme.Card2,
        AutoButtonColor = true,
    }, row)
    corner(button, 10)

    local knob = make("Frame", {
        Name = "Knob",
        Size = UDim2.fromOffset(13, 13),
        Position = UDim2.fromOffset(3, 3),
        BackgroundColor3 = Theme.White,
        BorderSizePixel = 0,
    }, button)
    corner(knob, 8)

    states[itemKey] = initial or false

    local function render(animate)
        local on = states[itemKey]
        local bg = on and Theme.Purple or Theme.Card2
        local pos = on and UDim2.new(1, -16, 0, 3) or UDim2.fromOffset(3, 3)

        if animate then
            TweenService:Create(button, TweenInfo.new(0.12), {
                BackgroundColor3 = bg
            }):Play()
            TweenService:Create(knob, TweenInfo.new(0.12), {
                Position = pos
            }):Play()
        else
            button.BackgroundColor3 = bg
            knob.Position = pos
        end
    end

    button.Activated:Connect(function()
        states[itemKey] = not states[itemKey]
        render(true)
        setStatus(itemKey .. (states[itemKey] and ": ON (UI only)" or ": OFF"))
    end)

    render(false)
    controls[itemKey] = {type = "toggle", get = function()
        return states[itemKey]
    end}
end

local function makeSelect(parent, itemKey, options)
    local row = make("Frame", {
        Size = UDim2.new(1, 0, 0, 47),
        BackgroundTransparency = 1,
    }, parent)

    local textLabel = label(row, itemKey, 11, Theme.White)
    textLabel.Size = UDim2.new(1, 0, 0, 18)
    textLabel.Position = UDim2.fromOffset(2, 0)

    local button = make("TextButton", {
        Name = "Dropdown",
        Text = "",
        Position = UDim2.fromOffset(0, 20),
        Size = UDim2.new(1, 0, 0, 25),
        BackgroundColor3 = Theme.Card2,
        TextColor3 = Theme.White,
        AutoButtonColor = true,
    }, row)
    corner(button, 6)
    stroke(button, Theme.Purple, 0.65)

    local index = 1
    local valueLabel = label(button, tostring(options[index]), 10, Theme.White)
    valueLabel.Position = UDim2.fromOffset(8, 0)
    valueLabel.Size = UDim2.new(1, -28, 1, 0)

    local arrow = label(button, "⌄", 15, Theme.Light)
    arrow.TextXAlignment = Enum.TextXAlignment.Center
    arrow.Position = UDim2.new(1, -25, 0, 0)
    arrow.Size = UDim2.fromOffset(22, 25)

    button.Activated:Connect(function()
        index = index % #options + 1
        valueLabel.Text = tostring(options[index])
        setStatus(itemKey .. ": " .. tostring(options[index]) .. " (local)")
    end)

    controls[itemKey] = {
        type = "select",
        get = function() return options[index] end,
    }
end

local function makeSlider(parent, itemKey, initial, maxValue)
    local row = make("Frame", {
        Size = UDim2.new(1, 0, 0, 49),
        BackgroundTransparency = 1,
    }, parent)

    local value = math.clamp(initial or 1, 0, maxValue or 100)
    local top = label(row, itemKey, 11, Theme.White)
    top.Size = UDim2.new(1, -55, 0, 20)
    top.Position = UDim2.fromOffset(2, 0)

    local valueText = label(row, tostring(value), 11, Theme.Light, Enum.Font.GothamBold)
    valueText.TextXAlignment = Enum.TextXAlignment.Right
    valueText.Position = UDim2.new(1, -45, 0, 0)
    valueText.Size = UDim2.fromOffset(42, 20)

    local bar = make("Frame", {
        Position = UDim2.fromOffset(2, 29),
        Size = UDim2.new(1, -4, 0, 7),
        BackgroundColor3 = Theme.Card2,
        BorderSizePixel = 0,
    }, row)
    corner(bar, 5)

    local fill = make("Frame", {
        Size = UDim2.new(value / (maxValue or 100), 0, 1, 0),
        BackgroundColor3 = Theme.Purple,
        BorderSizePixel = 0,
    }, bar)
    corner(fill, 5)

    local knob = make("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(value / (maxValue or 100), 0, 0.5, 0),
        Size = UDim2.fromOffset(13, 13),
        BackgroundColor3 = Theme.Light,
        BorderSizePixel = 0,
    }, bar)
    corner(knob, 8)

    local dragging = false

    local function updateFromX(x)
        local width = math.max(bar.AbsoluteSize.X, 1)
        local alpha = math.clamp((x - bar.AbsolutePosition.X) / width, 0, 1)
        value = math.floor(alpha * (maxValue or 100) + 0.5)
        fill.Size = UDim2.new(alpha, 0, 1, 0)
        knob.Position = UDim2.new(alpha, 0, 0.5, 0)
        valueText.Text = tostring(value)
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromX(input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromX(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    controls[itemKey] = {
        type = "slider",
        get = function() return value end,
    }
end

local function makeAction(parent, itemKey)
    local button = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 31),
        BackgroundColor3 = Theme.Card2,
        Text = "↳  " .. itemKey,
        TextColor3 = Theme.Light,
        TextSize = 11,
        Font = Enum.Font.GothamSemibold,
        TextWrapped = true,
        AutoButtonColor = true,
    }, parent)
    corner(button, 7)
    stroke(button, Theme.Purple, 0.65)

    button.Activated:Connect(function()
        setStatus(itemKey .. ": UI demo only - chưa kết nối gameplay")
    end)
end

local function makeInfo(parent, itemKey)
    local box = make("Frame", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = Theme.Card2,
        BackgroundTransparency = 0.25,
    }, parent)
    corner(box, 6)

    local textLabel = label(box, "●  " .. itemKey, 10, Theme.Muted)
    textLabel.Position = UDim2.fromOffset(7, 0)
    textLabel.Size = UDim2.new(1, -14, 1, 0)
end

local function buildPage(pageIndex)
    if rebuilding then return end
    rebuilding = true
    currentPage = pageIndex
    clearContent()

    local page = pages[pageIndex]
    setStatus("TAB: " .. page.name .. "  •  UI ONLY")

    for _, sectionData in ipairs(page.sections) do
        local _, rows = makeCard(sectionData[1])

        for _, item in ipairs(sectionData[2]) do
            local kind = item[1]
            local itemName = item[2]

            if kind == T then
                makeToggle(rows, itemName, false)
            elseif kind == S then
                makeSelect(rows, itemName, item[3])
            elseif kind == L then
                makeSlider(rows, itemName, item[3], item[4])
            elseif kind == B then
                makeAction(rows, itemName)
            elseif kind == I then
                makeInfo(rows, itemName)
            end
        end
    end

    for i, button in ipairs(sidebarButtons) do
        local selected = i == pageIndex
        button.BackgroundColor3 = selected and Theme.Purple or Theme.Panel
        button.TextColor3 = selected and Theme.White or Theme.Muted
    end

    content.CanvasPosition = Vector2.zero
    rebuilding = false
end

for index, page in ipairs(pages) do
    local button = make("TextButton", {
        Name = "Tab_" .. index,
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Theme.Panel,
        Text = page.icon .. "  " .. page.name,
        TextColor3 = Theme.Muted,
        TextSize = 10,
        Font = Enum.Font.GothamSemibold,
        TextWrapped = true,
        AutoButtonColor = true,
        LayoutOrder = index,
    }, sidebar)
    corner(button, 8)
    sidebarButtons[index] = button

    button.Activated:Connect(function()
        buildPage(index)
    end)
end

-- Floating M button, useful after minimizing.
local floating = make("TextButton", {
    Name = "FloatingM",
    Text = "M",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Theme.White,
    BackgroundColor3 = Theme.Purple,
    Size = UDim2.fromOffset(52, 52),
    Position = UDim2.new(0, 16, 0.65, 0),
    Visible = false,
    Active = true,
    Draggable = true,
}, gui)
corner(floating, 26)
stroke(floating, Theme.Light, 0.1)

local isMinimized = false
local isClosed = false

minimizeButton.Activated:Connect(function()
    isMinimized = true
    root.Visible = false
    floating.Visible = true
end)

floating.Activated:Connect(function()
    if not isClosed then
        isMinimized = false
        root.Visible = true
        floating.Visible = false
    end
end)

closeButton.Activated:Connect(function()
    isClosed = true
    root.Visible = false
    floating.Visible = true
    setStatus("MENU HIDDEN - nhấn M để mở lại")
end)

-- Responsive scaling for portrait and landscape screens.
local function updateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end

    local viewport = camera.ViewportSize
    local shortSide = math.min(viewport.X, viewport.Y)

    if shortSide < 380 then
        rootScale.Scale = 0.82
    elseif shortSide < 600 then
        rootScale.Scale = 0.92
    else
        rootScale.Scale = 1
    end

    if viewport.X < viewport.Y then
        root.Size = UDim2.fromScale(0.97, 0.84)
        sidebar.Size = UDim2.new(0, 94, 1, -8)
        content.Position = UDim2.new(0, 104, 0, 4)
        content.Size = UDim2.new(1, -109, 1, -8)
        statusBar.Position = UDim2.new(0, 104, 1, -21)
        statusBar.Size = UDim2.new(1, -109, 0, 18)
    else
        root.Size = UDim2.fromScale(0.94, 0.86)
        sidebar.Size = UDim2.new(0, 112, 1, -8)
        content.Position = UDim2.new(0, 123, 0, 4)
        content.Size = UDim2.new(1, -128, 1, -8)
        statusBar.Position = UDim2.new(0, 123, 1, -21)
        statusBar.Size = UDim2.new(1, -128, 0, 18)
    end
end

local function connectCamera()
    local camera = workspace.CurrentCamera
    if camera then
        camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
    end
    updateScale()
end

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(connectCamera)
connectCamera()

-- Drag the main window using its header.
do
    local dragging = false
    local dragStart
    local startPosition

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPosition = root.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            root.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

buildPage(1)
print("[MINATO HUB] UI loaded. Gameplay functions are not connected.")
