--========================================================--
--        jhaju's admin panel V2.5.1
--        Developer / Admin Panel
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

--========================================================--
-- CONFIG
--========================================================--

local Config = {
    WalkSpeed = 16,
    JumpPower = 50,
    FlySpeed = 50,
    Gravity = 196.2,
    HipHeight = nil,

    Noclip = false,
    InfiniteJump = false,
    Fly = false,

    ESP = false,
    ESPInfo = false,
    Tracers = false,
    FOVCircle = false,
    FOV = 200,

    XRay = false,
    NoFog = false,
    FullBright = false,
    NightVision = false,
    Shadows = true,

    Aimbot = false,
    AimbotFOV = 200,
    AimSmoothness = 50,
    AimPrediction = 0,
    TargetLock = false,
    TeamCheck = true,
    WallCheck = true,

    Notifications = true,
    Animations = true,

    Theme = "Red",

    UITransparency = 0.50,
    UIWidth = 390,
    UIHeight = 290,

    SpawnPosition = nil
}

--========================================================--
-- MODULE SYSTEM
--========================================================--

local Modules = {}

local function RegisterModule(Name, StartFunction, StopFunction)
    Modules[Name] = {
        Enabled = false,
        Start = StartFunction,
        Stop = StopFunction
    }
end

local function ToggleModule(Name, State)
    local Module = Modules[Name]

    if not Module then
        return false
    end

    Module.Enabled = State

    if State then
        if Module.Start then
            Module.Start()
        end
    else
        if Module.Stop then
            Module.Stop()
        end
    end

    return true
end

RegisterModule(
    "Developer Mode",
    function()
        print("[V2.5.1] Developer Mode enabled")
    end,
    function()
        print("[V2.5.1] Developer Mode disabled")
    end
)

RegisterModule(
    "Spawn System",
    function()
        print("[V2.5.1] Spawn System enabled")
    end,
    function()
        print("[V2.5.1] Spawn System disabled")
    end
)

--========================================================--
-- CLEAN OLD UI
--========================================================--

local Old = PlayerGui:FindFirstChild("JhajuAdminPanel")

if Old then
    Old:Destroy()
end

--========================================================--
-- MAIN GUI
--========================================================--

local Gui = Instance.new("ScreenGui")
Gui.Name = "JhajuAdminPanel"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(Config.UIWidth, Config.UIHeight)
Main.Position = UDim2.new(0.5, -195, 0.5, -145)
Main.BackgroundColor3 = Color3.fromRGB(120,0,0)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255,30,30)
MainStroke.Thickness = 2
MainStroke.Parent = Main

--========================================================--
-- BACKGROUND
--========================================================--

local Inner = Instance.new("Frame")
Inner.Size = UDim2.new(1,-4,1,-4)
Inner.Position = UDim2.fromOffset(2,2)
Inner.BackgroundColor3 = Color3.fromRGB(10,10,10)
Inner.BorderSizePixel = 0
Inner.ClipsDescendants = true
Inner.Parent = Main

local InnerCorner = Instance.new("UICorner")
InnerCorner.CornerRadius = UDim.new(0,14)
InnerCorner.Parent = Inner

local Background = Instance.new("ImageLabel")
Background.Size = UDim2.fromScale(1,1)
Background.BackgroundTransparency = 1
Background.Image = "rbxassetid://110731912846398"
Background.ScaleType = Enum.ScaleType.Fit
Background.Parent = Inner

local BackgroundCorner = Instance.new("UICorner")
BackgroundCorner.CornerRadius = UDim.new(0,14)
BackgroundCorner.Parent = Background

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.fromScale(1,1)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = Config.UITransparency
Overlay.BorderSizePixel = 0
Overlay.Parent = Inner

local OverlayCorner = Instance.new("UICorner")
OverlayCorner.CornerRadius = UDim.new(0,14)
OverlayCorner.Parent = Overlay

--========================================================--
-- TOP BAR
--========================================================--

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1,-8,0,42)
TopBar.Position = UDim2.fromOffset(4,4)
TopBar.BackgroundColor3 = Color3.fromRGB(30,5,5)
TopBar.BackgroundTransparency = 0.1
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 10
TopBar.Parent = Inner

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0,10)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-110,0,22)
Title.Position = UDim2.fromOffset(12,4)
Title.BackgroundTransparency = 1
Title.Text = "jhaju's admin panel"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 11
Title.Parent = TopBar

local Version = Instance.new("TextLabel")
Version.Size = UDim2.new(1,-110,0,14)
Version.Position = UDim2.fromOffset(12,25)
Version.BackgroundTransparency = 1
Version.Text = "V2.5.1 • Developer Edition"
Version.TextColor3 = Color3.fromRGB(255,100,100)
Version.TextSize = 9
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.ZIndex = 11
Version.Parent = TopBar

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(30,30)
Minimize.Position = UDim2.new(1,-68,0,6)
Minimize.BackgroundColor3 = Color3.fromRGB(100,15,15)
Minimize.Text = "−"
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.TextSize = 20
Minimize.Font = Enum.Font.GothamBold
Minimize.BorderSizePixel = 0
Minimize.ZIndex = 12
Minimize.Parent = TopBar

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(30,30)
Close.Position = UDim2.new(1,-34,0,6)
Close.BackgroundColor3 = Color3.fromRGB(150,20,20)
Close.Text = "×"
Close.TextColor3 = Color3.new(1,1,1)
Close.TextSize = 20
Close.Font = Enum.Font.GothamBold
Close.BorderSizePixel = 0
Close.ZIndex = 12
Close.Parent = TopBar

for _,Button in ipairs({Minimize,Close}) do
    local C = Instance.new("UICorner")
    C.CornerRadius = UDim.new(0,8)
    C.Parent = Button
end

--========================================================--
-- DRAG
--========================================================--

local function MakeDraggable(Object,Handle)

    Handle = Handle or Object

    local Dragging = false
    local StartMouse
    local StartPosition

    Handle.InputBegan:Connect(function(Input)

        if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

            Dragging = true
            StartMouse = Input.Position
            StartPosition = Object.Position

            Input.Changed:Connect(function()

                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end

            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)

        if not Dragging then
            return
        end

        if Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch then

            local Delta = Input.Position - StartMouse

            Object.Position = UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        end
    end)
end

MakeDraggable(Main,TopBar)

--========================================================--
-- SIDEBAR
--========================================================--

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.fromOffset(90,228)
Sidebar.Position = UDim2.fromOffset(4,50)
Sidebar.BackgroundColor3 = Color3.fromRGB(20,5,5)
Sidebar.BackgroundTransparency = 0.15
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 10
Sidebar.Parent = Inner

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0,10)
SideCorner.Parent = Sidebar

--========================================================--
-- CONTENT
--========================================================--

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-104,1,-50)
Content.Position = UDim2.fromOffset(100,50)
Content.BackgroundColor3 = Color3.fromRGB(8,8,8)
Content.BackgroundTransparency = 0.18
Content.BorderSizePixel = 0
Content.ZIndex = 10
Content.Parent = Inner

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0,10)
ContentCorner.Parent = Content

--========================================================--
-- PAGES
--========================================================--

local Tabs = {}
local Pages = {}

local function CreatePage(Name)

    local Page = Instance.new("ScrollingFrame")
    Page.Name = Name
    Page.Size = UDim2.new(1,-10,1,-10)
    Page.Position = UDim2.fromOffset(5,5)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(180,20,20)
    Page.Visible = false
    Page.ZIndex = 11
    Page.Parent = Content

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0,5)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Page

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(
            0,0,0,
            Layout.AbsoluteContentSize.Y + 10
        )
    end)

    Pages[Name] = Page

    return Page
end

local function CreateTab(Name,Order)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,-8,0,35)
    Button.Position = UDim2.fromOffset(4,4+(Order-1)*40)
    Button.BackgroundColor3 = Color3.fromRGB(55,10,10)
    Button.Text = Name
    Button.TextColor3 = Color3.fromRGB(220,220,220)
    Button.TextSize = 11
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.ZIndex = 11
    Button.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,7)
    Corner.Parent = Button

    Tabs[Name] = Button

    return Button
end

local PlayerPage = CreatePage("Player")
local VisualPage = CreatePage("Visual")
local CombatPage = CreatePage("Combat")
local SettingsPage = CreatePage("Settings")
local DeveloperPage = CreatePage("Developer")

local PlayerTab = CreateTab("Player",1)
local VisualTab = CreateTab("Visual",2)
local CombatTab = CreateTab("Combat",3)
local SettingsTab = CreateTab("Settings",4)
local DeveloperTab = CreateTab("Dev",5)

local function ShowPage(Name)

    for PageName,Page in pairs(Pages) do
        Page.Visible = PageName == Name
    end

    for TabName,Button in pairs(Tabs) do

        if (TabName == Name) or
           (TabName == "Dev" and Name == "Developer") then

            Button.BackgroundColor3 = Color3.fromRGB(150,20,20)
        else
            Button.BackgroundColor3 = Color3.fromRGB(55,10,10)
        end
    end
end

PlayerTab.MouseButton1Click:Connect(function()
    ShowPage("Player")
end)

VisualTab.MouseButton1Click:Connect(function()
    ShowPage("Visual")
end)

CombatTab.MouseButton1Click:Connect(function()
    ShowPage("Combat")
end)

SettingsTab.MouseButton1Click:Connect(function()
    ShowPage("Settings")
end)

DeveloperTab.MouseButton1Click:Connect(function()
    ShowPage("Developer")
end)

--========================================================--
-- UI HELPERS
--========================================================--

local function CreateButton(Parent,Text,Callback)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,-8,0,32)
    Button.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Button.Text = Text
    Button.TextColor3 = Color3.new(1,1,1)
    Button.TextSize = 11
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.ZIndex = 12
    Button.Parent = Parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,7)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(Callback)

    return Button
end

local function CreateToggle(Parent,Text,Default,Callback)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,-8,0,32)

    local State = Default

    local function Refresh()
        Button.Text = Text.."  "..(State and "ON" or "OFF")
        Button.BackgroundColor3 = State
            and Color3.fromRGB(150,20,20)
            or Color3.fromRGB(40,40,40)
    end

    Button.TextColor3 = Color3.new(1,1,1)
    Button.TextSize = 11
    Button.Font = Enum.Font.Gotham
    Button.BorderSizePixel = 0
    Button.ZIndex = 12
    Button.Parent = Parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,7)
    Corner.Parent = Button

    Refresh()

    Button.MouseButton1Click:Connect(function()

        State = not State
        Refresh()
        Callback(State)

    end)

    return Button
end

local function CreateSlider(Parent,Text,Min,Max,Default,Callback)

    local Holder = Instance.new("Frame")
    Holder.Size = UDim2.new(1,-8,0,50)
    Holder.BackgroundTransparency = 1
    Holder.ZIndex = 12
    Holder.Parent = Parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1,0,0,20)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(230,230,230)
    Label.TextSize = 11
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 13
    Label.Parent = Holder

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1,0,0,8)
    Bar.Position = UDim2.fromOffset(0,27)
    Bar.BackgroundColor3 = Color3.fromRGB(50,50,50)
    Bar.BorderSizePixel = 0
    Bar.ZIndex = 13
    Bar.Parent = Holder

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(1,0)
    Corner.Parent = Bar

    local Fill = Instance.new("Frame")
    Fill.BackgroundColor3 = Color3.fromRGB(190,25,25)
    Fill.BorderSizePixel = 0
    Fill.ZIndex = 14
    Fill.Parent = Bar

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1,0)
    FillCorner.Parent = Fill

    local function SetValue(Value)

        Value = math.clamp(Value,Min,Max)

        local Percent = (Value-Min)/(Max-Min)

        Fill.Size = UDim2.new(Percent,0,1,0)
        Label.Text = Text..": "..math.floor(Value)

        Callback(math.floor(Value))
    end

    SetValue(Default)

    local Dragging = false

    Bar.InputBegan:Connect(function(Input)

        if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

            Dragging = true

            local Percent = math.clamp(
                (Input.Position.X-Bar.AbsolutePosition.X) /
                Bar.AbsoluteSize.X,
                0,1
            )

            SetValue(Min+(Max-Min)*Percent)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)

        if not Dragging then
            return
        end

        if Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch then

            local Percent = math.clamp(
                (Input.Position.X-Bar.AbsolutePosition.X) /
                Bar.AbsoluteSize.X,
                0,1
            )

            SetValue(Min+(Max-Min)*Percent)
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)

        if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

            Dragging = false
        end
    end)

    return Holder
end

--========================================================--
-- PLAYER
--========================================================--

CreateSlider(PlayerPage,"Walk Speed",16,150,16,function(Value)

    Config.WalkSpeed = Value

    local Humanoid = Player.Character
        and Player.Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        Humanoid.WalkSpeed = Value
    end
end)

CreateSlider(PlayerPage,"Jump Power",50,150,50,function(Value)

    Config.JumpPower = Value

    local Humanoid = Player.Character
        and Player.Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = Value
    end
end)

CreateToggle(PlayerPage,"Noclip",false,function(Value)
    Config.Noclip = Value
end)

CreateToggle(PlayerPage,"Infinite Jump",false,function(Value)
    Config.InfiniteJump = Value
end)

CreateToggle(PlayerPage,"Fly",false,function(Value)
    Config.Fly = Value
end)

CreateSlider(PlayerPage,"Fly Speed",10,200,50,function(Value)
    Config.FlySpeed = Value
end)

CreateButton(PlayerPage,"📍 SET SPAWN",function()

    local Character = Player.Character
    local Root = Character and Character:FindFirstChild("HumanoidRootPart")

    if Root then
        Config.SpawnPosition = Root.CFrame
        print("[V2.5.1] Spawn saved")
    end
end)

CreateButton(PlayerPage,"📍 TELEPORT TO SPAWN",function()

    if not Config.SpawnPosition then
        warn("[V2.5.1] No spawn set")
        return
    end

    local Character = Player.Character
    local Root = Character and Character:FindFirstChild("HumanoidRootPart")

    if Root then
        Root.CFrame = Config.SpawnPosition + Vector3.new(0,3,0)
    end
end)

CreateButton(PlayerPage,"✕ CLEAR SPAWN",function()
    Config.SpawnPosition = nil
end)

CreateButton(PlayerPage,"Reset Character",function()

    local Humanoid = Player.Character
        and Player.Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        Humanoid.Health = 0
    end
end)

CreateSlider(
    PlayerPage,
    "Gravity",
    0,
    250,
    math.floor(workspace.Gravity),
    function(Value)

        Config.Gravity = Value
        workspace.Gravity = Value
    end
)

--========================================================--
-- VISUAL CONTROLS
--========================================================--

CreateToggle(VisualPage,"ESP",false,function(Value)
    Config.ESP = Value
end)

CreateToggle(VisualPage,"ESP Info",false,function(Value)
    Config.ESPInfo = Value
end)

CreateToggle(VisualPage,"Tracers",false,function(Value)
    Config.Tracers = Value
end)

CreateToggle(VisualPage,"FOV Circle",false,function(Value)
    Config.FOVCircle = Value
end)

CreateSlider(VisualPage,"FOV",50,500,200,function(Value)
    Config.FOV = Value
end)

CreateToggle(VisualPage,"X-Ray",false,function(Value)
    Config.XRay = Value
end)

CreateToggle(VisualPage,"No Fog",false,function(Value)
    Config.NoFog = Value
end)

CreateToggle(VisualPage,"Full Bright",false,function(Value)
    Config.FullBright = Value
end)

CreateToggle(VisualPage,"Night Vision",false,function(Value)
    Config.NightVision = Value
end)

CreateToggle(VisualPage,"Shadows",true,function(Value)

    Config.Shadows = Value
    Lighting.GlobalShadows = Value

end)

--========================================================--
-- COMBAT CONTROLS
--========================================================--

CreateToggle(CombatPage,"Aimbot",false,function(Value)
    Config.Aimbot = Value
end)

CreateSlider(CombatPage,"Aimbot FOV",50,500,200,function(Value)
    Config.AimbotFOV = Value
end)

CreateSlider(CombatPage,"Aim Smoothness",1,100,50,function(Value)
    Config.AimSmoothness = Value
end)

CreateSlider(CombatPage,"Aim Prediction",0,100,0,function(Value)
    Config.AimPrediction = Value
end)

CreateToggle(CombatPage,"Target Lock",false,function(Value)
    Config.TargetLock = Value
end)

CreateToggle(CombatPage,"Team Check",true,function(Value)
    Config.TeamCheck = Value
end)

CreateToggle(CombatPage,"Wall Check",true,function(Value)
    Config.WallCheck = Value
end)--========================================================--
-- CONFIG PROFILES
--========================================================--

local Profiles = {}

local ProfileBox = Instance.new("TextBox")
ProfileBox.Size = UDim2.new(1,-8,0,32)
ProfileBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
ProfileBox.PlaceholderText = "Profile name..."
ProfileBox.Text = ""
ProfileBox.TextColor3 = Color3.new(1,1,1)
ProfileBox.PlaceholderColor3 = Color3.fromRGB(130,130,130)
ProfileBox.TextSize = 11
ProfileBox.Font = Enum.Font.Gotham
ProfileBox.BorderSizePixel = 0
ProfileBox.ZIndex = 12
ProfileBox.Parent = SettingsPage

local ProfileCorner = Instance.new("UICorner")
ProfileCorner.CornerRadius = UDim.new(0,7)
ProfileCorner.Parent = ProfileBox

local function CopyConfig()

    local Data = {}

    for Key,Value in pairs(Config) do
        if typeof(Value) ~= "CFrame" then
            Data[Key] = Value
        end
    end

    return Data
end

local function LoadConfig(Data)

    if not Data then
        return
    end

    for Key,Value in pairs(Data) do

        if Config[Key] ~= nil then
            Config[Key] = Value
        end
    end

    local Character = Player.Character
    local Humanoid = Character
        and Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        Humanoid.WalkSpeed = Config.WalkSpeed
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = Config.JumpPower
    end

    workspace.Gravity = Config.Gravity
end

CreateButton(SettingsPage,"💾 SAVE PROFILE",function()

    local Name = ProfileBox.Text

    if Name == "" then
        return
    end

    Profiles[Name] = CopyConfig()

    print("[V2.5.1] Profile saved:",Name)
end)

CreateButton(SettingsPage,"📂 LOAD PROFILE",function()

    local Name = ProfileBox.Text

    if Profiles[Name] then
        LoadConfig(Profiles[Name])
        print("[V2.5.1] Profile loaded:",Name)
    end
end)

CreateButton(SettingsPage,"🗑 DELETE PROFILE",function()

    local Name = ProfileBox.Text

    if Profiles[Name] then
        Profiles[Name] = nil
        print("[V2.5.1] Profile deleted:",Name)
    end
end)

--========================================================--
-- UI EDITOR
--========================================================--

CreateSlider(SettingsPage,"UI Transparency",0,90,50,function(Value)

    Config.UITransparency = Value/100
    Overlay.BackgroundTransparency = Config.UITransparency

end)

CreateSlider(SettingsPage,"UI Width",300,600,390,function(Value)

    Config.UIWidth = Value

    Main.Size = UDim2.fromOffset(
        Config.UIWidth,
        Config.UIHeight
    )
end)

CreateSlider(SettingsPage,"UI Height",220,500,290,function(Value)

    Config.UIHeight = Value

    Main.Size = UDim2.fromOffset(
        Config.UIWidth,
        Config.UIHeight
    )
end)

CreateButton(SettingsPage,"🎨 RESET UI SIZE",function()

    Config.UIWidth = 390
    Config.UIHeight = 290
    Config.UITransparency = 0.50

    Main.Size = UDim2.fromOffset(390,290)
    Overlay.BackgroundTransparency = 0.50

end)

--========================================================--
-- SEARCH
--========================================================--

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1,-8,0,34)
SearchBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
SearchBox.PlaceholderText = "🔎 Search..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.new(1,1,1)
SearchBox.PlaceholderColor3 = Color3.fromRGB(140,140,140)
SearchBox.TextSize = 11
SearchBox.Font = Enum.Font.Gotham
SearchBox.BorderSizePixel = 0
SearchBox.ZIndex = 15
SearchBox.Parent = Content

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0,8)
SearchCorner.Parent = SearchBox

local SearchResults = Instance.new("ScrollingFrame")
SearchResults.Size = UDim2.new(1,-8,1,-44)
SearchResults.Position = UDim2.fromOffset(4,40)
SearchResults.BackgroundTransparency = 1
SearchResults.BorderSizePixel = 0
SearchResults.ScrollBarThickness = 3
SearchResults.Visible = false
SearchResults.ZIndex = 16
SearchResults.Parent = Content

local SearchLayout = Instance.new("UIListLayout")
SearchLayout.Padding = UDim.new(0,4)
SearchLayout.Parent = SearchResults

local SearchEntries = {
    {"Walk Speed","Player"},
    {"Jump Power","Player"},
    {"Noclip","Player"},
    {"Infinite Jump","Player"},
    {"Fly","Player"},
    {"Fly Speed","Player"},
    {"Set Spawn","Player"},
    {"Teleport to Spawn","Player"},
    {"Clear Spawn","Player"},

    {"ESP","Visual"},
    {"ESP Info","Visual"},
    {"Tracers","Visual"},
    {"FOV Circle","Visual"},
    {"X-Ray","Visual"},
    {"No Fog","Visual"},
    {"Full Bright","Visual"},
    {"Night Vision","Visual"},

    {"Aimbot","Combat"},
    {"Aimbot FOV","Combat"},
    {"Aim Smoothness","Combat"},
    {"Aim Prediction","Combat"},
    {"Target Lock","Combat"},
    {"Team Check","Combat"},
    {"Wall Check","Combat"},

    {"Config Profiles","Settings"},
    {"UI Editor","Settings"},

    {"Hub Stats","Developer"},
    {"Developer Mode","Developer"},
    {"Modules","Developer"}
}

local function ClearSearch()

    for _,Child in ipairs(SearchResults:GetChildren()) do

        if Child:IsA("TextButton") then
            Child:Destroy()
        end
    end
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()

    ClearSearch()

    local Query = string.lower(SearchBox.Text)

    if Query == "" then
        SearchResults.Visible = false
        return
    end

    SearchResults.Visible = true

    for _,Entry in ipairs(SearchEntries) do

        local Name = Entry[1]
        local PageName = Entry[2]

        if string.find(
            string.lower(Name),
            Query,
            1,
            true
        ) then

            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1,-4,0,32)
            Button.BackgroundColor3 = Color3.fromRGB(45,20,20)
            Button.Text = Name.."  →  "..PageName
            Button.TextColor3 = Color3.new(1,1,1)
            Button.TextSize = 11
            Button.Font = Enum.Font.Gotham
            Button.BorderSizePixel = 0
            Button.ZIndex = 17
            Button.Parent = SearchResults

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0,7)
            Corner.Parent = Button

            Button.MouseButton1Click:Connect(function()

                SearchBox.Text = ""
                SearchResults.Visible = false

                ShowPage(PageName)
            end)
        end
    end
end)

--========================================================--
-- HUB STATS
--========================================================--

local StatsTitle = Instance.new("TextLabel")
StatsTitle.Size = UDim2.new(1,-8,0,25)
StatsTitle.BackgroundTransparency = 1
StatsTitle.Text = "📊 HUB STATS"
StatsTitle.TextColor3 = Color3.fromRGB(255,100,100)
StatsTitle.TextSize = 13
StatsTitle.Font = Enum.Font.GothamBold
StatsTitle.TextXAlignment = Enum.TextXAlignment.Left
StatsTitle.ZIndex = 12
StatsTitle.Parent = DeveloperPage

local StatsLabel = Instance.new("TextLabel")
StatsLabel.Size = UDim2.new(1,-8,0,150)
StatsLabel.BackgroundColor3 = Color3.fromRGB(20,20,20)
StatsLabel.BackgroundTransparency = 0.15
StatsLabel.TextColor3 = Color3.new(1,1,1)
StatsLabel.TextSize = 11
StatsLabel.Font = Enum.Font.Code
StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
StatsLabel.TextYAlignment = Enum.TextYAlignment.Top
StatsLabel.BorderSizePixel = 0
StatsLabel.ZIndex = 12
StatsLabel.Parent = DeveloperPage

local StatsCorner = Instance.new("UICorner")
StatsCorner.CornerRadius = UDim.new(0,8)
StatsCorner.Parent = StatsLabel

--========================================================--
-- DEVELOPER MODE
--========================================================--

CreateToggle(DeveloperPage,"Developer Mode",false,function(Value)
    ToggleModule("Developer Mode",Value)
end)

CreateToggle(DeveloperPage,"Spawn System",false,function(Value)
    ToggleModule("Spawn System",Value)
end)

CreateButton(DeveloperPage,"🔄 Reload UI",function()
    print("[V2.5.1] UI reload requested")
end)

CreateButton(DeveloperPage,"🧹 Reset Config",function()

    Config.WalkSpeed = 16
    Config.JumpPower = 50
    Config.FlySpeed = 50
    Config.Gravity = 196.2
    Config.Noclip = false
    Config.InfiniteJump = false
    Config.Fly = false
    Config.Aimbot = false
    Config.ESP = false
    Config.ESPInfo = false
    Config.Tracers = false

    workspace.Gravity = 196.2

    print("[V2.5.1] Config reset")
end)

CreateButton(DeveloperPage,"🧩 LIST MODULES",function()

    for Name,Module in pairs(Modules) do
        print(
            "[MODULE]",
            Name,
            "Enabled:",
            Module.Enabled
        )
    end
end)

--========================================================--
-- NOCLIP
--========================================================--

RunService.Stepped:Connect(function()

    if not Config.Noclip then
        return
    end

    local Character = Player.Character

    if not Character then
        return
    end

    for _,Part in ipairs(Character:GetDescendants()) do

        if Part:IsA("BasePart") then
            Part.CanCollide = false
        end
    end
end)

--========================================================--
-- INFINITE JUMP
--========================================================--

UserInputService.JumpRequest:Connect(function()

    if not Config.InfiniteJump then
        return
    end

    local Humanoid = Player.Character
        and Player.Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        Humanoid:ChangeState(
            Enum.HumanoidStateType.Jumping
        )
    end
end)

--========================================================--
-- CHARACTER SETTINGS
--========================================================--

local function ApplyCharacterSettings(Character)

    local Humanoid = Character:WaitForChild("Humanoid",10)

    if not Humanoid then
        return
    end

    Humanoid.WalkSpeed = Config.WalkSpeed
    Humanoid.UseJumpPower = true
    Humanoid.JumpPower = Config.JumpPower

    if Config.HipHeight ~= nil then
        Humanoid.HipHeight = Config.HipHeight
    end
end

Player.CharacterAdded:Connect(function(Character)

    task.wait(0.5)
    ApplyCharacterSettings(Character)

end)

if Player.Character then
    task.spawn(function()
        ApplyCharacterSettings(Player.Character)
    end)
end

--========================================================--
-- FLY
--========================================================--

local FlyVelocity
local FlyGyro

local function StopFly()

    if FlyVelocity then
        FlyVelocity:Destroy()
        FlyVelocity = nil
    end

    if FlyGyro then
        FlyGyro:Destroy()
        FlyGyro = nil
    end
end

RunService.RenderStepped:Connect(function()

    if not Config.Fly then
        StopFly()
        return
    end

    local Character = Player.Character
    local Root = Character
        and Character:FindFirstChild("HumanoidRootPart")

    if not Root then
        return
    end

    if not FlyVelocity then

        FlyVelocity = Instance.new("BodyVelocity")
        FlyVelocity.MaxForce = Vector3.new(1e9,1e9,1e9)
        FlyVelocity.Parent = Root
    end

    if not FlyGyro then

        FlyGyro = Instance.new("BodyGyro")
        FlyGyro.MaxTorque = Vector3.new(1e9,1e9,1e9)
        FlyGyro.P = 1e5
        FlyGyro.Parent = Root
    end

    local Direction = Vector3.zero

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        Direction += Camera.CFrame.LookVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        Direction -= Camera.CFrame.LookVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        Direction -= Camera.CFrame.RightVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        Direction += Camera.CFrame.RightVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        Direction += Vector3.new(0,1,0)
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        Direction -= Vector3.new(0,1,0)
    end

    if Direction.Magnitude > 0 then
        Direction = Direction.Unit * Config.FlySpeed
    end

    FlyVelocity.Velocity = Direction
    FlyGyro.CFrame = Camera.CFrame

end)

--========================================================--
-- FOV CIRCLE
--========================================================--

local FOVGui = Instance.new("Frame")
FOVGui.BackgroundTransparency = 1
FOVGui.Visible = false
FOVGui.ZIndex = 50
FOVGui.Parent = Gui

local FOVCorner = Instance.new("UICorner")
FOVCorner.CornerRadius = UDim.new(1,0)
FOVCorner.Parent = FOVGui

local FOVStroke = Instance.new("UIStroke")
FOVStroke.Color = Color3.fromRGB(255,40,40)
FOVStroke.Thickness = 1
FOVStroke.Parent = FOVGui

RunService.RenderStepped:Connect(function()

    local Radius = Config.FOV

    FOVGui.Size = UDim2.fromOffset(
        Radius*2,
        Radius*2
    )

    local Viewport = Camera.ViewportSize

    FOVGui.Position = UDim2.fromOffset(
        Viewport.X/2-Radius,
        Viewport.Y/2-Radius
    )

    FOVGui.Visible = Config.FOVCircle
end)

--========================================================--
-- ESP SYSTEM
--========================================================--

local ESPObjects = {}

local function RemoveESP(TargetPlayer)

    local Data = ESPObjects[TargetPlayer]

    if not Data then
        return
    end

    if Data.Highlight then
        Data.Highlight:Destroy()
    end

    if Data.Billboard then
        Data.Billboard:Destroy()
    end

    if Data.Tracer then
        Data.Tracer:Destroy()
    end

    ESPObjects[TargetPlayer] = nil
end

local function IsEnemy(TargetPlayer)

    if TargetPlayer == Player then
        return false
    end

    if Config.TeamCheck and
       Player.Team ~= nil and
       TargetPlayer.Team ~= nil and
       Player.Team == TargetPlayer.Team then

        return false
    end

    return true
end

local function CreateESP(TargetPlayer)

    if TargetPlayer == Player then
        return
    end

    local Character = TargetPlayer.Character

    if not Character then
        return
    end

    local Root = Character:FindFirstChild("HumanoidRootPart")

    if not Root then
        return
    end

    RemoveESP(TargetPlayer)

    local Highlight = Instance.new("Highlight")
    Highlight.Name = "JhajuESP"
    Highlight.Adornee = Character
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillColor = Color3.fromRGB(255,40,40)
    Highlight.FillTransparency = 0.65
    Highlight.OutlineColor = Color3.fromRGB(255,100,100)
    Highlight.OutlineTransparency = 0
    Highlight.Enabled = Config.ESP and IsEnemy(TargetPlayer)
    Highlight.Parent = Gui

    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "JhajuESPInfo"
    Billboard.Adornee = Root
    Billboard.Size = UDim2.fromOffset(180,50)
    Billboard.StudsOffset = Vector3.new(0,3,0)
    Billboard.AlwaysOnTop = true
    Billboard.Enabled = Config.ESPInfo and IsEnemy(TargetPlayer)
    Billboard.Parent = Gui

    local Info = Instance.new("TextLabel")
    Info.Size = UDim2.fromScale(1,1)
    Info.BackgroundTransparency = 1
    Info.TextColor3 = Color3.new(1,1,1)
    Info.TextStrokeTransparency = 0
    Info.TextSize = 12
    Info.Font = Enum.Font.GothamBold
    Info.Text = TargetPlayer.Name
    Info.Parent = Billboard

    local Tracer = Instance.new("Frame")
    Tracer.Name = "JhajuTracer"
    Tracer.AnchorPoint = Vector2.new(0.5,0.5)
    Tracer.BackgroundColor3 = Color3.fromRGB(255,40,40)
    Tracer.BorderSizePixel = 0
    Tracer.Size = UDim2.fromOffset(2,0)
    Tracer.Visible = false
    Tracer.ZIndex = 45
    Tracer.Parent = Gui

    ESPObjects[TargetPlayer] = {
        Highlight = Highlight,
        Billboard = Billboard,
        Info = Info,
        Tracer = Tracer
    }
end

local function RefreshESP(TargetPlayer)

    local Data = ESPObjects[TargetPlayer]

    if not Data then
        CreateESP(TargetPlayer)
        Data = ESPObjects[TargetPlayer]
    end

    if not Data then
        return
    end

    local Character = TargetPlayer.Character
    local Root = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

    local Enemy = IsEnemy(TargetPlayer)

    Data.Highlight.Enabled =
        Config.ESP and Enemy

    Data.Billboard.Enabled =
        Config.ESPInfo and Enemy

    Data.Tracer.Visible =
        Config.Tracers and Enemy and Root ~= nil

    if Root and Humanoid then

        local Distance =
            (Camera.CFrame.Position - Root.Position).Magnitude

        Data.Info.Text =
            TargetPlayer.Name..
            "\nHP: "..math.floor(Humanoid.Health)..
            "/"..math.floor(Humanoid.MaxHealth)..
            " | "..math.floor(Distance).."m"

        local ScreenPos,OnScreen =
            Camera:WorldToViewportPoint(Root.Position)

        if Config.Tracers and Enemy and OnScreen then

            local Center =
                Vector2.new(
                    Camera.ViewportSize.X/2,
                    Camera.ViewportSize.Y
                )

            local Target =
                Vector2.new(
                    ScreenPos.X,
                    ScreenPos.Y
                )

            local Delta = Target-Center
            local Length = Delta.Magnitude

            Data.Tracer.Position =
                UDim2.fromOffset(
                    Center.X + Delta.X/2,
                    Center.Y + Delta.Y/2
                )

            Data.Tracer.Size =
                UDim2.fromOffset(2,Length)

            Data.Tracer.Rotation =
                math.deg(math.atan2(Delta.Y,Delta.X))+90

        else
            Data.Tracer.Visible = false
        end

    end
end

for _,TargetPlayer in ipairs(Players:GetPlayers()) do

    if TargetPlayer ~= Player then

        TargetPlayer.CharacterAdded:Connect(function()
            task.wait(0.5)
            CreateESP(TargetPlayer)
        end)

        CreateESP(TargetPlayer)
    end
end

Players.PlayerAdded:Connect(function(TargetPlayer)

    TargetPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        CreateESP(TargetPlayer)
    end)
end)

Players.PlayerRemoving:Connect(function(TargetPlayer)
    RemoveESP(TargetPlayer)
end)

RunService.RenderStepped:Connect(function()

    for _,TargetPlayer in ipairs(Players:GetPlayers()) do

        if TargetPlayer ~= Player then
            RefreshESP(TargetPlayer)
        end
    end
end)

--========================================================--
-- AIMBOT SYSTEM
--========================================================--

local LockedTarget = nil

local function GetTargetPart(Character)

    if not Character then
        return nil
    end

    return Character:FindFirstChild("Head")
        or Character:FindFirstChild("HumanoidRootPart")
        or Character:FindFirstChild("UpperTorso")
end

local function IsValidTarget(TargetPlayer)

    if not TargetPlayer
    or TargetPlayer == Player then
        return false
    end

    local Character = TargetPlayer.Character

    if not Character then
        return false
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    local Part = GetTargetPart(Character)

    if not Humanoid
    or Humanoid.Health <= 0
    or not Part then
        return false
    end

    if Config.TeamCheck
    and Player.Team ~= nil
    and TargetPlayer.Team ~= nil
    and Player.Team == TargetPlayer.Team then

        return false
    end

    return true
end

local function HasLineOfSight(TargetPart)

    if not Config.WallCheck then
        return true
    end

    local Origin = Camera.CFrame.Position
    local Direction = TargetPart.Position-Origin

    local Params = RaycastParams.new()
    Params.FilterType = Enum.RaycastFilterType.Exclude
    Params.FilterDescendantsInstances = {
        Player.Character
    }

    local Result =
        workspace:Raycast(
            Origin,
            Direction,
            Params
        )

    if not Result then
        return true
    end

    return Result.Instance:IsDescendantOf(
        TargetPart.Parent
    )
end

local function GetClosestTarget()

    local Closest = nil
    local ClosestDistance = Config.AimbotFOV

    local Center = Vector2.new(
        Camera.ViewportSize.X/2,
        Camera.ViewportSize.Y/2
    )

    for _,TargetPlayer in ipairs(Players:GetPlayers()) do

        if IsValidTarget(TargetPlayer) then

            local Character = TargetPlayer.Character
            local Part = GetTargetPart(Character)

            if Part then

                local ScreenPosition,OnScreen =
                    Camera:WorldToViewportPoint(
                        Part.Position
                    )

                if OnScreen then

                    local ScreenPoint =
                        Vector2.new(
                            ScreenPosition.X,
                            ScreenPosition.Y
                        )

                    local Distance =
                        (ScreenPoint-Center).Magnitude

                    if Distance < ClosestDistance
                    and HasLineOfSight(Part) then

                        ClosestDistance = Distance
                        Closest = TargetPlayer
                    end
                end
            end
        end
    end

    return Closest
end

RunService.RenderStepped:Connect(function()

    if not Config.Aimbot then
        LockedTarget = nil
        return
    end

    if Config.TargetLock
    and IsValidTarget(LockedTarget) then

        local Part =
            GetTargetPart(LockedTarget.Character)

        if Part and not HasLineOfSight(Part) then
            LockedTarget = nil
        end

    else
        LockedTarget = GetClosestTarget()
    end

    if not LockedTarget then
        return
    end

    local Character = LockedTarget.Character
    local Part = GetTargetPart(Character)

    if not Part then
        return
    end

    local AimPosition = Part.Position

    local Root =
        Character:FindFirstChild("HumanoidRootPart")

    if Root and Config.AimPrediction > 0 then

        AimPosition +=
            Root.AssemblyLinearVelocity
            * (Config.AimPrediction/100)
            * 0.05
    end

    local CurrentCFrame = Camera.CFrame

    local DesiredCFrame =
        CFrame.lookAt(
            CurrentCFrame.Position,
            AimPosition
        )

    local Smooth =
        math.clamp(
            Config.AimSmoothness/100,
            0.01,
            1
        )

    Camera.CFrame =
        CurrentCFrame:Lerp(
            DesiredCFrame,
            Smooth
        )
end)

--========================================================--
-- LIGHTING
--========================================================--

local OriginalBrightness = Lighting.Brightness
local OriginalAmbient = Lighting.Ambient
local OriginalOutdoor = Lighting.OutdoorAmbient
local OriginalFogStart = Lighting.FogStart
local OriginalFogEnd = Lighting.FogEnd

RunService.RenderStepped:Connect(function()

    if Config.FullBright or Config.NightVision then

        Lighting.Brightness = 3
        Lighting.Ambient = Color3.new(1,1,1)
        Lighting.OutdoorAmbient = Color3.new(1,1,1)

    else

        Lighting.Brightness = OriginalBrightness
        Lighting.Ambient = OriginalAmbient
        Lighting.OutdoorAmbient = OriginalOutdoor

    end

    if Config.NoFog then

        Lighting.FogStart = 0
        Lighting.FogEnd = 100000

    else

        Lighting.FogStart = OriginalFogStart
        Lighting.FogEnd = OriginalFogEnd
    end

    Lighting.GlobalShadows = Config.Shadows
end)

--========================================================--
-- HUB STATS
--========================================================--

local LastTime = tick()
local Frames = 0
local FPS = 60

RunService.RenderStepped:Connect(function()

    Frames += 1

    local Now = tick()

    if Now-LastTime >= 1 then

        FPS = Frames/(Now-LastTime)
        Frames = 0
        LastTime = Now
    end

    local Character = Player.Character

    local Humanoid = Character
        and Character:FindFirstChildOfClass("Humanoid")

    local Root = Character
        and Character:FindFirstChild("HumanoidRootPart")

    local Position =
        Root and Root.Position or Vector3.zero

    local Health =
        Humanoid and Humanoid.Health or 0

    local MaxHealth =
        Humanoid and Humanoid.MaxHealth or 0

    local Speed =
        Humanoid and Humanoid.WalkSpeed or 0

    local State =
        Humanoid
        and Humanoid:GetState().Name
        or "Unknown"

    local Ping = "?"

    pcall(function()

        Ping = math.floor(
            Player:GetNetworkPing()*1000
        )
    end)

    StatsLabel.Text =
        "FPS: "..math.floor(FPS).."\n"..
        "PING: "..tostring(Ping).." ms\n\n"..
        "POSITION\n"..
        "X: "..math.floor(Position.X).."\n"..
        "Y: "..math.floor(Position.Y).."\n"..
        "Z: "..math.floor(Position.Z).."\n\n"..
        "HEALTH: "..math.floor(Health)..
        "/"..math.floor(MaxHealth).."\n"..
        "WALKSPEED: "..math.floor(Speed).."\n"..
        "STATE: "..State
end)

--========================================================--
-- MINIMIZE / RESTORE
--========================================================--

local Restore = Instance.new("TextButton")
Restore.Size = UDim2.fromOffset(48,48)
Restore.Position = UDim2.new(0,20,0.5,-24)
Restore.BackgroundColor3 = Color3.fromRGB(100,15,15)
Restore.Text = "jh"
Restore.TextColor3 = Color3.new(1,1,1)
Restore.TextSize = 14
Restore.Font = Enum.Font.GothamBold
Restore.BorderSizePixel = 0
Restore.Visible = false
Restore.ZIndex = 60
Restore.Parent = Gui

local RestoreCorner = Instance.new("UICorner")
RestoreCorner.CornerRadius = UDim.new(1,0)
RestoreCorner.Parent = Restore

MakeDraggable(Restore)

local function HideHub()

    Main.Visible = false
    Restore.Visible = true
    SearchBox.Visible = false
    SearchResults.Visible = false
end

local function ShowHub()

    Main.Visible = true
    Restore.Visible = false
    SearchBox.Visible = true
end

Minimize.MouseButton1Click:Connect(HideHub)
Close.MouseButton1Click:Connect(HideHub)
Restore.MouseButton1Click:Connect(ShowHub)

UserInputService.InputBegan:Connect(function(Input,Processed)

    if Processed then
        return
    end

    if Input.KeyCode == Enum.KeyCode.RightControl then

        if Main.Visible then
            HideHub()
        else
            ShowHub()
        end
    end
end)

--========================================================--
-- START
--========================================================--

ShowPage("Player")

if Player.Character then

    task.spawn(function()
        ApplyCharacterSettings(Player.Character)
    end)
end

print("======================================")
print(" jhaju's admin panel V2.5.1")
print(" Developer Edition")
print(" Quick Aimbot: REMOVED")
print(" ESP: READY")
print(" Aimbot: READY")
print(" Spawn Point: READY")
print(" UI Editor: READY")
print(" Search: READY")
print(" Config Profiles: READY")
print(" Hub Stats: READY")
print(" Module System: READY")
print("======================================")