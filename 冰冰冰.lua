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

-- 通用参数
local FULL_H = 344
local TITLE_H = 40
local BTN_H = 32
local GAP = 7
local START_Y = 50
local WATERMARK_H = 22
local function rowY(n) return START_Y + (n - 1) * (BTN_H + GAP) end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, FULL_H)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -(FULL_H / 2))
MainFrame.BackgroundColor3 = Color3.fromRGB(205, 170, 125)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, TITLE_H)
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

local function makeButton(text, x, w)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(w, 0, 0, BTN_H)
    b.Position = UDim2.new(x, 0, 0, 0)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
    b.TextColor3 = Color3.fromRGB(255, 248, 220)
    b.Font = Enum.Font.Fondamento
    b.TextSize = 16
    b.Parent = MainFrame
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b
    return b
end

local function makeLabel(text, x, w)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(w, 0, 0, BTN_H)
    l.Position = UDim2.new(x, 0, 0, 0)
    l.Text = text
    l.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
    l.TextColor3 = Color3.fromRGB(101, 67, 33)
    l.Font = Enum.Font.Fondamento
    l.TextSize = 16
    l.Parent = MainFrame
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = l
    return l
end

-- 第1行：环绕部件开关
local ToggleButton = makeButton("环绕部件 关", 0.1, 0.8)
ToggleButton.BackgroundColor3 = Color3.fromRGB(160, 82, 45)
ToggleButton.Position = UDim2.new(0.1, 0, 0, rowY(1))

-- 第2行：传送到观察者
local TeleportButton = makeButton("传送到观察者", 0.1, 0.8)
TeleportButton.Position = UDim2.new(0.1, 0, 0, rowY(2))

-- 第3行：半径
local DecreaseRadius = makeButton("<", 0.1, 0.2)
DecreaseRadius.Position = UDim2.new(0.1, 0, 0, rowY(3))
local RadiusDisplay = makeLabel("半径: 50", 0.3, 0.4)
RadiusDisplay.Position = UDim2.new(0.3, 0, 0, rowY(3))
local IncreaseRadius = makeButton(">", 0.7, 0.2)
IncreaseRadius.Position = UDim2.new(0.7, 0, 0, rowY(3))

-- 第4行：速度
local DecreaseSpeed = makeButton("<", 0.1, 0.2)
DecreaseSpeed.Position = UDim2.new(0.1, 0, 0, rowY(4))
local SpeedDisplay = makeLabel("速度: 10", 0.3, 0.4)
SpeedDisplay.Position = UDim2.new(0.3, 0, 0, rowY(4))
local IncreaseSpeed = makeButton(">", 0.7, 0.2)
IncreaseSpeed.Position = UDim2.new(0.7, 0, 0, rowY(4))

-- 第5行：高度
local DecreaseHeight = makeButton("<", 0.1, 0.2)
DecreaseHeight.Position = UDim2.new(0.1, 0, 0, rowY(5))
local HeightDisplay = makeLabel("高度: 100", 0.3, 0.4)
HeightDisplay.Position = UDim2.new(0.3, 0, 0, rowY(5))
local IncreaseHeight = makeButton(">", 0.7, 0.2)
IncreaseHeight.Position = UDim2.new(0.7, 0, 0, rowY(5))

-- 第6行：穿墙 + 无摔伤
local NoclipButton = makeButton("穿墙", 0.1, 0.35)
NoclipButton.Position = UDim2.new(0.1, 0, 0, rowY(6))
local NoFallButton = makeButton("无摔伤", 0.55, 0.35)
NoFallButton.Position = UDim2.new(0.55, 0, 0, rowY(6))

-- 第7行：FPS
local FPSDisplay = makeLabel("FPS: 计算中...", 0.1, 0.8)
FPSDisplay.Position = UDim2.new(0.1, 0, 0, rowY(7))
FPSDisplay.TextSize = 15

-- 水印：紧贴 FPS 下方
local WATERMARK_Y = rowY(7) + BTN_H + 6
local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(1, 0, 0, WATERMARK_H)
Watermark.Position = UDim2.new(0, 0, 0, WATERMARK_Y)
Watermark.Text = "超级环绕 [V3] - 由 Projeto LKB 破解"
Watermark.TextColor3 = Color3.fromRGB(101, 67, 33)
Watermark.BackgroundTransparency = 1
Watermark.Font = Enum.Font.Fondamento
Watermark.TextSize = 13
Watermark.Parent = MainFrame

-- 最小化
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -36, 0, 5)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 248, 220)
MinimizeButton.Font = Enum.Font.Fondamento
MinimizeButton.TextSize = 18
MinimizeButton.Parent = MainFrame
local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 15)
MinimizeCorner.Parent = MinimizeButton

local minimized = false
local isAnimating = false
local allElements = {
    ToggleButton, TeleportButton, DecreaseRadius, RadiusDisplay, IncreaseRadius,
    DecreaseSpeed, SpeedDisplay, IncreaseSpeed, DecreaseHeight, HeightDisplay, IncreaseHeight,
    NoclipButton, NoFallButton, FPSDisplay, Watermark
}

MinimizeButton.MouseButton1Click:Connect(function()
    if isAnimating then return end
    isAnimating = true
    minimized = not minimized

    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 260, 0, TITLE_H), "Out", "Quad", 0.25, true)
        task.delay(0.25, function()
            if minimized then
                for _, el in ipairs(allElements) do el.Visible = false end
            end
            MinimizeButton.Text = "+"
            isAnimating = false
        end)
        MinimizeButton.Text = "+"
    else
        for _, el in ipairs(allElements) do el.Visible = true end
        Watermark.Position = UDim2.new(0, 0, 0, WATERMARK_Y)
        MainFrame:TweenSize(UDim2.new(0, 260, 0, FULL_H), "Out", "Quad", 0.25, true)
        task.delay(0.25, function()
            if not minimized then
                for _, el in ipairs(allElements) do el.Visible = true end
                Watermark.Position = UDim2.new(0, 0, 0, WATERMARK_Y)
            end
            MinimizeButton.Text = "-"
            isAnimating = false
        end)
        MinimizeButton.Text = "-"
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
    ToggleButton.BackgroundColor3 = ringPartsEnabled and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(139, 69, 19)
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

-- 聊天消息（兼容新聊天系统）
local function SendChatMessage(message)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local textChannel = TextChatService.TextChannels.RBXGeneral
        textChannel:SendAsync(message)
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end
end
