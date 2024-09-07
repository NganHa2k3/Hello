local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer

-- Find the nearest player
local function getNearestPlayer()
    local nearestPlayer = nil
    local shortestDistance = math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end
    return nearestPlayer
end

local nearestPlayer = getNearestPlayer()

if nearestPlayer then
    local args = {
        [1] = "All",
        [2] = nearestPlayer.Name .. " ⒶⓇⒺ  ⒼⒶⓎ !"
    }
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
else
    print("No nearest player found.")
end
