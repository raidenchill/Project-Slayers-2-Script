local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local Config = require(script.Parent.AdminBossConfig)
local remote = ReplicatedStorage:WaitForChild("AdminBossOneHit")

local function isAdmin()
    for _, userId in ipairs(Config.AdminUserIds) do
        if player.UserId == userId then
            return true
        end
    end
    return false
end

local function scanBosses()
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local found = 0
    for _, boss in ipairs(CollectionService:GetTagged(Config.BossTag)) do
        local bossRoot = boss:IsA("Model") and (boss:FindFirstChild("HumanoidRootPart") or boss.PrimaryPart)
        local humanoid = boss:IsA("Model") and boss:FindFirstChildOfClass("Humanoid")
        if bossRoot and humanoid and humanoid.Health > 0 then
            local distance = (bossRoot.Position - root.Position).Magnitude
            if distance <= Config.ScanRadius then
                found += 1
                print(string.format("[AdminBoss] Boss: %s | %.0f studs away", boss.Name, distance))
            end
        end
    end

    print(string.format("[AdminBoss] Scan complete: %d boss(es) found.", found))
end

if isAdmin() then
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end

        if input.KeyCode == Enum.KeyCode.U then
            scanBosses()
        elseif input.KeyCode == Config.OneHitKey then
            remote:FireServer("oneHitNearest")
        end
    end)

    print("[AdminBoss] Loaded. U = scan bosses, Y = one-hit nearest boss.")
end
