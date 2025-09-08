
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Main Box
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(0, 51, 102) -- Azul oscuro
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Title Label
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Keidell Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

-- Icon Image
local icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Position = UDim2.new(0.5, -25, 0.2, -25)
icon.Image = "rbxassetid://11805138142" -- ID de la imagen de Riyo
icon.BackgroundTransparency = 1
icon.Parent = frame

-- Button 1: Auto Farm
local button1 = Instance.new("TextButton")
button1.Size = UDim2.new(0, 200, 0, 40)
button1.Position = UDim2.new(0.5, -100, 0.4, 0)
button1.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
button1.Text = "Auto Farm"
button1.Font = Enum.Font.GothamBold
button1.TextSize = 16
button1.TextColor3 = Color3.fromRGB(255, 255, 255)
button1.Parent = frame

-- Round corners for button 1
local btnCorner1 = Instance.new("UICorner")
btnCorner1.CornerRadius = UDim.new(0, 10)
btnCorner1.Parent = button1

-- Button 2: ESP
local button2 = Instance.new("TextButton")
button2.Size = UDim2.new(0, 200, 0, 40)
button2.Position = UDim2.new(0.5, -100, 0.6, 0)
button2.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
button2.Text = "ESP"
button2.Font = Enum.Font.GothamBold
button2.TextSize = 16
button2.TextColor3 = Color3.fromRGB(255, 255, 255)
button2.Parent = frame

-- Round corners for button 2
local btnCorner2 = Instance.new("UICorner")
btnCorner2.CornerRadius = UDim.new(0, 10)
btnCorner2.Parent = button2

-- Button 3: Speed Boost
local button3 = Instance.new("TextButton")
button3.Size = UDim2.new(0, 200, 0, 40)
button3.Position = UDim2.new(0.5, -100, 0.8, 0)
button3.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
button3.Text = "Speed Boost"
button3.Font = Enum.Font.GothamBold
button3.TextSize = 16
button3.TextColor3 = Color3.fromRGB(255, 255, 255)
button3.Parent = frame

-- Round corners for button 3
local btnCorner3 = Instance.new("UICorner")
btnCorner3.CornerRadius = UDim.new(0, 10)
btnCorner3.Parent = button3

-- Button Click Events
button1.MouseButton1Click:Connect(function()
    -- Activar Auto Farm
    print("Auto Farm activado")
    -- Aquí puedes agregar la lógica para el Auto Farm
end)

button2.MouseButton1Click:Connect(function()
    -- Activar ESP
    print("ESP activado")
    -- Aquí puedes agregar la lógica para el ESP
end)

button3.MouseButton1Click:Connect(function()
    -- Activar Speed Boost
    print("Speed Boost activado")
    -- Aquí puedes agregar la lógica para el Speed Boost
end)
