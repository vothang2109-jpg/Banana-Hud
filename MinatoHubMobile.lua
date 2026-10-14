-- MINATO HUB MOBILE | Purple / Black UI template
-- For a Roblox experience you own. Install as a LocalScript in
-- StarterPlayer > StarterPlayerScripts. Gameplay buttons are UI placeholders;
-- connect them to your own validated server systems.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local existing = playerGui:FindFirstChild("MinatoHubMobile")
if existing then existing:Destroy() end

local COLORS = {
    bg = Color3.fromRGB(7, 7, 17), panel = Color3.fromRGB(15, 13, 30),
    card = Color3.fromRGB(25, 20, 47), cardHover = Color3.fromRGB(43, 27, 75),
    purple = Color3.fromRGB(137, 55, 255), light = Color3.fromRGB(202, 157, 255),
    white = Color3.fromRGB(247, 242, 255), muted = Color3.fromRGB(163, 151, 190),
    off = Color3.fromRGB(67, 61, 91), green = Color3.fromRGB(91, 239, 154),
    red = Color3.fromRGB(255, 99, 130),
}

local function create(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end
local function corner(obj, radius)
    create("UICorner", {CornerRadius = UDim.new(0, radius or 12)}, obj)
end
local function stroke(obj, color, transparency, thickness)
    create("UIStroke", {Color = color or COLORS.purple, Transparency = transparency or 0.25, Thickness = thickness or 1}, obj)
end
local function animate(obj, props, duration)
    TweenService:Create(obj, TweenInfo.new(duration or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end
local function label(parent, text, pos, size, textSize, color, font, alignment)
    return create("TextLabel", {
        BackgroundTransparency = 1, Position = pos, Size = size, Text = text,
        TextColor3 = color or COLORS.white, Font = font or Enum.Font.Gotham,
        TextSize = textSize or 12, TextXAlignment = alignment or Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd,
    }, parent)
end

local gui = create("ScreenGui", {
    Name = "MinatoHubMobile", ResetOnSpawn = false, IgnoreGuiInset = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 50,
}, playerGui)

local rootScale = create("UIScale", {Scale = 1}, gui)
local function updateScale()
    local cam = workspace.CurrentCamera
    if not cam then return end
    local viewport = cam.ViewportSize
    rootScale.Scale = math.clamp(math.min(viewport.X / 390, viewport.Y / 650), 0.72, 1)
end
updateScale()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end

local window = create("Frame", {
    Name = "Window", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.94, 0, 0.78, 0), BackgroundColor3 = COLORS.bg,
    BorderSizePixel = 0, ClipsDescendants = true,
}, gui)
corner(window, 17); stroke(window, COLORS.purple, 0.08, 1.4)
create("UISizeConstraint", {MinSize = Vector2.new(285, 330), MaxSize = Vector2.new(600, 700)}, window)

local header = create("Frame", {Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = COLORS.panel, BorderSizePixel = 0}, window)
create("Frame", {Size = UDim2.new(1, 0, 0, 2), BackgroundColor3 = COLORS.purple, BorderSizePixel = 0}, header)
local logo = create("Frame", {Position = UDim2.fromOffset(10, 9), Size = UDim2.fromOffset(39, 39), BackgroundColor3 = COLORS.purple, BorderSizePixel = 0}, header)
corner(logo, 13); stroke(logo, COLORS.light, 0.15)
label(logo, "M", UDim2.fromScale(0, 0), UDim2.fromScale(1, 1), 24, Color3.new(1,1,1), Enum.Font.GothamBlack, Enum.TextXAlignment.Center)
label(header, "MINATO HUB", UDim2.fromOffset(58, 8), UDim2.new(1, -145, 0, 24), 15, COLORS.white, Enum.Font.GothamBlack)
label(header, "MOBILE EDITION  •  PURPLE", UDim2.fromOffset(59, 31), UDim2.new(1, -145, 0, 16), 8, COLORS.light, Enum.Font.GothamMedium)
local minimize = create("TextButton", {AnchorPoint = Vector2.new(1,0.5), Position = UDim2.new(1,-45,0.5,0), Size = UDim2.fromOffset(29,29), BackgroundColor3 = COLORS.card, Text = "—", TextColor3 = COLORS.white, TextSize = 16, Font = Enum.Font.GothamBold, AutoButtonColor = false, BorderSizePixel = 0}, header)
corner(minimize, 9)
local close = create("TextButton", {AnchorPoint = Vector2.new(1,0.5), Position = UDim2.new(1,-9,0.5,0), Size = UDim2.fromOffset(29,29), BackgroundColor3 = COLORS.card, Text = "×", TextColor3 = COLORS.red, TextSize = 21, Font = Enum.Font.GothamBold, AutoButtonColor = false, BorderSizePixel = 0}, header)
corner(close, 9)

local body = create("Frame", {Position = UDim2.fromOffset(0,58), Size = UDim2.new(1,0,1,-58), BackgroundTransparency = 1}, window)
local nav = create("ScrollingFrame", {Position = UDim2.fromOffset(8,8), Size = UDim2.new(0,98,1,-16), BackgroundColor3 = COLORS.panel, BorderSizePixel = 0, ScrollBarThickness = 2, ScrollBarImageColor3 = COLORS.purple, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y}, body)
corner(nav, 12)
create("UIPadding", {PaddingTop=UDim.new(0,7), PaddingBottom=UDim.new(0,7), PaddingLeft=UDim.new(0,5), PaddingRight=UDim.new(0,5)}, nav)
create("UIListLayout", {Padding=UDim.new(0,4), SortOrder=Enum.SortOrder.LayoutOrder}, nav)
local content = create("Frame", {Position=UDim2.new(0,114,0,8), Size=UDim2.new(1,-122,1,-16), BackgroundTransparency=1}, body)
local title = label(content, "Home", UDim2.fromOffset(0,0), UDim2.new(1,0,0,24), 16, COLORS.white, Enum.Font.GothamBold)
local subtitle = label(content, "Welcome, " .. player.DisplayName, UDim2.fromOffset(0,24), UDim2.new(1,0,0,18), 9, COLORS.muted)
local list = create("ScrollingFrame", {Position=UDim2.fromOffset(0,46), Size=UDim2.new(1,0,1,-46), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=2, ScrollBarImageColor3=COLORS.purple, CanvasSize=UDim2.new(), AutomaticCanvasSize=Enum.AutomaticSize.Y}, content)
create("UIListLayout", {Padding=UDim.new(0,6), SortOrder=Enum.SortOrder.LayoutOrder}, list)

local categories = {
    {"Home","⌂"}, {"Farm","⚔"}, {"Quest / Items","◇"}, {"Auto Fishing","♧"},
    {"Sea Event","≋"}, {"Raid / Fruits","✦"}, {"Stats","▥"}, {"Teleport","⌖"},
    {"Visual","◉"}, {"Shop","▣"}, {"Misc","⚙"},
}
local active = "Home"
local navRefs, states = {}, {}
local statusText = "UI ready"
local statusLabel
local renderPage

local function setStatus(text)
    statusText = text
    if statusLabel and statusLabel.Parent then statusLabel.Text = "Status: " .. text end
end
local function section(text)
    label(list, string.upper(text), UDim2.new(), UDim2.new(1,-2,0,21), 10, COLORS.light, Enum.Font.GothamBold)
end
local function row(text, desc, kind, key, initial)
    local card = create("Frame", {Size=UDim2.new(1,-2,0,55), BackgroundColor3=COLORS.card, BorderSizePixel=0}, list)
    corner(card, 10)
    create("Frame", {Position=UDim2.fromOffset(0,11), Size=UDim2.new(0,3,0,33), BackgroundColor3=COLORS.purple, BorderSizePixel=0}, card)
    label(card, text, UDim2.fromOffset(9,6), UDim2.new(1,-78,0,20), 10, COLORS.white, Enum.Font.GothamSemibold)
    label(card, desc, UDim2.fromOffset(9,27), UDim2.new(1,-80,0,18), 8, COLORS.muted)
    if kind == "toggle" then
        local enabled = states[key]
        if enabled == nil then enabled = initial == true end
        states[key] = enabled
        local switch = create("TextButton", {AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-8,0.5,0), Size=UDim2.fromOffset(38,22), BackgroundColor3=enabled and COLORS.purple or COLORS.off, Text="", AutoButtonColor=false, BorderSizePixel=0}, card)
        corner(switch, 20)
        local knob = create("Frame", {AnchorPoint=Vector2.new(0,0.5), Position=enabled and UDim2.new(1,-19,0.5,0) or UDim2.new(0,3,0.5,0), Size=UDim2.fromOffset(16,16), BackgroundColor3=Color3.new(1,1,1), BorderSizePixel=0}, switch)
        corner(knob, 10)
        switch.Activated:Connect(function()
            enabled = not enabled; states[key] = enabled
            animate(switch, {BackgroundColor3=enabled and COLORS.purple or COLORS.off})
            animate(knob, {Position=enabled and UDim2.new(1,-19,0.5,0) or UDim2.new(0,3,0.5,0)})
            if key == "FullBright" then
                if enabled then
                    Lighting.Brightness = 3; Lighting.ClockTime = 14; Lighting.GlobalShadows = false
                else
                    Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.GlobalShadows = true
                end
            end
            setStatus(text .. (enabled and " ON" or " OFF"))
        end)
    elseif kind == "button" then
        local btn = create("TextButton", {AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-7,0.5,0), Size=UDim2.fromOffset(52,26), BackgroundColor3=COLORS.purple, Text="OPEN", TextColor3=Color3.new(1,1,1), Font=Enum.Font.GothamBold, TextSize=8, AutoButtonColor=false, BorderSizePixel=0}, card)
        corner(btn, 8)
        btn.Activated:Connect(function()
            if key == "OpenFarm" or key == "OpenStats" then
                active = key == "OpenFarm" and "Farm" or "Stats"
                for name, ref in pairs(navRefs) do
                    ref.button.BackgroundColor3 = name == active and COLORS.cardHover or COLORS.panel
                    ref.icon.TextColor3 = name == active and COLORS.light or COLORS.muted
                end
                renderPage(active)
            else
                setStatus("Demo action: " .. key)
            end
            animate(btn, {BackgroundColor3=COLORS.light}, 0.08)
            task.delay(0.12, function() if btn.Parent then animate(btn, {BackgroundColor3=COLORS.purple}) end end)
        end)
    end
end
local function clearList()
    for _, child in ipairs(list:GetChildren()) do
        if not child:IsA("UIListLayout") then child:Destroy() end
    end
end

renderPage = function(name)
    clearList(); title.Text = name
    subtitle.Text = name == "Home" and ("Xin chào, " .. player.DisplayName .. " • Mobile") or "MINATO HUB  •  Mobile controls"
    statusLabel = nil
    if name == "Home" then
        section("Welcome to Minato Hub")
        local hero = create("Frame", {Size=UDim2.new(1,-2,0,94), BackgroundColor3=COLORS.panel, BorderSizePixel=0}, list)
        corner(hero, 12); stroke(hero, COLORS.purple, 0.25)
        label(hero, "MINATO HUB", UDim2.fromOffset(10,10), UDim2.new(1,-20,0,28), 18, COLORS.light, Enum.Font.GothamBlack)
        local desc = label(hero, "MOBILE EDITION\nPurple UI • Android friendly", UDim2.fromOffset(11,40), UDim2.new(1,-22,0,42), 9, COLORS.muted)
        desc.TextWrapped = true
        section("Quick actions")
        row("Open Farm tab", "Show farm UI controls", "button", "OpenFarm")
        row("Open Stats tab", "Show player UI controls", "button", "OpenStats")
        row("Notifications", "Example local UI toggle", "toggle", "Notifications", true)
        row("Safe Mode", "Conservative demo setting", "toggle", "SafeMode", true)
    elseif name == "Farm" then
        section("Farm controls")
        row("Auto Farm Level", "Demo toggle; connect your own system", "toggle", "AutoFarmLevel")
        row("Auto Collect Drops", "Demo toggle", "toggle", "AutoCollectDrops")
        row("Auto Complete Tasks", "Demo toggle", "toggle", "AutoCompleteTasks")
        row("Select Target", "Example button", "button", "SelectTarget")
        row("Start Farm Routine", "Example action only", "button", "StartFarm")
    elseif name == "Quest / Items" then
        section("Quest")
        row("Track Active Quest", "Demo toggle", "toggle", "TrackQuest")
        row("Claim Quest Reward", "Example action", "button", "ClaimQuestReward")
        section("Items")
        row("Refresh Inventory", "Example action", "button", "RefreshInventory")
        row("Auto Use Consumables", "Demo toggle", "toggle", "AutoUseConsumables")
    elseif name == "Auto Fishing" then
        section("Fishing")
        row("Auto Fishing", "Demo toggle", "toggle", "AutoFishing")
        row("Auto Sell Fish", "Demo toggle", "toggle", "AutoSellFish")
        row("Cast / Reel", "Example action", "button", "FishingAction")
    elseif name == "Sea Event" then
        section("Sea events")
        row("Track Sea Events", "Demo toggle", "toggle", "TrackSeaEvents")
        row("Join Active Event", "Example action", "button", "JoinSeaEvent")
        row("Refresh Event Status", "Example action", "button", "RefreshSeaEvent")
    elseif name == "Raid / Fruits" then
        section("Raid")
        row("Track Raid", "Demo toggle", "toggle", "TrackRaid")
        row("Join Raid", "Example action", "button", "JoinRaid")
        section("Fruits")
        row("Track Fruits", "Demo toggle", "toggle", "TrackFruits")
        row("Store Selected Fruit", "Example action", "button", "StoreFruit")
    elseif name == "Stats" then
        section("Player stats")
        row("Refresh Stats", "Example action", "button", "RefreshStats")
        row("Track XP", "Demo toggle", "toggle", "TrackXP")
        row("Track Currency", "Demo toggle", "toggle", "TrackCurrency")
        row("Show Performance", "Demo toggle", "toggle", "ShowPerformance")
    elseif name == "Teleport" then
        section("Destinations")
        row("Teleport to Spawn", "Example UI action only", "button", "TeleportSpawn")
        row("Teleport to Shop", "Example UI action only", "button", "TeleportShop")
        row("Teleport to Quest", "Example UI action only", "button", "TeleportQuest")
    elseif name == "Visual" then
        section("Visual settings")
        row("Full Bright", "Local lighting demo", "toggle", "FullBright")
        row("Reduce Effects", "Demo toggle", "toggle", "ReduceEffects")
        row("Restore Lighting", "Restore basic default values", "button", "RestoreLighting")
    elseif name == "Shop" then
        section("Shop")
        row("Open Shop", "Example action", "button", "OpenShop")
        row("Refresh Stock", "Example action", "button", "RefreshShop")
        row("Auto Buy Selected", "Demo toggle", "toggle", "AutoBuySelected")
    elseif name == "Misc" then
        section("General")
        row("Notifications", "Demo toggle", "toggle", "Notifications", true)
        row("Safe Mode", "Demo toggle", "toggle", "SafeMode", true)
        row("Rebuild Page", "Refresh this page", "button", "RebuildPage")
        row("Reset Toggles", "Reset local toggle states", "button", "ResetToggles")
    end
    section("Status")
    statusLabel = label(list, "Status: " .. statusText, UDim2.new(), UDim2.new(1,-2,0,32), 9, COLORS.green)
end

for order, data in ipairs(categories) do
    local name, iconText = data[1], data[2]
    local btn = create("TextButton", {Name="Nav_"..tostring(order), Size=UDim2.new(1,0,0,43), BackgroundColor3=name==active and COLORS.cardHover or COLORS.panel, Text="", LayoutOrder=order, AutoButtonColor=false, BorderSizePixel=0}, nav)
    corner(btn, 9)
    local ico = label(btn, iconText, UDim2.new(0,0,0,1), UDim2.new(1,0,0,21), 15, name==active and COLORS.light or COLORS.muted, Enum.Font.GothamBold, Enum.TextXAlignment.Center)
    local txt = label(btn, name, UDim2.new(0,1,0,22), UDim2.new(1,-2,0,17), 7, COLORS.white, Enum.Font.GothamSemibold, Enum.TextXAlignment.Center)
    txt.TextWrapped = true
    navRefs[name] = {button=btn, icon=ico}
    btn.Activated:Connect(function()
        active = name
        for n, ref in pairs(navRefs) do
            ref.button.BackgroundColor3 = n==active and COLORS.cardHover or COLORS.panel
            ref.icon.TextColor3 = n==active and COLORS.light or COLORS.muted
        end
        renderPage(active)
    end)
end
renderPage("Home")

local floating = create("TextButton", {Name="FloatingM", AnchorPoint=Vector2.new(1,1), Position=UDim2.new(1,-18,1,-90), Size=UDim2.fromOffset(52,52), BackgroundColor3=COLORS.purple, Text="M", TextColor3=Color3.new(1,1,1), Font=Enum.Font.GothamBlack, TextSize=24, Visible=false, AutoButtonColor=false, BorderSizePixel=0}, gui)
corner(floating, 20); stroke(floating, COLORS.light, 0.05, 1.4)

-- Drag the panel from its header; touch and mouse are supported.
local dragging, dragStart, startPosition = false, nil, nil
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPosition = window.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        window.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
    end
end)
minimize.Activated:Connect(function() window.Visible = false; floating.Visible = true end)
floating.Activated:Connect(function() window.Visible = true; floating.Visible = false end)
close.Activated:Connect(function() window.Visible = false; floating.Visible = true; setStatus("Menu hidden; tap M to reopen") end)

print("[MINATO HUB MOBILE] UI loaded. Demo controls only; connect your own game systems.")
