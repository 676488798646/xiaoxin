local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")

local LocalPlayer = Players.LocalPlayer

-- Sound Effects
local function playSound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

playSound("2865227271")

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SuperRingPartsGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 380)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(205, 170, 125)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Super 的渐变配色：棕 → 暗红
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(205, 170, 125)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 0, 0))
})
MainGradient.Rotation = 90
MainGradient.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "超级环绕部件 v3"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(222, 216, 204)
Title.Font = Enum.Font.Fondamento
Title.TextSize = 22
Title.Parent = MainFrame

-- Super 的标题渐变：暗红 → 亮红
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 69, 69))
})
TitleGradient.Rotation = 90
TitleGradient.Parent = Title

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 20)
TitleCorner.Parent = Title

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.8, 0, 0, 35)
ToggleButton.Position = UDim2.new(0.1, 0, 0, 50)
ToggleButton.Text = "环绕部件 关"
ToggleButton.BackgroundColor3 = Color3.fromRGB(160, 82, 45)
ToggleButton.TextColor3 = Color3.fromRGB(255, 248, 220)
ToggleButton.Font = Enum.Font.Fondamento
ToggleButton.TextSize = 18
ToggleButton.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

-- 传送到观察者
local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0.8, 0, 0, 35)
TeleportButton.Position = UDim2.new(0.1, 0, 0, 90)
TeleportButton.Text = "传送到观察者"
TeleportButton.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
TeleportButton.TextColor3 = Color3.fromRGB(255, 248, 220)
TeleportButton.Font = Enum.Font.Fondamento
TeleportButton.TextSize = 18
TeleportButton.Parent = MainFrame
local TeleportCorner = Instance.new("UICorner")
TeleportCorner.CornerRadius = UDim.new(0, 10)
TeleportCorner.Parent = TeleportButton

-- 半径
local DecreaseRadius = Instance.new("TextButton")
DecreaseRadius.Size = UDim2.new(0.2, 0, 0, 35)
DecreaseRadius.Position = UDim2.new(0.1, 0, 0, 130)
DecreaseRadius.Text = "<"
DecreaseRadius.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
DecreaseRadius.TextColor3 = Color3.fromRGB(255, 248, 220)
DecreaseRadius.Font = Enum.Font.Fondamento
DecreaseRadius.TextSize = 18
DecreaseRadius.Parent = MainFrame
local DecreaseCorner = Instance.new("UICorner")
DecreaseCorner.CornerRadius = UDim.new(0, 10)
DecreaseCorner.Parent = DecreaseRadius

local RadiusDisplay = Instance.new("TextLabel")
RadiusDisplay.Size = UDim2.new(0.4, 0, 0, 35)
RadiusDisplay.Position = UDim2.new(0.3, 0, 0, 130)
RadiusDisplay.Text = "半径: 50"
RadiusDisplay.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
RadiusDisplay.TextColor3 = Color3.fromRGB(101, 67, 33)
RadiusDisplay.Font = Enum.Font.Fondamento
RadiusDisplay.TextSize = 18
RadiusDisplay.Parent = MainFrame
local RadiusCorner = Instance.new("UICorner")
RadiusCorner.CornerRadius = UDim.new(0, 10)
RadiusCorner.Parent = RadiusDisplay

local IncreaseRadius = Instance.new("TextButton")
IncreaseRadius.Size = UDim2.new(0.2, 0, 0, 35)
IncreaseRadius.Position = UDim2.new(0.7, 0, 0, 130)
IncreaseRadius.Text = ">"
IncreaseRadius.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
IncreaseRadius.TextColor3 = Color3.fromRGB(255, 248, 220)
IncreaseRadius.Font = Enum.Font.Fondamento
IncreaseRadius.TextSize = 18
IncreaseRadius.Parent = MainFrame
local IncreaseCorner = Instance.new("UICorner")
IncreaseCorner.CornerRadius = UDim.new(0, 10)
IncreaseCorner.Parent = IncreaseRadius

-- 速度
local DecreaseSpeed = Instance.new("TextButton")
DecreaseSpeed.Size = UDim2.new(0.2, 0, 0, 35)
DecreaseSpeed.Position = UDim2.new(0.1, 0, 0, 170)
DecreaseSpeed.Text = "<"
DecreaseSpeed.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
DecreaseSpeed.TextColor3 = Color3.fromRGB(255, 248, 220)
DecreaseSpeed.Font = Enum.Font.Fondamento
DecreaseSpeed.TextSize = 18
DecreaseSpeed.Parent = MainFrame
local DecreaseSpeedCorner = Instance.new("UICorner")
DecreaseSpeedCorner.CornerRadius = UDim.new(0, 10)
DecreaseSpeedCorner.Parent = DecreaseSpeed

local SpeedDisplay = Instance.new("TextLabel")
SpeedDisplay.Size = UDim2.new(0.4, 0, 0, 35)
SpeedDisplay.Position = UDim2.new(0.3, 0, 0, 170)
SpeedDisplay.Text = "速度: 10"
SpeedDisplay.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
SpeedDisplay.TextColor3 = Color3.fromRGB(101, 67, 33)
SpeedDisplay.Font = Enum.Font.Fondamento
SpeedDisplay.TextSize = 18
SpeedDisplay.Parent = MainFrame
local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 10)
SpeedCorner.Parent = SpeedDisplay

local IncreaseSpeed = Instance.new("TextButton")
IncreaseSpeed.Size = UDim2.new(0.2, 0, 0, 35)
IncreaseSpeed.Position = UDim2.new(0.7, 0, 0, 170)
IncreaseSpeed.Text = ">"
IncreaseSpeed.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
IncreaseSpeed.TextColor3 = Color3.fromRGB(255, 248, 220)
IncreaseSpeed.Font = Enum.Font.Fondamento
IncreaseSpeed.TextSize = 18
IncreaseSpeed.Parent = MainFrame
local IncreaseSpeedCorner = Instance.new("UICorner")
IncreaseSpeedCorner.CornerRadius = UDim.new(0, 10)
IncreaseSpeedCorner.Parent = IncreaseSpeed

-- 高度
local DecreaseHeight = Instance.new("TextButton")
DecreaseHeight.Size = UDim2.new(0.2, 0, 0, 35)
DecreaseHeight.Position = UDim2.new(0.1, 0, 0, 210)
DecreaseHeight.Text = "<"
DecreaseHeight.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
DecreaseHeight.TextColor3 = Color3.fromRGB(255, 248, 220)
DecreaseHeight.Font = Enum.Font.Fondamento
DecreaseHeight.TextSize = 18
DecreaseHeight.Parent = MainFrame
local DecreaseHeightCorner = Instance.new("UICorner")
DecreaseHeightCorner.CornerRadius = UDim.new(0, 10)
DecreaseHeightCorner.Parent = DecreaseHeight

local HeightDisplay = Instance.new("TextLabel")
HeightDisplay.Size = UDim2.new(0.4, 0, 0, 35)
HeightDisplay.Position = UDim2.new(0.3, 0, 0, 210)
HeightDisplay.Text = "高度: 100"
HeightDisplay.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
HeightDisplay.TextColor3 = Color3.fromRGB(101, 67, 33)
HeightDisplay.Font = Enum.Font.Fondamento
HeightDisplay.TextSize = 18
HeightDisplay.Parent = MainFrame
local HeightCorner = Instance.new("UICorner")
HeightCorner.CornerRadius = UDim.new(0, 10)
HeightCorner.Parent = HeightDisplay

local IncreaseHeight = Instance.new("TextButton")
IncreaseHeight.Size = UDim2.new(0.2, 0, 0, 35)
IncreaseHeight.Position = UDim2.new(0.7, 0, 0, 210)
IncreaseHeight.Text = ">"
IncreaseHeight.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
IncreaseHeight.TextColor3 = Color3.fromRGB(255, 248, 220)
IncreaseHeight.Font = Enum.Font.Fondamento
IncreaseHeight.TextSize = 18
IncreaseHeight.Parent = MainFrame
local IncreaseHeightCorner = Instance.new("UICorner")
IncreaseHeightCorner.CornerRadius = UDim.new(0, 10)
IncreaseHeightCorner.Parent = IncreaseHeight

-- 穿墙 / 无摔伤
local NoclipButton = Instance.new("TextButton")
NoclipButton.Size = UDim2.new(0.35, 0, 0, 35)
NoclipButton.Position = UDim2.new(0.1, 0, 0, 250)
NoclipButton.Text = "穿墙"
NoclipButton.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
NoclipButton.TextColor3 = Color3.fromRGB(255, 248, 220)
NoclipButton.Font = Enum.Font.Fondamento
NoclipButton.TextSize = 18
NoclipButton.Parent = MainFrame
local NoclipCorner = Instance.new("UICorner")
NoclipCorner.CornerRadius = UDim.new(0, 10)
NoclipCorner.Parent = NoclipButton

local NoFallButton = Instance.new("TextButton")
NoFallButton.Size = UDim2.new(0.35, 0, 0, 35)
NoFallButton.Position = UDim2.new(0.55, 0, 0, 250)
NoFallButton.Text = "无摔伤"
NoFallButton.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
NoFallButton.TextColor3 = Color3.fromRGB(255, 248, 220)
NoFallButton.Font = Enum.Font.Fondamento
NoFallButton.TextSize = 18
NoFallButton.Parent = MainFrame
local NoFallCorner = Instance.new("UICorner")
NoFallCorner.CornerRadius = UDim.new(0, 10)
NoFallCorner.Parent = NoFallButton

-- 无限收益 / 飞行
local InfYieldButton = Instance.new("TextButton")
InfYieldButton.Size = UDim2.new(0.35, 0, 0, 35)
InfYieldButton.Position = UDim2.new(0.1, 0, 0, 290)
InfYieldButton.Text = "无限收益"
InfYieldButton.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
InfYieldButton.TextColor3 = Color3.fromRGB(255, 248, 220)
InfYieldButton.Font = Enum.Font.Fondamento
InfYieldButton.TextSize = 14
InfYieldButton.Parent = MainFrame
local InfYieldCorner = Instance.new("UICorner")
InfYieldCorner.CornerRadius = UDim.new(0, 10)
InfYieldCorner.Parent = InfYieldButton

local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0.35, 0, 0, 35)
FlyButton.Position = UDim2.new(0.55, 0, 0, 290)
FlyButton.Text = "飞行"
FlyButton.BackgroundColor3 = Color3.fromRGB(186, 85, 211)
FlyButton.TextColor3 = Color3.fromRGB(240, 255, 255)
FlyButton.Font = Enum.Font.Fondamento
FlyButton.TextSize = 18
FlyButton.Parent = MainFrame
local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 10)
FlyCorner.Parent = FlyButton

-- FPS
local FPSDisplay = Instance.new("TextLabel")
FPSDisplay.Size = UDim2.new(0.8, 0, 0, 30)
FPSDisplay.Position = UDim2.new(0.1, 0, 0, 330)
FPSDisplay.Text = "FPS: 计算中..."
FPSDisplay.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
FPSDisplay.TextColor3 = Color3.fromRGB(101, 67, 33)
FPSDisplay.Font = Enum.Font.Fondamento
FPSDisplay.TextSize = 16
FPSDisplay.Parent = MainFrame
local FPSCorner = Instance.new("UICorner")
FPSCorner.CornerRadius = UDim.new(0, 10)
FPSCorner.Parent = FPSDisplay

local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(1, 0, 0, 20)
Watermark.Position = UDim2.new(0, 0, 1, -20)
Watermark.Text = "超级环绕 [V3] - 由 Projeto LKB 破解"
Watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
Watermark.BackgroundTransparency = 1
Watermark.Font = Enum.Font.Fondamento
Watermark.TextSize = 14
Watermark.Parent = MainFrame

-- 最小化
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 85, 127)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 248, 220)
MinimizeButton.Font = Enum.Font.Fondamento
MinimizeButton.TextSize = 18
MinimizeButton.Parent = MainFrame
local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 15)
MinimizeCorner.Parent = MinimizeButton

local minimized = false
local allElements = {
    Title, ToggleButton, TeleportButton, DecreaseRadius, RadiusDisplay, IncreaseRadius,
    DecreaseSpeed, SpeedDisplay, IncreaseSpeed, DecreaseHeight, HeightDisplay, IncreaseHeight,
    NoclipButton, NoFallButton, InfYieldButton, FlyButton, FPSDisplay, Watermark
}
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 220, 0, 40), "Out", "Quad", 0.3, true)
        MinimizeButton.Text = "+"
        for _, el in ipairs(allElements) do el.Visible = false end
    else
        MainFrame:TweenSize(UDim2.new(0, 220, 0, 380), "Out", "Quad", 0.3, true)
        MinimizeButton.Text = "-"
        for _, el in ipairs(allElements) do el.Visible = true end
    end
    playSound("12221967")
end)

-- 拖动
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

-- Network
if not getgenv().Network then
    getgenv().Network = { BaseParts = {}, Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424) }
    Network.RetainPart = function(Part)
        if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(workspace) then
            table.insert(Network.BaseParts, Part)
            Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            Part.CanCollide = false
        end
    end
    local function EnablePartControl()
        LocalPlayer.ReplicationFocus = workspace
        RunService.Heartbeat:Connect(function()
            sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
            for _, Part in pairs(Network.BaseParts) do
                if Part:IsDescendantOf(workspace) then Part.Velocity = Network.Velocity end
            end
        end)
    end
    EnablePartControl()
end

-- 环绕变量
local radius = 50
local height = 100
local rotationSpeed = 10
local attractionStrength = 1000
local ringPartsEnabled = false
local observerMode = false
local observerPosition = Vector3.new(-280, 179, 342)

local function RetainPart(Part)
    if Part:IsA("BasePart") and not Part.Anchored and Part:IsDescendantOf(workspace) then
        if Part.Parent == LocalPlayer.Character or Part:IsDescendantOf(LocalPlayer.Character) then return false end
        Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        Part.CanCollide = false
        return true
    end
    return false
end

local parts = {}
local function addPart(part)
    if RetainPart(part) then
        if not table.find(parts, part) then table.insert(parts, part) end
    end
end
local function removePart(part)
    local index = table.find(parts, part)
    if index then table.remove(parts, index) end
end

for _, part in pairs(workspace:GetDescendants()) do addPart(part) end
workspace.DescendantAdded:Connect(addPart)
workspace.DescendantRemoving:Connect(removePart)

RunService.Heartbeat:Connect(function()
    if not ringPartsEnabled then return end
    local center
    if observerMode then
        center = observerPosition
    else
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        center = hrp and hrp.Position
    end
    if center then
        for _, part in pairs(parts) do
            if part.Parent and not part.Anchored then
                local pos = part.Position
                local distance = (Vector3.new(pos.X, center.Y, pos.Z) - center).Magnitude
                local angle = math.atan2(pos.Z - center.Z, pos.X - center.X)
                local newAngle = angle + math.rad(rotationSpeed)
                local targetPos = Vector3.new(
                    center.X + math.cos(newAngle) * math.min(radius, distance),
                    center.Y + (height * math.abs(math.sin((pos.Y - center.Y) / height))),
                    center.Z + math.sin(newAngle) * math.min(radius, distance)
                )
                part.Velocity = (targetPos - part.Position).unit * attractionStrength
            end
        end
    end
end)

-- 穿墙
local noclipEnabled = false
local noclipConn = nil
local function enableNoclip()
    noclipConn = RunService.Stepped:Connect(function()
        if LocalPlayer.Character then
            for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
                if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
            end
        end
    end)
end
local function disableNoclip()
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
end

-- 无摔伤
local function noFall(chr)
    if not chr then return end
    local root = chr:WaitForChild("HumanoidRootPart", 5)
    if not root then return end
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not root.Parent then conn:Disconnect() return end
        local old = root.AssemblyLinearVelocity
        root.AssemblyLinearVelocity = Vector3.zero
        RunService.RenderStepped:Wait()
        root.AssemblyLinearVelocity = old
    end)
end

-- 无限收益 / 飞行
local function loadInfYield()
    local ok, err = pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
    if not ok then warn("Failed to execute script: " .. err) end
end
local function loadFly()
    local ok, err = pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)
    if not ok then warn("Failed to execute Fly script: " .. err) end
end

-- FPS
local lastTick = tick()
RunService.RenderStepped:Connect(function()
    local now = tick()
    local fps = math.floor(1 / (now - lastTick))
    lastTick = now
    FPSDisplay.Text = "FPS: " .. tostring(fps)
end)

-- 按钮功能
ToggleButton.MouseButton1Click:Connect(function()
    ringPartsEnabled = not ringPartsEnabled
    ToggleButton.Text = ringPartsEnabled and "环绕部件 开" or "环绕部件 关"
    ToggleButton.BackgroundColor3 = ringPartsEnabled and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(160, 82, 45)
    playSound("12221967")
end)

TeleportButton.MouseButton1Click:Connect(function()
    observerMode = not observerMode
    TeleportButton.Text = observerMode and "返回玩家" or "传送到观察者"
    TeleportButton.BackgroundColor3 = observerMode and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(139, 69, 19)
    playSound("12221967")
end)

DecreaseRadius.MouseButton1Click:Connect(function()
    radius = math.max(10, radius - 5)
    RadiusDisplay.Text = "半径: " .. radius
    playSound("12221967")
end)
IncreaseRadius.MouseButton1Click:Connect(function()
    radius = math.min(100, radius + 5)
    RadiusDisplay.Text = "半径: " .. radius
    playSound("12221967")
end)

DecreaseSpeed.MouseButton1Click:Connect(function()
    rotationSpeed = math.max(1, rotationSpeed - 1)
    SpeedDisplay.Text = "速度: " .. rotationSpeed
    playSound("12221967")
end)
IncreaseSpeed.MouseButton1Click:Connect(function()
    rotationSpeed = math.min(100, rotationSpeed + 1)
    SpeedDisplay.Text = "速度: " .. rotationSpeed
    playSound("12221967")
end)

DecreaseHeight.MouseButton1Click:Connect(function()
    height = math.max(10, height - 10)
    HeightDisplay.Text = "高度: " .. height
    playSound("12221967")
end)
IncreaseHeight.MouseButton1Click:Connect(function()
    height = height + 10
    HeightDisplay.Text = "高度: " .. height
    playSound("12221967")
end)

NoclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    NoclipButton.Text = noclipEnabled and "取消穿墙" or "穿墙"
    NoclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(139, 69, 19)
    if noclipEnabled then enableNoclip() else disableNoclip() end
    playSound("12221967")
end)

NoFallButton.MouseButton1Click:Connect(function()
    noFall(LocalPlayer.Character)
    LocalPlayer.CharacterAdded:Connect(noFall)
    playSound("12221967")
end)

InfYieldButton.MouseButton1Click:Connect(function()
    loadInfYield()
    playSound("12221967")
end)

FlyButton.MouseButton1Click:Connect(function()
    loadFly()
    playSound("12221967")
end)

-- 通知
StarterGui:SetCore("SendNotification", {
    Title = "感谢 Projeto LKB！",
    Text = "由 2xyyy 于 2024 年制作！",
    Duration = 10
})

local userId = Players:GetUserIdFromNameAsync("NannaDev")
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

StarterGui:SetCore("SendNotification", {
    Title = "Enjoy Super Ring [V3]",
    Text = "Cracked By .gg/3kZ7dKbJPe",
    Icon = content,
    Duration = 5
})