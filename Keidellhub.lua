local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local range = 500

local function detect()
    local closest, brainroots, bases, times = nil, {}, {}, {}

    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (v.Character.HumanoidRootPart.Position - camera.CFrame.Position).magnitude
            if not closest or dist < (closest and closest.dist or math.huge) then
                closest = {name = v.Name, dist = dist}
            end
            if v.Character:FindFirstChild("Brainroot") then
                table.insert(brainroots, v.Name)
            end
            if v.Character:FindFirstChild("TimeLeft") then
                table.insert(times, {v.Name, v.Character.TimeLeft.Value})
            end
        end
    end

    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "Base" then
            table.insert(bases, v)
        end
    end

    print("Jugador más cercano:", closest and closest.name or "Ninguno")
    print("Jugadores con Brainroot:", table.concat(brainroots, ", "))
    print("Bases detectadas:", #bases)
    for _, v in pairs(times) do
        print(v[1] .. ": " .. v[2] .. " segundos")
    end
end

detect()
