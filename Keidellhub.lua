local plr = game.Players.LocalPlayer
local uis = game:GetService("User InputService")
local run = game:GetService("RunService")
local sg = game:GetService("StarterGui")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KeidellHub"

-- Botón para abrir GUI
local iconBtn = Instance.new("TextButton", gui)
iconBtn.Size = UDim2.new(0, 50, 0, 50)
iconBtn.Position = UDim2.new(0, 10, 0, 10)
iconBtn.Text = "K"
iconBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
iconBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
iconBtn.Font = Enum.Font.Fantasy
iconBtn.TextSize = 30
iconBtn.AutoButtonColor = false
iconBtn.BorderSizePixel = 0
iconBtn.BackgroundTransparency = 0.1
Instance.new("UICorner", iconBtn).CornerRadius = UDim.new(0, 12)

-- Frame principal
local mainFrame = Instance.new("Frame", gui)
mainFrame.Name = "mainFrame"
mainFrame.Size = UDim2.new(0, 420, 0, 280)
mainFrame.Position = UDim2.new(0, 70, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

-- Título
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "KeidellHub"
title.TextColor3 = Color3.new(0, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.BackgroundTransparency = 0
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 6)

-- Logo
local logoImage = Instance.new("ImageLabel", mainFrame)
logoImage.Size = UDim2.new(0, 100, 0, 100)
logoImage.Position = UDim2.new(0.5, -50, 0, 40)
logoImage.BackgroundTransparency = 1
logoImage.Image = "rbxassetid://1381234567" -- Reemplaza con tu asset ID de Riyo Reaper
logoImage.ScaleType = Enum.ScaleType.Fit

-- Botón eliminar paredes
local removeWallsBtn = Instance.new("TextButton", mainFrame)
removeWallsBtn.Size = UDim2.new(0, 180, 0, 40)
removeWallsBtn.Position = UDim2.new(0, 10, 0, 150)
removeWallsBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
removeWallsBtn.Text = "Eliminar Paredes"
removeWallsBtn.TextColor3 = Color3.new(1, 1, 1)
removeWallsBtn.Font = Enum.Font.SourceSansBold
removeWallsBtn.TextSize = 18
Instance.new("UICorner", removeWallsBtn).CornerRadius = UDim.new(0, 6)

-- Botón teletransportar a base con clon y Brainroot
local teleportBtn = Instance.new("TextButton", mainFrame)
teleportBtn.Size = UDim2.new(0, 180, 0, 40)
teleportBtn.Position = UDim2.new(0, 220, 0, 150)
teleportBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
teleportBtn.Text = "Teletransportar a Base"
teleportBtn.TextColor3 = Color3.new(1, 1, 1)
teleportBtn.Font = Enum.Font.SourceSansBold
teleportBtn.TextSize = 18
Instance.new("UICorner", teleportBtn).CornerRadius = UDim.new(0, 6)

-- Label de estado
local statusLabel = Instance.new("TextLabel", mainFrame)
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 1, -30)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Listo"
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 14
statusLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Función para eliminar paredes
removeWallsBtn.MouseButton1Click:Connect(function()
    statusLabel.Text = "Status: Eliminando paredes..."
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Name:lower():find("wall") then
            part.Transparency = 1
            part.CanCollide = false
        end
    end
    wait(2)
    statusLabel.Text = "Status: Paredes eliminadas"
    wait(2)
    statusLabel.Text = "Status: Listo"
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

-- Función para teletransportar a base con clon y Brainroot
teleportBtn.MouseButton1Click:Connect(function()
    statusLabel.Text = "Status: Teletransportando a base con clon..."
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    wait(1)

    local baseName = "PlayerBase_" .. plr.UserId
    local base = workspace:FindFirstChild(baseName)

    if not base then
        statusLabel.Text = "Status: Base no encontrada"
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        wait(2)
        statusLabel.Text = "Status: Listo"
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        return
    end

    local clone = base:FindFirstChild("Clone")
    if not clone then
        clone = workspace:FindFirstChild("Clone_" .. plr.UserId)
    end

    if not clone then
        statusLabel.Text = "Status: Clon no encontrado"
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        wait(2)
        statusLabel.Text = "Status: Listo"
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        return
    end

    if plr.Character and plr.Character.PrimaryPart then
        plr.Character:SetPrimaryPartCFrame(base.CFrame + Vector3.new(0, 5, 0))
    else
        statusLabel.Text = "Status: Personaje no encontrado"
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        wait(2)
        statusLabel.Text = "Status: Listo"
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        return
    end

    if clone.PrimaryPart then
        clone:SetPrimaryPartCFrame(base.CFrame + Vector3.new(3, 5, 0))
    else
        for _, part in pairs(clone:GetChildren()) do
            if part:IsA("BasePart") then
                part.CFrame = base.CFrame + Vector3.new(3, 5, 0)
            end
        end
    end

    statusLabel.Text = "Status: Teletransportado a base con clon"
    wait(2)
    statusLabel.Text = "Status: Listo"
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

-- Toggle GUI
iconBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Botón cerrar
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 180, 0, 30)
closeBtn.Position = UDim2.new(0, 10, 1, -70)
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
closeBtn.Text = "Cerrar GUI"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18
closeBtn.Parent = mainFrame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
