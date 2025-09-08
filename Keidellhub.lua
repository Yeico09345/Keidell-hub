-- Keidell Hub - Chilli Completo

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
frame.Size = UDim2.new(0, 360, 0, 370)
frame.Position = UDim2.new(0.5, -180, 0.5, -185)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.ZIndex = 1
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

-- Imagen Riyo
local riyo = Instance.new("ImageLabel", frame)
riyo.Size = UDim2.new(0, 60, 0, 60)
riyo.Position = UDim2.new(0, 15, 0, 15)
riyo.BackgroundTransparency = 1
riyo.Image = "rbxassetid://13781894238"
riyo.ZIndex = 2

-- Título
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -80, 0, 40)
title.Position = UDim2.new(0, 80, 0, 15)
title.BackgroundTransparency = 1
title.Text = "Keidell Hub - Chilli Completo"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2

-- Output
local output = Instance.new("TextLabel", frame)
output.Size = UDim2.new(1, -30, 0, 70)
output.Position = UDim2.new(0, 15, 0, 80)
output.BackgroundTransparency = 0.4
output.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
output.TextColor3 = Color3.fromRGB(220,220,220)
output.Font = Enum.Font.Gotham
output.TextSize = 16
output.Text = "Listo."
output.TextWrapped = true
output.TextYAlignment = Enum.TextYAlignment.Top
output.ZIndex = 2
Instance.new("UICorner", output).CornerRadius = UDim.new(0, 8)

-- Invisibilidad automática
local function force_invisible()
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
end

-- Auto Steal Brainroot
local autoSteal = false
local autoStealBtn
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
        force_invisible()
        wait(0.2)
    end
end

autoStealBtn = Instance.new("TextButton", frame)
autoStealBtn.Size = UDim2.new(0, 300, 0, 32)
autoStealBtn.Position = UDim2.new(0, 30, 0, 170)
autoStealBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 80)
autoStealBtn.Text = "Auto Steal Brainroot [OFF]"
autoStealBtn.TextColor3 = Color3.fromRGB(255,255,255)
autoStealBtn.Font = Enum.Font.GothamBold
autoStealBtn.TextSize = 16
Instance.new("UICorner", autoStealBtn).CornerRadius = UDim.new(0, 8)
autoStealBtn.MouseButton1Click:Connect(function()
    autoSteal = not autoSteal
    autoStealBtn.Text = "Auto Steal Brainroot ["..(autoSteal and "ON" or "OFF").."]"
    if autoSteal then
        spawn(auto_steal_brainroot)
    end
end)

-- TP Base
local function teleport_base()
    local myTeam = player.Team
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "Base" and v:FindFirstChild("Team") and v.Team.Value == myTeam then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0,5,0)
                output.Text = "Teletransportado a tu base."
                return
            end
        end
    end
    output.Text = "No se encontró tu base."
end

local tpBaseBtn = Instance.new("TextButton", frame)
tpBaseBtn.Size = UDim2.new(0, 300, 0, 32)
tpBaseBtn.Position = UDim2.new(0, 30, 0, 210)
tpBaseBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 80)
tpBaseBtn.Text = "TP a tu base"
tpBaseBtn.TextColor3 = Color3.fromRGB(255,255,255)
tpBaseBtn.Font = Enum.Font.GothamBold
tpBaseBtn.TextSize = 16
Instance.new("UICorner", tpBaseBtn).CornerRadius = UDim.new(0, 8)
tpBaseBtn.MouseButton1Click:Connect(teleport_base)

-- TP Brainroot
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

local tpBrainrootBtn = Instance.new("TextButton", frame)
tpBrainrootBtn.Size = UDim2.new(0, 300, 0, 32)
tpBrainrootBtn.Position = UDim2.new(0, 30, 0, 250)
tpBrainrootBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
tpBrainrootBtn.Text = "TP a Brainroot"
tpBrainrootBtn.TextColor3 = Color3.fromRGB(255,255,255)
tpBrainrootBtn.Font = Enum.Font.GothamBold
tpBrainrootBtn.TextSize = 16
Instance.new("UICorner", tpBrainrootBtn).CornerRadius = UDim.new(0, 8)
tpBrainrootBtn.MouseButton1Click:Connect(teleport_brainroot)

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

local tpPlayerBtn = Instance.new("TextButton", frame)
tpPlayerBtn.Size = UDim2.new(0, 300, 0, 32)
tpPlayerBtn.Position = UDim2.new(0, 30, 0, 290)
tpPlayerBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 60)
tpPlayerBtn.Text = "TP a Jugador (escribe nombre en consola)"
tpPlayerBtn.TextColor3 = Color3.fromRGB(255,255,255)
tpPlayerBtn.Font = Enum.Font.GothamBold
tpPlayerBtn.TextSize = 16
Instance.new("UICorner", tpPlayerBtn).CornerRadius = UDim.new(0, 8)
tpPlayerBtn.MouseButton1Click:Connect(function()
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
