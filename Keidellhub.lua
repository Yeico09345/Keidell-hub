-- Cargar Rayfield
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Crear ventana sin key system
local Window = Rayfield:CreateWindow({
    Name = "Rayfield Example Window",
    LoadingTitle = "Rayfield Interface Suite",
    LoadingSubtitle = "by Sirius",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Big Hub"
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false -- Aquí desactivamos el sistema de llave
})

-- Crear pestaña
local Tab = Window:CreateTab("Tab Example", 4483362458) -- Título, Imagen

-- Crear sección
local Section = Tab:CreateSection("Section Example", false) -- false indica que contiene elementos

-- Agregar botón a la pestaña
Tab:CreateButton({
    Name = "Ejemplo de Botón",
    Callback = function()
        print("Botón presionado")
    end
})
