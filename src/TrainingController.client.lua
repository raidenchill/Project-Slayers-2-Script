local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local config = require(script.Parent.TrainingConfig)
local busy = false

local function train()
    if busy then return end
    busy = true

    print(string.format("[%s] Training action triggered (+%d XP)", player.Name, config.XPPerTraining))
    task.wait(config.Cooldown)
    busy = false
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == config.TrainingKey then
        train()
    end
end)

print("Training controller loaded. Press T to test.")
