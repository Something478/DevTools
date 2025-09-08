local Players = game:GetService("Players")
local TAG_NAME = "ScriptOwnerTag"
local CHECK_INTERVAL = 2

local GROUPS = {
    {
        Name = "Owner",
        Usernames = { "IdkMyNameBro_012" },
        TagText = "PlasmaByte\nScript Owner",
        Color = Color3.fromRGB(120, 4, 214)
    }
}

local TargetLookup = {}
for _, group in pairs(GROUPS) do
    for _, username in pairs(group.Usernames) do
        TargetLookup[username] = group
    end
end

local function createTag(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        if player.Character.Head:FindFirstChild(TAG_NAME) then return end
        local group = TargetLookup[player.Name]
        if not group then return end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = TAG_NAME
        billboard.Size = UDim2.new(0, 100, 0, 40)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.Adornee = player.Character.Head
        billboard.AlwaysOnTop = true
        billboard.Parent = player.Character.Head

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = group.TagText
        label.TextColor3 = group.Color
        label.TextStrokeTransparency = 0
        label.TextScaled = true
        label.Font = Enum.Font.Sarpanch
        label.Parent = billboard
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
