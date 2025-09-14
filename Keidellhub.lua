local plr = game.Players.LocalPlayer
local playerGui = plr:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "TestGui"
gui.Parent = playerGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.5, -75, 0.5, -25)
btn.Text = "¡Hola desde KeidellHub!"
btn.Parent = gui

btn.MouseButton1Click:Connect(function()
    btn.Text = "¡Funciona!"
end)
