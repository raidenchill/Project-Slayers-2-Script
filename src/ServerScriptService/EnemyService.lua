local EnemyService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local enemiesFolder = Workspace:FindFirstChild("Enemies") or Instance.new("Folder")
enemiesFolder.Name = "Enemies"
enemiesFolder.Parent = Workspace

function EnemyService.Spawn(enemyTemplate, spawnCFrame, health, speed)
    local enemy = enemyTemplate:Clone()
    enemy:PivotTo(spawnCFrame)
    enemy:SetAttribute("Health", health)
    enemy:SetAttribute("MaxHealth", health)
    enemy:SetAttribute("Speed", speed)
    enemy.Parent = enemiesFolder
    return enemy
end

function EnemyService.Damage(enemy, amount)
    if not enemy or not enemy.Parent then return false end
    local health = enemy:GetAttribute("Health") or 0
    health -= amount
    enemy:SetAttribute("Health", health)
    if health <= 0 then
        enemy:Destroy()
        return true
    end
    return false
end

return EnemyService
