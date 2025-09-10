-- 📥 Cargar Rayfield
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("User InputService")
local Workspace = game:GetService("Workspace")

-- Variables para levitación
local flying = false
local speed = 50
local bodyVelocity

local function startFlying()
    if flying then return end
    flying = true
    local character = Player.Character or Player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(0, 1e5, 0)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = hrp
end

local function stopFlying()
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
end

RunService.Heartbeat:Connect(function()
    if flying and bodyVelocity then
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end)

-- Crear ventana
local Window = Rayfield:CreateWindow({
    Name = "Steal a Brainroot",
    LoadingTitle = "Cargando...",
    LoadingSubtitle = "Por favor espera",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "KeidellHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false
})

local MainTab = Window:CreateTab("Home", 4483345998)

-- Levitation toggle
MainTab:CreateToggle({
    Name = "Levitation",
    CurrentValue = false,
    Flag = "LevitationToggle",
    Callback = function(value)
        if value then
            startFlying()
        else
            stopFlying()
        end
    end
})

-- Infinite Jump toggle
local infJumpConnection
MainTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJumpToggle",
    Callback = function(value)
        if value then
            infJumpConnection = UserInputService.JumpRequest:Connect(function()
                local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if infJumpConnection then
                infJumpConnection:Disconnect()
                infJumpConnection = nil
            end
        end
    end
})

-- Anti Damage toggle
local antiDamageConnection
MainTab:CreateToggle({
    Name = "Anti Damage",
    CurrentValue = false,
    Flag = "AntiDamageToggle",
    Callback = function(value)
        local char = Player.Character or Player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        if value then
            antiDamageConnection = humanoid.HealthChanged:Connect(function()
                humanoid.Health = humanoid.MaxHealth
            end)
        else
            if antiDamageConnection then
                antiDamageConnection:Disconnect()
                antiDamageConnection = nil
            end
        end
    end
})

-- ESP Players button
MainTab:CreateButton({
    Name = "ESP Players",
    Callback = function()
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if not plr.Character:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Adornee = plr.Character
                    highlight.Parent = plr.Character
                end
            end
        end
    end
})

-- ESP Bases button
MainTab:CreateButton({
    Name = "ESP Bases",
    Callback = function()
        for _, base in pairs(Workspace:GetChildren()) do
            if base:IsA("Model") and base:FindFirstChild("HumanoidRootPart") then
                if not base:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Adornee = base
                    highlight.Parent = base
                end
            end
        end
    end
})

-- Botones móviles
local function createMobileButton(name, pos, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 0, 80)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = Player:WaitForChild("PlayerGui")
    btn.BackgroundTransparency = 0.2
    btn.Active = true
    btn.Draggable = true
    btn.ZIndex = 10
    return btn
end

local upBtn = createMobileButton("⬆️", UDim2.new(0.85, 0, 0.6, 0), Color3.fromRGB(50, 200, 50))
local downBtn = createMobileButton("⬇️", UDim2.new(0.85, 0, 0.75, 0), Color3.fromRGB(50, 50, 200))
local toggleBtn = createMobileButton("⚡", UDim2.new(0.7, 0, 0.7, 0), Color3.fromRGB(200, 50, 50))

upBtn.MouseButton1Down:Connect(function()
    if flying and bodyVelocity then bodyVelocity.Velocity = Vector3.new(0, speed, 0) end
end)
upBtn.MouseButton1Up:Connect(function()
    if flying and bodyVelocity then bodyVelocity.Velocity = Vector3.new(0, 0, 0) end
end)

downBtn.MouseButton1Down:Connect(function()
    if flying and bodyVelocity then bodyVelocity.Velocity = Vector3.new(0, -speed, 0) end
end)
downBtn.MouseButton1Up:Connect(function()
    if flying and bodyVelocity then bodyVelocity.Velocity = Vector3.new(0, 0, 0) end
end)

toggleBtn.MouseButton1Click:Connect(function()
    if flying then stopFlying() else startFlying() end
end)

-- Botón circular para toggle ventana
local function createCircleButton()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CircleToggleUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")

    local Button = Instance.new("ImageButton")
    Button.Size = UDim2.new(0, 60, 0, 60)
    Button.Position = UDim2.new(0, 50, 0.8, 0)
    Button.BackgroundTransparency = 1
    Button.Image = "rbxassetid://6023426915" -- Imagen circular genérica
    Button.ZIndex = 10
    Button.Parent = ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = Button

    -- Draggable para móvil
    local dragging, dragInput, startPos, startInput
    Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = Button.Position
            startInput = input
        end
    end)
    Button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - startInput.Position
            Button.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    Button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    return Button
end

local CircleButton = createCircleButton()
CircleButton.MouseButton1Click:Connect(function()
    if Window.Visible then
        Window:Hide()
    else
        Window:Show()
    end
end)
