local UserInputService = game:GetService("UserInputService")

local function CreateGUI(title)
    local gui = Instance.new("ScreenGui")
    gui.Name = "MyGUI"
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 10
    gui.Parent = game.Players.LocalPlayer.PlayerGui
    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.BackgroundTransparency = 0
    frame.BackgroundColor3 = Color3.fromRGB(240, 248, 255)
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new(0, 110, 0, -20) 
    frame.Size = UDim2.new(0, 500, 0, 280)
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local dragging = false
    local startPos, startOffset

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = input.Position
            startOffset = frame.Position
            gui.Active = true 
        end
    end)

    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            startPos = nil
            startOffset = nil
            gui.Active = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - startPos
            frame.Position = UDim2.new(startOffset.X.Scale, startOffset.X.Offset + delta.X, startOffset.Y.Scale,  
                startOffset.Y.Offset + delta.Y)
        end
    end)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0.05, 0.15 * frame.Size.Y.Offset)
    titleLabel.Position = UDim2.new(0, 0, 0.01, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(0, 0, 0)
    titleLabel.TextSize = math.floor(frame.Size.Y.Offset * 0.1)
    titleLabel.Parent = frame
    local disagreeButton = Instance.new("TextButton")
    disagreeButton.Name = "DisagreeButton"
    disagreeButton.Size = UDim2.new(0, 0.4 * frame.Size.X.Offset, 0, 0.15 * frame.Size.Y.Offset)
    disagreeButton.Position = UDim2.new(0, 0.1 * frame.Size.X.Offset, 0,
        frame.Size.Y.Offset - 0.25 * frame.Size.Y.Offset)
    disagreeButton.BackgroundTransparency = 0
    disagreeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    disagreeButton.Text = "不同意"
    disagreeButton.TextColor3 = Color3.new(255, 0, 0)
    disagreeButton.TextSize = math.floor(frame.Size.Y.Offset * 0.08)
    disagreeButton.Font = Enum.Font.SourceSans
    disagreeButton.Parent = frame
    local disagreeCorner = Instance.new("UICorner")
    disagreeCorner.CornerRadius = UDim.new(0, 10)
    disagreeCorner.Parent = disagreeButton

    local agreeButton = Instance.new("TextButton")
    agreeButton.Name = "AgreeButton"
    agreeButton.Size = UDim2.new(0, 0.4 * frame.Size.X.Offset, 0, 0.15 * frame.Size.Y.Offset)
    agreeButton.Position = UDim2.new(0, frame.Size.X.Offset - 0.5 * frame.Size.X.Offset, 0,
        frame.Size.Y.Offset - 0.25 * frame.Size.Y.Offset)
    agreeButton.BackgroundTransparency = 0
    agreeButton.BackgroundColor3 = Color3.fromRGB(106, 159, 255)
    agreeButton.Text = "同意"
    agreeButton.TextColor3 = Color3.new(255, 255, 255)
    agreeButton.TextSize = math.floor(frame.Size.Y.Offset * 0.08)
    agreeButton.Font = Enum.Font.SourceSans 
    agreeButton.Parent = frame

    
    local agreeFrame = Instance.new("TextLabel")
    agreeFrame.Size = UDim2.new(0.8, 0, 0.5, 0)
    agreeFrame.Position = UDim2.new(0.1, 0, 0.22, 0)
    agreeFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    agreeFrame.Text = "1.账号封禁,我概不负责.\n  2.请不要为脚本招黑"
    agreeFrame.TextWrapped = true

    
    agreeFrame.TextSize = 16  


    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = agreeFrame

    agreeFrame.Parent = frame

    local agreeCorner = Instance.new("UICorner")
    agreeCorner.CornerRadius = UDim.new(0, 10)
    agreeCorner.Parent = agreeButton
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 40, 0, 40)
    minimizeButton.Position = UDim2.new(1, -65, 0, 10)
    minimizeButton.BackgroundTransparency = 0
    minimizeButton.BackgroundColor3 = Color3.fromRGB(199, 199, 199)
    minimizeButton.Text = "-"
    minimizeButton.TextSize = 28  
    minimizeButton.TextColor3 = Color3.new(0, 0, 0)
    minimizeButton.Font = Enum.Font.SourceSans
    minimizeButton.Parent = frame

    local isMinimized = false

    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 5)
    minimizeCorner.Parent = minimizeButton

    minimizeButton.MouseButton1Click:Connect(function()
        if isMinimized then
            frame.Size = UDim2.new(0, 500, 0, 280)
            titleLabel.Position = UDim2.new(0, 0, 0.01, 0)
            minimizeButton.Text = "-"
            minimizeButton.TextSize = 28
            isMinimized = false
            disagreeButton.Visible = true
            agreeButton.Visible = true
            agreeFrame.Visible = true
        else
            frame.Size = UDim2.new(0, 500, 0, 60)
            titleLabel.Position = UDim2.new(0, 0, 0, 0)
            minimizeButton.Text = "+"
            minimizeButton.TextSize = 28 
            isMinimized = true
            disagreeButton.Visible = false
            agreeButton.Visible = false
            agreeFrame.Visible = false
        end
    end)

    local function AnimateExit()
        local duration = 1
        local startTime = tick()
        local initialSize = frame.Size
        while (tick() - startTime) < duration do
            local elapsedTime = tick() - startTime
            local scale = 1 - elapsedTime / duration
            frame.Size = UDim2.new(initialSize.X.Scale * scale, initialSize.X.Offset * scale,
                initialSize.Y.Scale * scale, initialSize.Y.Offset * scale)
            frame.Position = frame.Position + UDim2.new((1 - scale) / 2, 0, (1 - scale) / 2, 0)
            wait()
        end
        gui:Destroy()
    end
    disagreeButton.MouseButton1Click:Connect(function()
        AnimateExit()
    end)
    agreeButton.MouseButton1Click:Connect(function()
        AnimateExit()
  
  end)
    agreeButton.MouseButton1Click:Connect(function()
        AnimateExit()

local OrionLib = loadstring(game:HttpGet("https://pastebin.com/raw/FUEx0f3G"))()
local LBLG = Instance.new("ScreenGui", getParent)
local LBL = Instance.new("TextLabel", getParent)
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true
LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 1, 1)
LBL.BackgroundTransparency = 1
LBL.BorderColor3 = Color3.new(0, 0, 0)
LBL.Position = UDim2.new(0.75,0,0.010,0)
LBL.Size = UDim2.new(0, 133, 0, 30)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "TextLabel"
LBL.TextColor3 = Color3.new(1, 1, 1)
LBL.TextScaled = true
LBL.TextSize = 14
LBL.TextWrapped = true
LBL.Visible = true

local FpsLabel = LBL
local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

local function HeartbeatUpdate()
	LastIteration = tick()
	for Index = #FrameUpdateTable, 1, -1 do
		FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
	end
	FrameUpdateTable[1] = LastIteration
	local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
	CurrentFPS = CurrentFPS - CurrentFPS % 1
	FpsLabel.Text = ("小欣时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S"))
end
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)
local Window = OrionLib:MakeWindow({Name = "xiaoX中心", HidePremium = false, SaveConfig = true,IntroText = "小欣脚本", ConfigFolder = "小欣脚本"})
game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "小欣脚本"; Text ="小欣脚本"; Duration = 4; })

local about = Window:MakeTab({
    Name = "小欣制作",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

about:AddParagraph("此脚本为免费脚本")
about:AddParagraph("纯缝合")

local Tab =Window:MakeTab({
	Name = "公告",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "复制作者QQ",
	Callback = function()
     setclipboard("3928145450")
  	end
})

OrionLib:MakeNotification({
	Name = "小欣脚本",
	Content = "欢迎使用小欣中心",
	Image = "rbxassetid://4483345998",
	Time = 2

})

local Tab = Window:MakeTab({

	Name = "DOORS2.0",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "门2.0",

	Callback = function()

loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\89\83\108\111\110\47\82\65\87\45\46\46\97\45\115\99\114\105\112\116\47\109\97\105\110\47\37\69\57\37\57\57\37\56\56\68\79\79\82\83\50\46\48\77\79\79\78\37\69\54\37\66\55\37\66\55\37\69\54\37\66\55\37\56\54\34\41\41\40\41")()

    end

})

local Tab = Window:MakeTab({

    Name = "玩家",

    Icon = "rbxassetid://4483345998",

    PremiumOnly = false

})

local Section = Tab:AddSection({

	Name = "欢迎玩家"

})

Tab:AddSlider({

	Name = "速度",

	Min = 16,

	Max = 200,

	Default = 16,

	Color = Color3.fromRGB(255,255,255),

	Increment = 1,

	ValueName = "数值",

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value

	end    

})

Tab:AddSlider({

	Name = "跳跃高度",

	Min = 50,

	Max = 200,

	Default = 50,

	Color = Color3.fromRGB(255,255,255),

	Increment = 1,

	ValueName = "数值",

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value

	end    

})

Tab:AddTextbox({

	Name = "跳跃高度设置",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value

	end

})

Tab:AddTextbox({

	Name = "移动速度设置",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value

	end

})

Tab:AddTextbox({

	Name = "重力设置",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Workspace.Gravity = Value

	end

})

Tab:AddToggle({

	Name = "夜视",

	Default = false,

	Callback = function(Value)

		if Value then

		    game.Lighting.Ambient = Color3.new(1, 1, 1)

		else

		    game.Lighting.Ambient = Color3.new(0, 0, 0)

		end

	end

})

Tab:AddButton({

	Name = "飞行V3（隐藏）",

	Callback = function()

     loadstring(game:HttpGet('https://pastebin.com/raw/U27yQRxS'))()

  	end    

})

Tab:AddButton({

	Name = "替身",

	Callback = function()

loadstring(game:HttpGet(('https://raw.githubusercontent.com/SkrillexMe/SkrillexLoader/main/SkrillexLoadMain')))()

    end

})

Tab:AddButton({

	Name = "爬墙",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()

end

})

Tab:AddButton({

	Name = "光影V4",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()

end

})

Tab:AddButton({

	Name = "变成蛇",

	Callback = function()

loadstring(game:HttpGet(('https://pastefy.ga/tWBTcE4R/raw'),true))()

	end

})

Tab:AddButton({

	Name = "让别让别人控制自己",

	Callback = function()

loadstring(game:HttpGet(('https://pastefy.ga/a7RTi4un/raw'),true))()

	end

})

Tab:AddButton({

	Name = "点击传送工具",

	Callback = function()

mouse = game.Players.LocalPlayer:GetMouse() tool = Instance.new("Tool") tool.RequiresHandle = false tool.Name = "[FE] TELEPORT TOOL" tool.Activated:connect(function() local pos = mouse.Hit+Vector3.new(0,2.5,0) pos = CFrame.new(pos.X,pos.Y,pos.Z) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos end) tool.Parent = game.Players.LocalPlayer.Backpack

	end

})

Tab:AddButton({

	Name = "全(英文😭)",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/kEq7bdf9"))()

end

})

Tab:AddButton({

	Name = "地岩",

	Callback = function()

loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\98\98\97\109\120\98\98\97\109\120\98\98\97\109\120\47\99\111\100\101\115\112\97\99\101\115\45\98\108\97\110\107\47\109\97\105\110\47\37\69\55\37\57\57\37\66\68\34\41\41\40\41")()

	end

})

Tab:AddButton({

	Name = "dx旧版本",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/DXuwu/test-lol/main/YO.lua"))()

end

})

Tab:AddButton({

	Name = "脚本中心",

	Callback = function()

loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\103\101\109\120\72\119\65\49"))()

end

})

Tab:AddButton({

	Name = "无敌",

	Callback = function()

local lp = game:GetService "Players".LocalPlayer

if lp.Character:FindFirstChild "Head" then

    local char = lp.Character

    char.Archivable = true

    local new = char:Clone()

    new.Parent = workspace

    lp.Character = new

    wait(2)

    local oldhum = char:FindFirstChildWhichIsA "Humanoid"

    local newhum = oldhum:Clone()

    newhum.Parent = char

    newhum.RequiresNeck = false

    oldhum.Parent = nil

    wait(2)

    lp.Character = char

    new:Destroy()

    wait(1)

    newhum:GetPropertyChangedSignal("Health"):Connect(

        function()

            if newhum.Health <= 0 then

                oldhum.Parent = lp.Character

                wait(1)

                oldhum:Destroy()

            end

        end)

    workspace.CurrentCamera.CameraSubject = char

    if char:FindFirstChild "Animate" then

        char.Animate.Disabled = true

        wait(.1)

        char.Animate.Disabled = false

    end

    lp.Character:FindFirstChild "Head":Destroy()

end

end

})

Tab:AddButton({

	Name = "甩飞别人",

	Callback = function()

     loadstring(game:HttpGet("https://pastebin.com/raw/GnvPVBEi"))()

  	end    

})

Tab:AddButton({

	Name = "防止掉线（反挂机）",

	Callback = function()

	print("Anti Afk On")

		local vu = game:GetService("VirtualUser")

		game:GetService("Players").LocalPlayer.Idled:connect(function()

		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)

		   wait(1)

		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)

		end)

  	end

})

Tab:AddButton({

	Name = "透视",

	Callback = function()

     loadstring(game:HttpGet('https://pastebin.com/raw/MA8jhPWT'))()

  	end    

})

Tab:AddButton({

	Name = "吸取全部玩家",

	Callback = function()

     loadstring(game:HttpGet('https://pastebin.com/raw/hQSBGsw2'))()

  	end    

})

Tab:AddButton({

	Name = "人物无敌",

	Callback = function()

     loadstring(game:HttpGet('https://pastebin.com/raw/H3RLCWWZ'))()

	end    

})

Tab:AddButton({

	Name = "隐身(E)",

	Callback = function()

	 loadstring(game:HttpGet('https://pastebin.com/raw/nwGEvkez'))()

  	end    

})

Tab:AddButton({

	Name = "电脑键盘",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()

  	end    

})

Tab:AddButton({

	Name = "飞车(E)(别人看到)",

	Callback = function()

     loadstring(game:HttpGet("https://pastebin.com/raw/G3GnBCyC", true))()

  	end    

})

Tab:AddTextbox({

	Name = "跳跃高度",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value

	end	 

})

Tab:AddTextbox({

	Name = "重力设置",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Workspace.Gravity = Value

	end

})

Tab:AddToggle({

	Name = "穿墙2",

	Default = false,

	Callback = function(Value)

		if Value then

		    Noclip = true

		    Stepped = game.RunService.Stepped:Connect(function()

			    if Noclip == true then

				    for a, b in pairs(game.Workspace:GetChildren()) do

                        if b.Name == game.Players.LocalPlayer.Name then

                            for i, v in pairs(game.Workspace[game.Players.LocalPlayer.Name]:GetChildren()) do

                                if v:IsA("BasePart") then

                                    v.CanCollide = false

                                end

                            end

                        end

                    end

			    else

				    Stepped:Disconnect()

			    end

		    end)

	    else

		    Noclip = false

	    end

	end

})

Tab:AddToggle({

	Name = "夜视",

	Default = false,

	Callback = function(Value)

		if Value then

		    game.Lighting.Ambient = Color3.new(1, 1, 1)

		else

		    game.Lighting.Ambient = Color3.new(0, 0, 0)

		end

	end

})

Tab:AddButton({

	Name = "鼠标（手机非常不建议用）",

	Callback = function()

loadstring(game:HttpGet(('https://pastefy.ga/V75mqzaz/raw'),true))()

	end

})

Tab:AddButton({

	Name = "飞行",

	Callback = function()

loadstring(game:HttpGet('https://pastebin.com/raw/U27yQRxS'))()

	end 

})

Tab:AddButton({

	Name = "跟踪玩家",

	Callback = function()

      	loadstring(game:HttpGet("https://pastebin.com/raw/F9PNLcXk"))()

  	end

})

Tab:AddButton({

	Name = "伪名说话",

	Callback = function()

loadstring(game:HttpGet(('https://pastefy.ga/zCFEwaYq/raw'),true))()

	end 

})

Tab:AddButton({

	Name = "踏空行走",

	Callback = function()

loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()

	end

})

Tab:AddButton({

	Name = "透视",

	Callback = function()

loadstring(game:GetObjects("rbxassetid://10092697033")[1].Source)()

	end 

})

Tab:AddButton({

	Name = "转起来",

	Callback = function()

      	loadstring(game:HttpGet('https://pastebin.com/raw/r97d7dS0', true))()

  	end

})

Tab:AddButton({

	Name = "隐身(E)",

	Callback = function()

	 loadstring(game:HttpGet('https://pastebin.com/raw/nwGEvkez'))()

  	end    

})

Tab:AddButton({

    Name="立即死亡",

    Callback=function()

        game.Players.LocalPlayer.Character.Humanoid.Health=0

    end

})

Tab:AddButton({

	Name = "黑客脚本",

	Callback = function()

loadstring(game: HttpGet("https://raw.githubusercontent.com/BirthScripts/Scripts/main/c00l.lua"))()

    end

})

Tab:AddButton({

	Name = "管理员",

	Callback = function()

loadstring(game: HttpGet(('https://raw.githubusercontent.com/iK4oS/backdoor.exe/master/source.lua'),true))()

    end

})

Tab:AddButton({

    Name="回满血后分服务器可能不可以能用",

    Callback=function()

        game.Players.LocalPlayer.Character.Humanoid.Health=10000

    end

})

Tab:AddButton({

	Name = "键盘",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()

    end

})

Tab:AddButton({

    Name="玩家动作",

    Callback=function()

        getgenv().she="作者小盛蓝免费请勿倒卖"

loadstring(game:HttpGet("https://pastebin.com/raw/Zj4NnKs6"))()

    end

})

local Tab = Window:MakeTab({

    Name = "doors",

    Icon = "rbxassetid://4483345998",

    PremiumOnly = false

})

Tab:AddButton({

	Name = "DX夜",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/DXuwu/test-lol/main/YO.lua"))()

	end

})

Tab:AddButton({

	Name = "脚本",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Darkrai-X/main/Games/Doors"))()

	end

})

Tab:AddButton({

	Name = "超级脚本",

	Callback = function()

loadstring(game: HttpGet("https://raw.githubusercontent.com/Fazedrab/EntitySpawner/main/doors(orionlib).lua"))()

end

})

Tab:AddButton({

	Name = "修改",

	Callback = function()

loadstring(game:HttpGet"https://raw.githubusercontent.com/sponguss/Doors-Entity-Replicator/main/source.lua")()

	end

})

Tab:AddButton({

    Name="微山doors",

    Callback=function()

        --微山doors 2.3.2(愚人节快乐)

loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\117\72\72\112\56\102\122\83"))()

    end

})

Tab:AddButton({

    Name="我的",

    Callback=function()

        loadstring(game:HttpGet("https://pastebin.com/raw/QsCas0t3"))()

    end

})

Tab:AddButton({

    Name="云doors",

    Callback=function()

        loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/EntitySpawner/main/doors(orionlib).lua"))()

    end

})

Tab:AddButton({

	Name = "最不强",

	Callback = function()

     loadstring(game:HttpGet(('https://pastebin.com/raw/R8QMbhzv')))()

  	end    

})

Tab:AddButton({

    Name="白",

    Callback=function()

        _G["白脚本作者修狗"]="xdjhadgdsrfcyefjhsadcctyseyr6432478rudghfvszhxcaheey"loadstring(game:HttpGet(('https://raw.githubusercontent.com/wev666666/baijiaobengV2.0beta/main/%E7%99%BD%E8%84%9A%E6%9C%ACbeta'),true))()

    end

})

local Tab = Window:MakeTab({

    Name = "忍者传奇",

    Icon = "rbxassetid://4483345998",

    PremiumOnly = false

})

Tab:AddButton({

    Name="操你妈不知道",

    Callback=function()

        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptpastebin/raw/main/1"))()

    end

})

Tab:AddButton({

	Name = "忍者传奇",

	Callback = function()

pcall(loadstring(game:HttpGet("https://pastebin.com/raw/2UjrXwTV")))

end

})

Tab:AddButton({

    Name="不知道",

    Callback=function()

        loadstring(game:HttpGet("https://raw.githubusercontent.com/harisiskandar178/5repo/main/script4.lua"))()

    end

})

local Tab = Window:MakeTab({

    Name = "极速传奇",

    Icon = "rbxassetid://4483345998",

    PremiumOnly = false

})

Tab:AddButton({

    Name="青脚本",

    Callback=function()


loadstring(game:HttpGet('https://raw.githubusercontent.com/kkaaccnnbb/money/main/fix'))()

    end

})

Tab:AddButton({

	Name = "脚本二",

	Callback = function()

loadstring(game:HttpGet('\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\98\111\121\115\99\112\47\98\101\116\97\47\109\97\105\110\47\37\69\57\37\56\48\37\57\70\37\69\53\37\66\65\37\65\54\37\69\55\37\56\50\37\66\56\37\69\56\37\66\53\37\66\55\46\108\117\97'))()

    end

})

Tab:AddButton({

	Name = "脚本三",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/TrixAde/Proxima-Hub/main/Main.lua"))()

    end

})

Tab:AddButton({

	Name = "剑客v3——roblox加入群主剑客才可用",

	Callback = function()

jianke_V3 = "作者_初夏"jianke = "剑客QQ群347724155"loadstring(game:HttpGet(('https://raw.githubusercontent.com/jiankeQWQ/jiankeV3/main/jianke_V3')))()

    end

})

local Tab = Window:MakeTab({

	Name = "鲨口求生2",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddDropdown({

	Name = "免费船只",

	Default = "1",

	Options = {"DuckyBoatBeta", "DuckyBoat", "BlueCanopyMotorboat", "BlueWoodenMotorboat", "UnicornBoat", "Jetski", "RedMarlin", "Sloop", "TugBoat", "SmallDinghyMotorboat", "JetskiDonut", "Marlin", "TubeBoat", "FishingBoat", "VikingShip", "SmallWoodenSailboat", "RedCanopyMotorboat", "Catamaran", "CombatBoat", "TourBoat", "Duckmarine", "PartyBoat", "MilitarySubmarine",  "GingerbreadSteamBoat", "Sleigh2022", "Snowmobile", "CruiseShip"},

	Callback = function(Value)

local ohString1 = (Value)

game:GetService("ReplicatedStorage").EventsFolder.BoatSelection.UpdateHostBoat:FireServer(ohString1)

	end    

})

Tab:AddButton({

	Name = "自动杀鲨鱼🦈",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/Sw1ndlerScripts/RobloxScripts/main/Misc%20Scripts/sharkbite2.lua",true))()

  	end    

})

local Tab = Window:MakeTab({

	Name = "能量突击",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "能量突击",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Harley-HUB/Energy-Assault/main/Ene", true))()

    end

})

local Tab = Window:MakeTab({

	Name = "汽车经销大亨",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "英文版",

	Callback = function()

pcall(function()
    repeat wait() until game:IsLoaded()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/03sAlt/BlueLockSeason2/main/README.md"))()
end)

    end

})

local Tab = Window:MakeTab({

	Name = "FE脚本",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "C00lgui",

	Callback = function()

     loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()

  	end    

})

Tab:AddButton({

	Name = "1x1x1x1",

	Callback = function()

     loadstring(game:HttpGet(('https://pastebin.com/raw/JipYNCht'),true))()

  	end    

})

Tab:AddButton({

	Name = "动画中心",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()

  	end    

})

Tab:AddButton({

	Name = "幽灵中心",

	Callback = function()

loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub'))()

    end

})

Tab:AddButton({

	Name = "蜘蛛侠爬墙配合键盘脚本按c",

	Callback = function()

loadstring(game:HttpGet(('https://pastebin.com/raw/2X0hKUgq'),true))()

    end

})

Tab:AddButton({

	Name = "铁拳打死你",

	Callback = function()

loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'),true))()

    end

})

Tab:AddButton({

	Name = "声音播放器",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/GEianeKX"))()

    end

})

Tab:AddButton({

	Name = "NA管理员",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))()

    end

})

local Tab = Window:MakeTab({

	Name = "By手腕",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "掰手腕",

	Callback = function()

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/99d16edc79729a038994f85ce7335971.lua"))()

    end

})

Tab:AddButton({

	Name = "脚本2——Key:ScriptJezz",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/ZhenX201/FE-Infinite-Money-All-Stats/main/source"))()

    end

})

Tab:AddButton({

	Name = "无卡",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/KrzysztofHub/script/main/loader.lua"))()

    end

})

Tab:AddButton({

	Name = "无卡",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/zicus-scripts/SkullHub/main/Loader.lua"))()

    end

})

Tab:AddButton({

	Name = "无卡",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/LOLking123456/wrestle2/main/armsim"))()

    end

})

local Tab = Window:MakeTab({

    Name = "力量传奇",

    Icon = "rbxassetid://4483345998",

    PremiumOnly = false

})

Tab:AddButton({

    Name="修改力量",

    Callback=function()

        loadstring(game:HttpGet('https://raw.githubusercontent.com/jynzl/main/main/Musclas%20Legenos.lua'))()

    end

})

Tab:AddButton({

	Name = "力量传奇Muscle Legend",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/harisiskandar178/Roblox-Script/main/Muscle%20Legend"))()

  	end    

})

Tab:AddButton({

    Name="力量传奇",

    Callback=function()

        loadstring(game:GetObjects("rbxassetid://10048914323")[1].Source)()

    end
})

Tab:AddButton({

	Name = "杯脚本",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/zuohongjian/bjb/main/llcq"))()

    end

})

Tab:AddButton({

	Name = "剑客v3——roblox加入群组剑客才可用",

	Callback = function()

jianke_V3 = "作者_初夏"jianke = "剑客QQ群347724155"loadstring(game:HttpGet(('https://raw.githubusercontent.com/jiankeQWQ/jiankeV3/main/jianke_V3')))()

    end

})

local Tab = Window:MakeTab({

    Name = "彩虹朋友",

    Icon = "rbxassetid://4483345998",

    PremiumOnly = false

})

Tab:AddButton({

    Name="彩虹朋友",

    Callback=function()

        loadstring(game:HttpGet('https://raw.githubusercontent.com/Sempiller/RainbowTool/main/Turkish.lua'))();

    end

})

Tab:AddButton({

	Name = "彩虹朋友2",	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/JNHHGaming/Rainbow-Friends/main/Rainbow%20Friends"))()

  	end    

})

Tab:AddButton({

	Name = "模仿者",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/ttjy9808/THEMIMICNEWMOBILEUINOTBETA/main/README.md"))()

    end

})

local Tab = Window:MakeTab({

	Name = "挂工厂",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "剑客v3——roblox加入群组剑客才可用",

	Callback = function()

jianke_V3 = "作者_初夏"jianke = "剑客QQ群347724155"loadstring(game:HttpGet(('https://raw.githubusercontent.com/jiankeQWQ/jiankeV3/main/jianke_V3')))()

    end

})

Tab:AddButton({

	Name = "兵工厂",

	Callback = function()

loadstring(game:HttpGet(('https://raw.githubusercontent.com/RandomAdamYT/DarkHub/master/Init'), true))()

    end

})

Tab:AddButton({

	Name = "水下世界_白名单已被破",

	Callback = function()

loadstring(game:HttpGet(('https://raw.githubusercontent.com/jiankeQWQ/Fish/main/sx')))()

    end

})

local Tab = Window:MakeTab({

    Name = "大闹监狱（监狱人生）",

    Icon = "rbxassetid://4483345998",

    PremiumOnly = false

})

Tab:AddButton({

	Name = "过于牛逼，谁用谁孤儿的管理员",

	Callback = function()

loadstring(game:HttpGet('https://raw.githubusercontent.com/H17S32/Tiger_Admin/main/Script'))()

  	end    

})

Tab:AddButton({

	Name = "新菜单",

	Callback = function()

     loadstring(game:HttpGet('https://raw.githubusercontent.com/LiverMods/xRawnder/main/HubMoblie'))()

  	end    

})

Tab:AddButton({

	Name = "v1.3",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/Denverrz/scripts/master/PRISONWARE_v1.3.txt"))();

  	end    

})

local Tab = Window:MakeTab({

	Name = "战争大亨",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "脚本1",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/ufouzzed/WarTycoon/main/ByJMaxeyy"))()

    end

})

Tab:AddButton({

	Name = "脚本二",

	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ToraIsMe/ToraIsMe/main/0wartycoon", true))()

    end

})

Tab:AddButton({

	Name = "脚本三",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Nivex123456/War-Tycoon/main/Script"))()

    end

})

Tab:AddButton({

	Name = "剑客v3——roblox加入群组剑客才可用",

	Callback = function()

jianke_V3 = "作者_初夏"jianke = "剑客QQ群347724155"loadstring(game:HttpGet(('https://raw.githubusercontent.com/jiankeQWQ/jiankeV3/main/jianke_V3')))()

    end

})

local Tab = Window:MakeTab({

    Name = "自然灾害模拟器",

    Icon = "rbxassetid://4483345998",

    PremiumOnly = false

})

Tab:AddButton({

	Name = "自然灾害模拟器",

	Callback = function()

loadstring(game:HttpGet("https://gist.githubusercontent.com/TurkOyuncu99/7c75386107937fa006304efd24543ad4/raw/8d759dfcd95d39949c692735cfdf62baec0bf835/cafwetweg", true))() 

end

})

Tab:AddButton({

	Name = "自然灾害",

	Callback = function()

loadstring(game:HttpGet('https://raw.githubusercontent.com/9NLK7/93qjoadnlaknwldk/main/main'))()

    end

})

local Tab = Window:MakeTab({

    Name = "代木大亨",

    Icon = "rbxassetid://4483345998",

    PremiumOnly = false

})

Tab:AddButton({

	Name = "伐木大亨",

	Callback = function()

-- Join to Discord : https://discord.gg/nightfallgui

loadstring(game:HttpGet('https://gist.githubusercontent.com/ItsEcstasy/327b705029ed89fd1be0f8382b3fb04f/raw/07c7beb24aebec0a26f4622c92b593428811db4d/Nightfall1.7-Temp'))()

	end

})

Tab:AddButton({

	Name = "青脚本",

	Callback = function()

loadstring(game:HttpGet('https://raw.githubusercontent.com/kkaaccnnbb/money/main/fix'))()

    end

})

local Tab = Window:MakeTab({

	Name = "动感星期五",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "script一",

	Callback = function()

loadstring(game:HttpGet('https://raw.githubusercontent.com/ShowerHead-FluxTeam/scripts/main/funky-friday-autoplay'))()

    end

})

local Tab = Window:MakeTab({

    Name = "各大脚本",

    Icon = "rbxassetid://4483345998",

    PremiumOnly = false

})

Tab:AddButton({

	Name = "☁脚本",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/LOL/main/%E4%BA%91%E8%84%9A%E6%9C%ACCloud%20script.lua", true))()

  	end

})

Tab:AddButton({

    Name="XC卡密:w",

    Callback=function()

        getgenv().XC="作者XC"

loadstring(game:HttpGet("https://pastebin.com/raw/PAFzYx0F"))()

    end

})

Tab:AddButton({

    Name="龙脚本",

    Callback=function()

        getgenv().long = "龙脚本，加载时间长请耐心"

loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\108\121\121\97\105\110\105\47\108\111\110\47\109\97\105\110\47\108\105\115\119\109\34\41\41\40\41")()

    end

})

Tab:AddButton({

    Name="USA",

    Callback=function()

        getgenv().USA="作者USA免费请勿倒卖"

loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/beta/main/USA.lua"))()

    end

})

Tab:AddButton({

	Name = "青脚本——支持很多游戏",

	Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/kkaaccnnbb/money/main/fix'))()

    end

})

Tab:AddButton({

	Name = "秋脚本",

	Callback = function()

local SCC_CharPool={
[1]= tostring(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,87,83,56,53,55,57,54,48,47,45,47,109,97,105,110,47,37,69,55,37,65,55,37,56,66,37,67,50,37,66,55,37,69,56,37,56,55,37,65,65,37,69,53,37,56,56,37,66,54,37,69,56,37,56,52,37,57,65,37,69,54,37,57,67,37,65,67,37,69,54,37,57,54,37,66,48,37,69,54,37,66,65,37,57,48,37,69,55,37,65,48,37,56,49,46,116,120,116})end)()))}
loadstring(game:HttpGet(SCC_CharPool[1]))()

    end

})

Tab:AddButton({

	Name = "冰脚本",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/GR4ChWKv"))()

    end

})

Tab:AddButton({

	Name = "剑客v3_roblox加入群组剑客才可用",

	Callback = function()

jianke_V3 = "作者_初夏"jianke = "剑客QQ群347724155"loadstring(game:HttpGet(('https://raw.githubusercontent.com/jiankeQWQ/jiankeV3/main/jianke_V3')))()

    end

})

Tab:AddButton({

	Name = "鲨脚本",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/sharksharksharkshark/shark-shark-shark-shark-shark/main/shark-scriptlollol.txt",true))()

    end

})

Tab:AddButton({

	Name = "水下世界支持很多游戏_名单已被破除",

	Callback = function()

loadstring(game:HttpGet(('https://raw.githubusercontent.com/jiankeQWQ/Fish/main/sx')))()

    end

})

Tab:AddButton({

	Name = "怀脚本",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/zuohongjian/bjb/main/bjb"))()

    end

})

Tab:AddButton({

	Name = "EZ Hub 150+",

	Callback = function()

loadstring(game:HttpGet(('https://raw.githubusercontent.com/debug420/Ez-Industries-Launcher-Data/master/Launcher.lua'),true))()

    end

})

Tab:AddButton({

	Name = "客户端中心",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/ObviouslyOrchi/Moonlight_Client.lua/main/Universal",true))()

    end

})

Tab:AddButton({

	Name = "作弊中心",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/mrgunz/UnnamedCheat/main/Loader"))();

    end

})

Tab:AddButton({

	Name = "阿斯顿中心",

	Callback = function()

loadstring(game:HttpGet(('https://raw.githubusercontent.com/rblxscriptsnet/unfair/main/rblxhub.lua'),true))()

    end

})

Tab:AddButton({

	Name = "脚本中心3卡密—released",

	Callback = function()

-- DISCORD: https://discord.gg/8YZMwfYaNqgetgenv().key = "JOIN DISCORD FOR KEY";loadstring(game:HttpGet("https://raw.githubusercontent.com/Ner0ox/sexy-script-hub/main/Loader.lua"))()

    end

})

Tab:AddButton({

	Name = "脚本中心外网",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/TakeModzz/Games-Hub-Script/main/Games%20Hub%20(Always%20updated)"))()

    end

})

Tab:AddButton({

	Name = "Every day中心",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/KATERGaming/Roblox/main/KaterHub.Lua"))()

    end

})

Tab:AddButton({

	Name = "移动中心",

	Callback = function()

loadstring(game:HttpGetAsync("https://shz.al/~mobile-hub-v2"))()

    end

})

Tab:AddButton({

	Name = "脚本中心另一版本",

	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/fgasfga/SCRIPT-HUB/main/Hello.lua", true))()

    end

})

Tab:AddButton({

	Name = "140+中心",

	Callback = function()

loadstring(game:HttpGet('https://raw.githubusercontent.com/1201for/V.G-Hub/main/V.Ghub'))()

    end

})

local Tab = Window:MakeTab({

	Name = "DOORS",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "门",

	Callback = function()

loadstring(game:HttpGet("https://github.com/DocYogurt/free/raw/main/long"))()

    end

})

Tab:AddButton({

	Name = "不坤到什么名字",

	Callback = function()

loadstring(game:HttpGet(("https://raw.githubusercontent.com/mstudio45/poopdoors_edited/main/poopdoors_edited.lua"),true))()

    end

})

Tab:AddButton({

	Name = "穿墙(无拉回)",

	Callback = function()

loadstring(game:HttpGet("https://github.com/DXuwu/OK/raw/main/clip"))()

    end

})

Tab:AddButton({

	Name = "手电筒（没电会有bug）",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Normal%20Flashlight"))()

    end

}) 

Tab:AddButton({

	Name = "神圣炸弹（清岩提供）",

    Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/HolyGrenadeByNerd.lua"))()

    end

})

Tab:AddButton({

	Name = "十字架",

    Callback = function()

loadstring(game:HttpGet('https://gist.githubusercontent.com/C00LBOZO/0c78ad8c74ca26324c87ede16ce8b387/raw/c0887ac0d24fde80bea11ab1a6a696ec296af272/Crucifix'))()

    end

})

Tab:AddButton({

	Name = "变身(阿巴怪提供)",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAccelerator/Public-Scripts/main/Morphing/MorphScript.lua"))();

    end

})

Tab:AddButton({

	Name = "微山2.3.2(依旧是阿巴怪提供)",

	Callback = function()

--微山doors 2.3.2(愚人节快乐)

loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\117\72\72\112\56\102\122\83"))()

    end

})

Tab:AddButton({

	Name = "飞行",

		Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/gqv7PXAa"))()

	end

})    

Tab:AddButton({

	Name = "键盘",

		Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()

	end

})    

Tab:AddButton({

	Name = "吸铁石",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/MagnetByNerd.lua"))()

    end

})

Tab:AddButton({

	Name = "剪刀",

	Callback = function()

   loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/shears_done.lua"))()

    end

})    

Tab:AddButton({

	Name = "激光枪",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Laser%20Gun"))()

    end

})

Tab:AddButton({

	Name = "能量罐（清岩提供）",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/nengliangtiao"))()

    end

})   

Tab:AddButton({

	Name = "紫色手电筒（在电梯购买东西的时候使用）",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Purple%20Flashlight"))()

    end

})  

local Tab = Window:MakeTab({

	Name = "脚本",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "青蛙",

	Callback = function()

getgenv().eom = "青蛙"

loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\39\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\68\122\120\115\81\82\68\85\39\41\41\40\41")()

    end

})

Tab:AddButton({

	Name = "地岩",

	Callback = function()

loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\98\98\97\109\120\98\98\97\109\120\98\98\97\109\120\47\99\111\100\101\115\112\97\99\101\115\45\98\108\97\110\107\47\109\97\105\110\47\37\69\55\37\57\57\37\66\68\34\41\41\40\41")()

    end

})

Tab:AddButton({

	Name = "ato",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/atoyayaya/jiaoben/main/jiamilist"))()

end

})

Tab:AddButton({

	Name = "龙",

	Callback = function()

loadstring(game:HttpGet "https://pastebin.com/raw/bXApbsu8")()

    end

})

Tab:AddButton({

	Name = "云脚本",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/Xiaos______________________________________________________________Yun__________________________________________________________________________betaV2.3------------------------------------------------------------------------------------jsjalololololololololololololololololololllololol.lua"))()

    end

})

Tab:AddButton({

  Name = "USA（卡密：USA AER）",

  Callback = function()

    getgenv().USA="作者莫羽免费请勿倒卖"loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/beta/main/USA.lua"))()

   end

})

local Tab = Window:MakeTab({

	Name = "游戏脚本",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "自动刷金条(造船寻宝)",	

Callback = function()	loadstring(game:HttpGet("https://pastebin.com/raw/Lyy77rnr",true))()

  	end

})

Tab:AddButton({

	Name = "巴掌模拟器",

	Callback = function()

loadstring(game:HttpGet(('https://raw.githubusercontent.com/Unknownkellymc1/Unknownscripts/main/slap-battles')))()

    end

})

Tab:AddDropdown({

	Name = "选择你的免费船(鲨鱼)",

	Default = "1",

	Options = {"无", "DuckyBoatBeta", "DuckyBoat", "BlueCanopyMotorboat", "BlueWoodenMotorboat", "UnicornBoat", "Jetski", "RedMarlin", "Sloop", "TugBoat", "SmallDinghyMotorboat", "JetskiDonut", "Marlin", "TubeBoat", "FishingBoat", "VikingShip", "SmallWoodenSailboat", "RedCanopyMotorboat", "Catamaran", "CombatBoat", "TourBoat", "Duckmarine", "PartyBoat", "MilitarySubmarine", "GingerbreadSteamBoat", "Sleigh2022", "Snowmobile", "CruiseShip"},

	Callback = function(Value)

local ohString1 = (Value)

game:GetService("ReplicatedStorage").EventsFolder.BoatSelection.UpdateHostBoat:FireServer(ohString1)

	end 

})

Tab:AddButton({

	Name = "自动杀鲨鱼🦈(鲨鱼)",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/Sw1ndlerScripts/RobloxScripts/main/Misc%20Scripts/sharkbite2.lua",true))()

  	end    

})

Tab:AddButton({

	Name = "动画星期五",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/funky-friday-autoplay/main/main.lua",true))()

  	end    

})

Tab:AddButton({

	Name = "宠物模拟器X",

	Callback = function()

     loadstring(game:HttpGet'https://raw.githubusercontent.com/RunDTM/ZeeroxHub/main/Loader.lua')()

  	end    

})

Tab:AddButton({

	Name = "蜂群模拟器",

	Callback = function()

     loadstring(game:HttpGet("https://pastebin.com/raw/3A61hnGA", true))()

  	end    

})

Tab:AddButton({

	Name = "Evade",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Evade/main.lua"))()

  	end    

})

Tab:AddButton({

	Name = "后室",

	Callback = function()

     loadstring(game:HttpGet('https://pastebin.com/raw/Gsqd40fL'))()

  	end    

})

Tab:AddButton({

	Name = "Synapse X",

	Callback = function()

     loadstring(game:HttpGet("https://pastebin.com/raw/tWGxhNq0"))()

  	end    

})

Tab:AddButton({

	Name = "彩虹朋友",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/JNHHGaming/Rainbow-Friends/main/Rainbow%20Friends"))()

  	end    

})

Tab:AddButton({

	Name = "HoHo",

	Callback = function()

     loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()

  	end    

})

Tab:AddButton({

	Name = "tds查看兵",

	Callback = function()

     local Towers = game:GetService("Players").LocalPlayer.PlayerGui.Interface.Root.Inventory.View.Frame.Frame.Frame

 

for _, v in pairs(Towers:GetDescendants()) do

	if v:IsA("ImageButton") then

        v.Visible = true

	end

end

  	end    

})

local Tab = Window:MakeTab({

	Name = "通用",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({	

Name = "工具包",	

Callback = function()	loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()	  	

     end

})

Tab:AddButton({

	Name = "透视",

	Callback = function()

     loadstring(game:HttpGet('https://pastebin.com/raw/MA8jhPWT'))()

  	end    

})

Tab:AddButton({

	Name = "飞车",

	Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/MHE1cbWF"))()

	end

})

Tab:AddButton({

	Name = "甩飞",

	Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/GnvPVBEi"))()

	end

})

Tab:AddButton({

	Name = "无限跳",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()

    end

})

local Tab = Window:MakeTab({

	Name = "FE脚本🌚",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "C00lgui",

	Callback = function()

   loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()

  	end    

})

Tab:AddButton({

	Name = "1x1x1x1",

	Callback = function()

     loadstring(game:HttpGet(('https://pastebin.com/raw/JipYNCht'),true))()

  	end    

})

Tab:AddButton({

	Name = "变玩家（R6）",

	Callback = function()

     loadstring(game:HttpGet("https://pastebin.com/raw/XR4sGcgJ"))()

  	end    

})

Tab:AddButton({

	Name = "动画中心",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()

  	end    

})

local Tab = Window:MakeTab({

	Name = "脚本作者小云",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "脚本doors",

	Callback = function()

     loadstring(game:HttpGet("https://pastebin.com/raw/whXp1Ca2"))()

  	end    

})

local Tab = Window:MakeTab({

  Name = "DOORS娱乐十字架(只对自己召唤的怪有用)",

  Icon = "rbxassetid://4483345998",

  PremiumOnly = false

})

Tab:AddButton({

  Name = "刷怪菜单",

  Callback = function ()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shuaguai"))()

  end

})

Tab:AddButton({

	Name = "DOORS变身脚本",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAccelerator/Public-Scripts/main/Morphing/MorphScript.lua"))();

end

}) 

Tab:AddButton({

  Name = "耶稣十字架",

  Callback = function ()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shizi2"))()

  end

})

Tab:AddButton({

  Name = "紫光十字架",

  Callback = function ()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shizi3"))()

  end

})

Tab:AddButton({

  Name = "万圣节十字架",

  Callback = function ()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shizi4"))()

  end

})

Tab:AddButton({

  Name = "普通十字架",

  Callback = function ()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shizizhen"))()

  end

})

local Tab = Window:MakeTab({

	Name = "造船寻宝",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

local Section = Tab:AddSection({

	Name = "付费功能"

})

Tab:AddButton({

	Name = "自动刷金条",

	Callback = function()

	loadstring(game:HttpGet("https://pastebin.com/raw/Lyy77rnr",true))()

  	end

})

Tab:AddButton({

	Name = "工具包",

	Callback = function()

	loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()	

  	end

})

Tab:AddButton({

	Name = "防止掉线（反挂机）",

	Callback = function()

	print("Anti Afk On")

		local vu = game:GetService("VirtualUser")

		game:GetService("Players").LocalPlayer.Idled:connect(function()

		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)

		   wait(1)

		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)

		end)

  	end

})

local Tab = Window:MakeTab({

	Name = "监狱人生",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "PRISONWARE V1.3",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/Denverrz/scripts/master/PRISONWARE_v1.3.txt"))();

  	end    

})

Tab:AddButton({

	Name = "警卫室",

	Callback = function()

	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(847.7261352539062, 98.95999908447266, 2267.387451171875)

  	end

})

Tab:AddButton({

	Name = "监狱室内",

	Callback = function()

	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(919.2575073242188, 98.95999908447266, 2379.74169921875)

  	end

})

Tab:AddButton({

	Name = "罪犯复活点",

	Callback = function()

	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-937.5891723632812, 93.09876251220703, 2063.031982421875)

  	end

})

Tab:AddButton({

	Name = "监狱室外",

	Callback = function()

	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(760.6033325195312, 96.96992492675781, 2475.405029296875)

  	end

})

local Tab = Window:MakeTab({

	Name = "鲨口求生2",	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddDropdown({

	Name = "免费船只",

	Default = "1",

	Options = {"DuckyBoatBeta", "DuckyBoat", "BlueCanopyMotorboat", "BlueWoodenMotorboat", "UnicornBoat", "Jetski", "RedMarlin", "Sloop", "TugBoat", "SmallDinghyMotorboat", "JetskiDonut", "Marlin", "TubeBoat", "FishingBoat", "VikingShip", "SmallWoodenSailboat", "RedCanopyMotorboat", "Catamaran", "CombatBoat", "TourBoat", "Duckmarine", "PartyBoat", "MilitarySubmarine",  "GingerbreadSteamBoat", "Sleigh2022", "Snowmobile", "CruiseShip"},

	Callback = function(Value)

local ohString1 = (Value)

game:GetService("ReplicatedStorage").EventsFolder.BoatSelection.UpdateHostBoat:FireServer(ohString1)

	end    

})

Tab:AddButton({

	Name = "自动杀鲨鱼🦈",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/Sw1ndlerScripts/RobloxScripts/main/Misc%20Scripts/sharkbite2.lua",true))()

  	end    

})

local Tab = Window:MakeTab({

	Name = "FE脚本",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "C00lgui",

	Callback = function()

     loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()

  	end    

})

Tab:AddButton({

	Name = "1x1x1x1",

	Callback = function()

     loadstring(game:HttpGet(('https://pastebin.com/raw/JipYNCht'),true))()

  	end    

})

Tab:AddButton({

	Name = "动画中心",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()

  	end    

})

local Tab = Window:MakeTab({

	Name = "通用",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

      Name = "阿尔宙斯V3.0 UI",

      Callback = function()

      loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20X%20V3"))()

      end

})

 

 Tab:AddButton({

  Name = "HUA 光影",

  Callback = function()

    loadstring(game:HttpGet("https://pastebin.com/raw/arzRCgwS"))()

  end

})

Tab:AddButton({

  Name = "光影_2",

  Default = false,

  Callback = function()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()

  end

})

Tab:AddButton({

  Name = "美丽天空",

  Callback = function()

    -- Roblox Graphics Enhancher

    local light = game.Lighting

    for i, v in pairs(light:GetChildren()) do

      v:Destroy()

    end

    local ter = workspace.Terrain

    local color = Instance.new("ColorCorrectionEffect")

    local bloom = Instance.new("BloomEffect")

    local sun = Instance.new("SunRaysEffect")

    local blur = Inst

  end

})

Tab:AddButton({

	Name = "超高画质",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()

end

})    

Tab:AddButton({

  Name = "旋转",

  Callback = function()

    loadstring(game:HttpGet('https://pastebin.com/raw/r97d7dS0', true))()

  end

})

Tab:AddToggle({

	Name = "夜视",

	Default = false,

	Callback = function(Value)

		if Value then

		    game.Lighting.Ambient = Color3.new(1, 1, 1)

		else

		    game.Lighting.Ambient = Color3.new(0, 0, 0)

		end

	end

})

 

Tab:AddButton({

	Name = "飞车",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/MHE1cbWF"))()

	end

})

Tab:AddButton({

	Name = "爬墙",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()

end

})

Tab:AddButton({

	Name = "电脑键盘",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()

  	end    

})

Tab:AddButton({

	Name = "踏空行走",

	Callback = function()

loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()

	end

})

Tab:AddButton({

	Name = "防止掉线（反挂机）",

	Callback = function()

	print("Anti Afk On")

		local vu = game:GetService("VirtualUser")

		game:GetService("Players").LocalPlayer.Idled:connect(function()

		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)

		   wait(1)

		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)

		end)

  	end

})

local player = Window:MakeTab({

	Name = "玩家",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddTextbox({

	Name = "重力设置",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Workspace.Gravity = Value

	end

})

Tab:AddButton({

	Name = "隐身(E)",

	Callback = function()

	 loadstring(game:HttpGet('https://pastebin.com/raw/nwGEvkez'))()

  	end    

})

Tab:AddButton({

	Name = "无限跳",

    Default = false,

	Callback = function(Value)

loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()

	end

})

player:AddTextbox({

	Name = "移动速度",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value

	end

})

player:AddTextbox({

	Name = "跳跃高度",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value

	end

})

player:AddButton({

	Name = "穿墙",

	Callback = function()

      	loadstring(game:HttpGet("https://pastebin.com/raw/jvyN5hT8"))()

  	end

})

player:AddButton({

	Name = "飞行",

	Callback = function()

      	loadstring(game:HttpGet("https://pastebin.com/raw/U27yQRxS"))()

  	end

})

local Tab = Window:MakeTab({

    Name = "伐木脚本",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "先点键盘，再点这个",

	Callback = function()

    loadstring(game:HttpGet('https://raw.githubusercontent.com/Butterisgood/butter-hub/main/butters%20recode-obfuscated.lua'))("Apple is cute")

    end

})

Tab:AddButton({

	Name = "免费白脚本",

	Callback = function()

	loadstring(game:HttpGet("https://raw.githubusercontent.com/CloudX-ScriptsWane/ScriptsDache/main/%E4%BC%90%E6%9C%A8%E5%A4%A7%E4%BA%A822.lua", true))()

    end

})

Tab:AddButton({

      Name = "小云bark2.0",

      Callback = function()

      loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/bark2.0.lua"))()

      end

      })

local Tab = Window:MakeTab({

    Name = "DOORS",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "微山DOORS",

	Callback = function()

loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\117\72\72\112\56\102\122\83"))()

  	end

})

Tab:AddButton({

	Name = "kingHub(已更新)",

	Callback = function()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/KINGHUB01/BlackKing/main/BlackKing%20Doors%20Mobile"))()

  	end

})

Tab:AddButton({

  Name = "门绘图显示",

  Callback = function()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/doors1"))()

  end

})

Tab:AddButton({

	Name = "手电筒（没电会有bug）",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Normal%20Flashlight"))()

end

})      

Tab:AddButton({

  Name = "DOORS低回拉穿墙",

  Callback = function()

    loadstring(game:HttpGet("https://github.com/DXuwu/OK/raw/main/clip"))()

  end

})

Tab:AddButton({

  Name = "刷怪菜单",

  Callback = function ()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shuaguai"))()

  end

})

Tab:AddButton({

	Name = "DOORS变身脚本",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAccelerator/Public-Scripts/main/Morphing/MorphScript.lua"))();

end

}) 

Tab:AddButton({

	Name = "不可能模式",

	Callback = function()

    loadstring(game:HttpGet('https://raw.githubusercontent.com/Ukazix/impossible-mode/main/Protected_79.lua.txt'))()

  	end

})

Tab:AddButton({

	Name = "Endless模式",

	Callback = function()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/check78/worldcuuuup/main/Script.lua"))()

  	end

})

Tab:AddButton({

	Name = "物品复制枪",

	Callback = function()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/EverythingGunByNeRD.lua"))()

  	end

})

Tab:AddButton({

	Name = "控制物品大小枪",

	Callback = function()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/SizeChangerByNerd.lua"))()

  	end

})

Tab:AddButton({

	Name = "香蕉枪(可在困难模式发射香蕉)",

	Callback = function()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/BananaGunByNerd.lua"))()

  	end

})

Tab:AddButton({

	Name = "手持臭猫",

	Callback = function()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Maxwell%20Plushie"))()

  	end

})

Tab:AddButton({

	Name = "磁铁",

	Callback = function()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/MagnetByNerd.lua"))()

  	end

})

local Tab = Window:MakeTab({

	Name = "极速传奇",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "开启卡宠",

	Callback = function()

	loadstring(game:HttpGet("https://pastebin.com/raw/uR6azdQQ"))()		

  	end

})

Tab:AddButton({

	Name = "自动重生和自动刷等级",

	Callback = function()

	loadstring(game:HttpGet("https://pastebin.com/raw/AyeCYbT6"))()        

  	end    

})

local Section = Tab:AddSection({

	Name = "传送岛屿"

})

Tab:AddButton({

	Name = "返还出生岛",

	Callback = function()

	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9682.98828125, 58.87917709350586, 3099.033935546875)      

	end    

})

Tab:AddButton({

	Name = "白雪城",

	Callback = function()

	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9676.138671875, 58.87917709350586, 3782.69384765625)   end    

})

Tab:AddButton({

	Name = "熔岩城",

	Callback = function()

	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11054.96875, 216.83917236328125, 4898.62841796875)       

  	end    

})

Tab:AddButton({

	Name = "传奇公路",

	Callback = function()

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13098.87109375, 216.83917236328125, 5907.6279296875)    end    

})

local Tab = Window:MakeTab({

    Name = "俄亥俄州",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "俄亥俄州",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/hkvHeHed",true))()

end

})

local Tab = Window:MakeTab({

    Name = "蜂群模拟器",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "修勾的蜂群",

	Callback = function()

	loadstring(game:HttpGet("https://rahttps://rahttps://raw.githubusercontent.com/USA868/USA--/main/.github/%E5%B7%A5%E4%BD%9C%E6%B5%81%E7%A8%8B/1%E6%9D%96%E4%BA%BA%E4%BD%BF%E7%94%A8?token=GHSAT0AAAAAACB6LLQWA5JNQNNWTP47AOWSZCLYRTQ"))()

end

})

local Tab = Window:MakeTab({

    Name = "幸运方块",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "HUA 幸运方块",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/QS5CcYdU"))()

end

})

local Tab = Window:MakeTab({

    Name = "MM2",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "HUA MM2",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/A6z5Ba66"))()

end

})

local Tab = Window:MakeTab({

    Name = "忍者传奇",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddToggle(

    {

        Name = "自动挥舞",

        Default = false,

        Callback = function(x)

            autoswing = x

            if autoswing then

                swinging()

            end

        end

    }

)

Tab:AddToggle(

    {

        Name = "自动售卖",

        Default = false,

        Callback = function(x)

            autosell = x

            if autosell then

                selling()

            end

        end

    }

)

    

Tab:AddToggle(

    {

        Name = "存满了自动售卖",

        Default = false,

        Callback = function(x)

            autosellmax = x

            if autosellmax then

                maxsell()

            end

        end

    }

)

local Section = Tab:AddSection({

	Name = "自动购买功能"

})

Tab:AddToggle(

    {

        Name = "自动购买剑",

        Default = false,

        Callback = function(x)

            autobuyswords = x

            if autobuyswords then

                buyswords()

            end

        end

    }

)

Tab:AddToggle(

    {

        Name = "自动购买腰带",

        Default = false,

        Callback = function(x)

            autobuybelts = x

            if autobuybelts then

                buybelts()

            end

        end

    }

)

Tab:AddToggle(

    {

        Name = "自动购买称号（等级）",

        Default = false,

        Callback = function(x)

            autobuyranks = x

            if autobuyranks then

                buyranks()

            end

        end

    }

)

Tab:AddToggle(

    {

        Name = "自动购买忍术",

        Default = false,

        Callback = function(x)

            autobuyskill = x

            if autobuyskill then

                buyskill()

            end

        end

    }

)

Tab:AddToggle(

    {

        Name = "自动购买（全部打开就行）",

        Default = false,

        Callback = function(x)

            autobuyshurikens = x

            if autobuyshurikens then

                buyshurikens()

            end

        end

    }

)

Tab:AddButton(

    {

        Name = "解锁所有岛",

        Callback = function()

            for _, v in next, game.workspace.islandUnlockParts:GetChildren() do

                if v then

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.islandSignPart.CFrame

                    wait(.5)

                end

            end

        end

    }

)

local Tab = Window:MakeTab({

  Name = "通用脚本",

  Icon = "rbxassetid://4483345998",

  PremiumOnly = false

  })

  

 Tab:AddButton({

	Name = "飞行",

	Callback = function()

loadstring(game:HttpGet('https://rentry.co/shadiao_yazifly/raw'))()

end

})

Tab:AddTextbox({

	Name = "移动速度",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value

	end	 

})

 Tab:AddTextbox({

	Name = "跳跃高度",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value

	end	 

})

Tab:AddTextbox({

	Name = "最大血量",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.MaxHealth = Value

	end	 

})

Tab:AddTextbox({

	Name = "当前血量",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.Health = Value

	end	 

})

Tab:AddTextbox({

	Name = "重力设置",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Workspace.Gravity = Value

	end

})

Tab:AddButton({

	Name = "修改玩家碰撞箱",

	Callback = function()

loadstring(game:HttpGet('https://rentry.co/aaaaaaaaaduckduck/raw'))()

end

})

Tab:AddButton({

	Name = "粘墙行走",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()

end

})

Tab:AddToggle({

	Name = "夜视",

	Default = false,

	Callback = function(Value)

		if Value then

		    game.Lighting.Ambient = Color3.new(1, 1, 1)

		else

		    game.Lighting.Ambient = Color3.new(0, 0, 0)

		end

	end

})

Tab:AddToggle({

	Name = "穿墙",

	Default = false,

	Callback = function(Value)

		if Value then

		    Noclip = true

		    Stepped = game.RunService.Stepped:Connect(function()

			    if Noclip == true then

				    for a, b in pairs(game.Workspace:GetChildren()) do

                        if b.Name == game.Players.LocalPlayer.Name then

                            for i, v in pairs(game.Workspace[game.Players.LocalPlayer.Name]:GetChildren()) do

                                if v:IsA("BasePart") then

                                    v.CanCollide = false

                                end

                            end

                        end

                    end

			    else

				    Stepped:Disconnect()

			    end

		    end)

	    else

		    Noclip = false

	    end

	end

})

Tab:AddButton({

	Name = "转起来",

	Callback = function()

      	loadstring(game:HttpGet('https://pastebin.com/raw/r97d7dS0', true))()

  	end

})

Tab:AddButton({

	Name = "转圈fling GUI",

	Callback = function()

loadstring(game:HttpGet('https://pastebin.com/raw/r97d7dS0', true))()

end

})

Tab:AddButton({

	Name = "锁定fling",

	Callback = function()

loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Best-Target-Fling-10816"))()

end

})

local Tab = Window:MakeTab({

  Name = "极速传奇",

  Icon = "rbxassetid://4483345998",

  PremiumOnly = false

  })

  

  Tab:AddButton({

	Name = "极速传奇",	Callback = function()

      	loadstring(game:HttpGet('\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\98\111\121\115\99\112\47\98\101\116\97\47\109\97\105\110\47\37\69\57\37\56\48\37\57\70\37\69\53\37\66\65\37\65\54\37\69\55\37\56\50\37\66\56\37\69\56\37\66\53\37\66\55\46\108\117\97'))()

  	end

})

local Tab = Window:MakeTab({

  Name = "脚本中心",

  Icon = "rbxassetid://4483345998",

  PremiumOnly = false

  })

  

Tab:AddButton({

	Name = "脚本中心",

	Callback = function()

  loadstring(game:HttpGet("https://pastebin.com/raw/De4aYHDY"))()

  	end

})

local Tab = Window:MakeTab({

	Name = "DOORS",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "神光脚本",

	Callback = function()

  _G["神光脚本作者TA"]="xdjhadgdsrfcyefjhsadcctyseyr6432478rudghfvszhxcaheey"loadstring(game:HttpGet(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,109,119,48,112,102,69,70,77})end)())))()--神光

    end

})

Tab:AddButton({

	Name = "面包脚本",

	Callback = function()

  _G["面包脚本作者TA"]="xdjhadgdsrfcyefjhsadcctyseyr6432478rudghfvszhxcaheey"loadstring(game:HttpGet(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,109,119,48,112,102,69,70,77})end)())))()--神光

    end

})

Tab:AddButton({

	Name = "Ohio doors",

	Callback = function()

 loadstring(game:HttpGet("https://raw.githubusercontent.com/rxn-xyz/Ohio./main/Ohio.lua",true))()

    end

})

Tab:AddButton({

	Name = "云doors",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/hsjakajaaa.lua"))()

    end

})

Tab:AddButton({

	Name = "吸铁石",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/MagnetByNerd.lua"))()

    end

})

Tab:AddButton({

	Name = "剪刀",

	Callback = function()

   

loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/shears_done.lua"))()

    end

})    

Tab:AddButton({

	Name = "激光枪",

	Callback = function()

  loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Laser%20Gun"))()

    end

})

Tab:AddButton({

	Name = "夜视仪",

	Callback = function()

   

  _G.OnShop = trueloadstring(game:HttpGet('https://raw.githubusercontent.com/DeividComSono/Scripts/main/Scanner.lua'))()

    end

})    

Tab:AddButton({

	Name = "最强",

	Callback = function()

   loadstring(game:HttpGet('https://pastebin.com/raw/R8QMbhzv'))()

  	end    

})

Tab:AddButton({

	Name = "十字架",

	Callback = function()

   

loadstring(game:HttpGet('https://pastebin.com/raw/ibbWwU6q'))()

  	end

})

Tab:AddButton({

	Name = "能量罐（清岩提供）",

	Callback = function()  

  loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/nengliangtiao"))()

    end

})   

Tab:AddButton({

	Name = "紫色手电筒（在电梯购买东西的时候使用）",

	Callback = function()

   

  loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Purple%20Flashlight"))()

    end

})  

local Tab = Window:MakeTab({

  Name = "国王遗产",

  Icon = "rbxassetid://4483345998",

  PremiumOnly = false

  })

Tab:AddButton({

	Name = "trick",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Strikehubv2z/StormSKz/main/All_in_one"))()

end

})

Tab:AddButton({

	Name = "ipper hub",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/hajibeza/RIPPER-HUB/main/King%20Leagacy"))()

end

})

Tab:AddButton({

	Name = "Xenon Hub",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/community/master/legacy"))()

end

})

Tab:AddButton({

	Name = "lack",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/sannin9000/scripts/main/kinglegacy.lua"))()

end

})

Tab:AddButton({

	Name = "yper hub",

	Callback = function()

repeat wait() until game:IsLoaded()loadstring(game:HttpGet("https://raw.githubusercontent.com/DookDekDEE/Hyper/main/script.lua"))() 

end

})

local Tab = Window:MakeTab({

	Name = "脚本",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "青蛙",

	Callback = function()

   

getgenv().eom = "青蛙"

loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\39\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\68\122\120\115\81\82\68\85\39\41\41\40\41")()

    end

})

Tab:AddButton({

	Name = "地岩",

	Callback = function()

loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\98\98\97\109\120\98\98\97\109\120\98\98\97\109\120\47\99\111\100\101\115\112\97\99\101\115\45\98\108\97\110\107\47\109\97\105\110\47\37\69\55\37\57\57\37\66\68\34\41\41\40\41")()

    end

})

Tab:AddButton({

	Name = "ato",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/atoyayaya/jiaoben/main/jiamilist"))()

end

})

Tab:AddButton({

	Name = "龙",

	Callback = function()

loadstring(game:HttpGet "https://pastebin.com/raw/bXApbsu8")()

    end

})

Tab:AddButton({

	Name = "云脚本",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/Xiaos______________________________________________________________Yun__________________________________________________________________________betaV2.3------------------------------------------------------------------------------------jsjalololololololololololololololololololllololol.lua"))()

    end

})

Tab:AddButton({

  Name = "USA（卡密：USA AER）",

  Callback = function()

    getgenv().USA="作者莫羽免费请勿倒卖"loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/beta/main/USA.lua"))()

   end

})local Tab = Window:MakeTab({

	Name = "脚本大全",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "自动刷金条(造船寻宝)",	

Callback = function()	loadstring(game:HttpGet("https://pastebin.com/raw/Lyy77rnr",true))()

  	end

})

Tab:AddButton({

	Name = "巴掌模拟器",

	Callback = function()

loadstring(game:HttpGet(('https://raw.githubusercontent.com/Unknownkellymc1/Unknownscripts/main/slap-battles')))()

    end

})

Tab:AddButton({

	Name = "Blox Fruit",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Frerfgzz/free-script/main/SMZHUBv2BETA"))()

end

})

Tab:AddButton({

	Name = "一路向西",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/pHN96bvq"))()

end

})

Tab:AddButton({

	Name = "力量传奇",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/harisiskandar178/Roblox-Script/main/Muscle%20Legend"))()

  	end    

})

local Tab = Window:MakeTab({

  Name = "鲨口求生2",

  Icon = "rbxassetid://4483345998",

  PremiumOnly = false

  })

  

Tab:AddDropdown({

	Name = "选择你的免费船(鲨2)",

	Default = "1",

	Options = {"无", "DuckyBoatBeta", "DuckyBoat", "BlueCanopyMotorboat", "BlueWoodenMotorboat", "UnicornBoat", "Jetski", "RedMarlin", "Sloop", "TugBoat", "SmallDinghyMotorboat", "JetskiDonut", "Marlin", "TubeBoat", "FishingBoat", "VikingShip", "SmallWoodenSailboat", "RedCanopyMotorboat", "Catamaran", "CombatBoat", "TourBoat", "Duckmarine", "PartyBoat", "MilitarySubmarine", "GingerbreadSteamBoat", "Sleigh2022", "Snowmobile", "CruiseShip"},

	Callback = function(Value)

local ohString1 = (Value)

game:GetService("ReplicatedStorage").EventsFolder.BoatSelection.UpdateHostBoat:FireServer(ohString1)

	end 

})

Tab:AddButton({

	Name = "自动杀鲨鱼（鲨2）",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/Sw1ndlerScripts/RobloxScripts/main/Misc%20Scripts/sharkbite2.lua",true))()

  	end    

})

local Tab = Window:MakeTab({

  Name = "脚本大全2",

  Icon = "rbxassetid://4483345998",

  PremiumOnly = false

  })

  

Tab:AddButton({

	Name = "动感星期五",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/funky-friday-autoplay/main/main.lua",true))()

  	end    

})

Tab:AddButton({

	Name = "宠物模拟器X",

	Callback = function()

     loadstring(game:HttpGet'https://raw.githubusercontent.com/RunDTM/ZeeroxHub/main/Loader.lua')()

  	end    

})

Tab:AddButton({

	Name = "蜂群模拟器",

	Callback = function()

     loadstring(game:HttpGet("https://pastebin.com/raw/3A61hnGA", true))()

  	end    

})

Tab:AddButton({

	Name = "Evade",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Evade/main.lua"))()

  	end    

})

Tab:AddButton({

	Name = "后室",

	Callback = function()

     loadstring(game:HttpGet('https://pastebin.com/raw/Gsqd40fL'))()

  	end    

})

Tab:AddButton({

	Name = "Synapse X",

	Callback = function()

     loadstring(game:HttpGet("https://pastebin.com/raw/tWGxhNq0"))()

  	end    

})

Tab:AddButton({

	Name = "彩虹朋友",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/JNHHGaming/Rainbow-Friends/main/Rainbow%20Friends"))()

  	end    

})

Tab:AddButton({

	Name = "HoHo blox fruit",

	Callback = function()

     loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()

  	end    

})

Tab:AddButton({

	Name = "tds查看兵",

	Callback = function()

     local Towers = game:GetService("Players").LocalPlayer.PlayerGui.Interface.Root.Inventory.View.Frame.Frame.Frame

 

for _, v in pairs(Towers:GetDescendants()) do

	if v:IsA("ImageButton") then

        v.Visible = true

	end

end

  	end    

})

local Tab = Window:MakeTab({

	Name = "通用2",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({	

Name = "工具包",	

Callback = function()	loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()	  	

     end

})

Tab:AddButton({

	Name = "透视",

	Callback = function()

     loadstring(game:HttpGet('https://pastebin.com/raw/MA8jhPWT'))()

  	end    

})

Tab:AddButton({

	Name = "飞车",

	Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/MHE1cbWF"))()

	end

})

Tab:AddButton({

	Name = "甩飞",

	Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/GnvPVBEi"))()

	end

})

Tab:AddButton({

	Name = "无限跳",

	Callback = function()

loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()

    end

})

local Tab = Window:MakeTab({

	Name = "FE脚本",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "C00lgui",

	Callback = function()

   loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()

  	end    

})

Tab:AddButton({

	Name = "1x1x1x1",

	Callback = function()

     loadstring(game:HttpGet(('https://pastebin.com/raw/JipYNCht'),true))()

  	end    

})

Tab:AddButton({

	Name = "变玩家（R6）",

	Callback = function()

     loadstring(game:HttpGet("https://pastebin.com/raw/XR4sGcgJ"))()

  	end    

})

Tab:AddButton({

	Name = "动画中心",

	Callback = function()

     loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()

  	end    

})

local Tab = Window:MakeTab({

	Name = "doors2",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "脚本doors",

	Callback = function()

     loadstring(game:HttpGet("https://pastebin.com/raw/whXp1Ca2"))()

  	end    

})

local Tab = Window:MakeTab({

  Name = "DOORS娱乐十字架(只对自己召唤的怪有用)",

  Icon = "rbxassetid://4483345998",

  PremiumOnly = false

})

Tab:AddButton({

  Name = "刷怪菜单",

  Callback = function ()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shuaguai"))()

  end

})

Tab:AddButton({

	Name = "DOORS变身脚本",

	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAccelerator/Public-Scripts/main/Morphing/MorphScript.lua"))();

end

}) 

Tab:AddButton({

  Name = "耶稣十字架",

  Callback = function ()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shizi2"))()

  end

})

Tab:AddButton({

  Name = "紫光十字架",

  Callback = function ()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shizi3"))()

  end

})

Tab:AddButton({

  Name = "万圣节十字架",

  Callback = function ()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shizi4"))()

  end

})

Tab:AddButton({

  Name = "普通十字架",

  Callback = function ()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shizizhen"))()

  end

})

local Tab = Window:MakeTab({

	Name = "水下世界",

	Icon = "rbxassetid://4483345998",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "水下世界卡密xiaoxiaoyu",

	Callback = function()

    loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\52\118\53\110\55\110\47\108\108\108\108\108\108\108\108\108\108\108\108\108\108\108\108\108\108\108\108\108\47\109\97\105\110\47\85\110\100\101\114\119\97\116\101\114\37\50\48\119\111\114\108\100\46\108\117\97\34\41\41\40\41\10")()

  end

})
})

local Tab = Window:MakeTab({

  Name = "CHAIN",

  Icon = "rbxassetid://4483345998",

  PremiumOnly = false

})

Tab:AddButton({

	Name = "lnfinitely",

	Callback = function()
local __namecall__namecall = hookmetamethod(game, "__namecall", function(self, ...)    if not checkcaller() then        if getnamecallmethod() == "FireServer" then            if self.Name == "CTS" then                local args = {...}                if args[1] == "DoneDodge" then                    print('dodgeagain0_0')                    args[1] = "Dodge"                end                return __namecall(self, unpack(args))            end;        end;    end;    return __namecall(self, ...)end);
   

  	end    

})

end)
end
local myTitle = "小欣脚本协议条款" 
CreateGUI(myTitle)
 
  
