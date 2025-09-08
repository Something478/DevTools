local Players = game:GetService("Players")

local GROUPS = {
    {
        usernames = { "IdkMyNameBro_012" },
        tag = "Script Owner",
        color = Color3.fromRGB(120, 4, 214)
    },
    {
        usernames = { "Theo_TheoBenzo" },
        tag = "The Chosen One",
        color = Color3.fromRGB(0, 120, 255)
    },
    {
        usernames = { "buratitat7", "yourgames9", "lIlIIIIlllIlIlIlIlIl" },
        tag = "Cool Person",
        color = Color3.fromRGB(255, 215, 0)
    },
}

local UserGroupLookup = {}
for _, group in ipairs(GROUPS) do
    for _, username in ipairs(group.usernames) do
        UserGroupLookup[username] = { tag = group.tag, color = group.color }
    end
end

local function createTag(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:WaitForChild("Head", 5)
    if not head then return end

    local groupInfo = UserGroupLookup[player.Name]
    if not groupInfo then return end

    local tagName = groupInfo.tag .. "Tag"
    if head:FindFirstChild(tagName) then
        head[tagName]:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = tagName
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.Adornee = head
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = groupInfo.tag
    label.TextColor3 = groupInfo.color
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold -- safer font
    label.Parent = billboard
end

Players.PlayerAdded:Connect(function(player)
    if UserGroupLookup[player.Name] then
        player.CharacterAdded:Connect(function()
            task.wait(1)
            createTag(player)
        end)
    end
end)
