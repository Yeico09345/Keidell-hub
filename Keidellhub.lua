-- Keidell Hub - UI y Funciones (FUNCIONAL)

local player = game.Players.LocalPlayer

-- UI principal
local gui = Instance.new("ScreenGui", (gethui and gethui()) or game.CoreGui)
gui.Name = "KeidellHub"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- Fondo de nieve animado
local snowFolder = Instance.new("Folder", gui)
snowFolder.Name = "Snow"
local function createSnowflake()
    local snow = Instance.new("Frame")
    snow.Size = UDim2.new(0, math.random(4,8), 0, math.random(4,8))
    snow.Position = UDim2.new(math.random(), 0, 0, -10)
    snow.BackgroundColor3 = Color3.fromRGB(255,255,255)
    snow.BackgroundTransparency = math.random(30,60)/100
    snow.BorderSizePixel = 0
    snow.Parent = snowFolder
    snow.ZIndex = 0
    return snow
end
spawn(function()
    while gui.Parent do
        local snow = createSnowflake()
        local speed = math.random(30,60)/100
        local drift = math.random(-30,30)/100
        spawn(function()
            for i = 1, 200 do
                if not snow.Parent then break end
                snow.Position = snow.Position + UDim2.new(drift/200, 0, speed/200, 0)
                wait(0.01)
            end
            if snow and snow.Parent then snow:Destroy() end
        end)
        wait(0.07)
    end
end)

-- Frame principal
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 340, 0, 420)
frame.Position = UDim2.new(0.5, -170, 0.5, -210)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
frame.BackgroundTransparency = 0.07
frame.BorderSizePixel = 0
frame.ZIndex = 1
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

-- Imagen Riyo
local riyo = Instance.new("ImageLabel", frame)
riyo.Size = UDim2.new(0, 50, 0, 50)
riyo.Position = UDim2.new(0, 15, 0, 15)
riyo.BackgroundTransparency = 1
riyo.Image = "rbxassetid://13781894238"
riyo.ZIndex = 2

-- Título
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -80, 0, 36)
title.Position = UDim2.new(0, 75, 0, 18)
title.BackgroundTransparency = 1
title.Text = "Keidell Hub"
title.TextColor3 = Color3.fromRGB(255, 90, 90)
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2

-- Subtítulo
local subtitle = Instance.new("TextLabel", frame)
subtitle.Size = UDim2.new(1, -80, 0, 20)
subtitle.Position = UDim2.new(0, 75, 0, 50)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Keidell Style"
subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 16
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.ZIndex = 2

-- Output
local output = Instance.new("TextLabel", frame)
output.Size = UDim2.new(1, -30, 0, 38)
output.Position = UDim2.new(0, 15, 0, 75)
output.BackgroundTransparency = 0.25
output.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
output.TextColor3 = Color3.fromRGB(220,220,220)
output.Font = Enum.Font.Gotham
output.TextSize = 15
output.Text = "Listo."
output.TextWrapped = true
output.TextYAlignment = Enum.TextYAlignment.Top
output.ZIndex = 2
Instance.new("UICorner", output).CornerRadius = UDim.new(0, 8)

-- Invisibilidad automática (bucle real)
spawn(function()
    while gui.Parent do
        if player.Character and player.Character:FindFirstChild("Brainroot") then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 1
                    for _, d in pairs(part:GetChildren()) do
                        if d:IsA("Decal") then d.Transparency = 1 end
                    end
                end
            end
        end
        wait(0.2)
    end
end)

-- TP base
local function teleport_base()
    local myTeam = player.Team
    local found = false
    -- 1. Buscar base por equipo
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "Base" and v:FindFirstChild("Team") and v.Team.Value == myTeam and myTeam ~= nil then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0,5,0)
                output.Text = "Teletransportado a tu base (por equipo)."
                found = true
                return
            end
        end
    end
    -- 2. Buscar base por propietario (si existe esa propiedad)
    if not found then
        for _, v in pairs(workspace:GetChildren()) do
            if v.Name == "Base" and v:FindFirstChild("Owner") and v.Owner.Value == player.Name then
                player.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0,5,0)
                output.Text = "Teletransportado a tu base (por propietario)."
                found = true
                return
            end
        end
    end
    -- 3. Llevarte a la base más cercana
    if not found then
        local closest, dist = nil, math.huge
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = player.Character.HumanoidRootPart.Position
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name == "Base" and v:IsA("BasePart") then
                    local d = (v.Position - pos).Magnitude
                    if d < dist then
                        closest = v
                        dist = d
                    end
                end
            end
            if closest then
                player.Character.HumanoidRootPart.CFrame = closest.CFrame + Vector3.new(0,5,0)
                output.Text = "Teletransportado a la base más cercana."
                return
            end
        end
    end
    output.Text = "No se encontró tu base."
end

-- TP brainroot
local function teleport_brainroot()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Brainroot" and v:IsA("BasePart") then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0,3,0)
                output.Text = "Teletransportado a brainroot."
                return
            end
        end
    end
    output.Text = "No se encontró brainroot."
end

-- TP a jugador
local function teleport_player(targetName)
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():sub(1, #targetName) == targetName:lower() and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
            output.Text = "Teletransportado a "..v.Name
            return
        end
    end
    output.Text = "Jugador no encontrado."
end

-- Auto Steal Brainroot
local autoSteal = false
local autoStealBtn
local function updateAutoStealButton()
    autoStealBtn.Text = "Auto Steal Brainroot ["..(autoSteal and "ON" or "OFF").."]"
    autoStealBtn.BackgroundColor3 = autoSteal and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(120, 60, 80)
end

local function auto_steal_brainroot()
    while autoSteal do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("Brainroot") then
                local brainroot = v.Character.Brainroot
                if not player.Character:FindFirstChild("Brainroot") then
                    brainroot.Parent = player.Character
                    output.Text = "Robado brainroot de: " .. v.Name
                end
            end
        end
        wait(0.2)
    end
end

local y = 120
local function makeButton(text, color, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 310, 0, 34)
    btn.Position = UDim2.new(0, 15, 0, y)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
    y = y + 40
    return btn
end

autoStealBtn = makeButton("Auto Steal Brainroot [OFF]", Color3.fromRGB(120, 60, 80), function()
    autoSteal = not autoSteal
    updateAutoStealButton()
    if autoSteal then
        spawn(auto_steal_brainroot)
    end
end)

makeButton("TP a tu base", Color3.fromRGB(60, 120, 80), teleport_base)
makeButton("TP a Brainroot", Color3.fromRGB(80, 80, 120), teleport_brainroot)

local tpPlayerBtn = makeButton("TP a Jugador (escribe nombre en consola)", Color3.fromRGB(120, 120, 60), function()
    output.Text = "Escribe el nombre del jugador en la consola (print) y ejecuta: _G.tp('nombre')"
    _G.tp = teleport_player
end)

-- Botón cerrar
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -42, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
