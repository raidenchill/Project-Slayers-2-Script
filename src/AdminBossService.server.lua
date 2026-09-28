local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(script.Parent.AdminBossConfig)

local remote = ReplicatedStorage:FindFirstChild("AdminBossOneHit")
if not remote then
    remote = Instance.new("RemoteEvent")
    remote.Name = "AdminBossOneHit"
    remote.Parent = ReplicatedStorage
end

local function isAdmin(player)
    for _, userId in ipairs(Config.AdminUserIds) do
        if player.UserId == userId then
            return true
        end
    end
    return false
end

local function getRoot(model)
    return model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
end

local function findNearestBoss(player)
    local character = player.Character
    local playerRoot = character and getRoot(character)
    if not playerRoot then return nil end

    local nearest, nearestDistance
    for _, boss in ipairs(CollectionService:GetTagged(Config.BossTag)) do
        if boss:IsA("Model") then
            local humanoid = boss:FindFirstChildOfClass("Humanoid")
            local root = getRoot(boss)
            if humanoid and humanoid.Health > 0 and root then
                local distance = (root.Position - playerRoot.Position).Magnitude
                if distance <= Config.ScanRadius and (not nearestDistance or distance < nearestDistance) then
                    nearest = boss
                    nearestDistance = distance
                end
            end
        end
    end

    return nearest
end

remote.OnServerEvent:Connect(function(player, action)
    if action ~= "oneHitNearest" or not isAdmin(player) then
        return
    end

    local boss = findNearestBoss(player)
    if not boss then
        return
    end

    local humanoid = boss:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health > 0 then
        humanoid.Health = 0
        print(string.format("[AdminBoss] %s defeated %s", player.Name, boss.Name))
    end
end)

print("Admin boss service loaded.")
