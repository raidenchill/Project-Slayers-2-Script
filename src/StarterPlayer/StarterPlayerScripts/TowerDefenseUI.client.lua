local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "TowerDefenseUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local waveLabel = Instance.new("TextLabel")
waveLabel.Size = UDim2.fromOffset(220, 50)
waveLabel.Position = UDim2.fromOffset(20, 20)
waveLabel.BackgroundTransparency = 0.2
waveLabel.TextScaled = true
waveLabel.Text = "Wave: 0"
waveLabel.Parent = gui

local cashLabel = Instance.new("TextLabel")
cashLabel.Size = UDim2.fromOffset(220, 50)
cashLabel.Position = UDim2.fromOffset(20, 80)
cashLabel.BackgroundTransparency = 0.2
cashLabel.TextScaled = true
cashLabel.Parent = gui

local function updateCash()
    local stats = player:FindFirstChild("leaderstats")
    local cash = stats and stats:FindFirstChild("Cash")
    if cash then cashLabel.Text = "Cash: " .. cash.Value end
end

task.spawn(function()
    while gui.Parent do
        updateCash()
        task.wait(0.25)
    end
end)

local waveEvent = ReplicatedStorage:WaitForChild("WaveUpdate")
waveEvent.OnClientEvent:Connect(function(wave, total)
    waveLabel.Text = string.format("Wave: %d/%d", wave, total)
end)
