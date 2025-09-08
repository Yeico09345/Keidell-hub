-- Keidell Hub v1.0 - Brainroot Stealer

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local library = Instance.new("ScreenGui")
library.Name = "KeidellHub"
library.Parent = (gethui and gethui()) or game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = library

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Keidell Hub - Brainroot"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.Parent = frame

local output = Instance.new("TextLabel")
output.Size = UDim2.new(1, -20, 0, 80)
output.Position = UDim2.new(0, 10, 0, 50)
output.BackgroundTransparency = 1
output.TextColor3 = Color3.fromRGB(200,200,200)
output.Font = Enum.Font.SourceSans
output.TextSize = 16
output.Text = "Listo."
output.TextWrapped = true
output.TextYAlignment = Enum.TextYAlignment.Top
output.Parent = frame

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

local detectBtn = Instance.new("TextButton")
detectBtn.Size = UDim2.new(0, 130, 0, 36)
detectBtn.Position = UDim2.new(0, 20, 1, -46)
detectBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
detectBtn.Text = "Detectar"
detectBtn.TextColor3 = Color3.fromRGB(255,255,255)
detectBtn.Font = Enum.Font.SourceSansBold
detectBtn.TextSize = 18
detectBtn.Parent = frame

local stealBtn = Instance.new("TextButton")
stealBtn.Size = UDim2.new(0, 130, 0, 36)
stealBtn.Position = UDim2.new(1, -150, 1, -46)
stealBtn.BackgroundColor3 = Color3.fromRGB(90, 40, 40)
stealBtn.Text = "Steal Brainroot"
stealBtn.TextColor3 = Color3.fromRGB(255,255,255)
stealBtn.Font = Enum.Font.SourceSansBold
stealBtn.TextSize = 18
stealBtn.Parent = frame

local lastClosest = nil

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
