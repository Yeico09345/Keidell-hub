local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success then
    warn("Failed to load Rayfield: " .. Rayfield)
    return
else
    print("Rayfield loaded successfully")
end

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

print("Window created successfully")

local MainTab = Window:CreateTab("🤓Home", nil)
local MainSection = MainTab:CreateSection("Help")

print("Tab and section created successfully")

-- === Infinite Jump Core (safe, no ragdoll) ===
_G.infinjump = false
local UIS = game:GetService("UserInputService")
local Player = game:GetService("Players").LocalPlayer

UIS.JumpRequest:Connect(function()
    if _G.infinjump and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Button for Infinite Jump
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

print("Button created successfully")

-- Circle Minimize Button (outside Rayfield)
local function createCircleButton()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CircleToggleUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")

    local Button = Instance.new("ImageButton")
    Button.Size = UDim2.new(0, 60, 0, 60)
    Button.Position = UDim2.new(0, 50, 0.8, 0) -- left side, lower area
    Button.BackgroundTransparency = 1
    Button.Image = "rbxassetid://3570695787" -- round UI asset
    Button.ImageColor3 = Color3.fromRGB(60, 120, 255)
    Button.Parent = ScreenGui

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

    -- Toggle Rayfield UI
    local visible = true
    Button.MouseButton1Click:Connect(function()
        visible = not visible
        Rayfield:ToggleUI(visible)
    end)
end

createCircleButton()

-- Notify the user that the script has been executed
Rayfield:Notify({
    Title = "Script Executed",
    Content = "Welcome to Keidell hub",
    Duration = 5,
    Image = nil,
    Actions = {
        Ignore = {
            Name = "Okay!",
            Callback = function()
                print("The user tapped Okay!")
            end
        },
    },
})
