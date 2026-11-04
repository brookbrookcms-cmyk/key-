-- CocoKukirinLife.lua | Roblox Luau | performance-optimized source
-- Direct execution avoids ObscuraVM VM overhead. Rejoin before first use.
local players = game:GetService("Players")
local starterPlayer = game:GetService("StarterPlayer")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local v1 = game:GetService("Workspace")
local httpService = game:GetService("HttpService")
local tweenService = game:GetService("TweenService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local virtualUser = game:GetService("VirtualUser")

local localPlayer = players.LocalPlayer

local function f1()
  local playerGui, waitForChild

  if gethui then
    local v27, v28 = pcall(gethui)

    if v27 and v28 then
      return v28
    end

    playerGui = localPlayer:FindFirstChild("PlayerGui")

    waitForChild = playerGui
    waitForChild = playerGui or localPlayer:WaitForChild("PlayerGui", 5)

    return waitForChild
  end

  playerGui = localPlayer:FindFirstChild("PlayerGui")

  waitForChild = playerGui
  waitForChild = playerGui or localPlayer:WaitForChild("PlayerGui", 5)

  return waitForChild
end

local v29 = f1()

local f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20,
  maxSPEED, boostPOWER, v30, v31, v32, v33, v34, v35, v36, v37, scooterFlySpeed, v38,
  mobileScooterFlySpeed, speedMult, v39, v40, v41, maxSpeed, mobileMaxSpeed, v42,
  mobileBoostPower, v43, v44, v45, mobileSteeringMultiplier, v46, v47, v48, v49, v50, v51,
  instance, instance2, connect, v52, instance3, instance4, connect2, v53, cframe, v54, connect3,
  v55, v56, v57, seatPart, antiCrashToggle, antiCrashToggle2, v58, values, v59, f21, v60, f22,
  f23, v61, connect4, v62, steeringMultiplier, v63, brakePower, v64, suspensionForce, v65,
  maybachSpeed, v66, rightShift, v67, espOutlineTransparency, v68, v69, v70, huge, dropdown,
  v71, connect5, f24, raycastParams, suavleysGUI, f25, f26, f27,
  f28, f29, toggle, toggle2, f30, f31, f32, f33, f34, f35, raycastParams2, f36

if not v29 then
  return
else
  -- Avoid duplicate input, Heartbeat, and GUI connections.
  if v29:FindFirstChild("SuavleysGUI") then
    warn("[Coco Kukirin Life] Already loaded. Rejoin Roblox to restart.")
    return
  end

  maxSPEED = 240
  boostPOWER = 0
  v30 = false
  v31 = false
  v32 = false
  v33 = false
  v34 = false
  v35 = false
  v36 = false
  v37 = false
  scooterFlySpeed = 50
  v38 = false
  mobileScooterFlySpeed = 50
  speedMult = 3
  v39 = nil
  v40 = nil
  v41 = nil
  maxSpeed = nil
  mobileMaxSpeed = 240
  v42 = false
  mobileBoostPower = 1.5
  v43 = false
  v44 = 0.05
  v45 = false
  mobileSteeringMultiplier = 1.5
  v46 = false
  v47 = 0.8
  v48 = {}
  v49 = 0
  v50 = 0
  v51 = false
  instance = nil
  instance2 = nil
  connect = nil
  v52 = 0
  instance3 = nil
  instance4 = nil
  connect2 = nil
  v53 = 0
  cframe = nil
  v54 = nil
  connect3 = nil
  v55 = false
  v56 = false
  v57 = false
  seatPart = nil
  antiCrashToggle = nil
  antiCrashToggle2 = nil

  v58 = {
    AutoOpen = false,
    SelectedCrates = { "Basic Crate" },
    OpenAmount = 1,
    Delay = 1,
    AutoLearn = true,
    LearnedRemote = nil,
    LearnedArgsTemplate = nil,
  }

  values = { "Basic Crate", "Charms Crate", "Sticker Pack", "Hardware Crate", "G5 Crate" }
  v59 = {}

  local function f37()
    table.clear(v59)
    local v72 = { "crate", "pack", "case", "unbox", "open", "roll", "spin", "chest", "box" }

    for index2, value2 in ipairs(replicatedStorage:GetDescendants()) do
      if index2 % 200 == 0 then task.wait() end
      if value2:IsA("RemoteEvent") or value2:IsA("RemoteFunction") then
        local v73 = string.lower(value2.Name)
        local v74 = value2.Parent and string.lower(value2.Parent.Name) or ""

        for index3, value3 in ipairs(v72) do
          if string.find(v73, value3) or string.find(v74, value3) then
            table.insert(v59, value2)
            break
          end
        end
      end
    end
  end

  task.defer(f37)

  pcall(function()
    if not hookmetamethod or not getnamecallmethod then
      return
    end

    local v75 = nil

    v75 = hookmetamethod(game, "__namecall", newcclosure(function(p1, ...)
      local v76 = getnamecallmethod()
      local v77 = { ... }

      if v58.AutoLearn and (v76 == "FireServer" or v76 == "InvokeServer") and not checkcaller() then
        local lower = string.lower
        local v78 = v77[1]
        local v79 = lower(tostring(p1.Name))
        local v80 = v78 and string.lower(tostring(v77[1])) or ""

        if string.find(v79, "crate") or string.find(v79, "pack") or string.find(v79, "unbox")
          or string.find(v79, "open") or string.find(v80, "crate") or string.find(v80, "pack") then
          v58.LearnedRemote = p1
          v58.LearnedArgsTemplate = v77
        end
      end

      return v75(p1, ...)
    end))
  end)

  function f5(p2, ...)
    local v81 = { ... }

    task.spawn(function()
      pcall(function()
        if p2:IsA("RemoteEvent") then
          p2:FireServer(unpack(v81))
        elseif p2:IsA("RemoteFunction") then
          p2:InvokeServer(unpack(v81))
        end
      end)
    end)
  end

  function f2(p3)
    local playerGui2 = localPlayer:FindFirstChild("PlayerGui")

    if not playerGui2 or not firesignal then
      return
    else
      local v82 = p3 == 3 and "3" or "1"

      for index4, value4 in ipairs(playerGui2:GetDescendants()) do
        local v83 = value4

        if v83:IsA("TextButton") or v83:IsA("ImageButton") then
          local v84 = string.lower(v83.Name)
          local v85 = v83:IsA("TextButton") and string.lower(v83.Text) or ""

          if string.find(v84, "open") or string.find(v85, "open") or string.find(v84, "buy") then
            if string.find(v84, v82) or string.find(v85, v82) then
              pcall(function()
                firesignal(v83.MouseButton1Click)
                firesignal(v83.Activated)
              end)
            end
          end
        end
      end

      return
    end
  end

  function f21(p4, p5)
    if v58.LearnedRemote then
      local learnedRemote = v58.LearnedRemote
      local learnedArgsTemplate = v58.LearnedArgsTemplate or {}

      if #learnedArgsTemplate >= 2 and type(learnedArgsTemplate[2]) == "number" then
        f5(learnedRemote, p4, p5)
      elseif #learnedArgsTemplate >= 1 and type(learnedArgsTemplate[1]) == "table" then
        f5(learnedRemote, {
          Crate = p4,
          Name = p4,
          Amount = p5,
          Count = p5,
        })
      else
        f5(learnedRemote, p4, p5)

        if p5 == 3 then
          local count = 0

          while true do
            count = 1 + count

            if not (3 >= count) then
              break
            end

            f5(learnedRemote, p4)
            task.wait(0.08)
          end
        else
          f5(learnedRemote, p4)
        end
      end

      return
    end

    for index5, value5 in ipairs(v59) do
      f5(value5, p4, p5)
      f5(value5, "Open", p4, p5)
      f5(value5, { Crate = p4, Amount = p5 })

      if p5 == 3 then
        f5(value5, p4, "3x")
        f5(value5, p4, true)

        for k = 1, 3 do
          f5(value5, p4)
          task.wait(0.05)
        end
      else
        f5(value5, p4)
        f5(value5, p4, "1x")
      end
    end

    f2(p5)
  end

  v60 = { VehicleImpactClient = true, PoliceHitClient = true, HeadImpactClient = true }

  function f3(p6)
    if v57 then
      return
    end

    v57 = true
    v56 = p6

    pcall(function()
      if antiCrashToggle and antiCrashToggle.Set then
        antiCrashToggle:Set(p6)
      end

      if antiCrashToggle2 and antiCrashToggle2.Set then
        antiCrashToggle2:Set(p6)
      end
    end)

    f22(p6)
    v57 = false
  end

  function f22(p7)
    local playerScripts = localPlayer:FindFirstChild("PlayerScripts")
    local starterPlayerScripts = starterPlayer:FindFirstChild("StarterPlayerScripts")

    local function f38(p8)
      if not p8 then
        return
      end

      for index6, value6 in ipairs(p8:GetDescendants()) do
        local v86 = value6

        if v60[v86.Name] then
          pcall(function()
            if v86:IsA("LocalScript") or v86:IsA("Script") then
              v86.Disabled = p7
              v86.Enabled = not p7
            end
          end)
        end
      end
    end

    f38(playerScripts)
    f38(starterPlayerScripts)
  end

  function f23()
    if v35 or v36 or v37 or v38 then
      f22(true)
    else
      f22(v56)
    end
  end

  task.spawn(function()
    local v87 = 0

    while true do
      task.wait(1)

      if v56 then
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

        if humanoid then
          if humanoid.SeatPart and humanoid.Sit then
            v87 = 0
            seatPart = humanoid.SeatPart
          elseif not humanoid.SeatPart and seatPart and seatPart.Parent then
            v87 = v87 + 1

            if v87 <= 5 then
              pcall(function()
                humanoid.PlatformStand = false
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart then
                  humanoidRootPart.CFrame = seatPart.CFrame + Vector3.new(0, 1.5, 0)
                end

                seatPart:Sit(humanoid)
              end)
            else
              f3(false)
              v87 = 0
            end
          end
        end
      else
        v87 = 0
      end
    end
  end)

  v61 = false
  connect4 = nil
  v62 = false
  steeringMultiplier = 1
  v63 = false
  brakePower = 0.05
  v64 = false
  suspensionForce = 5
  v65 = false
  maybachSpeed = 3
  v66 = false
  local rainbowCacheModel = nil
  local rainbowCacheParts = {}
  local rainbowCacheStamp = 0
  local rainbowTimer = 0
  rightShift = Enum.KeyCode.RightShift
  v67 = false
  espOutlineTransparency = 0
  v68 = {}
  v69 = 0
  v70 = nil
  huge = math.huge
  dropdown = nil
  v71 = false
  connect5 = nil

  function f4(p9)
    v71 = p9

    if p9 then
      if not connect5 then
        connect5 = localPlayer.Idled:Connect(function()
          virtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
          task.wait(1)
          virtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
      end

      f24()
    elseif connect5 then
      connect5:Disconnect()
      connect5 = nil
    end
  end

  function f24()
    local waitForChild2 = localPlayer:WaitForChild("PlayerGui", 5)
    local afkNotice, frame2

    if not waitForChild2 then
      return
    else
      if waitForChild2:FindFirstChild("AFK_Notice") then
        waitForChild2.AFK_Notice:Destroy()
      end

      afkNotice = Instance.new("ScreenGui")
      afkNotice.Name = "AFK_Notice"
      afkNotice.ResetOnSpawn = false
      afkNotice.IgnoreGuiInset = false
      afkNotice.Parent = waitForChild2

      frame2 = Instance.new("Frame")
      frame2.Size = UDim2.new(0, 560, 0, 60)
      frame2.Position = UDim2.new(0.5, 0, 0, -150)
      frame2.AnchorPoint = Vector2.new(0.5, 0)
      frame2.BackgroundColor3 = Color3.fromRGB(70, 90, 70)
      frame2.BackgroundTransparency = 0
      frame2.BorderSizePixel = 0
      frame2.ZIndex = 10
      frame2.Parent = afkNotice

      local uiCorner = Instance.new("UICorner")
      uiCorner.CornerRadius = UDim.new(0, 12)
      uiCorner.Parent = frame2

      local uiStroke = Instance.new("UIStroke")
      uiStroke.Color = Color3.fromRGB(180, 255, 180)
      uiStroke.Thickness = 2
      uiStroke.Transparency = 0.05
      uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
      uiStroke.Parent = frame2

      local textLabel = Instance.new("TextLabel")
      textLabel.Size = UDim2.new(1, -20, 1, -10)
      textLabel.Position = UDim2.new(0, 10, 0, 5)
      textLabel.BackgroundTransparency = 1
      textLabel.Text = "✅ Anti-Afk Executed. You can now afk without being kicked."
      textLabel.Font = Enum.Font.GothamSemibold
      textLabel.TextSize = 18
      textLabel.TextColor3 = Color3.fromRGB(240, 255, 240)
      textLabel.TextWrapped = true
      textLabel.TextXAlignment = Enum.TextXAlignment.Left
      textLabel.TextYAlignment = Enum.TextYAlignment.Center
      textLabel.ZIndex = 11
      textLabel.Parent = frame2

      tweenService:Create(
        frame2, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Position = UDim2.new(0.5, 0, 0, -50) }
      ):Play()

      task.delay(10, function()
        if afkNotice and afkNotice.Parent then
          local create = tweenService:Create(frame2, TweenInfo.new(
            2, Enum.EasingStyle.Quint, Enum.EasingDirection.In
          ), { Position = UDim2.new(0.5, 0, 0, -120) })

          create:Play()
          create.Completed:Wait()

          afkNotice:Destroy()
        end
      end)

      return
    end
  end

  RaycastParams.new().FilterType = Enum.RaycastFilterType.Exclude

  raycastParams = RaycastParams.new()
  raycastParams.FilterType = Enum.RaycastFilterType.Exclude
  raycastParams.IgnoreWater = true

  -- Remove leftovers from older versions if present.
  local oldHead = localPlayer.Character and localPlayer.Character:FindFirstChild("Head")
  local oldWatermark = oldHead and oldHead:FindFirstChild("DiscordWatermark")
  if oldWatermark then oldWatermark:Destroy() end

  suavleysGUI = Instance.new("ScreenGui")
  local global = Enum.ZIndexBehavior.Global

  suavleysGUI.Name = "SuavleysGUI"
  suavleysGUI.ResetOnSpawn = false
  suavleysGUI.ZIndexBehavior = global

  function f6(p11)
    local v88 = string.lower(p11.Name .. " " .. (p11.Parent and p11.Parent.Name or "") .. " "
      .. (p11:IsA("TextButton") and p11.Text or ""))

    if string.find(v88, "gas") or string.find(v88, "forward") or string.find(v88, "drive")
      or string.find(v88, "accel") or string.find(v88, "vor") or string.find(v88, "up")
      or string.find(v88, "throttle") or v88 == "w" then
      return 1, 0
    end

    if string.find(v88, "brake") or string.find(v88, "back") or string.find(v88, "reverse")
      or string.find(v88, "bremse") or string.find(v88, "down") or string.find(v88, "stop")
      or v88 == "s" then
      return -1, 0
    end

    if string.find(v88, "left") or string.find(v88, "links") or v88 == "a" then
      return 0, -1
    end

    if string.find(v88, "right") or string.find(v88, "rechts") or v88 == "d" then
      return 0, 1
    end

    return 0, 0
  end

  function f7()
    v49 = 0
    v50 = 0

    for key, value7 in pairs(v48) do
      if key and key.Parent then
        if value7[1] ~= 0 then
          v49 = value7[1]
        end

        if value7[2] ~= 0 then
          v50 = value7[2]
        end
      else
        v48[key] = nil
      end
    end
  end

  suavleysGUI.DisplayOrder = 999999
  suavleysGUI.IgnoreGuiInset = true
  suavleysGUI.Parent = v29

  function f25(p12)
    if not p12:IsA("GuiButton") then
      return
    end

    if p12:IsDescendantOf(suavleysGUI) then
      return
    end

    if string.find(string.lower(p12:GetFullName()), "windui") then
      return
    end

    p12.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        local v89, v90 = f6(p12)

        if v89 ~= 0 or v90 ~= 0 then
          v48[p12] = { v89, v90 }
          f7()
        end
      end
    end)

    p12.InputEnded:Connect(function(input2)
      if input2.UserInputType == Enum.UserInputType.Touch
        or input2.UserInputType == Enum.UserInputType.MouseButton1 then
        if v48[p12] then
          v48[p12] = nil
          f7()
        end
      end
    end)
  end

  task.spawn(function()
    local waitForChild4 = localPlayer:WaitForChild("PlayerGui", 5)

    if waitForChild4 then
      for index7, value8 in ipairs(waitForChild4:GetDescendants()) do
        f25(value8)
      end

      waitForChild4.DescendantAdded:Connect(f25)
    end
  end)

  function f8(p13, p14, p15, p16, text, fillColor, p17)
    if p16[p13] then
      return
    else
      local highlight = Instance.new("Highlight")
      highlight.Adornee = p14
      highlight.FillColor = fillColor
      highlight.OutlineColor = p17
      highlight.FillTransparency = 0.5
      highlight.OutlineTransparency = espOutlineTransparency
      highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
      highlight.Parent = p14

      local billboardGui = Instance.new("BillboardGui")
      billboardGui.Adornee = p15
      billboardGui.Size = UDim2.new(0, 150, 0, 24)
      billboardGui.StudsOffset = Vector3.new(0, 3, 0)
      billboardGui.AlwaysOnTop = true
      billboardGui.MaxDistance = 5000
      billboardGui.Parent = p15

      local textLabel5 = Instance.new("TextLabel")
      textLabel5.Size = UDim2.new(1, 0, 1, 0)
      textLabel5.BackgroundTransparency = 1
      textLabel5.Text = text
      textLabel5.TextColor3 = p17
      textLabel5.TextStrokeTransparency = 0.2
      textLabel5.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
      textLabel5.Font = Enum.Font.GothamBold
      textLabel5.TextSize = 11
      textLabel5.Parent = billboardGui

      p16[p13] = { highlight = highlight, billboard = billboardGui }
      return
    end
  end

  function f9()
    v46 = false

    if connect2 then
      connect2:Disconnect()
      connect2 = nil
    end

    if instance4 then
      instance4:Destroy()
      instance4 = nil
    end

    if instance3 then
      instance3:Destroy()
      instance3 = nil
    end
  end

  function f10()
    for key2, value9 in pairs(v68) do
      if value9.highlight then
        value9.highlight.OutlineTransparency = espOutlineTransparency
      end
    end
  end

  function f11(p18, canCollide)
    if p18 and p18.Parent then
      for index8, value10 in ipairs(p18:GetConnectedParts(true)) do
        if value10:IsA("BasePart") then
          value10.CanCollide = canCollide
        end
      end
    end

    if localPlayer.Character then
      for index9, value11 in ipairs(localPlayer.Character:GetDescendants()) do
        if value11:IsA("BasePart") then
          value11.CanCollide = canCollide
        end
      end
    end
  end

  function f12(p19, p20, p21)
    local throttleFloat = 0
    local steerFloat = 0

    if p20 and p20:IsA("VehicleSeat") then
      if math.abs(p20.ThrottleFloat) > 0.05 then
        throttleFloat = p20.ThrottleFloat
      elseif p20.Throttle ~= 0 then
        throttleFloat = p20.Throttle
      end

      if math.abs(p20.SteerFloat) > 0.05 then
        steerFloat = p20.SteerFloat
      elseif p20.Steer ~= 0 then
        steerFloat = p20.Steer
      end
    end

    if throttleFloat == 0 and v49 ~= 0 then
      throttleFloat = v49
    end

    if steerFloat == 0 and v50 ~= 0 then
      steerFloat = v50
    end

    if throttleFloat == 0 and p19 and p19.MoveDirection.Magnitude > 0.05 then
      local cframe2 = p20 and p20.CFrame

      local cframe3 = cframe2
      cframe3 = cframe2 or p21 and p21.CFrame

      if cframe3 then
        local vectorToObjectSpace = cframe3:VectorToObjectSpace(p19.MoveDirection)

        if vectorToObjectSpace.Z < -0.15 then
          throttleFloat = 1
        elseif vectorToObjectSpace.Z > 0.15 then
          throttleFloat = -1
        end

        if steerFloat == 0 and math.abs(vectorToObjectSpace.X) > 0.15 then
          steerFloat = vectorToObjectSpace.X > 0 and 1 or -1
        end
      end
    end

    return throttleFloat, steerFloat
  end

  function f13(p22)
    if not p22 or not p22.Parent then
      return false
    elseif p22:IsA("VehicleSeat") then
      return true
    elseif p22:IsA("Seat") then
      local v91 = string.lower(p22.Name)
      local v92 = p22.Parent and string.lower(p22.Parent.Name) or ""

      if string.find(v91, "drive") or string.find(v91, "ride_") or string.find(v92, "ride_")
        or string.find(v92, "scooter") then
        return true
      end

      return false
    else
      return false
    end
  end

  function f26()
    local character2 = localPlayer.Character
    return character2 and character2:FindFirstChildOfClass("Humanoid"), character2 and character2:FindFirstChild("HumanoidRootPart")
  end

  function f14()
    return v35 or v36
  end

  function f15()
    local v93, v94 = f27()

    if not v93 or not v94 then
      return false
    end

    raycastParams.FilterDescendantsInstances = { localPlayer.Character, v93 }

    if v1:Raycast(v94.Position, Vector3.new(0, -7.5, 0), raycastParams) then
      return true
    end

    return v1:Raycast(
      v94.Position - v94.CFrame.LookVector * 2.5, Vector3.new(0, -7.5, 0), raycastParams
    ) ~= nil
  end

  function f27()
    local character3 = localPlayer.Character

    if not character3 then
      return nil, nil
    else
      local humanoid2 = character3:FindFirstChildOfClass("Humanoid")

      if humanoid2 and humanoid2.SeatPart and humanoid2.SeatPart.Parent then
        local parent = humanoid2.SeatPart.Parent

        return parent, humanoid2.SeatPart.AssemblyRootPart or parent.PrimaryPart
          or parent:FindFirstChild("Chassis") or parent:FindFirstChild("Main")
          or parent:FindFirstChildWhichIsA("BasePart") or humanoid2.SeatPart
      end

      return character3, character3:FindFirstChild("HumanoidRootPart")
    end
  end

  function f16()
    local v95 = {}
    local v96, v97 = f26()

    for index10, value12 in ipairs(players:GetPlayers()) do
      if value12 ~= localPlayer and value12.Character
        and value12.Character:FindFirstChild("HumanoidRootPart") and v97 then
        if (v97.Position - value12.Character.HumanoidRootPart.Position).Magnitude <= huge then
          table.insert(v95, value12.Name)
        end
      end
    end

    if #v95 == 0 then
      table.insert(v95, "No Players in Range")
    end

    return v95
  end

  function f17()
    v51 = false

    if connect then
      connect:Disconnect()
      connect = nil
    end

    if instance2 then
      instance2:Destroy()
      instance2 = nil
    end

    if instance then
      instance:Destroy()
      instance = nil
    end
  end

  function f28()
    if connect3 then
      connect3:Disconnect()
    end

    connect3 = runService.Heartbeat:Connect(function()
      if not f14() then
        if connect3 then
          connect3:Disconnect()
          connect3 = nil
        end

        return
      else
        local character4 = localPlayer.Character

        if not character4 then
          return
        else
          local humanoid3 = character4:FindFirstChildOfClass("Humanoid")

          if humanoid3 and v54 and v54.Parent then
            if v54.Occupant ~= humanoid3 then
              v54:Sit(humanoid3)
            end
          end

          return
        end
      end
    end)
  end

  function f29(p23)
    f28()

    local function f40()
      return p23 and v36 or not p23 and v35
    end

    while f40() do
      local character5 = localPlayer.Character

      if not character5 then
        break
      else
        local humanoidRootPart2 = character5:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart2 then
          break
        else
          local assemblyRootPart = humanoidRootPart2.AssemblyRootPart or humanoidRootPart2
          local v98 = p23 and math.clamp(v47, 0.2, 1.5) or 1

          if not v54 or not v54.Parent then
            for index11, value13 in ipairs(assemblyRootPart:GetConnectedParts(true)) do
              if value13:IsA("Seat") or value13:IsA("VehicleSeat") then
                v54 = value13
                break
              end
            end
          end

          f11(assemblyRootPart, false)

          local findFirstChild = character5:FindFirstChild("VehicleImpactClient", true)
            or v1:FindFirstChild("VehicleImpactClient", true)

          if findFirstChild then
            if findFirstChild:IsA("LuaSourceContainer") then
              findFirstChild.Disabled = true
            elseif findFirstChild:IsA("BasePart") then
              findFirstChild.CanCollide = false
            end
          end

          local v99 = 0.35 / v98
          local total = 0
          local position = humanoidRootPart2.Position

          humanoidRootPart2.CFrame = CFrame.new(position)
            * (humanoidRootPart2.CFrame - position) * CFrame.Angles(math.rad(-60), 0, 0)

          while total < v99 and f40() do
            total = total + task.wait()

            humanoidRootPart2.AssemblyLinearVelocity = humanoidRootPart2.CFrame.LookVector
                * (20 * v98)
              + Vector3.new(0, 5, 0)
          end

          if not f40() then
            break
          end

          humanoidRootPart2.AssemblyLinearVelocity = humanoidRootPart2.CFrame.LookVector * 15
            + Vector3.new(0, 60, 0)

          task.wait(0.2 / v98)

          if not f40() then
            break
          else
            local v100 = p23 and 9 or 8
            local v101 = 1.6 / v98
            local total2 = 0

            while total2 < v101 and f40() do
              local v102 = task.wait()
              total2 = total2 + v102
              humanoidRootPart2.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
              local v103 = math.rad(360 * v100 / v101 * v102 * -1)
              local position2 = humanoidRootPart2.Position

              humanoidRootPart2.CFrame = humanoidRootPart2.CFrame * CFrame.Angles(v103, 0, 0)
              humanoidRootPart2.Position = position2
            end

            if not f40() then
              break
            else
              local position3 = humanoidRootPart2.Position
              local lookVector = humanoidRootPart2.CFrame.LookVector
              local unit = Vector3.new(lookVector.X, 0, lookVector.Z).Unit

              if unit.Magnitude > 0 then
                humanoidRootPart2.CFrame = CFrame.new(position3, position3 + unit)
              end

              humanoidRootPart2.AssemblyLinearVelocity = Vector3.new(0, -20 * v98, 0)

              local raycastParams3 = RaycastParams.new()

              raycastParams3.FilterDescendantsInstances = {
                character5, assemblyRootPart:GetConnectedParts(true),
              }

              raycastParams3.FilterType = Enum.RaycastFilterType.Exclude

              while f40() do
                task.wait(0.05)

                if v1:Raycast(humanoidRootPart2.Position, Vector3.new(0, -5, 0), raycastParams3) then
                  f11(assemblyRootPart, false)
                  break
                end
              end

              if not f40() then
                break
              end

              if f40() and cframe then
                f11(assemblyRootPart, false)
                local v104 = 1 / v98
                local total3 = 0
                local cframe4 = assemblyRootPart.CFrame

                while total3 < v104 and f40() do
                  total3 = total3 + runService.RenderStepped:Wait()
                  local v105 = math.clamp(total3 / v104, 0, 1)

                  assemblyRootPart.CFrame = cframe4:Lerp(cframe, v105 * v105 * (3 - 2 * v105))
                  assemblyRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                  assemblyRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end

                if f40() then
                  assemblyRootPart.CFrame = cframe
                  assemblyRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                  assemblyRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
              end

              if not f40() then
                break
              end

              task.wait(0.4 / v98)
            end
          end
        end
      end
    end
  end

  function f18()
    local v106 = {}

    if listfiles then
      local v107, v108 = pcall(listfiles, "")

      if v107 and v108 then
        for index12, value14 in ipairs(v108) do
          local v109 = string.match(value14, "SuavleyGUI_(.+)%.json$")

          if v109 then
            table.insert(v106, v109)
          end
        end
      end
    end

    if #v106 == 0 then
      table.insert(v106, "default")
    end

    return v106
  end

  toggle = nil

  function f19(p24, p25, p26)
    if v55 then
      return
    end

    if p24 then
      local character6 = localPlayer.Character
      local humanoid4 = character6 and character6:FindFirstChildOfClass("Humanoid")
      local seatPart2 = humanoid4 and humanoid4.SeatPart

      if not humanoid4 or not humanoid4.Sit or not seatPart2 or not f13(seatPart2) then
        v55 = true

        if p25 then
          v36 = false

          pcall(function()
            if toggle2 and toggle2.Set then
              toggle2:Set(false)
            end
          end)
        else
          v35 = false

          pcall(function()
            if toggle and toggle.Set then
              toggle:Set(false)
            end
          end)
        end

        v55 = false

        pcall(function()
          local windUI = getgenv().WindUI or _G.WindUI

          if windUI and windUI.Notify then
            windUI:Notify({
              Title = "Autofarm Error",
              Content = "You must be sitting on a scooter to start the autofarm!",
              Duration = 3,
            })
          end
        end)

        return
      end
    end

    v55 = true

    if p25 then
      v36 = p24

      if p24 and v35 then
        v35 = false

        pcall(function()
          if toggle and toggle.Set then
            toggle:Set(false)
          end
        end)
      end
    else
      v35 = p24

      if p24 and v36 then
        v36 = false

        pcall(function()
          if toggle2 and toggle2.Set then
            toggle2:Set(false)
          end
        end)
      end
    end

    v55 = false
    local character7 = localPlayer.Character

    local humanoidRootPart3 = character7
    humanoidRootPart3 = character7 and character7:FindFirstChild("HumanoidRootPart")

    local assemblyRootPart2 = humanoidRootPart3

    assemblyRootPart2 = humanoidRootPart3
      and (humanoidRootPart3.AssemblyRootPart or humanoidRootPart3)

    if p24 then
      if humanoidRootPart3 and assemblyRootPart2 then
        cframe = assemblyRootPart2.CFrame

        for index13, value15 in ipairs(assemblyRootPart2:GetConnectedParts(true)) do
          if value15:IsA("Seat") or value15:IsA("VehicleSeat") then
            v54 = value15
            break
          end
        end

        f11(assemblyRootPart2, false)
      end

      if p26 then
        p26:SetDesc(p25 and "MOBILE MONEY FARM ACTIVE" or "MONEY FARM ACTIVE")
      end

      f23()
      task.spawn(function() f29(p25) end)
    else
      if not f14() then
        if assemblyRootPart2 then
          f11(assemblyRootPart2, true)
        end

        if connect3 then
          connect3:Disconnect()
          connect3 = nil
        end

        if p26 then
          p26:SetDesc("Status: Idle")
        end
      end

      f23()
    end
  end

  toggle2 = nil

  function f20(p27)
    for key3, value16 in pairs(p27) do
      f30(value16)
      p27[key3] = nil
    end
  end

  function f30(p28)
    if not p28 then
      return
    end

    if p28.highlight and p28.highlight.Parent then
      p28.highlight:Destroy()
    end

    if p28.billboard and p28.billboard.Parent then
      p28.billboard:Destroy()
    end
  end

  function f31()
    if not v67 then
      f20(v68)
      return
    else
      local v110 = {}

      for index14, value17 in ipairs(players:GetPlayers()) do
        if value17 ~= localPlayer and value17.Character
          and value17.Character:FindFirstChild("Head") then
          v110[value17] = true

          f8(
            value17, value17.Character, value17.Character.Head, v68,
            value17.DisplayName or value17.Name, Color3.fromRGB(80, 180, 255),
            Color3.fromRGB(120, 200, 255)
          )
        end
      end

      for key4 in pairs(v68) do
        if not v110[key4] then
          f30(v68[key4])
          v68[key4] = nil
        end
      end

      return
    end
  end

  function f32(p29, p30)
    local v111, v112 = f27()

    if not v111 or not v112 then
      return
    end

    local getPivot = v111:IsA("Model") and v111:GetPivot() or v112.CFrame
    local v113 = os.clock()

    task.spawn(function()
      while true do
        local v114 = math.clamp((os.clock() - v113) / (p30 or 0.8), 0, 1)

        if v112 and v112.Parent then
          local zero = Vector3.zero
          v112.AssemblyLinearVelocity = Vector3.zero
          v112.AssemblyAngularVelocity = zero
        end

        if v111:IsA("Model") then
          v111:PivotTo(getPivot:Lerp(p29, v114))
        else
          v112.CFrame = getPivot:Lerp(p29, v114)
        end

        if v114 >= 1 then
          break
        end

        runService.Heartbeat:Wait()
      end
    end)
  end

  userInputService.InputBegan:Connect(function(input3, p31)
    if p31 then
      return
    end

    if input3.KeyCode == Enum.KeyCode.W or input3.KeyCode == Enum.KeyCode.Up then
      v31 = true
    elseif input3.KeyCode == Enum.KeyCode.S or input3.KeyCode == Enum.KeyCode.Down then
      v32 = true
    elseif input3.KeyCode == Enum.KeyCode.A or input3.KeyCode == Enum.KeyCode.Left then
      v33 = true
    elseif input3.KeyCode == Enum.KeyCode.D or input3.KeyCode == Enum.KeyCode.Right then
      v34 = true
    end
  end)

  userInputService.InputEnded:Connect(function(input4, p32)
    if input4.KeyCode == Enum.KeyCode.W or input4.KeyCode == Enum.KeyCode.Up then
      v31 = false
    elseif input4.KeyCode == Enum.KeyCode.S or input4.KeyCode == Enum.KeyCode.Down then
      v32 = false
    elseif input4.KeyCode == Enum.KeyCode.A or input4.KeyCode == Enum.KeyCode.Left then
      v33 = false
    elseif input4.KeyCode == Enum.KeyCode.D or input4.KeyCode == Enum.KeyCode.Right then
      v34 = false
    end
  end)

  function loadWindUI()
    local v115, v116 = pcall(function()
      return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end)

    local suavleysGuiWindow, statusParagraph, boostToggle, betterSteeringToggle,
      betterBrakesToggle, wheelieAssistToggle, toggle3, rainbowEScooterToggle, suspensionToggle,
      maybachSuspensionToggle, playerESPToggle, toggle4, toggle5, toggle6, toggle7,
      autofarmStatusParagraph, keybind, v117, selectConfigDropdown

    if not v115 or not v116 then
      return
    else
      getgenv().WindUI = v116

      pcall(function()
        v116:Notify({
          Title = "System Notice",
          Content = "Some features might not work anymore because the game got a new anti-cheat.",
          Duration = 6,
        })
      end)

      suavleysGuiWindow = v116:CreateWindow({
        Title = "coco's kukirin life",
        Icon = "https://raw.githubusercontent.com/brookbrookcms-cmyk/key-/main/assets/coco_kukirin_life.jpg",
        Author = "Made by coco",
        Folder = "SuavleysGUI",
        Size = UDim2.fromOffset(530, 420),
        Theme = "Dark",
        Transparent = true,
        ToggleKey = rightShift,
      })

      local aboutTab = suavleysGuiWindow:Tab({ Title = "About", Icon = "info" })
      local scooterTab = suavleysGuiWindow:Tab({ Title = "Scooter", Icon = "bike" })

      local mobileBetaTab = suavleysGuiWindow:Tab({
        Title = "Mobile (beta)",
        Icon = "smartphone",
      })

      local optikTab = suavleysGuiWindow:Tab({ Title = "Optik", Icon = "palette" })
      local autofarmTab = suavleysGuiWindow:Tab({ Title = "Autofarm", Icon = "coins" })
      local cratesTab = suavleysGuiWindow:Tab({ Title = "Crates", Icon = "package" })
      local funTab = suavleysGuiWindow:Tab({ Title = "Fun", Icon = "shield" })
      local otherTab = suavleysGuiWindow:Tab({ Title = "Other", Icon = "compass" })
      local configTab = suavleysGuiWindow:Tab({ Title = "Config", Icon = "settings" })
      suavleysGuiWindow:SelectTab(1)

      aboutTab:Paragraph({
        Title = "Made by coco",
        Desc = "Join coco's discord for more",
        Image = "https://raw.githubusercontent.com/brookbrookcms-cmyk/key-/main/assets/coco_kukirin_life.jpg",
        ImageSize = 80,
        Buttons = {
          {
            Title = "Copy Discord",
            Icon = "copy",
            Callback = function()
              if setclipboard then
                setclipboard("https://discord.gg/r8V48K4CHd")
              end
            end,
          },
        },
      })

      aboutTab:Paragraph({
        Title = "Notice",
        Desc = "Some features might not work anymore because the game got a new anti-cheat.",
      })

      aboutTab:Paragraph({ Title = "Discord", Desc = "https://discord.gg/r8V48K4CHd" })

      statusParagraph = scooterTab:Paragraph({ Title = "Status", Desc = "Ready" })
      boostToggle = nil
      betterSteeringToggle = nil
      betterBrakesToggle = nil
      wheelieAssistToggle = nil
      toggle3 = nil
      rainbowEScooterToggle = nil
      suspensionToggle = nil
      maybachSuspensionToggle = nil
      playerESPToggle = nil
      toggle4 = nil
      toggle5 = nil
      toggle6 = nil
      toggle7 = nil

      scooterTab:Slider({
        Title = "Speed Cap",
        Step = 1,
        Value = { Min = 30, Max = 1000, Default = maxSPEED },
        Callback = function(value18) maxSPEED = value18 end,
      })

      scooterTab:Slider({
        Title = "Acceleration",
        Step = 0.1,
        Value = { Min = 0, Max = 15, Default = boostPOWER },
        Callback = function(value19) boostPOWER = value19 end,
      })

      scooterTab:Slider({
        Title = "Speed Multiplier",
        Desc = "turn it down if you get teleported back the game got a new anti cheat",
        Step = 0.1,
        Value = { Min = 1, Max = 10, Default = speedMult },
        Callback = function(value20) speedMult = value20 end,
      })

      boostToggle = scooterTab:Toggle({
        Title = "Boost",
        Value = v30,
        Callback = function(value21)
          v30 = value21
          statusParagraph:SetDesc(value21 and "BOOST ACTIVE" or "BOOST OFF")
        end,
      })

      scooterTab:Slider({
        Title = "Fly Speed",
        Step = 5,
        Value = { Min = 10, Max = 1000, Default = scooterFlySpeed },
        Callback = function(value22) scooterFlySpeed = value22 end,
      })

      scooterTab:Toggle({
        Title = "Scooter Fly (PC)",
        Value = v37,
        Callback = function(value23)
          v37 = value23
          f23()
        end,
      })

      scooterTab:Slider({
        Title = "Steering Power",
        Step = 0.1,
        Value = { Min = 0.2, Max = 3, Default = steeringMultiplier },
        Callback = function(value24) steeringMultiplier = value24 end,
      })

      betterSteeringToggle = scooterTab:Toggle({
        Title = "Better Steering",
        Value = v62,
        Callback = function(value25) v62 = value25 end,
      })

      scooterTab:Slider({
        Title = "Brake Power",
        Desc = "make it lower when you crash while braking",
        Step = 0.01,
        Value = { Min = 0.01, Max = 0.2, Default = brakePower },
        Callback = function(value26) brakePower = value26 end,
      })

      betterBrakesToggle = scooterTab:Toggle({
        Title = "Better Brakes",
        Value = v63,
        Callback = function(value27) v63 = value27 end,
      })

      antiCrashToggle = scooterTab:Toggle({
        Title = "Anti Crash",
        Value = v56,
        Callback = function(value28) f3(value28) end,
      })

      toggle3 = scooterTab:Toggle({
        Title = "Glue on Floor",
        Desc = "Keeps vehicle upright and firmly grounded",
        Value = v61,
        Callback = function(value29)
          v61 = value29

          if value29 then
            if not connect4 then
              connect4 = runService.RenderStepped:Connect(function()
                local character8 = localPlayer.Character

                if not character8 then
                  return
                else
                  local humanoid5 = character8:FindFirstChildOfClass("Humanoid")

                  if not humanoid5 or not humanoid5.Sit or not humanoid5.SeatPart then
                    return
                  else
                    local assemblyRootPart3 = humanoid5.SeatPart.AssemblyRootPart
                      or humanoid5.SeatPart

                    if not assemblyRootPart3 then
                      return
                    else
                      if f15() then
                        local assemblyLinearVelocity = assemblyRootPart3.AssemblyLinearVelocity

                        if assemblyLinearVelocity.Y > 2 then
                          assemblyRootPart3.AssemblyLinearVelocity = Vector3.new(assemblyLinearVelocity.X, assemblyLinearVelocity.Y
                            * 0.25, assemblyLinearVelocity.Z)
                        end
                      end

                      local v118 = { assemblyRootPart3.CFrame:ToOrientation() }

                      assemblyRootPart3.CFrame = CFrame.new(assemblyRootPart3.Position)
                        * CFrame.Angles(0, v118[2], 0)

                      local assemblyAngularVelocity = assemblyRootPart3.AssemblyAngularVelocity

                      assemblyRootPart3.AssemblyAngularVelocity = Vector3.new(assemblyAngularVelocity.X
                        * 0.1, assemblyAngularVelocity.Y, assemblyAngularVelocity.Z
                        * 0.1)

                      return
                    end
                  end
                end
              end)
            end
          elseif connect4 then
            connect4:Disconnect()
            connect4 = nil
          end
        end,
      })

      wheelieAssistToggle = scooterTab:Toggle({
        Title = "Wheelie Assist",
        Desc = "wheelies for you",
        Value = v51,
        Callback = function(value30)
          local seatPart3

          if value30 then
            local v119 = f26()
            seatPart3 = v119 and v119.SeatPart

            if seatPart3 and f13(seatPart3) then
              instance = Instance.new("Attachment", seatPart3)

              instance2 = Instance.new("AlignOrientation", seatPart3)
              instance2.Mode = Enum.OrientationAlignmentMode.OneAttachment
              instance2.Attachment0 = instance

              local v120 = instance2
              local v121 = instance2
              instance2.MaxTorque = 100000000
              v120.MaxAngularVelocity = 35
              v121.Responsiveness = 30

              local v122, v123
              v122, v52, v123 = seatPart3.CFrame:ToOrientation()

              connect = runService.Heartbeat:Connect(function(delta)
                local v124 = f26()

                if not seatPart3 or not seatPart3.Parent or not v124
                  or v124.SeatPart ~= seatPart3 then
                  f17()
                  return
                else
                  local steerFloat2 = v33 and -1
                    or v34 and 1
                    or seatPart3:IsA("VehicleSeat")
                      and (seatPart3.SteerFloat ~= 0 and seatPart3.SteerFloat or seatPart3.Steer)
                    or 0

                  if steerFloat2 ~= 0 then
                    v52 = v52 - steerFloat2 * 3 * delta
                  end

                  instance2.CFrame = CFrame.Angles(0, v52, 0)
                    * CFrame.Angles(math.rad(35), 0, 0)

                  return
                end
              end)

              v51 = true
            end
          else
            f17()
          end
        end,
      })

      mobileBetaTab:Paragraph({
        Title = "Notice",
        Desc = "If stuff from the normal categories don't work try the mobile version",
      })

      antiCrashToggle2 = mobileBetaTab:Toggle({
        Title = "Anti Crash",
        Value = v56,
        Callback = function(value31) f3(value31) end,
      })

      mobileBetaTab:Slider({
        Title = "Mobile Speed Cap",
        Step = 1,
        Value = { Min = 30, Max = 1000, Default = mobileMaxSpeed },
        Callback = function(value32) mobileMaxSpeed = value32 end,
      })

      mobileBetaTab:Slider({
        Title = "Mobile Boost Power",
        Step = 0.1,
        Value = { Min = 0.5, Max = 10, Default = mobileBoostPower },
        Callback = function(value33) mobileBoostPower = value33 end,
      })

      toggle4 = mobileBetaTab:Toggle({
        Title = "Mobile Speed Boost",
        Value = v42,
        Callback = function(value34) v42 = value34 end,
      })

      mobileBetaTab:Slider({
        Title = "Mobile Fly Speed",
        Step = 5,
        Value = { Min = 10, Max = 1000, Default = mobileScooterFlySpeed },
        Callback = function(value35) mobileScooterFlySpeed = value35 end,
      })

      mobileBetaTab:Toggle({
        Title = "Scooter Fly (Mobile)",
        Value = v38,
        Callback = function(value36)
          v38 = value36
          f23()
        end,
      })

      mobileBetaTab:Slider({
        Title = "Mobile Brake Power",
        Desc = "turn it off or down if you keep on falling",
        Step = 0.01,
        Value = { Min = 0, Max = 0.2, Default = v44 },
        Callback = function(value37) v44 = math.clamp(value37, 0, 0.2) end,
      })

      toggle5 = mobileBetaTab:Toggle({
        Title = "Mobile Better Brakes",
        Value = v43,
        Callback = function(value38) v43 = value38 end,
      })

      mobileBetaTab:Slider({
        Title = "Mobile Steering Power",
        Step = 0.1,
        Value = { Min = 0.5, Max = 3, Default = mobileSteeringMultiplier },
        Callback = function(value39) mobileSteeringMultiplier = value39 end,
      })

      toggle6 = mobileBetaTab:Toggle({
        Title = "Mobile Better Steering",
        Value = v45,
        Callback = function(value40) v45 = value40 end,
      })

      toggle7 = mobileBetaTab:Toggle({
        Title = "Mobile Auto Wheelie",
        Value = v46,
        Callback = function(value41)
          local seatPart4

          if value41 then
            local v125, v126 = f26()
            seatPart4 = v125 and v125.SeatPart

            if seatPart4 and f13(seatPart4) then
              instance3 = Instance.new("Attachment", seatPart4)

              instance4 = Instance.new("AlignOrientation", seatPart4)
              instance4.Mode = Enum.OrientationAlignmentMode.OneAttachment
              instance4.Attachment0 = instance3

              local v127 = instance4
              local v128 = instance4
              instance4.MaxTorque = 100000000
              v127.MaxAngularVelocity = 35
              v128.Responsiveness = 30
              local v129, v130
              v130, v53, v129 = seatPart4.CFrame:ToOrientation()

              connect2 = runService.Heartbeat:Connect(function(delta2)
                local v131, v132 = f26()

                if not seatPart4 or not seatPart4.Parent or not v131
                  or v131.SeatPart ~= seatPart4 then
                  f9()
                  return
                else
                  local v133, v134 = f12(v131, seatPart4, v132)
                  local v135 = v134 ~= 0 and v134 or v33 and -1 or v34 and 1 or 0

                  if v135 ~= 0 then
                    v53 = v53 - v135 * 3 * delta2
                  end

                  instance4.CFrame = CFrame.Angles(0, v53, 0)
                    * CFrame.Angles(math.rad(35), 0, 0)

                  return
                end
              end)

              v46 = true
            end
          else
            f9()
          end
        end,
      })

      rainbowEScooterToggle = optikTab:Toggle({
        Title = "Rainbow EScooter",
        Value = v66,
        Callback = function(value42)
          v66 = value42
          if not value42 then
            rainbowCacheModel = nil
            table.clear(rainbowCacheParts)
            rainbowTimer = 0
          end
        end,
      })

      optikTab:Slider({
        Title = "Suspension Force",
        Step = 1,
        Value = { Min = 1, Max = 10, Default = suspensionForce },
        Callback = function(value43) suspensionForce = value43 end,
      })

      suspensionToggle = optikTab:Toggle({
        Title = "Suspension",
        Value = v64,
        Callback = function(value44) v64 = value44 end,
      })

      optikTab:Slider({
        Title = "Maybach Speed",
        Step = 1,
        Value = { Min = 0, Max = 10, Default = maybachSpeed },
        Callback = function(value45) maybachSpeed = value45 end,
      })

      maybachSuspensionToggle = optikTab:Toggle({
        Title = "Maybach Suspension",
        Value = v65,
        Callback = function(value46) v65 = value46 end,
      })

      autofarmTab:Paragraph({
        Title = "⚠️ WARNING ⚠️",
        Desc = "FARMING TO MUCH MONEY MIGHT GET YOU BANNED FROM THIS GAME",
      })

      autofarmStatusParagraph = autofarmTab:Paragraph({
        Title = "Autofarm Status",
        Desc = "Idle",
      })

      toggle = autofarmTab:Toggle({
        Title = "Farm Money (Scooter)",
        Value = false,
        Callback = function(value47) f19(value47, false, autofarmStatusParagraph) end,
      })

      autofarmTab:Slider({
        Title = "Mobile Farm Speed",
        Desc = "make it slower if it doesnt work for you",
        Step = 0.05,
        Value = { Min = 0.2, Max = 1.5, Default = v47 },
        Callback = function(value48) v47 = math.clamp(value48, 0.2, 1.5) end,
      })

      toggle2 = autofarmTab:Toggle({
        Title = "Mobile Farm Money",
        Value = false,
        Callback = function(value49) f19(value49, true, autofarmStatusParagraph) end,
      })

      cratesTab:Paragraph({
        Title = "Info",
        Desc = "might not work on sUNC executers like xeno or solara",
      })

      cratesTab:Dropdown({
        Title = "Select Crates",
        Values = values,
        Value = { "Basic Crate" },
        Multi = true,
        Callback = function(value50)
          v58.SelectedCrates = {}

          if type(value50) == "table" then
            for key5, value51 in pairs(value50) do
              if type(key5) == "number" and type(value51) == "string" then
                table.insert(v58.SelectedCrates, value51)
              elseif type(key5) == "string" and value51 == true then
                table.insert(v58.SelectedCrates, key5)
              end
            end
          elseif type(value50) == "string" then
            table.insert(v58.SelectedCrates, value50)
          end
        end,
      })

      cratesTab:Dropdown({
        Title = "Open Amount",
        Values = { "1x", "3x" },
        Value = "1x",
        Multi = false,
        Callback = function(value52) v58.OpenAmount = value52 == "3x" and 3 or 1 end,
      })

      cratesTab:Toggle({
        Title = "Auto Open",
        Value = false,
        Callback = function(value53)
          v58.AutoOpen = value53

          if value53 then
            task.spawn(function()
              while v58.AutoOpen do
                local selectedCrates = v58.SelectedCrates

                if #selectedCrates == 0 then
                  selectedCrates = { "Basic Crate" }
                end

                for index15, value54 in ipairs(selectedCrates) do
                  if not v58.AutoOpen then
                    break
                  end

                  f21(value54, v58.OpenAmount)
                  task.wait(v58.Delay)
                end

                task.wait(0.1)
              end
            end)
          end
        end,
      })

      funTab:Paragraph({ Title = "Information", Desc = "you cant drive when the siren goes on" })

      funTab:Button({
        Title = "Steal Nearest Police Car",
        Callback = function()
          local v136, v137 = f26()

          local humanoid6 = localPlayer.Character
            and localPlayer.Character:FindFirstChildOfClass("Humanoid")

          if not v137 or not humanoid6 then
            v116:Notify({ Title = "Error", Content = "Character not found!", Duration = 2 })
            return
          else
            local v138 = nil
            local huge2 = math.huge

            for index16, value55 in ipairs(v1:GetDescendants()) do
              if value55:IsA("VehicleSeat") or value55:IsA("Seat") then
                local v139 = string.lower(value55.Parent.Name .. " " .. value55.Name)

                if string.find(v139, "police") or string.find(v139, "cop")
                  or string.find(v139, "polizei") or string.find(v139, "sheriff") then
                  local magnitude = (v137.Position - value55.Position).Magnitude

                  if magnitude < huge2 then
                    v138 = value55
                    huge2 = magnitude
                  end
                end
              end
            end

            if v138 then
              humanoid6.PlatformStand = false
              v138:Sit(humanoid6)

              v116:Notify({
                Title = "Success",
                Content = "Successfully jumped into nearest police car!",
                Duration = 2,
              })
            else
              v116:Notify({
                Title = "Not Found",
                Content = "No police car found nearby!",
                Duration = 2,
              })
            end

            return
          end
        end,
      })

      otherTab:Toggle({
        Title = "Anti-AFK",
        Value = v71,
        Callback = function(value56) f4(value56) end,
      })

      playerESPToggle = otherTab:Toggle({
        Title = "Player ESP",
        Value = v67,
        Callback = function(value57)
          v67 = value57

          if not value57 then
            f20(v68)
          end
        end,
      })

      otherTab:Slider({
        Title = "ESP Outline Strength",
        Step = 0.05,
        Value = { Min = 0, Max = 1, Default = espOutlineTransparency },
        Callback = function(value58)
          espOutlineTransparency = value58
          f10()
        end,
      })

      local v140 = f16()
      v70 = v140[1]

      dropdown = otherTab:Dropdown({
        Title = "Players in Range",
        Values = v140,
        Default = v140[1],
        Callback = function(value59) v70 = value59 end,
      })

      otherTab:Button({
        Title = "Refresh Players",
        Callback = function()
          local v141 = f16()
          v70 = v141[1]

          if dropdown and dropdown.Refresh then
            dropdown:Refresh(v141)
          end

          v116:Notify({
            Title = "Teleport",
            Content = "Players in range refreshed!",
            Duration = 2,
          })
        end,
      })

      otherTab:Button({
        Title = "Teleport to Selected Player",
        Callback = function()
          if not v70 or v70 == "No Players in Range" then
            v116:Notify({
              Title = "Error",
              Content = "No valid player in range selected!",
              Duration = 2,
            })

            return
          else
            local findFirstChild2 = players:FindFirstChild(v70)

            if findFirstChild2 and findFirstChild2.Character
              and findFirstChild2.Character:FindFirstChild("HumanoidRootPart") then
              f32(findFirstChild2.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 3), 0.6)

              v116:Notify({
                Title = "Teleport",
                Content = "Teleporting to " .. findFirstChild2.Name .. "...",
                Duration = 2,
              })
            else
              v116:Notify({
                Title = "Error",
                Content = "Player character not found!",
                Duration = 2,
              })
            end

            return
          end
        end,
      })

      task.spawn(function()
        while true do
          task.wait(5)
          local v142 = f16()

          if dropdown and dropdown.Refresh then
            dropdown:Refresh(v142)

            if not table.find(v142, v70) then
              v70 = v142[1]
            end
          end
        end
      end)

      keybind = configTab:Keybind({
        Title = "Toggle UI Key",
        Desc = "Keybind to open/close the menu",
        Value = rightShift.Name,
        Callback = function(value60)
          local v143 = typeof(value60) == "EnumItem"
          local v144

          if v143 and value60.EnumType == Enum.KeyCode then
            v144 = value60
          elseif typeof(value60) == "string" and value60 ~= "" and value60 ~= "None"
            and Enum.KeyCode[value60] then
            v144 = Enum.KeyCode[value60]
          end

          if v144 and v144 ~= Enum.KeyCode.Unknown then
            rightShift = v144
            suavleysGuiWindow:SetToggleKey(v144)
          end
        end,
      })

      v117 = "default"
      local v145 = f18()

      selectConfigDropdown = configTab:Dropdown({
        Title = "Select Config",
        Values = v145,
        Default = v145[1] or "default",
        Callback = function(value61) v117 = value61 end,
      })

      configTab:Input({
        Title = "New Config Name",
        Default = "default",
        Callback = function(value62)
          if value62 and value62 ~= "" then
            v117 = value62
          end
        end,
      })

      configTab:Button({
        Title = "Save Configuration",
        Callback = function()
          local v146 = {
            MAX_SPEED = maxSPEED,
            BOOST_POWER = boostPOWER,
            speedMult = speedMult,
            steeringMultiplier = steeringMultiplier,
            brakePower = brakePower,
            suspensionForce = suspensionForce,
            maybachSpeed = maybachSpeed,
            espOutlineTransparency = espOutlineTransparency,
            toggleKeybind = rightShift.Name,
            boostEnabled = v30,
            steeringEnabled = v62,
            brakesEnabled = v63,
            antiCrashEnabled = v56,
            glueOnFloorEnabled = v61,
            wheelieEnabled = v51,
            rainbowEnabled = v66,
            suspensionEnabled = v64,
            maybachEnabled = v65,
            playerEspEnabled = v67,
            mobileMaxSpeed = mobileMaxSpeed,
            mobileBoostEnabled = v42,
            mobileBrakesEnabled = v43,
            mobileSteeringEnabled = v45,
            mobileWheelieEnabled = v46,
            mobileBoostPower = mobileBoostPower,
            mobileBrakePower = v44,
            mobileSteeringMultiplier = mobileSteeringMultiplier,
            mobileFarmSpeed = v47,
            antiAfkEnabled = v71,
            scooterFlySpeed = scooterFlySpeed,
            mobileScooterFlySpeed = mobileScooterFlySpeed,
          }

          if writefile then
            pcall(writefile, "SuavleyGUI_" .. v117 .. ".json", httpService:JSONEncode(v146))

            v116:Notify({
              Title = "Config",
              Content = "Config '" .. v117 .. "' saved!",
              Duration = 2,
            })

            if selectConfigDropdown and selectConfigDropdown.Refresh then
              selectConfigDropdown:Refresh(f18())
            end
          end
        end,
      })

      configTab:Button({
        Title = "Load Configuration",
        Callback = function()
          local v147 = "SuavleyGUI_" .. v117 .. ".json"

          if isfile and isfile(v147) and readfile then
            local v148, v149 = pcall(function() return httpService:JSONDecode(readfile(v147)) end)

            if v148 and type(v149) == "table" then
              maxSPEED = v149.MAX_SPEED or maxSPEED
              boostPOWER = v149.BOOST_POWER or boostPOWER
              speedMult = v149.speedMult or speedMult
              steeringMultiplier = v149.steeringMultiplier or steeringMultiplier
              brakePower = v149.brakePower or brakePower
              suspensionForce = v149.suspensionForce or suspensionForce
              maybachSpeed = v149.maybachSpeed or maybachSpeed

              espOutlineTransparency = v149.espOutlineTransparency
                or v149.espOutlineTransparency

              mobileMaxSpeed = v149.mobileMaxSpeed or mobileMaxSpeed
              mobileBoostPower = v149.mobileBoostPower or mobileBoostPower
              v44 = math.clamp(v149.mobileBrakePower or v44, 0, 0.2)

              mobileSteeringMultiplier = v149.mobileSteeringMultiplier
                or mobileSteeringMultiplier

              v47 = math.clamp(v149.mobileFarmSpeed or v47, 0.2, 1.5)
              scooterFlySpeed = v149.scooterFlySpeed or scooterFlySpeed
              mobileScooterFlySpeed = v149.mobileScooterFlySpeed or mobileScooterFlySpeed

              if v149.toggleKeybind and Enum.KeyCode[v149.toggleKeybind] then
                rightShift = Enum.KeyCode[v149.toggleKeybind]
                suavleysGuiWindow:SetToggleKey(rightShift)

                pcall(function()
                  if keybind and keybind.Set then
                    keybind:Set(rightShift.Name)
                  end
                end)
              end

              if v149.boostEnabled ~= nil and boostToggle then
                boostToggle:Set(v149.boostEnabled)
              end

              if v149.steeringEnabled ~= nil and betterSteeringToggle then
                betterSteeringToggle:Set(v149.steeringEnabled)
              end

              if v149.brakesEnabled ~= nil and betterBrakesToggle then
                betterBrakesToggle:Set(v149.brakesEnabled)
              end

              if v149.antiCrashEnabled ~= nil then
                f3(v149.antiCrashEnabled)
              end

              if v149.glueOnFloorEnabled ~= nil and toggle3 then
                toggle3:Set(v149.glueOnFloorEnabled)
              end

              if v149.wheelieEnabled ~= nil and wheelieAssistToggle then
                wheelieAssistToggle:Set(v149.wheelieEnabled)
              end

              if v149.rainbowEnabled ~= nil and rainbowEScooterToggle then
                rainbowEScooterToggle:Set(v149.rainbowEnabled)
              end

              if v149.suspensionEnabled ~= nil and suspensionToggle then
                suspensionToggle:Set(v149.suspensionEnabled)
              end

              if v149.maybachEnabled ~= nil and maybachSuspensionToggle then
                maybachSuspensionToggle:Set(v149.maybachEnabled)
              end

              if v149.playerEspEnabled ~= nil and playerESPToggle then
                playerESPToggle:Set(v149.playerEspEnabled)
              end

              if v149.mobileBoostEnabled ~= nil and toggle4 then
                toggle4:Set(v149.mobileBoostEnabled)
              end

              if v149.mobileBrakesEnabled ~= nil and toggle5 then
                toggle5:Set(v149.mobileBrakesToggle)
              end

              if v149.mobileSteeringEnabled ~= nil and toggle6 then
                toggle6:Set(v149.mobileSteeringEnabled)
              end

              if v149.mobileWheelieEnabled ~= nil and toggle7 then
                toggle7:Set(v149.mobileWheelieEnabled)
              end

              if v149.antiAfkEnabled ~= nil then
                f4(v149.antiAfkEnabled)
              end

              f10()

              v116:Notify({
                Title = "Config",
                Content = "Config '" .. v117 .. "' loaded!",
                Duration = 2,
              })
            end
          end
        end,
      })

      configTab:Button({
        Title = "Delete Configuration",
        Callback = function()
          local v150 = "SuavleyGUI_" .. v117 .. ".json"

          if delfile and isfile and isfile(v150) then
            pcall(delfile, v150)

            v116:Notify({
              Title = "Config",
              Content = "Config '" .. v117 .. "' deleted!",
              Duration = 2,
            })

            if selectConfigDropdown and selectConfigDropdown.Refresh then
              selectConfigDropdown:Refresh(f18())
            end
          else
            v116:Notify({
              Title = "Error",
              Content = "Config not found or cannot be deleted!",
              Duration = 2,
            })
          end
        end,
      })

      return
    end
  end

  function f33()
    if v39 then
      v39.Force = Vector3.zero
      v39:Destroy()
      v39 = nil
    end

    if v40 then
      v40:Destroy()
      v40 = nil
    end

    v41 = nil
    maxSpeed = nil
  end

  function f34(p33)
    if v41 ~= p33 or not v39 or not v39.Parent then
      f33()
      v41 = p33

      local kukirinCleanAttachment = Instance.new("Attachment")
      kukirinCleanAttachment.Name = "KukirinCleanAttachment"
      kukirinCleanAttachment.Parent = p33

      v40 = kukirinCleanAttachment

      local kukirinCleanForce = Instance.new("VectorForce")
      kukirinCleanForce.Name = "KukirinCleanForce"
      kukirinCleanForce.Attachment0 = kukirinCleanAttachment
      kukirinCleanForce.ApplyAtCenterOfMass = true
      kukirinCleanForce.RelativeTo = Enum.ActuatorRelativeTo.World
      kukirinCleanForce.Force = Vector3.zero
      kukirinCleanForce.Parent = p33

      v39 = kukirinCleanForce
    end

    return v39
  end

  function f35(p34, p35, p36)
    if not p36 or not p35.Sit then
      return false
    end

    if p35.Health <= 0 or p35.PlatformStand then
      return false
    else
      local getState = p35:GetState()

      if getState == Enum.HumanoidStateType.Physics
        or getState == Enum.HumanoidStateType.Ragdoll
        or getState == Enum.HumanoidStateType.FallingDown
        or getState == Enum.HumanoidStateType.GettingUp
        or getState == Enum.HumanoidStateType.Dead then
        return false
      else
        for key6, value63 in pairs(p34:GetAttributes()) do
          local lower2 = key6:lower()

          if (lower2:find("ragdoll") or lower2:find("bail") or lower2:find("crash"))
            and value63 == true then
            return false
          end
        end

        local humanoidRootPart4 = p34:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart4 or (humanoidRootPart4.Position - p36.Position).Magnitude > 6.5 then
          return false
        end

        return true
      end
    end
  end

  raycastParams2 = RaycastParams.new()
  raycastParams2.FilterType = Enum.RaycastFilterType.Exclude
  raycastParams2.IgnoreWater = true

  function f36(p37)
    local rightVector = p37.RightVector
    local vector2 = Vector3.new(-rightVector.Z, 0, rightVector.X)

    if vector2.Magnitude > 0.01 then
      local lookVector2 = p37.LookVector
      local vector3 = Vector3.new(lookVector2.X, 0, lookVector2.Z)

      if vector3.Magnitude > 0.01 and vector2:Dot(vector3) < 0 then
        vector2 = -vector2
      end

      return vector2.Unit
    else
      local lookVector3 = p37.LookVector
      local vector4 = Vector3.new(lookVector3.X, 0, lookVector3.Z)
      return vector4.Magnitude > 0.01 and vector4.Unit or Vector3.new(0, 0, -1)
    end
  end

  runService.Heartbeat:Connect(function(delta3)
    v69 = v69 + delta3

    if v69 >= 0.5 then
      v69 = 0
      if v67 or next(v68) then f31() end
    end

    -- Avoid per-frame physics work with all scooter features disabled.
    if not (v30 or v37 or v38 or v62 or v45 or v63 or v43 or v42
            or v64 or v65 or v66) then
      if v39 then f33() end
      return
    end

    local character9 = localPlayer.Character

    if not character9 then
      f33()
    else
      local humanoid7 = character9:FindFirstChildOfClass("Humanoid")

      if not humanoid7 then
        f33()
      else
        local seatPart5 = humanoid7.SeatPart

        if not (v37 or v38 or (v30 and speedMult > 1))
          or not f35(character9, humanoid7, seatPart5) then
          f33()
        else
          raycastParams2.FilterDescendantsInstances = {
            character9, seatPart5:FindFirstAncestorOfClass("Model") or seatPart5,
          }

          local raycast = workspace:Raycast(
            seatPart5.Position, Vector3.new(0, -7.5, 0), raycastParams2
          )

          local assemblyLinearVelocity2 = seatPart5.AssemblyLinearVelocity
          local v151 = v37 or v38
          local v152 = v37 and scooterFlySpeed or mobileScooterFlySpeed

          if v151 then
            local currentCamera = workspace.CurrentCamera

            if currentCamera then
              local unit2 = currentCamera.CFrame.LookVector.Unit
              local unit3 = currentCamera.CFrame.RightVector.Unit
              local zero2 = Vector3.zero

              if v37 then
                if not userInputService:GetFocusedTextBox() then
                  if v31 then
                    zero2 = zero2 + unit2
                  end

                  if v32 then
                    zero2 = zero2 - unit2
                  end

                  if v33 then
                    zero2 = zero2 - unit3
                  end

                  if v34 then
                    zero2 = zero2 + unit3
                  end
                end
              elseif v38 then
                local v153, v154 = f12(humanoid7, seatPart5, seatPart5)

                if v153 ~= 0 then
                  zero2 = zero2 + unit2 * v153
                end

                if v154 ~= 0 then
                  zero2 = zero2 + unit3 * v154
                end
              end

              if zero2.Magnitude > 0.01 then
                seatPart5.AssemblyLinearVelocity = zero2.Unit * v152

                if unit2.Magnitude > 0.1 then
                  seatPart5.CFrame = CFrame.new(seatPart5.Position, seatPart5.Position + unit2)
                end
              else
                seatPart5.AssemblyLinearVelocity = Vector3.zero

                if raycast then
                  local v155 = { seatPart5.CFrame:ToOrientation() }

                  seatPart5.CFrame = CFrame.new(seatPart5.Position)
                    * CFrame.Angles(0, v155[2], 0)
                elseif unit2.Magnitude > 0.1 then
                  seatPart5.CFrame = CFrame.new(seatPart5.Position, seatPart5.Position + unit2)
                end
              end

              seatPart5.AssemblyAngularVelocity = Vector3.zero
            end
          elseif not raycast then
            if v39 then
              v39.Force = Vector3.zero
            end
          elseif not v30 or speedMult <= 1 then
            if v39 then
              v39.Force = Vector3.zero
            end
          else
            local throttleFloat2 = 0

            if not userInputService:GetFocusedTextBox() then
              if userInputService:IsKeyDown(Enum.KeyCode.W)
                or userInputService:IsKeyDown(Enum.KeyCode.Up) then
                throttleFloat2 = 1
              elseif userInputService:IsKeyDown(Enum.KeyCode.S)
                or userInputService:IsKeyDown(Enum.KeyCode.Down) then
                throttleFloat2 = -1
              end
            end

            if throttleFloat2 == 0 and seatPart5:IsA("VehicleSeat")
              and math.abs(seatPart5.ThrottleFloat) > 0.05 then
              throttleFloat2 = seatPart5.ThrottleFloat
            end

            local v156 = f36(seatPart5.CFrame)
            local dot = assemblyLinearVelocity2:Dot(v156)
            local v157 = math.max(seatPart5.AssemblyMass, 10)

            if throttleFloat2 <= 0 or dot < -0.5 then
              if v39 then
                v39.Force = Vector3.zero
              end
            else
              if not maxSpeed or maxSpeed < 5 then
                maxSpeed = 30

                if seatPart5:IsA("VehicleSeat") and seatPart5.MaxSpeed > 5 then
                  maxSpeed = seatPart5.MaxSpeed
                end
              end

              local v158 = maxSpeed * speedMult
              local v159 = 0

              if dot < v158 then
                v159 = v157 * (22 * speedMult)
                  * math.clamp((v158 - dot) / math.max(v158 * 0.4, 15), 0.2, 1) * throttleFloat2
              end

              local v160 = v156 * v159
              f34(seatPart5).Force = Vector3.new(v160.X, 0, v160.Z)
            end
          end
        end
      end
    end

    local v161, v162 = f26()
    local seatPart6 = v161 and v161.SeatPart
    local v163, v164 = f27()
    local v165 = 0
    local v166 = 0

    if seatPart6 and v164 then
      v166, v165 = f12(v161, seatPart6, v164)
    end

    local v167 = v33 and -1 or v34 and 1 or 0
    local v168 = v167 ~= 0 and v167 or v165

    if v62 then
      if seatPart6 and v164 and v168 ~= 0 then
        v164.AssemblyAngularVelocity = Vector3.new(
          v164.AssemblyAngularVelocity.X, -v168 * steeringMultiplier * 1.2,
          v164.AssemblyAngularVelocity.Z
        )
      end
    end

    if v45 and seatPart6 and v164 then
      if v168 ~= 0 then
        v164.AssemblyAngularVelocity = Vector3.new(
          v164.AssemblyAngularVelocity.X, -v168 * mobileSteeringMultiplier * 1.2,
          v164.AssemblyAngularVelocity.Z
        )
      end
    end

    if v63 then
      if seatPart6 and v164 then
        local v169 = v168 ~= 0

        if (v32 or v166 < -0.1) and not isStenewUserActive and not v169 then
          local assemblyLinearVelocity3 = v164.AssemblyLinearVelocity
          local magnitude2 = assemblyLinearVelocity3.Magnitude

          if magnitude2 > 0.5 then
            local v170 = math.max(0, magnitude2 - brakePower * 5)
            v164.AssemblyLinearVelocity = assemblyLinearVelocity3.Unit * v170
          end
        end
      end
    end

    if v43 and seatPart6 and v164 then
      if v166 < -0.05 then
        local assemblyLinearVelocity4 = v164.AssemblyLinearVelocity
        local v171 = v44 * 0.15

        v164.AssemblyLinearVelocity = Vector3.new(
          assemblyLinearVelocity4.X * (1 - v171), assemblyLinearVelocity4.Y,
          assemblyLinearVelocity4.Z * (1 - v171)
        )
      end
    end

    if v42 and seatPart6 and v164 then
      if v166 > 0.05 and f15() then
        local v172 = f36(seatPart6.CFrame)
        local assemblyLinearVelocity5 = v164.AssemblyLinearVelocity
        local vector5 = Vector3.new(assemblyLinearVelocity5.X, 0, assemblyLinearVelocity5.Z)
        local v173 = math.min(mobileMaxSpeed, vector5.Magnitude + mobileBoostPower * 1.5)

        v164.AssemblyLinearVelocity = Vector3.new(
          v172.X * v173, assemblyLinearVelocity5.Y, v172.Z * v173
        )

        if v168 == 0 then
          local vectorToObjectSpace2 = seatPart6.CFrame:VectorToObjectSpace(v164.AssemblyAngularVelocity)

          v164.AssemblyAngularVelocity = seatPart6.CFrame:VectorToWorldSpace(Vector3.new(vectorToObjectSpace2.X, 0, vectorToObjectSpace2.Z
            * 0.2))
        end
      end
    end

    if v64 and seatPart6 and v164 then
      if v164.AssemblyLinearVelocity.Y > 0 then
        v164.AssemblyLinearVelocity = Vector3.new(v164.AssemblyLinearVelocity.X, v164.AssemblyLinearVelocity.Y
          - suspensionForce * 0.2, v164.AssemblyLinearVelocity.Z)
      end
    end

    if v65 and maybachSpeed > 0 and seatPart6 and v164 then
      v164.AssemblyLinearVelocity = Vector3.new(v164.AssemblyLinearVelocity.X, math.sin(os.clock() * (maybachSpeed * 3))
        * (maybachSpeed / 10 * 12), v164.AssemblyLinearVelocity.Z)
    end

    if v66 and v163 and seatPart6 then
      rainbowTimer = rainbowTimer + delta3
      if rainbowTimer >= 0.1 then
        rainbowTimer = 0
        local now = os.clock()
        if rainbowCacheModel ~= v163 or now - rainbowCacheStamp >= 3 then
          table.clear(rainbowCacheParts)
          for _, part in ipairs(v163:GetDescendants()) do
            if part:IsA("BasePart") then
              table.insert(rainbowCacheParts, part)
            end
          end
          rainbowCacheModel = v163
          rainbowCacheStamp = now
        end
        local rainbowColor = Color3.fromHSV(now * 0.4 % 1, 1, 1)
        for _, part in ipairs(rainbowCacheParts) do
          if part.Parent then part.Color = rainbowColor end
        end
      end
    end

    if v30 and v31 then
      if seatPart6 and v164 and f15() then
        local v174 = f36(seatPart6.CFrame)
        local assemblyLinearVelocity6 = v164.AssemblyLinearVelocity
        local vector6 = Vector3.new(assemblyLinearVelocity6.X, 0, assemblyLinearVelocity6.Z)
        local v175 = math.min(maxSPEED, vector6.Magnitude + boostPOWER * 0.5)

        v164.AssemblyLinearVelocity = Vector3.new(
          v174.X * v175, assemblyLinearVelocity6.Y, v174.Z * v175
        )

        if v168 == 0 then
          local vectorToObjectSpace3 = seatPart6.CFrame:VectorToObjectSpace(v164.AssemblyAngularVelocity)

          v164.AssemblyAngularVelocity = seatPart6.CFrame:VectorToWorldSpace(Vector3.new(vectorToObjectSpace3.X, 0, vectorToObjectSpace3.Z
            * 0.2))
        end
      end
    end
  end)

  -- Launch Coco Hub directly; no key entry, skip screen, or interstitial GUI.
  task.defer(loadWindUI)

  return
end
