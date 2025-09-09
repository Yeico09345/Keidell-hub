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

-- === Infinite Jump Core ===
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
