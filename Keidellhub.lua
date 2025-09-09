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
    KeySystem = false,
    KeySettings = {
        Title = "Keal hub key",
        Subtitle = "WhatsApp",
        Note = "Únete a nuestro grupo de WhatsApp para obtener la clave",
        FileName = "KeidellKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = "0" -- Reemplaza con la clave real
    }
})

local MainTab = Window:CreateTab("🤓Home", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Help") -- The 2nd argument is to tell if its only a Title and doesnt contain elements

Rayfield:Notify({
	Title = "tocaste el boton",
	Content = "capo",
	Duration = 3, -- Duration of the notification
	Image = nil,
	Actions = { -- Notification Buttons
		Ignore = {
			Name = "Okay!",
			Callback = function()
				print("The user tapped Okay!")
			end
		},
	},
})

local Button = MainSection:CreateButton({
   Name = "infinity jump",
   Info = "Button info/Description.", -- Speaks for itself, Remove if none.
   Interaction = 'Changable',
   Callback = function()
       local stopInfinityJump = infinityJump()
       Button:Destroy() -- Destroy the button after use to avoid multiple activations
   end,
})

-- Ajustes adicionales para minimizar la detección
Rayfield:DisableDefaultKeybinds()
Rayfield:SetTheme("Dark")

-- Inyectar el script en un hilo secundario
spawn(function()
    while true do
        -- Tu código aquí
        wait(5) -- Ajusta este valor para cambiar la frecuencia de ejecución
    end
end)
