local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Main Box
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 160)
frame.Position = UDim2.new(0.5, -140, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 45)
button.Position = UDim2.new(0.5, -100, 0.4, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 140, 255) -- blue by default
button.Text = "Buy to Unlock"
button.Font = Enum.Font.GothamBold
button.TextSize = 18
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Parent = frame

-- Round corners for button
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = button

-- Error Label (hidden at start)
local errorLabel = Instance.new("TextLabel")
errorLabel.Size = UDim2.new(1, 0, 0, 25)
errorLabel.Position = UDim2.new(0, 0, 0.8, 0)
errorLabel.BackgroundTransparency = 1
errorLabel.Text = ""
errorLabel.Font = Enum.Font.GothamBold
errorLabel.TextSize = 14
errorLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- red
errorLabel.TextXAlignment = Enum.TextXAlignment.Center
errorLabel.Parent = frame
