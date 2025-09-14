local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeidellHub"
screenGui.Parent = playerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false

local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(0, 450, 0, 400)
mainContainer.Position = UDim2.new(0.5, -225, 0.5, -200)
mainContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainContainer.BorderSizePixel = 0
mainContainer.ClipsDescendants = true
mainContainer.Parent = screenGui

local containerStroke = Instance.new("UIStroke")
containerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
containerStroke.Color = Color3.fromRGB(80, 80, 80)
containerStroke.Thickness = 2
containerStroke.Parent = mainContainer

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainContainer

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0, 200, 1, 0)
titleText.Position = UDim2.new(0.5, -100, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "KEIDELL HUB"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 14
titleText.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.Gotham
closeButton.TextSize = 14
closeButton.Parent = titleBar

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -50)
contentFrame.Position = UDim2.new(0, 10, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainContainer

local logoImage = Instance.new("ImageLabel")
logoImage.Size = UDim2.new(0, 100, 0, 100)
logoImage.Position = UDim2.new(0.5, -50, 0, 10)
logoImage.Image = "rbxassetid://YOUR_GACHIAKUTA_LOGO_IMAGE_ID"
logoImage.Parent = contentFrame

local checkButton = Instance.new("TextButton")
checkButton.Size = UDim2.new(1, 0, 0, 40)
checkButton.Position = UDim2.new(0, 0, 0, 120)
checkButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
checkButton.BorderSizePixel = 0
checkButton.Text = "REMOVE WALLS"
checkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkButton.Font = Enum.Font.GothamBold
checkButton.TextSize = 14
checkButton.Parent = contentFrame

local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(1, 0, 0, 40)
teleportButton.Position = UDim2.new(0, 0, 0, 170)
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
teleportButton.BorderSizePixel = 0
teleportButton.Text = "TELEPORT TO BASE"
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Font = Enum.Font.GothamBold
teleportButton.TextSize = 14
teleportButton.Parent = contentFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0, 220)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Ready..."
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 12
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = contentFrame

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.BackgroundTransparency = 1
footer.Text = "Version: 1.13.1 | Zeta Realm"
footer.TextColor3 = Color3.fromRGB(100, 100, 100)
footer.Font = Enum.Font.Gotham
footer.TextSize = 10
footer.TextXAlignment = Enum.TextXAlignment.Center
footer.Parent = contentFrame

local function tweenObject(obj, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween: Play()
    return tween
end

local hileScriptLink = "https://pastebin.com/raw/TKv2M6YN"

checkButton.MouseButton1Click:Connect(function()
    statusLabel.Text = "Status: Removing walls..."
    statusLabel.TextColor3 = Color3.fromRGB(0, 200, 0)
    wait(1)
    -- Code to remove walls
    for _, part in ipairs(workspace:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "Terrain" then
            part.Transparency = 1
            part.CanCollide = false
        end
    end
    statusLabel.Text = "Status: Walls removed!"
    statusLabel.TextColor3 = Color3.fromRGB(0, 200, 0)
    wait(2)
    statusLabel.Text = "Status: Ready..."
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

teleportButton.MouseButton1Click:Connect(function()
    statusLabel.Text = "Status: Teleporting to base..."
    statusLabel.TextColor3 = Color3.fromRGB(0, 200, 0)
    wait(1)
    -- Code to teleport to base
    local playerBase = workspace:FindFirstChild("PlayerBase") -- Assuming the base is named "PlayerBase"
    if playerBase then
        player.Character:SetPrimaryPartCFrame(playerBase.CFrame)
        statusLabel.Text = "Status: Teleported to base!"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 0)
    else
        statusLabel.Text = "Status: Base not found!"
        statusLabel.TextColor3 = Color3.fromRGB(200, 0, 0)
    end
    wait(2)
    statusLabel.Text = "Status: Ready..."
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui: Destroy()
end)

local dragging = false
local dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainContainer.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        mainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

mainContainer.Size = UDim2.new(0, 0, 0, 400)
mainContainer.Position = UDim2.new(0.5, 0, 0.5, -200)
tweenObject(mainContainer, { Size = UDim2.new(0, 450, 0, 400), Position = UDim2.new(0.5, -225, 0.5, -200)}, 0.5)
