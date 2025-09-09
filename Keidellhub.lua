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

local Button = MainSection:CreateButton({
   Name = "infinity jump",
   Info = "Button info/Description.",
   Interaction = 'Changable',
   Callback = function()
      local function infinityJump()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    local function onJumpRequest(input, gameProcessed)
        if not gameProcessed then
            humanoid:ChangeState("Jumping")
            wait(0.1)
            humanoid:ChangeState("Seated")
        end
        return Enum.ContextActionResult.Pass
    end

    local jumpRequestConnection = game:GetService("UserInputService").JumpRequest:Connect(onJumpRequest)

    return function()
        jumpRequestConnection:Disconnect()
    end
end
   end,
})

print("Button created successfully")
