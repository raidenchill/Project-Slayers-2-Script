local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local Config = require(ServerScriptService.GameConfig)

Players.PlayerAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local cash = Instance.new("IntValue")
    cash.Name = "Cash"
    cash.Value = Config.StartingCash
    cash.Parent = leaderstats

    local gems = Instance.new("IntValue")
    gems.Name = "Gems"
    gems.Value = Config.StartingGems
    gems.Parent = leaderstats
end)
