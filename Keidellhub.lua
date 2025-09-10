-- Load Rayfield
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success then
    warn("Failed to load Rayfield: " .. Rayfield)
    return
else
    print("Rayfield loaded successfully")
end

-- Create Circle Button
local function createCircleButton()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CircleToggleUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game:GetService("CoreGui")

    local Button = Instance.new("ImageButton")
    Button.Size = UDim2.new(0, 60, 0, 60)
    Button.Position = UDim2.new(0, 50, 0.8, 0)
    Button.BackgroundTransparency = 1
    Button.Image = "rbxassetid://YOUR_IMAGE_ID" -- Replace with your uploaded circle image
    Button.ZIndex = 10
    Button.Parent = ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = Button

    -- Draggable logic for mobile
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

    game:GetService("UserInputService").InputChanged:Connect(function(input)
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
print("Circle button created successfully")

-- Main Hub
local Window = Rayfield:CreateWindow({
    Name = "Steal a Brainroot",
    LoadingTitle = "Rayfield",
    LoadingSubtitle = "Mobile Ready",
    ConfigurationSaving = {Enabled = true, FolderName = "KeidellHub", FileName = "Keidell hub"},
    KeySystem = false,
})

Rayfield:ToggleUI(false)
local hubVisible = false

-- Tabs and Sections
local MainTab = Window:CreateTab("🤓Home", nil)
local MoveSection = MainTab:CreateSection("🌀 Movimiento")
local ProtectSection = MainTab:CreateSection("🛡️ Protección")
local VisualSection = MainTab:CreateSection("👁️ Visuales")

-- Player & RunService
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

-- Levitation
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
    bodyVelocity.Velocity = Vector3.zero
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
        bodyVelocity.Velocity = Vector3.zero
    end
end)

-- Levitation Button
MainTab:CreateButton({
   Name = "Toggle Levitation",
   Callback = function()
      if flying then stopFlying() else startFlying() end
   end
})

-- Infinite Jump
MainTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(value)
        local UIS = game:GetService("UserInputService")
        if value then
            _G.InfJump = UIS.JumpRequest:Connect(function()
                local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState("Jumping")
                end
            end)
        else
            if _G.InfJump then
                _G.InfJump:Disconnect()
                _G.InfJump = nil
            end
        end
    end
})

-- Anti Damage
MainTab:CreateToggle({
    Name = "Anti Daño",
    CurrentValue = false,
    Callback = function(value)
        local char = Player.Character or Player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        if value then
            _G.AntiDamage = humanoid.HealthChanged:Connect(function()
                humanoid.Health = humanoid.MaxHealth
            end)
        else
            if _G.AntiDamage then
                _G.AntiDamage:Disconnect()
                _G.AntiDamage = nil
            end
        end
    end
})

-- ESP Jugadores
MainTab:CreateButton({
    Name = "ESP Jugadores",
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

-- ESP Bases
MainTab:CreateButton({
    Name = "ESP Bases",
    Callback = function()
        for _, base in pairs(workspace:GetChildren()) do
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

-- Mobile Buttons (⬆️ ⬇️ ⚡)
local function createMobileButton(name, pos, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 0, 80)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = game:GetService("CoreGui")
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
    if flying and bodyVelocity then bodyVelocity.Velocity = Vector3.zero end
end)

downBtn.MouseButton1Down:Connect(function()
    if flying and bodyVelocity then bodyVelocity.Velocity = Vector3.new(0, -speed, 0) end
end)
downBtn.MouseButton1Up:Connect(function()
    if flying and bodyVelocity then bodyVelocity.Velocity = Vector3.zero end
end)

toggleBtn.MouseButton1Click:Connect(function()
    if flying then stopFlying() else startFlying() end
end)

-- Toggle Hub with Circle
CircleButton.MouseButton1Click:Connect(function()
    hubVisible = not hubVisible
    Rayfield:ToggleUI(hubVisible)
end)
