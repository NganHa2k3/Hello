local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer

-- Ensure LocalPlayer and their HumanoidRootPart are available
if not localPlayer or not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
    print("LocalPlayer or their HumanoidRootPart is not available.")
    return
end

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

-- Function to send a chat message
local function sendChatMessage(player)
    local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
        local message = player.Name .. " are G4Y !"
        local args = { message, "All" } -- Message first, then channel
        chatEvent.SayMessageRequest:FireServer(unpack(args))
    else
        print("Chat event or SayMessageRequest not found.")
    end
end

-- Execute once when the script runs
local nearestPlayer = getNearestPlayer()
if nearestPlayer then
    sendChatMessage(nearestPlayer)
else
    print("No nearest player found.")
end
