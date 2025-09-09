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
    Name = "Steal a brainroot ",
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
        Note = "Únete a nuestro grupo de WhatsApp para obtener la clave",
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

local function infinityJump()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    local function onJumpRequest(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.Space then
            humanoid:ChangeState("Jumping")
            wait(0.1)
            humanoid:ChangeState("Seated")
        end
        return Enum.ContextActionResult.Pass
    end

    local jumpRequestConnection = game:GetService("UserInputService").InputBegan:Connect(onJumpRequest)

    return function()
        jumpRequestConnection:Disconnect()
    end
end

local Button = MainSection:CreateButton({
   Name = "infinity jump",
   Callback = function()
      -- Toggles the infinite jump between on or off on every script run
      _G.infinjump = not _G.infinjump

      if _G.infinJumpStarted == nil then
          -- Ensures this only runs once to save resources
          _G.infinJumpStarted = true

          -- Notifies readiness
          game.StarterGui:SetCore("SendNotification", {
              Title = "WeAreDevs.net",
              Text = "The WeAreDevs Infinite Jump exploit is ready!",
              Duration = 5
          })

          -- The actual infinite jump
          local stopInfinityJump = infinityJump()
      end
   end
})

print("Button created successfully")
