local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local Config = require(ServerScriptService.GameConfig)

local wave = 0
local active = false

local waveEvent = Instance.new("RemoteEvent")
waveEvent.Name = "WaveUpdate"
waveEvent.Parent = game:GetService("ReplicatedStorage")

local function rewardPlayers(amount)
    for _, player in ipairs(Players:GetPlayers()) do
        local stats = player:FindFirstChild("leaderstats")
        local cash = stats and stats:FindFirstChild("Cash")
        if cash then cash.Value += amount end
    end
end

local function runWave()
    wave += 1
    waveEvent:FireAllClients(wave, Config.WaveCount)

    -- Connect your own enemy templates/path system here.
    -- The starter intentionally keeps enemy movement independent from copyrighted game data.
    task.wait(math.max(3, Config.Intermission / 2))
    rewardPlayers(50 + wave * 10)
end

task.spawn(function()
    while wave < Config.WaveCount do
        task.wait(Config.Intermission)
        runWave()
    end
    active = false
end)

active = true
