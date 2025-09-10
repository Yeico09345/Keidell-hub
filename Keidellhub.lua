-- 📥 Load OrionLib
local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
end)

if not success then
    warn("Failed to load OrionLib: " .. OrionLib)
    return
else
    print("OrionLib loaded successfully")
end

-- 🌌 Create main window
local Window = OrionLib:MakeWindow({
    Name = "Steal a Brainroot",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "KeidellHub"
})

print("Main window created successfully")

-- 📑 Create tab
local MainTab = Window:MakeTab({
    Name = "Home",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

print("Tab created successfully")

-- 👤 Player & RunService
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

-- 🪂 Levitation
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

-- 🔘 Levitation Button
MainTab:AddButton({
    Name = "Toggle Levitation",
    Callback = function()
        if flying then stopFlying() else startFlying() end
    end
})

print("Levitation button added successfully")

-- 🔁 Infinite Jump
MainTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
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

print("Infinite Jump toggle added successfully")

-- 🛡️ Anti Damage
MainTab:AddToggle({
    Name = "Anti Damage",
    Default = false,
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

print("Anti Damage toggle added successfully")

-- 👀 ESP Players
MainTab:AddButton({
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

print("ESP Players button added successfully")

-- 🏠 ESP Bases
MainTab:AddButton({
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

print("ESP Bases button added successfully")

-- 📱 Mobile Buttons
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

print("Mobile buttons created successfully")

-- 🔘 Circular Button to Toggle Hub
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
    Button.Image = "rbxassetid://YOUR_IMAGE_ID" -- Replace with your uploaded circle image
    Button.ZIndex = 10
    Button.Parent = ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = Button

    -- Draggable for mobile
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
CircleButton.MouseButton1Click:Connect(function()
    Window:Toggle()
end)

print("Circular button created successfully")
