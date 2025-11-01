local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- =====================================================
-- 界面创建
-- =====================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "超级环绕部件GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 320)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- 标题栏
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 0, 28)
Title.Position = UDim2.new(0, 3, 0, 3)
Title.Text = "部件环绕者"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(0, 204, 204)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- 最小化按钮
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 24, 0, 24)
MinimizeButton.Position = UDim2.new(1, -54.75, 0, 5)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.Parent = MainFrame

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(1, 0)
MinimizeCorner.Parent = MinimizeButton

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -28, 0, 5)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 内容容器
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -12, 1, -38)
ContentFrame.Position = UDim2.new(0, 6, 0, 34)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- =====================================================
-- 配置和状态
-- =====================================================
-- 环绕配置
local config = {
    enabled = false,
    radius = 50,
    height = 10,
    rotationSpeed = 10,
    attractionStrength = 1000,
    targetMode = "player",
    targetPlayer = nil,
    targetPart = nil,
    orbitPattern = "circle",
    spiralGrowth = 0.1,
    ellipseRatio = 0.6,
    figure8Scale = 0.5,
    starPoints = 5,
    starInnerRadius = 0.5,
    color = Color3.fromRGB(0, 255, 255)
}

local partSelectionActive = false
local currentOutline = nil

local function saveConfig()
    local configStr = HttpService:JSONEncode(config)
    writefile("超级环绕部件配置.txt", configStr)
end

local function loadConfig()
    if isfile("超级环绕部件配置.txt") then
        local configStr = readfile("超级环绕部件配置.txt")
        local loadedConfig = HttpService:JSONDecode(configStr)
        if type(loadedConfig) == "table" then
            for key, value in pairs(loadedConfig) do
                config[key] = value
            end
        end
    end
end

loadConfig()

-- =====================================================
-- 环绕模式
-- =====================================================
local orbitPatterns = {
    circle = "圆形",
    ellipse = "椭圆",
    figure8 = "八字形",
    spiral = "螺旋",
    helix = "螺旋上升",
    wave = "波浪",
    star = "星形",
    flower = "花朵",
    infinity = "无限符号",
    random = "随机"
}

-- =====================================================
-- 界面控件
-- =====================================================
-- 环绕开关按钮
local RingToggleButton = Instance.new("TextButton")
RingToggleButton.Size = UDim2.new(0, 48, 0, 32)
RingToggleButton.Position = UDim2.new(0, 0, 0, 0)
RingToggleButton.Text = config.enabled and "开启" or "关闭"
RingToggleButton.BackgroundColor3 = config.enabled and Color3.fromRGB(70, 200, 70) or Color3.fromRGB(255, 70, 70)
RingToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RingToggleButton.Font = Enum.Font.GothamBold
RingToggleButton.TextSize = 11
RingToggleButton.Parent = ContentFrame

local RingToggleCorner = Instance.new("UICorner")
RingToggleCorner.CornerRadius = UDim.new(0, 16)
RingToggleCorner.Parent = RingToggleButton

RingToggleButton.MouseButton1Click:Connect(function()
    config.enabled = not config.enabled
    RingToggleButton.Text = config.enabled and "开启" or "关闭"
    RingToggleButton.BackgroundColor3 = config.enabled and Color3.fromRGB(70, 200, 70) or Color3.fromRGB(255, 70, 70)
    saveConfig()
end)

-- 模式切换图标按钮
local ModeToggleButton = Instance.new("ImageButton")
ModeToggleButton.Size = UDim2.new(0, 32, 0, 32)
ModeToggleButton.Position = UDim2.new(0, 52, 0, 0)
ModeToggleButton.BackgroundColor3 = config.targetMode == "player" and Color3.fromRGB(100, 100, 200) or Color3.fromRGB(200, 100, 100)
ModeToggleButton.BorderSizePixel = 0
ModeToggleButton.Image = config.targetMode == "player" and "rbxthumb://type=Asset&id=117259180607823&w=150&h=150" or "rbxthumb://type=Asset&id=1248298703&w=150&h=150"
ModeToggleButton.Parent = ContentFrame

local ModeToggleCorner = Instance.new("UICorner")
ModeToggleCorner.CornerRadius = UDim.new(1, 0)
ModeToggleCorner.Parent = ModeToggleButton

ModeToggleButton.MouseButton1Click:Connect(function()
    if config.targetMode == "player" then
        config.targetMode = "part"
        ModeToggleButton.Image = "rbxthumb://type=Asset&id=1248298703&w=150&h=150"
        ModeToggleButton.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
    else
        config.targetMode = "player"
        ModeToggleButton.Image = "rbxthumb://type=Asset&id=117259180607823&w=150&h=150"
        ModeToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
    end
    updateGUI()
    saveConfig()
end)

-- 玩家名称输入框
local PlayerNameBox = Instance.new("TextBox")
PlayerNameBox.Size = UDim2.new(1, -144, 0, 32)
PlayerNameBox.Position = UDim2.new(0, 88, 0, 0)
PlayerNameBox.Text = config.targetPlayer and config.targetPlayer.Name or ""
PlayerNameBox.PlaceholderText = "输入玩家名称..."
PlayerNameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
PlayerNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerNameBox.Font = Enum.Font.Gotham
PlayerNameBox.TextSize = 11
PlayerNameBox.Visible = config.targetMode == "player"
PlayerNameBox.Parent = ContentFrame

local PlayerNameBoxCorner = Instance.new("UICorner")
PlayerNameBoxCorner.CornerRadius = UDim.new(0, 6)
PlayerNameBoxCorner.Parent = PlayerNameBox

PlayerNameBox.FocusLost:Connect(function()
    config.targetPlayer = findPlayer(PlayerNameBox.Text)
    saveConfig()
end)

-- 部件选择按钮
local PartSelectionButton = Instance.new("TextButton")
PartSelectionButton.Size = UDim2.new(1, -144, 0, 32)
PartSelectionButton.Position = UDim2.new(0, 88, 0, 0)
PartSelectionButton.Text = config.targetPart and ("已选择: " .. config.targetPart.Name) or "点击选择部件"
PartSelectionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
PartSelectionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PartSelectionButton.Font = Enum.Font.Gotham
PartSelectionButton.TextSize = 10
PartSelectionButton.Visible = config.targetMode == "part"
PartSelectionButton.Parent = ContentFrame

local PartSelectionButtonCorner = Instance.new("UICorner")
PartSelectionButtonCorner.CornerRadius = UDim.new(0, 6)
PartSelectionButtonCorner.Parent = PartSelectionButton

PartSelectionButton.MouseButton1Click:Connect(function()
    partSelectionActive = true
    PartSelectionButton.Text = "选择中... 点击一个部件"
    PartSelectionButton.BackgroundColor3 = Color3.fromRGB(50, 125, 50)
end)

-- 环绕模式下拉菜单
local PatternLabel = Instance.new("TextLabel")
PatternLabel.Size = UDim2.new(0, 100, 0, 20)
PatternLabel.Position = UDim2.new(0, 0, 0, 40)
PatternLabel.Text = "环绕模式:"
PatternLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PatternLabel.BackgroundTransparency = 1
PatternLabel.Font = Enum.Font.Gotham
PatternLabel.TextSize = 10
PatternLabel.TextXAlignment = Enum.TextXAlignment.Left
PatternLabel.Parent = ContentFrame

local PatternDropdown = Instance.new("TextButton")
PatternDropdown.Size = UDim2.new(0, 100, 0, 24)
PatternDropdown.Position = UDim2.new(0, 0, 0, 60)
PatternDropdown.Text = orbitPatterns[config.orbitPattern]
PatternDropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
PatternDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
PatternDropdown.Font = Enum.Font.Gotham
PatternDropdown.TextSize = 10
PatternDropdown.ZIndex = 10
PatternDropdown.Parent = ContentFrame

local PatternDropdownCorner = Instance.new("UICorner")
PatternDropdownCorner.CornerRadius = UDim.new(0, 6)
PatternDropdownCorner.Parent = PatternDropdown

local PatternList = Instance.new("ScrollingFrame")
PatternList.Size = UDim2.new(0, 100, 0, 120)
PatternList.Position = UDim2.new(0, 0, 0, 84)
PatternList.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
PatternList.BorderSizePixel = 0
PatternList.Visible = false
PatternList.ScrollBarThickness = 4
PatternList.ZIndex = 10
PatternList.Parent = ContentFrame

local PatternListCorner = Instance.new("UICorner")
PatternListCorner.CornerRadius = UDim.new(0, 6)
PatternListCorner.Parent = PatternList

-- 填充模式列表
local patternY = 0
for patternKey, patternName in pairs(orbitPatterns) do
    local PatternOption = Instance.new("TextButton")
    PatternOption.Size = UDim2.new(1, -4, 0, 20)
    PatternOption.Position = UDim2.new(0, 2, 0, patternY)
    PatternOption.Text = patternName
    PatternOption.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
    PatternOption.TextColor3 = Color3.fromRGB(255, 255, 255)
    PatternOption.Font = Enum.Font.Gotham
    PatternOption.TextSize = 10
    PatternOption.ZIndex = 10
    PatternOption.Parent = PatternList
    
    local PatternOptionCorner = Instance.new("UICorner")
    PatternOptionCorner.CornerRadius = UDim.new(0, 4)
    PatternOptionCorner.Parent = PatternOption
    
    PatternOption.MouseButton1Click:Connect(function()
        config.orbitPattern = patternKey
        PatternDropdown.Text = patternName
        PatternList.Visible = false
        updateGUI()
        saveConfig()
    end)
    
    patternY = patternY + 22
end

PatternList.CanvasSize = UDim2.new(0, 0, 0, patternY)

PatternDropdown.MouseButton1Click:Connect(function()
    PatternList.Visible = not PatternList.Visible
end)

-- 颜色选择器
local ColorLabel = Instance.new("TextLabel")
ColorLabel.Size = UDim2.new(0, 100, 0, 20)
ColorLabel.Position = UDim2.new(0, 110, 0, 40)
ColorLabel.Text = "环绕颜色:"
ColorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ColorLabel.BackgroundTransparency = 1
ColorLabel.Font = Enum.Font.Gotham
ColorLabel.TextSize = 10
ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
ColorLabel.Parent = ContentFrame

local ColorButton = Instance.new("TextButton")
ColorButton.Size = UDim2.new(0, 100, 0, 24)
ColorButton.Position = UDim2.new(0, 110, 0, 60)
ColorButton.Text = ""
ColorButton.BackgroundColor3 = config.color
ColorButton.BorderSizePixel = 0
ColorButton.Parent = ContentFrame

local ColorButtonCorner = Instance.new("UICorner")
ColorButtonCorner.CornerRadius = UDim.new(0, 6)
ColorButtonCorner.Parent = ColorButton

ColorButton.MouseButton1Click:Connect(function()
    -- 简单颜色选择器 - 循环切换预设颜色
    local colors = {
        Color3.fromRGB(0, 255, 255),
        Color3.fromRGB(255, 0, 255),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(255, 128, 0),
        Color3.fromRGB(128, 0, 255),
        Color3.fromRGB(0, 255, 128)
    }
    
    local currentIndex = 1
    for i, color in ipairs(colors) do
        if (color.R - config.color.R) < 0.01 and (color.G - config.color.G) < 0.01 and (color.B - config.color.B) < 0.01 then
            currentIndex = i
            break
        end
    end
    
    local nextIndex = (currentIndex % #colors) + 1
    config.color = colors[nextIndex]
    ColorButton.BackgroundColor3 = config.color
    saveConfig()
end)

-- 控制部分（2列布局）
local currentY = 220

local function createControl(name, color, labelText, defaultValue, callback, column)
    local xPos = column == 1 and 0 or 110
    
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 100, 0, 50)
    Container.Position = UDim2.new(0, xPos, 0, currentY)
    Container.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Container.BorderSizePixel = 0
    Container.Parent = ContentFrame
    
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 6)
    ContainerCorner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -8, 0, 14)
    Label.Position = UDim2.new(0, 4, 0, 2)
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 10
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local DecreaseButton = Instance.new("TextButton")
    DecreaseButton.Size = UDim2.new(0, 26, 0, 28)
    DecreaseButton.Position = UDim2.new(0, 4, 0, 18)
    DecreaseButton.Text = "-"
    DecreaseButton.BackgroundColor3 = color
    DecreaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DecreaseButton.Font = Enum.Font.GothamBold
    DecreaseButton.TextSize = 14
    DecreaseButton.Parent = Container
    
    local DecreaseCorner = Instance.new("UICorner")
    DecreaseCorner.CornerRadius = UDim.new(0, 4)
    DecreaseCorner.Parent = DecreaseButton
    
    local ValueBox = Instance.new("TextBox")
    ValueBox.Size = UDim2.new(0, 40, 0, 28)
    ValueBox.Position = UDim2.new(0, 32, 0, 18)
    ValueBox.Text = tostring(defaultValue)
    ValueBox.PlaceholderText = "..."
    ValueBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueBox.Font = Enum.Font.Gotham
    ValueBox.TextSize = 11
    ValueBox.Parent = Container
    
    local ValueBoxCorner = Instance.new("UICorner")
    ValueBoxCorner.CornerRadius = UDim.new(0, 4)
    ValueBoxCorner.Parent = ValueBox
    
    local IncreaseButton = Instance.new("TextButton")
    IncreaseButton.Size = UDim2.new(0, 26, 0, 28)
    IncreaseButton.Position = UDim2.new(0, 74, 0, 18)
    IncreaseButton.Text = "+"
    IncreaseButton.BackgroundColor3 = color
    IncreaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    IncreaseButton.Font = Enum.Font.GothamBold
    IncreaseButton.TextSize = 14
    IncreaseButton.Parent = Container
    
    local IncreaseCorner = Instance.new("UICorner")
    IncreaseCorner.CornerRadius = UDim.new(0, 4)
    IncreaseCorner.Parent = IncreaseButton
    
    DecreaseButton.MouseButton1Click:Connect(function()
        local value = tonumber(ValueBox.Text) or defaultValue
        local minValue = name == "高度" and -10000 or 0
        value = math.max(minValue, value - 10)
        ValueBox.Text = tostring(value)
        callback(value)
        saveConfig()
    end)
    
    IncreaseButton.MouseButton1Click:Connect(function()
        local value = tonumber(ValueBox.Text) or defaultValue
        value = math.min(10000, value + 10)
        ValueBox.Text = tostring(value)
        callback(value)
        saveConfig()
    end)
    
    ValueBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local newValue = tonumber(ValueBox.Text)
            if newValue then
                local minValue = name == "高度" and -10000 or 0
                newValue = math.clamp(newValue, minValue, 10000)
                ValueBox.Text = tostring(newValue)
                callback(newValue)
                saveConfig()
            else
                ValueBox.Text = tostring(defaultValue)
            end
        end
    end)
end

-- 更新界面的函数
function updateGUI()
    -- 更新玩家/部件输入的可见性
    PlayerNameBox.Visible = config.targetMode == "player"
    PartSelectionButton.Visible = config.targetMode == "part"
    
    -- 更新模式下拉菜单
    PatternDropdown.Text = orbitPatterns[config.orbitPattern]
    
    -- 清除现有控件
    for _, child in pairs(ContentFrame:GetChildren()) do
        if child:IsA("Frame") and child.Position.Y.Offset >= 220 then
            child:Destroy()
        end
    end
    
    -- 根据模式重新创建控件
    currentY = 220
    
    -- 第1行: 尺寸 | 速度
    createControl("尺寸", Color3.fromRGB(100, 150, 200), "尺寸", config.radius, function(value)
        config.radius = value
    end, 1)
    
    createControl("旋转速度", Color3.fromRGB(100, 200, 150), "速度", config.rotationSpeed, function(value)
        config.rotationSpeed = value
    end, 2)
    
    -- 第2行: 高度 | 强度
    currentY = 280
    createControl("高度", Color3.fromRGB(150, 100, 200), "高度", config.height, function(value)
        config.height = value
    end, 1)
    
    createControl("吸引力强度", Color3.fromRGB(200, 100, 100), "强度", config.attractionStrength, function(value)
        config.attractionStrength = value
    end, 2)
    
    -- 第3行: 模式特定控件
    currentY = 340
    
    if config.orbitPattern == "ellipse" then
        createControl("椭圆比例", Color3.fromRGB(200, 150, 100), "椭圆比例", config.ellipseRatio * 100, function(value)
            config.ellipseRatio = value / 100
        end, 1)
    elseif config.orbitPattern == "figure8" then
        createControl("八字形缩放", Color3.fromRGB(200, 150, 100), "缩放", config.figure8Scale * 100, function(value)
            config.figure8Scale = value / 100
        end, 1)
    elseif config.orbitPattern == "spiral" then
        createControl("螺旋增长", Color3.fromRGB(200, 150, 100), "增长率", config.spiralGrowth * 100, function(value)
            config.spiralGrowth = value / 100
        end, 1)
    elseif config.orbitPattern == "helix" then
        createControl("螺旋高度", Color3.fromRGB(200, 150, 100), "螺旋高度", config.helixHeight or 20, function(value)
            config.helixHeight = value
        end, 1)
    elseif config.orbitPattern == "wave" then
        createControl("波浪幅度", Color3.fromRGB(200, 150, 100), "幅度", config.waveAmplitude or 10, function(value)
            config.waveAmplitude = value
        end, 1)
    elseif config.orbitPattern == "star" then
        createControl("星形点数", Color3.fromRGB(200, 150, 100), "顶点数", config.starPoints or 5, function(value)
            config.starPoints = value
        end, 1)
        createControl("星形内径", Color3.fromRGB(150, 200, 100), "内径比例", config.starInnerRadius * 100, function(value)
            config.starInnerRadius = value / 100
        end, 2)
    elseif config.orbitPattern == "flower" then
        createControl("花朵花瓣", Color3.fromRGB(200, 150, 100), "花瓣数", config.flowerPetals or 6, function(value)
            config.flowerPetals = value
        end, 1)
    elseif config.orbitPattern == "infinity" then
        createControl("无限符号缩放", Color3.fromRGB(200, 150, 100), "缩放", config.infinityScale or 0.5, function(value)
            config.infinityScale = value
        end, 1)
    end
end

-- 初始化界面
updateGUI()

-- 最小化功能
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 280, 0, 32), "Out", "Quad", 0.3, true)
        MinimizeButton.Text = "+"
        ContentFrame.Visible = false
    else
        MainFrame:TweenSize(UDim2.new(0, 280, 0, 320), "Out", "Quad", 0.3, true)
        MinimizeButton.Text = "-"
        ContentFrame.Visible = true
    end
end)

-- 使界面可拖动
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
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- =====================================================
-- 核心逻辑
-- =====================================================

-- 玩家查找函数
local function findPlayer(name)
    if name == "" then
        return LocalPlayer
    end
    
    name = name:lower()
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Name:lower():find(name) or player.DisplayName:lower():find(name) then
            return player
        end
    end
    
    return LocalPlayer
end

-- 用鼠标选择部件
local Mouse = LocalPlayer:GetMouse()
Mouse.Button1Down:Connect(function()
    if partSelectionActive then
        local target = Mouse.Target
        if target and target:IsA("BasePart") then
            config.targetPart = target
            partSelectionActive = false
            updateGUI()
            
            if currentOutline then
                currentOutline:Destroy()
            end
            
            currentOutline = Instance.new("SelectionBox")
            currentOutline.Adornee = target
            currentOutline.LineThickness = 0.05
            currentOutline.Color3 = config.color
            currentOutline.Parent = target
        end
    end
end)

-- =====================================================
-- 网络和部件追踪
-- =====================================================
if not getgenv().Network then
    getgenv().Network = {
        BaseParts = {},
        Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
    }

    Network.RetainPart = function(Part)
        if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(workspace) then
            table.insert(Network.BaseParts, Part)
            Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        end
    end

    local function EnablePartControl()
        LocalPlayer.ReplicationFocus = workspace
        RunService.Heartbeat:Connect(function()
            sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
            for _, Part in pairs(Network.BaseParts) do
                if Part:IsDescendantOf(workspace) then
                    Part.Velocity = Network.Velocity
                end
            end
        end)
    end

    EnablePartControl()
end

-- 优化：使用字典/集合进行更快的查找和移除
local trackedParts = {}
local originalCollisions = {}

local function RetainPart(part)
    if part:IsA("BasePart") and not part.Anchored and part:IsDescendantOf(workspace) then
        if part.Parent == LocalPlayer.Character or part:IsDescendantOf(LocalPlayer.Character) then
            return false
        end
        part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        return true
    end
    return false
end

local function addPart(part)
    if RetainPart(part) then
        if not trackedParts[part] then
            trackedParts[part] = true
            originalCollisions[part] = part.CanCollide
        end
    end
end

local function removePart(part)
    if trackedParts[part] then
        trackedParts[part] = nil
        originalCollisions[part] = nil
    end
end

-- 优化：在单独的任务中运行初始扫描，避免在加载时冻结游戏
task.spawn(function()
    for _, part in pairs(workspace:GetDescendants()) do
        addPart(part)
    end
end)

workspace.DescendantAdded:Connect(addPart)
workspace.DescendantRemoving:Connect(removePart)

-- =====================================================
-- 环绕模式计算
-- =====================================================
local function calculateOrbitPosition(partPos, targetCenter, time)
    local angleIncrement = math.rad(config.rotationSpeed)
    local angle = math.atan2(partPos.Z - targetCenter.Z, partPos.X - targetCenter.X)
    local newAngle = angle + angleIncrement
    
    local targetPos
    
    if config.orbitPattern == "circle" then
        targetPos = Vector3.new(
            targetCenter.X + math.cos(newAngle) * config.radius,
            targetCenter.Y + config.height,
            targetCenter.Z + math.sin(newAngle) * config.radius
        )
    elseif config.orbitPattern == "ellipse" then
        targetPos = Vector3.new(
            targetCenter.X + math.cos(newAngle) * config.radius,
            targetCenter.Y + config.height,
            targetCenter.Z + math.sin(newAngle) * config.radius * config.ellipseRatio
        )
    elseif config.orbitPattern == "figure8" then
        targetPos = Vector3.new(
            targetCenter.X + math.sin(newAngle) * config.radius,
            targetCenter.Y + config.height,
            targetCenter.Z + math.sin(newAngle * 2) * config.radius * config.figure8Scale
        )
    elseif config.orbitPattern == "spiral" then
        local spiralRadius = config.radius + (time % 10) * config.spiralGrowth
        targetPos = Vector3.new(
            targetCenter.X + math.cos(newAngle) * spiralRadius,
            targetCenter.Y + config.height,
            targetCenter.Z + math.sin(newAngle) * spiralRadius
        )
    elseif config.orbitPattern == "helix" then
        local helixHeight = config.height + math.sin(newAngle * 2) * (config.helixHeight or 20)
        targetPos = Vector3.new(
            targetCenter.X + math.cos(newAngle) * config.radius,
            targetCenter.Y + helixHeight,
            targetCenter.Z + math.sin(newAngle) * config.radius
        )
    elseif config.orbitPattern == "wave" then
        local waveHeight = config.height + math.sin(newAngle * 3) * (config.waveAmplitude or 10)
        targetPos = Vector3.new(
            targetCenter.X + math.cos(newAngle) * config.radius,
            targetCenter.Y + waveHeight,
            targetCenter.Z + math.sin(newAngle) * config.radius
        )
    elseif config.orbitPattern == "star" then
        local points = config.starPoints or 5
        local innerRadius = config.radius * (config.starInnerRadius or 0.5)
        local angleStep = (math.pi * 2) / points
        local pointIndex = math.floor(newAngle / angleStep) % points
        local nextPointIndex = (pointIndex + 1) % points
        local localAngle = newAngle % angleStep
        local t = localAngle / angleStep
        
        -- 在外半径和内半径之间插值
        local radius = innerRadius
        if pointIndex % 2 == 0 then
            radius = innerRadius + (config.radius - innerRadius) * (1 - math.abs(t * 2 - 1))
        else
            radius = config.radius - (config.radius - innerRadius) * (1 - math.abs(t * 2 - 1))
        end
        
        targetPos = Vector3.new(
            targetCenter.X + math.cos(newAngle) * radius,
            targetCenter.Y + config.height,
            targetCenter.Z + math.sin(newAngle) * radius
        )
    elseif config.orbitPattern == "flower" then
        local petals = config.flowerPetals or 6
        local petalFrequency = petals / 2
        local radiusVariation = math.sin(newAngle * petalFrequency) * 0.4 + 0.6
        targetPos = Vector3.new(
            targetCenter.X + math.cos(newAngle) * config.radius * radiusVariation,
            targetCenter.Y + config.height,
            targetCenter.Z + math.sin(newAngle) * config.radius * radiusVariation
        )
    elseif config.orbitPattern == "infinity" then
        local scale = config.infinityScale or 0.5
        local t = newAngle / math.pi
        targetPos = Vector3.new(
            targetCenter.X + config.radius * math.cos(newAngle) / (1 + math.sin(newAngle) * math.sin(newAngle)),
            targetCenter.Y + config.height,
            targetCenter.Z + config.radius * math.sin(newAngle) * math.cos(newAngle) / (1 + math.sin(newAngle) * math.sin(newAngle)) * scale
        )
    elseif config.orbitPattern == "random" then
        local randomOffset = Vector3.new(
            math.random(-10, 10),
            math.random(-10, 10),
            math.random(-10, 10)
        )
        targetPos = Vector3.new(
            targetCenter.X + math.cos(newAngle) * config.radius + randomOffset.X,
            targetCenter.Y + config.height + randomOffset.Y,
            targetCenter.Z + math.sin(newAngle) * config.radius + randomOffset.Z
        )
    else
        -- 默认使用圆形
        targetPos = Vector3.new(
            targetCenter.X + math.cos(newAngle) * config.radius,
            targetCenter.Y + config.height,
            targetCenter.Z + math.sin(newAngle) * config.radius
        )
    end
    
    return targetPos
end

-- =====================================================
-- 主循环（优化版）
-- =====================================================
RunService.Heartbeat:Connect(function()
    if not config.enabled then return end
    
    local targetCenter
    
    -- 确定目标位置
    if config.targetMode == "player" then
        local targetPlayer = config.targetPlayer or LocalPlayer
        if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            targetCenter = targetPlayer.Character.HumanoidRootPart.Position
        end
    elseif config.targetMode == "part" then
        if config.targetPart and config.targetPart.Parent then
            targetCenter = config.targetPart.Position
        end
    end
    
    -- 如果找不到目标，则回退到本地玩家
    if not targetCenter then
        local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            targetCenter = humanoidRootPart.Position
        else
            return -- 如果找不到任何目标则退出
        end
    end

    -- 优化：预先计算此帧中所有部件相同的值
    local effectiveRadius = config.radius
    local maxDistance = effectiveRadius * 1.5 -- 优化：添加缓冲区以防止部件弹出/消失
    local currentTime = tick()

    -- 优化：使用新的字典式表进行迭代
    for part, _ in pairs(trackedParts) do
        if part and part.Parent and not part.Anchored then
            local partPos = part.Position
            
            -- 优化：添加距离检查。如果部件太远，完全忽略它
            local distanceFromTarget = (partPos - targetCenter).Magnitude
            if distanceFromTarget > maxDistance then
                continue -- 这个部件太远，跳到下一个
            end
            
            -- 根据环绕模式计算目标位置
            local targetPos = calculateOrbitPosition(partPos, targetCenter, currentTime)
            
            -- 应用速度
            local directionToTarget = (targetPos - partPos).unit
            part.Velocity = directionToTarget * config.attractionStrength
            
            -- 确保无碰撞
            part.CanCollide = false
        end
    end
end)
