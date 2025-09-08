-- Keidell Hub - Chilli Style (Auto Steal & Invis)

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

-- UI principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 260)
frame.Position = UDim2.new(0.5, -170, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Parent = library
frame.ZIndex = 1
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

local riyo = Instance.new("ImageLabel")
riyo.Size = UDim2.new(0, 60, 0, 60)
riyo.Position = UDim2.new(0, 15, 0, 15)
riyo.BackgroundTransparency = 1
riyo.Image = "rbxassetid://13781894238"
riyo.Parent = frame
riyo.ZIndex = 2

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 0, 40)
title.Position = UDim2.new(0, 80, 0, 15)
title.BackgroundTransparency = 1
title.Text = "Keidell Hub - Chilli Style"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
title.ZIndex = 2

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

-- FUNCIONES CHILLI HUB STYLE

-- Invisibilidad forzada si tienes brainroot
local function force_invisible()
    if player.Character and player.Character:FindFirstChild("Brainroot") then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 1
                if part:FindFirstChildOfClass("Decal") then
                    for _, d in pairs(part:GetChildren()) do
                        if d:IsA("Decal") then d.Transparency = 1 end
                    end
                end
            end
        end
    end
end

-- Auto steal brainroot en bucle
spawn(function()
    while true do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("Brainroot") then
                local brainroot = v.Character.Brainroot
                if not player.Character:FindFirstChild("Brainroot") then
                    brainroot.Parent = player.Character
                    output.Text = "Robado brainroot de: " .. v.Name
                end
            end
        end
        -- Invisibilidad automática si tienes brainroot
        force_invisible()
        wait(0.2)
    end
end)

-- Teleport a tu base (aunque esté cerrada)
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

-- BOTÓN TP BASE
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0, 300, 0, 32)
tpBtn.Position = UDim2.new(0, 20, 1, -54)
tpBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 80)
tpBtn.Text = "TP a tu base"
tpBtn.TextColor3 = Color3.fromRGB(255,255,255)
tpBtn.Font = Enum.Font.GothamBold
tpBtn.TextSize = 16
tpBtn.Parent = frame
tpBtn.ZIndex = 2
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 8)

tpBtn.MouseButton1Click:Connect(function()
    teleport_base()
end)
