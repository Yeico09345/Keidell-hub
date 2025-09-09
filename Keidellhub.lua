local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Steal a brainroot ",
    LoadingTitle = "Rayfield Interface Suite",
    LoadingSubtitle = "by Sirius",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "KeidellHub", -- Asegúrate de que este nombre de carpeta sea correcto
        FileName = "Keidell hub"
    },
    Discord = {
        Enabled = false,
        Invite = "your-discord-invite-code", -- Reemplaza con un código de invitación válido
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Keal hub key",
        Subtitle = "WhatsApp",
        Note = "Únete a nuestro grupo de WhatsApp para obtener la clave",
        FileName = "KeidellKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = "Keidell" -- Reemplaza con la clave real
    }
})

-- Ajustes adicionales para minimizar la detección
Rayfield:DisableDefaultKeybinds()
Rayfield:SetTheme("Dark")
