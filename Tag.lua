local Players = game:GetService("Players")

local Arcade = Enum.Font.Arcade

local GroupSystem = {
    Members = {
        [ "IdkMyNameBro_012" ] = {
            Tag = "Script Owner",
            Color = Color3.fromRGB(180, 100, 255) -- Purple
        },
        [ "Theo_TheoBenzo" ] = {
            Tag = "Theo | The Goat",
            Color = Color3.fromRGB(255, 215, 0) -- Golden
        }
    }
}

-- Tag system
local TAG_NAME = "GroupTag"
local CHECK_INTERVAL = 2

local function createTag(player)
    if not player.Character or not player.Character:FindFirstChild("Head") then return end
    if player.Character.Head:FindFirstChild(TAG_NAME) then 
        player.Character.Head:FindFirstChild(TAG_NAME):Destroy()
    end

    local memberData = GroupSystem.Members[player.Name]
    if not memberData then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = TAG_NAME
    billboard.Size = UDim2.new(0, 200, 0, 60)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.Adornee = player.Character.Head
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 100
    billboard.Parent = player.Character.Head

    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    background.BackgroundTransparency = 0.3
    background.BorderSizePixel = 0
    background.Parent = billboard
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = background

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 1, -10)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = memberData.Tag
    label.TextColor3 = memberData.Color
    label.TextStrokeTransparency = 0.7
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextScaled = true
    label.Font = Arcade
    label.Parent = billboard
end

task.spawn(function()
    while true do
        for _, player in pairs(Players:GetPlayers()) do
            if GroupSystem.Members[player.Name] then
                createTag(player)
            end
        end
        task.wait(CHECK_INTERVAL)
    end
end)

Players.PlayerAdded:Connect(function(player)
    if GroupSystem.Members[player.Name] then
        player.CharacterAdded:Connect(function()
            task.wait(1)
            createTag(player)
        end)
    end
end)