local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")

local LocalPlayer = Players.LocalPlayer

-- ===== 音效 =====
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

-- ===== GUI 创建（宽而低） =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SuperRingPartsGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 460, 0, 210)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -105)
MainFrame.BackgroundColor3 = Color3.fromRGB(205, 170, 125) -- 浅棕
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 36)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "超级环绕部件 v3"
Title.TextColor3 = Color3.fromRGB(101, 67, 33)
Title.BackgroundColor3 = Color3.fromRGB(222, 184, 135)
Title.Font = Enum.Font.Fondamento
Title.TextSize = 22
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 20)
TitleCorner.Parent = Title

-- 最小化
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -35, 0, 3)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 248, 220)
MinimizeButton.Font = Enum.Font.Fondamento
MinimizeButton.TextSize = 18
MinimizeButton.Parent = MainFrame

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 15)
MinimizeCorner.Parent = MinimizeButton

-- ===== 通用按钮工厂 =====
local function makeButton(text, x, y, w, h, bg)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, w, 0, h)
    btn.Position = UDim2.new(0, x, 0, y)
    btn.Text = text
    btn.BackgroundColor3 = bg or Color3.fromRGB(160, 82, 45)
    btn.TextColor3 = Color3.fromRGB(255, 248, 220)
    btn.Font = Enum.Font.Fondamento
    btn.TextSize = 14
    btn.Parent = MainFrame
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = btn
    return btn
end

-- 第一行：开关 / 传送 / 穿墙 / 无摔伤
local ToggleButton = makeButton("环绕部件 关", 10, 44, 105, 30)
local TeleportButton = makeButton("传送到观察者", 120, 44, 105, 30, Color3.fromRGB(139, 69, 19))
local NoclipButton = makeButton("穿墙", 230, 44, 105, 30, Color3.fromRGB(139, 69, 19))
local NoFallButton = makeButton("无摔伤", 340, 44, 105, 30, Color3.fromRGB(139, 69, 19))

-- 第二行：半径 < 值 >
local DecreaseRadius = makeButton("<", 10, 82, 30, 30, Color3.fromRGB(139, 69, 19))
local RadiusDisplay = Instance.new("TextLabel")
RadiusDisplay.Size = UDim2.new(0, 75, 0, 30)
RadiusDisplay.Position = UDim2.new(0, 45, 0, 82)
RadiusDisplay.Text = "半径: 50"
RadiusDisplay.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
RadiusDisplay.TextColor3 = Color3.fromRGB(101, 67, 33)
RadiusDisplay.Font = Enum.Font.Fondamento
RadiusDisplay.TextSize = 14
RadiusDisplay.Parent = MainFrame
local RadiusCorner = Instance.new("UICorner")
RadiusCorner.CornerRadius = UDim.new(0, 10)
RadiusCorner.Parent = RadiusDisplay
local IncreaseRadius = makeButton(">", 125, 82, 30, 30, Color3.fromRGB(139, 69, 19))

-- 第二行右：速度 < 值 >
local DecreaseSpeed = makeButton("<", 170, 82, 30, 30, Color3.fromRGB(139, 69, 19))
local SpeedDisplay = Instance.new("TextLabel")
SpeedDisplay.Size = UDim2.new(0, 75, 0, 30)
SpeedDisplay.Position = UDim2.new(0, 205, 0, 82)
SpeedDisplay.Text = "速度: 10"
SpeedDisplay.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
SpeedDisplay.TextColor3 = Color3.fromRGB(101, 67, 33)
SpeedDisplay.Font = Enum.Font.Fondamento
SpeedDisplay.TextSize = 14
SpeedDisplay.Parent = MainFrame
local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 10)
SpeedCorner.Parent = SpeedDisplay
local IncreaseSpeed = makeButton(">", 285, 82, 30, 30, Color3.fromRGB(139, 69, 19))

-- 第二行最右：高度 < 值 >
local DecreaseHeight = makeButton("<", 330, 82, 30, 30, Color3.fromRGB(139, 69, 19))
local HeightDisplay = Instance.new("TextLabel")
HeightDisplay.Size = UDim2.new(0, 75, 0, 30)
HeightDisplay.Position = UDim2.new(0, 365, 0, 82)
HeightDisplay.Text = "高度: 100"
HeightDisplay.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
HeightDisplay.TextColor3 = Color3.fromRGB(101, 67, 33)
HeightDisplay.Font = Enum.Font.Fondamento
HeightDisplay.TextSize = 14
HeightDisplay.Parent = MainFrame
local HeightCorner = Instance.new("UICorner")
HeightCorner.CornerRadius = UDim.new(0, 10)
HeightCorner.Parent = HeightDisplay

-- 第三行：无限收益 / 飞行
local InfYieldButton = makeButton("无限收益", 10, 120, 160, 30, Color3.fromRGB(47, 47, 47))
local FlyButton = makeButton("飞行", 180, 120, 160, 30, Color3.fromRGB(186, 85, 211))

-- 第四行：FPS
local FPSDisplay = Instance.new("TextLabel")
FPSDisplay.Size = UDim2.new(0, 430, 0, 28)
FPSDisplay.Position = UDim2.new(0, 10, 0, 158)
FPSDisplay.Text = "FPS: 计算中..."
FPSDisplay.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
FPSDisplay.TextColor3 = Color3.fromRGB(101, 67, 33)
FPSDisplay.Font = Enum.Font.Fondamento
FPSDisplay.TextSize = 14
FPSDisplay.Parent = MainFrame
local FPSCorner = Instance.new("UICorner")
FPSCorner.CornerRadius = UDim.new(0, 10)
FPSCorner.Parent = FPSDisplay

-- 水印
local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(1, 0, 0, 20)
Watermark.Position = UDim2.new(0, 0, 1, -20)
Watermark.Text = "超级环绕 [V3] - 由 Projeto LKB 破解"
Watermark.TextColor3 = Color3.fromRGB(101, 67, 33)
Watermark.BackgroundTransparency = 1
Watermark.Font = Enum.Font.Fondamento
Watermark.TextSize = 13
Watermark.Parent = MainFrame

-- 最小化逻辑
local minimized = false
local allElements = {
    ToggleButton, TeleportButton, NoclipButton, NoFallButton,
    DecreaseRadius, RadiusDisplay, IncreaseRadius,
    DecreaseSpeed, SpeedDisplay, IncreaseSpeed,
    DecreaseHeight, HeightDisplay,
    InfYieldButton, FlyButton, FPSDisplay, Watermark
}
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 460, 0, 36), "Out", "Quad", 0.3, true)
        MinimizeButton.Text = "+"
        for _, el in ipairs(allElements) do el.Visible = false end
    else
        MainFrame:TweenSize(UDim2.new(0, 460, 0, 210), "Out", "Quad", 0.3, true)
        MinimizeButton.Text = "-"
        for _, el in ipairs(allElements) do el.Visible = true end
    end
    playSound("12221967")
end)

-- 拖拽
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

-- ===== Network =====
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

-- ===== 环绕逻辑 =====
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

-- ===== 穿墙 =====
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

-- ===== 无摔伤 =====
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

-- ===== 外部脚本 =====
local function loadInfYield()
    local ok, err = pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
    if not ok then warn("Failed to execute script: " .. err) end
end
local function loadFly()
    local ok, err = pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)
    if not ok then warn("Failed to execute Fly script: " .. err) end
end

-- ===== FPS =====
local lastTick = tick()
RunService.RenderStepped:Connect(function()
    local now = tick()
    local fps = math.floor(1 / (now - lastTick))
    lastTick = now
    FPSDisplay.Text = "FPS: " .. tostring(fps)
end)

-- ===== 按钮功能 =====
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

-- ===== 通知 =====
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