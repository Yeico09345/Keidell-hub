-- Load Rayfield
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success then
    warn("Failed to load Rayfield: " .. Rayfield)
    return
end

-- === Circle Toggle Button ===
local function createCircleButton()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CircleToggleUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")

    local Button = Instance.new("ImageButton")
    Button.Size = UDim2.new(0, 60, 0, 60)
    Button.Position = UDim2.new(0, 50, 0.8, 0)
    Button.BackgroundTransparency = 1
    Button.Image = "rbxassetid://YOUR_IMAGE_ID" -- put your decal ID here

    -- Make it perfectly circular
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1,0)
    corner.Parent = Button

    Button.Parent = ScreenGui

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

-- === Hub ===
local Window = Rayfield:CreateWindow({
    Name = "Steal a brainroot",
    LoadingTitle = "Rayfield",
    LoadingSubtitle = "Mobile Ready",
    ConfigurationSaving = {Enabled = true, FolderName = "KeidellHub", FileName = "Keidell hub"},
    KeySystem = false,
})

Rayfield:ToggleUI(false)
local hubVisible = false

-- === Tabs ===
local MainTab = Window:CreateTab("🤓Home", nil)
local MainSection = MainTab:CreateSection("Levitation")

-- === Levitation ===
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

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

-- Mobile buttons
local function createMobileButton(name, pos, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 0, 80)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = game:GetService("CoreGui")
    btn.BackgroundTransparency = 0.2
    btn.Active = true
    btn.Draggable = true
    return btn
end

local upBtn = createMobileButton("⬆️", UDim2.new(0.85,0,0.6,0), Color3.fromRGB(50,200,50))
local downBtn = createMobileButton("⬇️", UDim2.new(0.85,0,0.75,0), Color3.fromRGB(50,50,200))
local toggleBtn = createMobileButton("⚡", UDim2.new(0.7,0,0.7,0), Color3.fromRGB(200,50,50))

upBtn.MouseButton1Down:Connect(function()
    if flying and bodyVelocity then bodyVelocity.Velocity = Vector3.new(0,speed,0) end
end)
upBtn.MouseButton1Up:Connect(function()
    if flying and bodyVelocity then bodyVelocity.Velocity = Vector3.zero end
end)

downBtn.MouseButton1Down:Connect(function()
    if flying and bodyVelocity then bodyVelocity.Velocity = Vector3.new(0,-speed,0) end
end)
downBtn.MouseButton1Up:Connect(function()
    if flying and bodyVelocity then bodyVelocity.Velocity = Vector3.zero end
end)

toggleBtn.MouseButton1Click:Connect(function()
    if flying then stopFlying() else startFlying() end
end)

-- Hub button
local Button = MainTab:CreateButton({
   Name = "Toggle Levitation",
   Callback = function()
      if flying then stopFlying() else startFlying() end
   end
})

-- Circle toggle for hub
CircleButton.MouseButton1Click:Connect(function()
    hubVisible = not hubVisible
    Rayfield:ToggleUI(hubVisible)
end)
