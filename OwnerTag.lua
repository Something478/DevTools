local Players = game:GetService("Players")

local TAG_NAME = "ScriptOwnerTag"
local TARGET_USERNAMES = { "IdkMyNameBro_012", "yourgames9" }
local CHECK_INTERVAL = 2

local TargetLookup = {}
for _, name in pairs(TARGET_USERNAMES) do
    TargetLookup[name] = true
end

local function createTag(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        if player.Character.Head:FindFirstChild(TAG_NAME) then return end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = TAG_NAME
        billboard.Size = UDim2.new(0, 120, 0, 40)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.Adornee = player.Character.Head
        billboard.AlwaysOnTop = true
        billboard.Parent = player.Character.Head

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextScaled = true
        label.Font = Enum.Font.Sarpanch
        label.TextStrokeTransparency = 0
        label.Parent = billboard

        -- /// Players & Tags
        if player.Name == "IdkMyNameBro_012" then
            label.Text = "Plasmabyte\nScript Owner"
            label.TextColor3 = Color3.fromRGB(120, 4, 214)
         elseif player.Name == "yourgames9" then
            label.Text = "Zombie\nTrue GOAT"
            label.TextColor3 = Color3.fromRGB(255, 215, 0)
            end

        local uiStroke = Instance.new("UIStroke")
        uiStroke.Thickness = 1.25
        uiStroke.Color = Color3.fromRGB(255, 255, 255)
        uiStroke.LineJoinMode = Enum.LineJoinMode.Miter
        uiStroke.Parent = label

        local uiGradient = Instance.new("UIGradient")
        uiGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 100, 100)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 10, 10)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
        }
        uiGradient.Rotation = 85
        uiGradient.Offset = Vector2.new(-2, 0)
        uiGradient.Enabled = true
        uiGradient.Name = "Gradient"
        uiGradient.Parent = uiStroke
    end
end

task.spawn(function()
    while true do
        for _, player in pairs(Players:GetPlayers()) do
            if TargetLookup[player.Name] then
                createTag(player)
            end
        end
        task.wait(CHECK_INTERVAL)
    end
end)

Players.PlayerAdded:Connect(function(player)
    if TargetLookup[player.Name] then
        player.CharacterAdded:Connect(function()
            task.wait(1)
            createTag(player)
        end)
    end
end)
