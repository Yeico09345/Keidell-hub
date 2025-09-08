-- Keidell Hub v1.1 - Brainroot Stealer con nieve y Riyo

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local library = Instance.new("ScreenGui")
library.Name = "KeidellHub"
library.Parent = (gethui and gethui()) or game:GetService("CoreGui")
library.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- Fondo de nieve animado
local snowFolder = Instance.new("Folder", library)
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
    while library.Parent do
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
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 260)
frame.Position = UDim2.new(0.5, -170, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Parent = library
frame.ZIndex = 1

local uicorner = Instance.new("UICorner", frame)
uicorner.CornerRadius = UDim.new(0, 18)

-- Imagen de Riyo (puedes cambiar el Image si tienes otro ID)
local riyo = Instance.new("ImageLabel")
riyo.Size = UDim2.new(0, 60, 0, 60)
riyo.Position = UDim2.new(0, 15, 0, 15)
riyo.BackgroundTransparency = 1
riyo.Image = "rbxassetid://13781894238" -- Cambia este ID si tienes otro de Riyo
riyo.Parent = frame
riyo.ZIndex = 2

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 0, 40)
title.Position = UDim2.new(0, 80, 0, 15)
title.BackgroundTransparency = 1
title.Text = "Keidell Hub - Brainroot"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
title.ZIndex = 2

-- Output
local output = Instance.new("TextLabel")
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
output.Parent = frame
output.ZIndex = 2
Instance.new("UICorner", output).CornerRadius = UDim.new(0, 8)

-- Funciones
local function detect()
    local closest, brainroots, bases, times = nil, {}, {}, {}

    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (v.Character.HumanoidRootPart.Position - camera.CFrame.Position).magnitude
            if not closest or dist < (closest and closest.dist or math.huge) then
                closest = {player = v, name = v.Name, dist = dist}
            end
            if v.Character:FindFirstChild("Brainroot") then
                table.insert(brainroots, v.Name)
            end
            if v.Character:FindFirstChild("TimeLeft") then
                table.insert(times, {v.Name, v.Character.TimeLeft.Value})
            end
        end
    end

    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "Base" then
            table.insert(bases, v)
        end
    end

    local msg = "Jugador más cercano: " .. (closest and closest.name or "Ninguno") .. "\n"
    msg = msg .. "Jugadores con Brainroot: " .. (#brainroots > 0 and table.concat(brainroots, ", ") or "Ninguno") .. "\n"
    msg = msg .. "Bases detectadas: " .. tostring(#bases) .. "\n"
    for _, v in pairs(times) do
        msg = msg .. v[1] .. ": " .. v[2] .. "s\n"
    end

    output.Text = msg
    return closest
end

local function steal_brainroot(target)
    if target and target.player and target.player.Character and target.player.Character:FindFirstChild("Brainroot") then
        local brainroot = target.player.Character.Brainroot
        brainroot.Parent = player.Character
        output.Text = "Robado brainroot de: " .. target.name
        return true
    end
    output.Text = "No se encontró brainroot para robar al objetivo."
    return false
end

local function steal_all_brainroots()
    local count = 0
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Brainroot") then
            local brainroot = v.Character.Brainroot
            brainroot.Parent = player.Character
            count = count + 1
        end
    end
    if count > 0 then
        output.Text = "Robados " .. count .. " brainroots."
    else
        output.Text = "No se encontraron brainroots para robar."
    end
end

-- Botones
local lastClosest = nil

local detectBtn = Instance.new("TextButton")
detectBtn.Size = UDim2.new(0, 140, 0, 38)
detectBtn.Position = UDim2.new(0, 20, 1, -54)
detectBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 110)
detectBtn.Text = "Detectar"
detectBtn.TextColor3 = Color3.fromRGB(255,255,255)
detectBtn.Font = Enum.Font.GothamBold
detectBtn.TextSize = 18
detectBtn.Parent = frame
detectBtn.ZIndex = 2
Instance.new("UICorner", detectBtn).CornerRadius = UDim.new(0, 8)

local stealBtn = Instance.new("TextButton")
stealBtn.Size = UDim2.new(0, 140, 0, 38)
stealBtn.Position = UDim2.new(1, -160, 1, -54)
stealBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 60)
stealBtn.Text = "Steal Brainroot"
stealBtn.TextColor3 = Color3.fromRGB(255,255,255)
stealBtn.Font = Enum.Font.GothamBold
stealBtn.TextSize = 18
stealBtn.Parent = frame
stealBtn.ZIndex = 2
Instance.new("UICorner", stealBtn).CornerRadius = UDim.new(0, 8)

local stealAllBtn = Instance.new("TextButton")
stealAllBtn.Size = UDim2.new(0, 300, 0, 32)
stealAllBtn.Position = UDim2.new(0, 20, 1, -98)
stealAllBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 80)
stealAllBtn.Text = "Steal TODOS los Brainroots"
stealAllBtn.TextColor3 = Color3.fromRGB(255,255,255)
stealAllBtn.Font = Enum.Font.GothamBold
stealAllBtn.TextSize = 16
stealAllBtn.Parent = frame
stealAllBtn.ZIndex = 2
Instance.new("UICorner", stealAllBtn).CornerRadius = UDim.new(0, 8)

detectBtn.MouseButton1Click:Connect(function()
    lastClosest = detect()
end)

stealBtn.MouseButton1Click:Connect(function()
    if not lastClosest then
        output.Text = "Primero detecta un objetivo."
        return
    end
    steal_brainroot(lastClosest)
end)

stealAllBtn.MouseButton1Click:Connect(function()
    steal_all_brainroots()
end)

externalBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Francesco908/BRAINROT-PUBLIC/main/stealABrainrot%20V2%20public%20script"))()
end)
