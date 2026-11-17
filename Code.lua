local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

-- ========== 音效 ==========
local function playSound(soundId)
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. soundId
	sound.Parent = SoundService
	sound:Play()
	sound.Ended:Connect(function() sound:Destroy() end)
end
playSound("2865227271")

-- ========== GUI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SuperRingPartsGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local FULL_H = 383
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
Title.Text = "超级环绕 by xiaoxin"
Title.TextColor3 = Color3.fromRGB(101, 67, 33)
Title.BackgroundColor3 = Color3.fromRGB(222, 184, 135)
Title.Font = Enum.Font.Fondamento
Title.TextSize = 20
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

local function makeTextBox(defaultText, x, w)
	local t = Instance.new("TextBox")
	t.Size = UDim2.new(w, 0, 0, BTN_H)
	t.Position = UDim2.new(x, 0, 0, 0)
	t.Text = defaultText
	t.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
	t.TextColor3 = Color3.fromRGB(101, 67, 33)
	t.Font = Enum.Font.Fondamento
	t.TextSize = 16
	t.ClearTextOnFocus = false
	t.Parent = MainFrame
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 8)
	c.Parent = t
	return t
end

-- 第1行：环绕部件开关
local ToggleButton = makeButton("环绕部件 关", 0.1, 0.8)
ToggleButton.BackgroundColor3 = Color3.fromRGB(160, 82, 45)
ToggleButton.Position = UDim2.new(0.1, 0, 0, rowY(1))

-- 第2行：传送到观察者
local TeleportButton = makeButton("传送到观察者", 0.1, 0.8)
TeleportButton.Position = UDim2.new(0.1, 0, 0, rowY(2))

-- 第3行：小球环绕
local BallRingButton = makeButton("小球环绕 关", 0.1, 0.8)
BallRingButton.Position = UDim2.new(0.1, 0, 0, rowY(3))

-- 第4行：半径
local DecreaseRadius = makeButton("<", 0.1, 0.2)
DecreaseRadius.Position = UDim2.new(0.1, 0, 0, rowY(4))
local RadiusBox = makeTextBox("半径: 50", 0.3, 0.4)
RadiusBox.Position = UDim2.new(0.3, 0, 0, rowY(4))
local IncreaseRadius = makeButton(">", 0.7, 0.2)
IncreaseRadius.Position = UDim2.new(0.7, 0, 0, rowY(4))

-- 第5行：速度
local DecreaseSpeed = makeButton("<", 0.1, 0.2)
DecreaseSpeed.Position = UDim2.new(0.1, 0, 0, rowY(5))
local SpeedBox = makeTextBox("速度: 10", 0.3, 0.4)
SpeedBox.Position = UDim2.new(0.3, 0, 0, rowY(5))
local IncreaseSpeed = makeButton(">", 0.7, 0.2)
IncreaseSpeed.Position = UDim2.new(0.7, 0, 0, rowY(5))

-- 第6行：小球数量
local DecreaseBallCount = makeButton("<", 0.1, 0.2)
DecreaseBallCount.Position = UDim2.new(0.1, 0, 0, rowY(6))
local BallCountBox = makeTextBox("数量: 50", 0.3, 0.4)
BallCountBox.Position = UDim2.new(0.3, 0, 0, rowY(6))
local IncreaseBallCount = makeButton(">", 0.7, 0.2)
IncreaseBallCount.Position = UDim2.new(0.7, 0, 0, rowY(6))

-- 第7行：穿墙 + 无摔伤
local NoclipButton = makeButton("穿墙", 0.1, 0.35)
NoclipButton.Position = UDim2.new(0.1, 0, 0, rowY(7))
local NoFallButton = makeButton("无摔伤", 0.55, 0.35)
NoFallButton.Position = UDim2.new(0.55, 0, 0, rowY(7))

-- 第8行：FPS
local FPSDisplay = makeTextBox("FPS: 计算中...", 0.1, 0.8)
FPSDisplay.Position = UDim2.new(0.1, 0, 0, rowY(8))
FPSDisplay.TextSize = 15
FPSDisplay.TextEditable = false

-- 水印
local WATERMARK_Y = rowY(8) + BTN_H + 6
local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(1, 0, 0, WATERMARK_H)
Watermark.Position = UDim2.new(0, 0, 0, WATERMARK_Y)
Watermark.Text = "超级环绕 - 由小欣制作"
Watermark.TextColor3 = Color3.fromRGB(101, 67, 33)
Watermark.BackgroundTransparency = 1
Watermark.Font = Enum.Font.Fondamento
Watermark.TextSize = 13
Watermark.Parent = MainFrame

-- 最小化按钮
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
	ToggleButton, TeleportButton, BallRingButton,
	DecreaseRadius, RadiusBox, IncreaseRadius,
	DecreaseSpeed, SpeedBox, IncreaseSpeed,
	DecreaseBallCount, BallCountBox, IncreaseBallCount,
	NoclipButton, NoFallButton, FPSDisplay, Watermark
}

MinimizeButton.MouseButton1Click:Connect(function()
	if isAnimating then return end
	isAnimating = true
	minimized = not minimized
	if minimized then
		MainFrame:TweenSize(UDim2.new(0, 260, 0, TITLE_H), "Out", "Quad", 0.2, true)
		task.delay(0.2, function()
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
		MainFrame:TweenSize(UDim2.new(0, 260, 0, FULL_H), "Out", "Quad", 0.2, true)
		task.delay(0.2, function()
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

-- 面板拖动
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

-- ========== Network ==========
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

-- ========== 零件环绕（V3 双圈逻辑） ==========
local radius = 50
local rotationSpeed = 10
local ringPartsEnabled = false
local observerMode = false
local observerPosition = Vector3.new(-280, 179, 342)

local partData = {}
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
		if not table.find(parts, part) then
			table.insert(parts, part)
		end
	end
end
local function removePart(part)
	local index = table.find(parts, part)
	if index then table.remove(parts, index) end
	partData[part] = nil
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
	if not center then return end

	local innerR = radius
	local outerR = radius + 10

	for _, part in pairs(parts) do
		if part.Parent and not part.Anchored then
			local data = partData[part]
			if not data then
				-- 随机分配内圈或外圈
				local isOuter = math.random() > 0.5
				local partRadius = isOuter and (innerR + 5 + math.random() * 5) or (innerR + math.random() * 5)
				partData[part] = {
					angle = math.random() * math.pi * 2,
					radius = partRadius,
					speedMultiplier = 0.8 + math.random() * 0.4
				}
				data = partData[part]
			end

			data.angle = data.angle + math.rad(rotationSpeed) * data.speedMultiplier
			local targetPos = Vector3.new(
				center.X + math.cos(data.angle) * data.radius,
				center.Y,
				center.Z + math.sin(data.angle) * data.radius
			)
			local moveVelocity = (targetPos - part.Position) * (rotationSpeed * 1.5)
			part.Velocity = Vector3.new(moveVelocity.X, 0, moveVelocity.Z)
		end
	end
end)

-- ========== 小球环绕（双圈，固定归属） ==========
local BALL_COLOR_ORANGE = Color3.fromRGB(255, 140, 0)
local BALL_COLOR_RED = Color3.fromRGB(255, 0, 0)
local BALL_DIAMETER = 1
local MAX_BALLS = 200
local BallFolder = Instance.new("Folder")
BallFolder.Name = "OrangeBallRing"
BallFolder.Parent = workspace

local ballRingEnabled = false
local ballPhase = 0
local ballCount = 50
local balls = {}
local _ballRingData = {} -- false=内圈, true=外圈

for i = 1, MAX_BALLS do
	local ball = Instance.new("Part")
	ball.Name = "RingBall_" .. i
	ball.Shape = Enum.PartType.Ball
	ball.Size = Vector3.new(BALL_DIAMETER, BALL_DIAMETER, BALL_DIAMETER)
	ball.Color = BALL_COLOR_ORANGE
	ball.Material = Enum.Material.Neon
	ball.Anchored = true
	ball.CanCollide = false
	ball.CanQuery = false
	ball.CanTouch = false
	ball.CastShadow = false
	ball.Transparency = 1
	ball.Parent = BallFolder
	balls[i] = ball
end

local function hideAllBalls()
	for _, ball in ipairs(balls) do
		ball.Transparency = 1
	end
	_ballRingData = {}
end

local function getBallColor()
	if not observerMode and radius < 15 then
		return BALL_COLOR_RED
	end
	return BALL_COLOR_ORANGE
end

-- 出生/消失动画
local ballAnimating = false
local ballAnimProgress = 0
local ballAnimDirection = 0

RunService.RenderStepped:Connect(function(dt)
	if not ballRingEnabled and ballAnimDirection == 0 and ballAnimProgress == 0 then
		return
	end

	-- 半径平滑过渡
	local diff = radius - displayRadius
	if math.abs(diff) > 0.05 then
		displayRadius = displayRadius + diff * math.clamp(dt * 6, 0, 1)
	else
		displayRadius = radius
	end

	-- 中心：跟玩家硬跟随，观察者模式 Lerp
	local targetC
	if observerMode then
		targetC = observerPosition
	else
		local character = LocalPlayer.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if not hrp then hideAllBalls() return end
		targetC = hrp.Position
	end

	if observerMode then
		if not currentCenter then
			currentCenter = targetC
		else
			currentCenter = currentCenter:Lerp(targetC, math.clamp(dt * 6, 0, 1))
		end
	else
		currentCenter = targetC
	end

	-- 动画
	if ballAnimDirection == 1 then
		ballAnimProgress = ballAnimProgress + dt * 3
		if ballAnimProgress >= 1 then
			ballAnimProgress = 1
			ballAnimDirection = 0
			ballAnimating = false
		end
	elseif ballAnimDirection == -1 then
		ballAnimProgress = ballAnimProgress - dt * 3
		if ballAnimProgress <= 0 then
			ballAnimProgress = 0
			ballAnimDirection = 0
			ballAnimating = false
			ballRingEnabled = false
			hideAllBalls()
			BallRingButton.Text = "小球环绕 关"
			BallRingButton.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
			return
		end
	end

	ballPhase = ballPhase + dt * math.rad(rotationSpeed)
	local ballColor = getBallColor()
	local currentR = displayRadius * ballAnimProgress

	for i = 1, ballCount do
		local ball = balls[i]
		if ball then
			if _ballRingData[i] == nil then
				_ballRingData[i] = (i > ballCount / 2) -- 前半内圈，后半外圈
			end

			local angle = ballPhase + (i - 1) * (2 * math.pi / ballCount)
			local r = _ballRingData[i] and (currentR + 10) or currentR

			ball.CFrame = CFrame.new(
				currentCenter.X + math.cos(angle) * r,
				currentCenter.Y,
				currentCenter.Z + math.sin(angle) * r
			)
			ball.Color = ballColor
			ball.Transparency = 0
		end
	end

	for i = ballCount + 1, MAX_BALLS do
		if balls[i] then balls[i].Transparency = 1 end
	end
end)

-- ========== 穿墙 ==========
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

-- ========== 无摔伤 ==========
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

-- ========== FPS ==========
local lastTick = tick()
RunService.RenderStepped:Connect(function()
	local now = tick()
	local fps = math.floor(1 / (now - lastTick))
	lastTick = now
	FPSDisplay.Text = "FPS: " .. tostring(fps)
end)

-- ========== displayRadius 和 currentCenter 声明（小球环用） ==========
local displayRadius = 50
local currentCenter = nil

-- ========== 按钮逻辑 ==========
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

BallRingButton.MouseButton1Click:Connect(function()
	if ballAnimating then return end
	if not ballRingEnabled then
		ballRingEnabled = true
		ballAnimDirection = 1
		ballAnimProgress = 0
		ballAnimating = true
		BallRingButton.Text = "小球环绕 开"
		BallRingButton.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
	else
		ballAnimDirection = -1
		ballAnimating = true
		BallRingButton.Text = "小球环绕 关"
		BallRingButton.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
	end
	playSound("12221967")
end)

-- 半径
local function setRadius(val)
	local n = tonumber(val)
	if not n then n = radius end
	radius = math.clamp(math.floor(n), 10, 100)
	RadiusBox.Text = "半径: " .. radius
end
DecreaseRadius.MouseButton1Click:Connect(function() setRadius(radius - 5) playSound("12221967") end)
IncreaseRadius.MouseButton1Click:Connect(function() setRadius(radius + 5) playSound("12221967") end)
RadiusBox.FocusLost:Connect(function()
	local input = RadiusBox.Text:match("%d+")
	setRadius(input or radius)
end)

-- 速度
local function setSpeed(val)
	local n = tonumber(val)
	if not n then n = rotationSpeed end
	rotationSpeed = math.clamp(math.floor(n), 1, 100)
	SpeedBox.Text = "速度: " .. rotationSpeed
end
DecreaseSpeed.MouseButton1Click:Connect(function() setSpeed(rotationSpeed - 1) playSound("12221967") end)
IncreaseSpeed.MouseButton1Click:Connect(function() setSpeed(rotationSpeed + 1) playSound("12221967") end)
SpeedBox.FocusLost:Connect(function()
	local input = SpeedBox.Text:match("%d+")
	setSpeed(input or rotationSpeed)
end)

-- 小球数量
local function setBallCount(val)
	local n = tonumber(val)
	if not n then n = ballCount end
	ballCount = math.clamp(math.floor(n), 30, MAX_BALLS)
	BallCountBox.Text = "数量: " .. ballCount
end
DecreaseBallCount.MouseButton1Click:Connect(function() setBallCount(ballCount - 5) playSound("12221967") end)
IncreaseBallCount.MouseButton1Click:Connect(function() setBallCount(ballCount + 5) playSound("12221967") end)
BallCountBox.FocusLost:Connect(function()
	local input = BallCountBox.Text:match("%d+")
	setBallCount(input or ballCount)
end)

-- 穿墙
NoclipButton.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	NoclipButton.Text = noclipEnabled and "取消穿墙" or "穿墙"
	NoclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(139, 69, 19)
	if noclipEnabled then enableNoclip() else disableNoclip() end
	playSound("12221967")
end)

-- 无摔伤
NoFallButton.MouseButton1Click:Connect(function()
	noFall(LocalPlayer.Character)
	LocalPlayer.CharacterAdded:Connect(noFall)
	playSound("12221967")
end)
