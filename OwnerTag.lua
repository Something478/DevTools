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
        billboard.Size = UDim2.new(0, 140, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.Adornee = player.Character.Head
        billboard.AlwaysOnTop = true
        billboard.Parent = player.Character.Head

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 0.7
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        frame.BorderSizePixel = 0
        frame.Parent = billboard
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = frame

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.9, 0, 0.9, 0)
        label.Position = UDim2.new(0.05, 0, 0.05, 0)
        label.BackgroundTransparency = 1
        label.TextScaled = true
        label.Font = Enum.Font.GothamBlack
        label.TextStrokeTransparency = 0
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) 
        label.Parent = frame

        if player.Name == "IdkMyNameBro_012" then
            label.Text = "PlasmaByte\nScript Owner"
            label.TextColor3 = Color3.fromRGB(180, 70, 255)
            label.Font = Enum.Font.Arcade
            frame.BackgroundColor3 = Color3.fromRGB(30, 0, 50)

            local pulseTween = game:GetService("TweenService"):Create(
                label,
                TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {TextTransparency = 0.2}
            )
            pulseTween:Play()
            
        elseif player.Name == "yourgames9" then
            label.Text = "Zombue\nTrue( GOAT"
            label.TextColor3 = Color3.fromRGB(255, 215, 0)
  
            label.Font = Enum.Font.Sarpanch
            frame.BackgroundColor3 = Color3.fromRGB(50, 40, 0)

            local glowTween = game:GetService("TweenService"):Create(
                label,
                TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {TextColor3 = Color3.fromRGB(255, 255, 150)}
            )
            glowTween:Play()
        end

        local uiStroke = Instance.new("UIStroke")
        uiStroke.Thickness = 2
        uiStroke.Color = Color3.fromRGB(0, 0, 0) 
        uiStroke.LineJoinMode = Enum.LineJoinMode.Round
        uiStroke.Parent = label
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