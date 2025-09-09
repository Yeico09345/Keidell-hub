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

-- Fixed Infinite Jump
local function enableInfiniteJump()
    local UserInputService = game:GetService("UserInputService")
    local player = game.Players.LocalPlayer
    local humanoid = player.Character:WaitForChild("Humanoid")

    UserInputService.JumpRequest:Connect(function()
        if _G.infinjump then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local Button = MainTab:CreateButton({
   Name = "infinity jump",
   Callback = function()
      _G.infinjump = not _G.infinjump

      if _G.infinJumpStarted == nil then
          _G.infinJumpStarted = true

          game:GetService("StarterGui"):SetCore("SendNotification", {
              Title = "Keidell Hub",
              Text = "Infinite Jump Ready!",
              Duration = 5
          })

          enableInfiniteJump()
      end
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
