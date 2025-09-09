local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Steal a brainroot ",
    LoadingTitle = "Rayfield Interface Suite",
    LoadingSubtitle = "by Sirius",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "KeidellHub", -- Specify a custom folder name
        FileName = "Keidell hub"
    },
    Discord = {
        Enabled = false,
        Invite = "your-discord-invite-code", -- Replace with a valid invite code
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Keidell hub key",
        Subtitle = "WhatsApp",
        Note = "Join our WhatsApp group for the key",
        FileName = "KeidellKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = "your-actual-key" -- Replace with the actual key
    }
})
