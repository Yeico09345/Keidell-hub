local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success then
    warn("Failed to load Rayfield: " .. Rayfield)
    return
else
    print("Rayfield loaded successfully")
end

-- === Circle Button First ===
local function createCircleButton()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CircleToggleUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")

    local Button = Instance.new("ImageButton")
    Button.Size = UDim2.new(0, 60, 0, 60)
    Button.Position = UDim2.new(0, 50, 0.8, 0) -- left-bottom
    Button.BackgroundTransparency = 1
    Button.Image = "rbxassetid://3570695787" -- round asset
    Button.ImageColor3 = Color3.fromRGB(200, 50, 255) -- brainrot purple
    Button.Parent = ScreenGui

    -- Make it draggable
    local dragging, dragInput, startPos, startInput
    Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = Button.Position
            startInput = input
        end
    end)

    Button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - startInput.Position
            Button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    Button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    return Button
end

local CircleButton = createCircleButton()

-- === Create Hub (hidden at first) ===
local Window = Rayfield:CreateWindow({
    Name = "Steal a brainroot",
    LoadingTitle = "Rayfield Interface Suite",
    LoadingSubtitle = "by Sirius",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "KeidellHub",
        FileName = "Keidell hub"
    },
    Discord = {
        Enabled = false,
        Invite = "your-discord-invite-code",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Keal hub key",
        Subtitle = "WhatsApp",
        Note = "Join our WhatsApp group for the key",
        FileName = "KeidellKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = "0"
    }
})

-- Hide UI at the start
Rayfield:ToggleUI(false)

-- === Tabs and Infinite Jump ===
local MainTab = Window:CreateTab("🤓Home", nil)
local MainSection = MainTab:CreateSection("Help")

_G.infinjump = false
local Player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

local function setupHumanoid()
    local char = Player.Character or Player.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end

local Humanoid = setupHumanoid()
Player.CharacterAdded:Connect(function()
    Humanoid = setupHumanoid()
end)

UIS.JumpRequest:Connect(function()
    if _G.infinjump and Humanoid and Humanoid.Health > 0 then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local Button = MainTab:CreateButton({
   Name = "Toggle Infinite Jump",
   Callback = function()
      _G.infinjump = not _G.infinjump
      game:GetService("StarterGui"):SetCore("SendNotification", {
          Title = "Infinite Jump",
          Text = _G.infinjump and "Enabled" or "Disabled",
          Duration = 3
      })
   end
})

-- === Circle toggles hub ===
local visible = false
CircleButton.MouseButton1Click:Connect(function()
    visible = not visible
    Rayfield:ToggleUI(visible)
end)
