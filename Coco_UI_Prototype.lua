-- Coco_UI_Prototype.lua | Roblox | Luau
-- Standalone interface prototype. No gameplay modification or executor hooks.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local previous = playerGui:FindFirstChild("CocoUIPrototype")
if previous then previous:Destroy() end

local theme = {
    bg = Color3.fromRGB(11, 11, 13),
    panel = Color3.fromRGB(20, 20, 23),
    surface = Color3.fromRGB(29, 29, 33),
    border = Color3.fromRGB(54, 54, 60),
    bright = Color3.fromRGB(244, 244, 245),
    muted = Color3.fromRGB(152, 152, 160),
    accent = Color3.fromRGB(238, 238, 241),
}
local state = {
    page = "Home",
    compact = false,
    touch = UserInputService.TouchEnabled,
    launched = os.clock(),
    travelled = 0,
    lastPosition = nil,
    nearbySeats = nil,
    status = {},
    connections = {},
    nav = {},
}

local function instance(kind, parent, props)
    local o = Instance.new(kind)
    for k, v in pairs(props or {}) do o[k] = v end
    o.Parent = parent
    return o
end
local function corner(o, radius)
    instance("UICorner", o, {CornerRadius = UDim.new(0, radius)})
end
local function stroke(o, color)
    instance("UIStroke", o, {Color=color or theme.border, Thickness=1})
end
local function pad(o, l, t, r, b)
    instance("UIPadding", o, {
        PaddingLeft=UDim.new(0,l), PaddingTop=UDim.new(0,t),
        PaddingRight=UDim.new(0,r), PaddingBottom=UDim.new(0,b)
    })
end
local function label(parent, text, size, color, height, bold)
    return instance("TextLabel", parent, {
        BackgroundTransparency=1, BorderSizePixel=0,
        Size=UDim2.new(1,0,0,height or 24),
        Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham,
        Text=text, TextSize=size or 14,
        TextColor3=color or theme.bright,
        TextXAlignment=Enum.TextXAlignment.Left,
        TextYAlignment=Enum.TextYAlignment.Center,
        TextWrapped=true,
    })
end
local function list(parent, spacing)
    instance("UIListLayout", parent, {
        FillDirection=Enum.FillDirection.Vertical,
        HorizontalAlignment=Enum.HorizontalAlignment.Center,
        SortOrder=Enum.SortOrder.LayoutOrder,
        Padding=UDim.new(0,spacing or 8),
    })
end

local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(900,650)
local width = math.min(760, math.max(330, viewport.X - 20))
local height = math.min(490, math.max(345, viewport.Y - 70))
local sideWidth = width < 520 and 115 or 174

local gui = instance("ScreenGui", playerGui, {
    Name="CocoUIPrototype", ResetOnSpawn=false, IgnoreGuiInset=true,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
})
local window = instance("Frame", gui, {
    Name="Window", AnchorPoint=Vector2.new(.5,.5),
    Position=UDim2.fromScale(.5,.5), Size=UDim2.fromOffset(width,height),
    BackgroundColor3=theme.bg, BorderSizePixel=0, ClipsDescendants=true,
})
corner(window, 14)
stroke(window, theme.border)
local scale = instance("UIScale", window, {Scale=1})

local side = instance("Frame",window,{
    BackgroundColor3=theme.panel, BorderSizePixel=0,
    Size=UDim2.new(0,sideWidth,1,0),
})
instance("Frame", side, {
    BackgroundColor3=theme.border, BorderSizePixel=0,
    Position=UDim2.new(1,-1,0,0), Size=UDim2.new(0,1,1,0),
})
local logo = instance("Frame",side,{
    BackgroundColor3=theme.surface, BorderSizePixel=0,
    Position=UDim2.fromOffset(13,16),Size=UDim2.fromOffset(41,41),
})
corner(logo,11)
stroke(logo)
local monogram = instance("TextLabel",logo,{
    BackgroundTransparency=1, Size=UDim2.fromScale(1,1),
    Font=Enum.Font.GothamBlack, Text="C", TextSize=26,
    TextColor3=theme.bright,
})
local name = instance("TextLabel",side,{
    BackgroundTransparency=1,Position=UDim2.fromOffset(13,64),
    Size=UDim2.new(1,-20,0,34),Font=Enum.Font.GothamBold,
    Text="COCO / HUB",TextColor3=theme.bright,
    TextSize=sideWidth<130 and 12 or 14, TextXAlignment=Enum.TextXAlignment.Left,
})
local menuArea = instance("Frame",side,{
    Position=UDim2.fromOffset(10,106),
    Size=UDim2.new(1,-20,1,-160),BackgroundTransparency=1,
})
list(menuArea,5)
local footer = instance("TextLabel",side,{
    BackgroundTransparency=1, Position=UDim2.new(0,12,1,-39),
    Size=UDim2.new(1,-22,0,24),
    Text="COCO  /  UI CONCEPT", TextXAlignment=Enum.TextXAlignment.Left,
    Font=Enum.Font.GothamMedium, TextColor3=theme.muted,
    TextSize=sideWidth<130 and 9 or 10,
})

local main = instance("Frame",window,{
    Position=UDim2.fromOffset(sideWidth,0),
    Size=UDim2.new(1,-sideWidth,1,0),
    BackgroundTransparency=1,BorderSizePixel=0,
})
local heading = instance("Frame",main,{
    BackgroundTransparency=1,Position=UDim2.fromOffset(20,12),
    Size=UDim2.new(1,-40,0,52),
})
local title = instance("TextLabel",heading,{
    BackgroundTransparency=1,Size=UDim2.new(1,-50,0,27),
    Font=Enum.Font.GothamBold,Text="HOME",TextSize=22,
    TextColor3=theme.bright,TextXAlignment=Enum.TextXAlignment.Left,
})
local subtitle = instance("TextLabel",heading,{
    BackgroundTransparency=1,Position=UDim2.fromOffset(0,28),
    Size=UDim2.new(1,0,0,18),Font=Enum.Font.Gotham,
    Text="KUKIRIN LIFE  /  CONTROL CENTER",
    TextColor3=theme.muted,TextSize=11,
    TextXAlignment=Enum.TextXAlignment.Left,
})
local close = instance("TextButton",heading,{
    Text="–",Position=UDim2.new(1,-28,0,0),
    Size=UDim2.fromOffset(28,26), BackgroundColor3=theme.surface,
    TextColor3=theme.bright,Font=Enum.Font.GothamBold,TextSize=20,
    BorderSizePixel=0,
})
corner(close,6)
local body = instance("Frame",main,{
    Position=UDim2.fromOffset(20,70),Size=UDim2.new(1,-40,1,-84),
    BackgroundTransparency=1,BorderSizePixel=0,
})
local restore = instance("TextButton",gui,{
    Name="OpenCoco",Position=UDim2.new(0,16,.5,-19),
    Size=UDim2.fromOffset(76,39),BackgroundColor3=theme.bright,
    Text="COCO",Font=Enum.Font.GothamBold,TextSize=13,
    TextColor3=theme.bg,Visible=false,BorderSizePixel=0,
})
corner(restore,9)
local notice = instance("TextLabel",gui,{
    AnchorPoint=Vector2.new(.5,1),Position=UDim2.new(.5,0,1,-23),
    Size=UDim2.fromOffset(350,34),
    BackgroundColor3=theme.surface,BorderSizePixel=0,
    TextColor3=theme.bright,Font=Enum.Font.Gotham,
    TextSize=12,Text="",Visible=false,
})
corner(notice,8)

local function toast(message)
    notice.Text=message
    notice.Visible=true
    local current=message
    task.delay(2.3,function()
        if notice.Parent and notice.Text==current then notice.Visible=false end
    end)
end
local function copy(s)
    if type(setclipboard)=="function" then
        local ok=pcall(setclipboard,s)
        toast(ok and "Copied to clipboard" or "Clipboard was unavailable")
    else
        toast("Clipboard not supported in this runtime")
    end
end
local function panel(parent)
    local p=instance("Frame",parent,{
        BackgroundColor3=theme.panel,BorderSizePixel=0,
        Size=UDim2.new(1,0,0,108),AutomaticSize=Enum.AutomaticSize.Y,
    })
    corner(p,10);stroke(p);pad(p,14,13,14,13);list(p,7)
    return p
end
local function action(parent,text,callback)
    local b=instance("TextButton",parent,{
        Size=UDim2.new(1,0,0,34),BackgroundColor3=theme.surface,
        Text=text,Font=Enum.Font.GothamMedium,TextSize=12,
        TextColor3=theme.bright,BorderSizePixel=0,
    })
    corner(b,7)
    table.insert(state.connections,b.MouseButton1Click:Connect(callback))
    return b
end
local function note(parent,text)
    return label(parent,text,12,theme.muted,37,false)
end
local function section(parent,titleText,description)
    local p=panel(parent)
    label(p,titleText,14,theme.bright,23,true)
    if description then note(p,description) end
    return p
end

local render
local names={"Home","Ride","Garage","Style","Earn","Players","Mobile","Settings"}
local function selectPage(tab)
    state.page=tab
    title.Text=string.upper(tab)
    for key, b in pairs(state.nav) do
        b.BackgroundColor3=key==tab and theme.surface or theme.panel
        b.TextColor3=key==tab and theme.bright or theme.muted
    end
    render()
end
for _, n in ipairs(names) do
    local b=instance("TextButton",menuArea,{
        Text="   "..n,TextXAlignment=Enum.TextXAlignment.Left,
        Font=Enum.Font.GothamMedium,TextSize=13,
        TextColor3=theme.muted,BackgroundColor3=theme.panel,
        BorderSizePixel=0,Size=UDim2.new(1,0,0,34),
    })
    corner(b,7)
    state.nav[n]=b
    table.insert(state.connections,b.MouseButton1Click:Connect(function()selectPage(n)end))
end

local function currentSeat()
    local c=player.Character
    local hum=c and c:FindFirstChildOfClass("Humanoid")
    return hum and hum.SeatPart
end
local function updateTelemetry()
    local seat=currentSeat()
    local sp=seat and seat.AssemblyLinearVelocity.Magnitude or 0
    local stats=state.status
    if stats.status and stats.status.Parent then
        stats.status.Text=seat and "SEATED / MOVING" or "ON FOOT"
    end
    if stats.speed and stats.speed.Parent then
        stats.speed.Text=string.format("%.0f studs/s",sp)
    end
    if stats.vehicle and stats.vehicle.Parent then
        stats.vehicle.Text=seat and (seat.Parent and seat.Parent.Name or seat.Name) or "None"
    end
    if stats.session and stats.session.Parent then
        stats.session.Text=string.format("%d min",math.floor((os.clock()-state.launched)/60))
    end
    if stats.distance and stats.distance.Parent then
        stats.distance.Text=string.format("%.0f studs",state.travelled)
    end
end

render=function()
    for _,ch in ipairs(body:GetChildren()) do ch:Destroy() end
    state.status={}
    local scroll=instance("ScrollingFrame",body,{
        BackgroundTransparency=1,BorderSizePixel=0,
        Size=UDim2.fromScale(1,1),
        ScrollBarThickness=2,ScrollBarImageColor3=theme.muted,
        CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,
    })
    list(scroll,10)
    pad(scroll,2,1,6,9)

    if state.page=="Home" then
        local hero=section(scroll,"COCO'S KUKIRIN LIFE","A redesigned monochrome control center.\nClean navigation. Live ride telemetry. Focused workspaces.")
        action(hero,"Copy community invite",function()copy("https://discord.gg/r8V48K4CHd")end)
        local p=section(scroll,"LIVE SESSION","Your current vehicle and speed are updated in real time.")
        state.status.status=label(p,"ON FOOT",13,theme.bright,22,true)
        state.status.speed=label(p,"0 studs/s",12,theme.muted,21)
        state.status.vehicle=label(p,"None",12,theme.muted,21)
        local q=section(scroll,"QUICK ACCESS","Jump straight to the section you need.")
        for _,n in ipairs({"Ride","Garage","Players","Settings"}) do
            action(q,"Open "..n,function()selectPage(n)end)
        end
    elseif state.page=="Ride" then
        local p=section(scroll,"RIDE TELEMETRY","Read-only information from your current seat.")
        state.status.status=label(p,"ON FOOT",14,theme.bright,22,true)
        state.status.speed=label(p,"0 studs/s",13,theme.bright,23)
        state.status.vehicle=label(p,"None",12,theme.muted,21)
        note(p,"Vehicle physics settings are not included in this UI prototype.")
    elseif state.page=="Garage" then
        local p=section(scroll,"NEARBY VEHICLES","Inspect public seat objects within 100 studs of your character.")
        local result=label(p,"Press Scan to inspect nearby seats.",12,theme.muted,42)
        action(p,"Scan nearby seats",function()
            local c=player.Character
            local root=c and c:FindFirstChild("HumanoidRootPart")
            if not root then result.Text="Character not ready";return end
            local count,closest=0,math.huge
            for _,o in ipairs(workspace:GetDescendants()) do
                if (o:IsA("VehicleSeat") or o:IsA("Seat")) then
                    local distance=(o.Position-root.Position).Magnitude
                    if distance<=100 then count=count+1;closest=math.min(closest,distance) end
                end
            end
            result.Text=string.format("%d nearby seats%s",count,count>0 and string.format("  •  nearest %.0f studs",closest) or "")
        end)
    elseif state.page=="Style" then
        local p=section(scroll,"DESIGN SYSTEM","A restrained black, white and graphite interface.")
        note(p,"Rounded panels, thin borders, grouped controls and high-contrast typography.")
        action(p,state.compact and "Switch to standard density" or "Switch to compact density",function()
            state.compact=not state.compact
            scale.Scale=state.compact and .91 or 1
            selectPage("Style")
        end)
    elseif state.page=="Earn" then
        local p=section(scroll,"SESSION TRACKER","A simple local activity log, separate from gameplay automation.")
        state.status.session=label(p,"0 min",14,theme.bright,25,true)
        state.status.distance=label(p,"0 studs",14,theme.bright,25)
        action(p,"Reset distance counter",function()
            state.travelled=0;state.lastPosition=nil;updateTelemetry()
            toast("Distance counter reset")
        end)
    elseif state.page=="Players" then
        local p=section(scroll,"PLAYER DIRECTORY","Current server members, excluding your own account.")
        local results=label(p,"Press Refresh to show players.",12,theme.muted,115)
        action(p,"Refresh player list",function()
            local a={}
            for _,plr in ipairs(Players:GetPlayers()) do
                if plr~=player then a[#a+1]=plr.DisplayName.."  (@"..plr.Name..")" end
            end
            table.sort(a)
            results.Text=#a>0 and table.concat(a,"\n") or "No other players found."
        end)
    elseif state.page=="Mobile" then
        local p=section(scroll,"TOUCH EXPERIENCE","Mobile-friendly entry point with a persistent reopen button.")
        note(p,"Touch input detected: "..tostring(UserInputService.TouchEnabled))
        action(p,state.touch and "Use regular UI scale" or "Enable larger touch controls",function()
            state.touch=not state.touch
            scale.Scale=state.touch and 1.05 or 1
            selectPage("Mobile")
        end)
    else
        local p=section(scroll,"PREFERENCES","Customize the presentation without changing gameplay.")
        action(p,"Reset display scale",function()
            state.compact=false;state.touch=false;scale.Scale=1
            toast("Display scale reset")
        end)
        action(p,"Copy Coco Discord",function()
            copy("https://discord.gg/r8V48K4CHd")
        end)
        note(p,"RightShift opens and closes the window on keyboard. The COCO button reopens it on touch.")
    end
    updateTelemetry()
end

local function setWindowVisible(visible)
    window.Visible=visible
    restore.Visible=not visible
end
table.insert(state.connections,close.MouseButton1Click:Connect(function()setWindowVisible(false)end))
table.insert(state.connections,restore.MouseButton1Click:Connect(function()setWindowVisible(true)end))
table.insert(state.connections,UserInputService.InputBegan:Connect(function(input,processed)
    if not processed and input.KeyCode==Enum.KeyCode.RightShift then
        setWindowVisible(not window.Visible)
    end
end))

local dragging, dragStart, startPos=false,nil,nil
table.insert(state.connections,heading.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        dragging=true;dragStart=input.Position;startPos=window.Position
    end
end))
table.insert(state.connections,UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        dragging=false
    end
end))
table.insert(state.connections,UserInputService.InputChanged:Connect(function(input)
    if dragging and dragStart and
      (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        local d=input.Position-dragStart
        window.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,
                                  startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
end))
local accumulator=0
table.insert(state.connections,RunService.Heartbeat:Connect(function(dt)
    accumulator=accumulator+dt
    if accumulator<.5 then return end
    accumulator=0
    local c=player.Character
    local root=c and c:FindFirstChild("HumanoidRootPart")
    if root then
        if state.lastPosition then
            local d=(root.Position-state.lastPosition).Magnitude
            if d<60 then state.travelled=state.travelled+d end
        end
        state.lastPosition=root.Position
    else
        state.lastPosition=nil
    end
    updateTelemetry()
end))
gui.Destroying:Connect(function()
    for _,c in ipairs(state.connections) do
        if c.Connected then c:Disconnect() end
    end
end)

selectPage("Home")
