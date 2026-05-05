local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
Rayfield:LoadConfiguration()
local Window = Rayfield:CreateWindow({
   Name = "LuaServiceTeam",
   Icon = "star",
   LoadingTitle = "lua.gg",
   LoadingSubtitle = "by LuaServiceTeam",
   ShowText = "lua.gg",
   Theme = "Amethyst",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "lua.gg Hub"
   },
   Discord = {
      Enabled = true,
      Invite = "https://discord.gg/4z3jHQQTB",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

-- CUSTOM LOGO (safe version)
task.spawn(function()
    task.wait(2)
    pcall(function()
        local CoreGui = game:GetService("CoreGui")
        for _,v in pairs(CoreGui:GetChildren()) do
            if string.find(v.Name:lower(), "rayfield") then
                local Logo = Instance.new("ImageLabel")
                Logo.Name = "CustomLogo"
                Logo.Parent = v
                Logo.Image = "rbxassetid://77069254742459"
                Logo.Size = UDim2.new(0,35,0,35)
                Logo.Position = UDim2.new(0,15,0,60)
                Logo.BackgroundTransparency = 1
                Logo.ZIndex = 999
                break
            end
        end
    end)
end)

-- GLOBALS
local player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- ESP SETTINGS
local espEnabled = false
local espBoxes = true
local espNames = true
local espDistance = true
local espHealth = true
local espTracers = false
local espColor = Color3.fromRGB(255, 0, 0)
local espConnections = {}
local showUID = false

-- AIMBOT SETTINGS
local aimLockEnabled = false
local aimAssistEnabled = false
local aimFOV = 100
local aimPart = "Head"
local aimSmoothness = 0.2
local aimPrediction = true
local teamCheck = true
local whitelistedPlayers = {}

-- CYCLE SETTINGS
local cycleActive = false
local autoCycle = false
local launchActive = false
local cycleSpeed = 30
local launchPower = 300
local launchHeight = 150
local cycleFOVEnabled = false
local cycleFOV = 120

-- FLY SETTINGS
local flyEnabled = false
local flySpeed = 50

-- NOCLIP SETTINGS
local noclipEnabled = false

-- NOCLIP FLY SETTINGS
local noclipFlyEnabled = false
local invisibleEnabled = false

-- FREECAM SETTINGS
local freecamEnabled = false
local freecamSpeed = 1

-- AUTO E SETTINGS
local autoEEnabled = false
local autoERadius = 10

-- MAGNORE SETTINGS
local magnoreEnabled = false
local magnoreTargets = {}
local magnoreSpeed = 50
local magnorePower = 500

-- PERFORMANCE
local fpsCounter = 0
local pingDisplay = 0

-- MACRO SETTINGS
local macroRecording = false
local macroPlaying = false
local recordedMacro = {}
local macroStartTime = 0

-- PANIC BUTTON
local panicActivated = false

-- SAVED SCRIPTS
_G.SavedScripts = _G.SavedScripts or {}

-- FPS COUNTER
spawn(function()
    local lastTime = tick()
    local frameCount = 0
    
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local currentTime = tick()
        
        if currentTime - lastTime >= 1 then
            fpsCounter = frameCount
            frameCount = 0
            lastTime = currentTime
        end
    end)
end)

-- PING MONITOR
spawn(function()
    while true do
        pingDisplay = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        wait(1)
    end
end)

-- PANIC BUTTON FUNCTION
local function activatePanic()
    panicActivated = true
    
    -- Disable all features
    aimLockEnabled = false
    aimAssistEnabled = false
    espEnabled = false
    cycleActive = false
    autoCycle = false
    launchActive = false
    flyEnabled = false
    noclipEnabled = false
    noclipFlyEnabled = false
    invisibleEnabled = false
    freecamEnabled = false
    autoEEnabled = false
    magnoreEnabled = false
    macroRecording = false
    macroPlaying = false
    
    -- Clean up ESP
    for _, connection in pairs(espConnections) do
        connection:Disconnect()
    end
    espConnections = {}
    
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr.Character then
            for _, obj in pairs(plr.Character:GetDescendants()) do
                if obj.Name == "ESP" or obj.Name == "UID" then
                    obj:Destroy()
                end
            end
        end
    end
    
    -- Reset character
    local character = player.Character
    if character then
        if character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            if hrp:FindFirstChild("FlyVelocity") then
                hrp.FlyVelocity:Destroy()
            end
        end
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                part.Transparency = 0
            end
        end
    end
    
    -- Reset camera
    Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    Workspace.CurrentCamera.FieldOfView = 70
    
    Rayfield:Notify({
       Title = "PANIC MODE",
       Content = "All features disabled!",
       Duration = 3,
       Image = 4483362458,
    })
    
    wait(2)
    panicActivated = false
end

-- MAIN TAB
local MainTab = Window:CreateTab("Main", 77069254742459)

local function SetSpeed(value)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = value
end

MainTab:CreateButton({
   Name = "Speed 100",
   Callback = function()
      SetSpeed(100)
   end,
})

MainTab:CreateSlider({
   Name = "Speed Control",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      SetSpeed(Value)
   end,
})

MainTab:CreateButton({
   Name = "Speed Fix (Reset to 16)",
   Callback = function()
      SetSpeed(16)
      Rayfield:Notify({
         Title = "Speed Fixed",
         Content = "Speed reset to default (16)",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

-- PERFORMANCE DISPLAY
MainTab:CreateParagraph({Title = "FPS/Ping Monitor", Content = "Updates in real-time below"})

spawn(function()
    while true do
        pcall(function()
            for _, tab in pairs(Window.Tabs) do
                if tab.Name == "Main" then
                    for _, element in pairs(tab.Elements) do
                        if element.Title and element.Title == "FPS/Ping Monitor" then
                            element:Set({
                                Title = "FPS/Ping Monitor",
                                Content = "FPS: " .. tostring(fpsCounter) .. " | Ping: " .. tostring(pingDisplay) .. "ms"
                            })
                        end
                    end
                end
            end
        end)
        wait(1)
    end
end)

-- IMPROVED CYCLE FUNCTIONS
local function startCycle()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    cycleActive = true
    
    -- FOV Change
    if cycleFOVEnabled then
        Workspace.CurrentCamera.FieldOfView = cycleFOV
    end
    
    spawn(function()
        while cycleActive do
            humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(cycleSpeed), 0)
            wait(0.005)
        end
        
        if cycleFOVEnabled then
            Workspace.CurrentCamera.FieldOfView = 70
        end
    end)
    
    spawn(function()
        while launchActive do
            local myPosition = humanoidRootPart.Position
            
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character then
                    local otherHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if otherHRP then
                        local distance = (myPosition - otherHRP.Position).Magnitude
                        
                        if distance < 15 then
                            local direction = (otherHRP.Position - myPosition).Unit
                            otherHRP.Velocity = direction * launchPower + Vector3.new(0, launchHeight, 0)
                            otherHRP.AssemblyLinearVelocity = direction * launchPower + Vector3.new(0, launchHeight, 0)
                        end
                    end
                end
            end
            
            wait(0.05)
        end
    end)
end

local function stopCycle()
    cycleActive = false
    launchActive = false
    if cycleFOVEnabled then
        Workspace.CurrentCamera.FieldOfView = 70
    end
end

MainTab:CreateToggle({
   Name = "Cycle",
   CurrentValue = false,
   Flag = "CycleToggle",
   Callback = function(Value)
        if Value then
            launchActive = true
            startCycle()
        else
            stopCycle()
        end
   end,
})

MainTab:CreateToggle({
   Name = "Auto Cycle",
   CurrentValue = false,
   Flag = "AutoCycleToggle",
   Callback = function(Value)
        autoCycle = Value
        if Value then
            launchActive = true
            startCycle()
        else
            stopCycle()
        end
   end,
})

MainTab:CreateSlider({
   Name = "Cycle Speed",
   Range = {10, 100},
   Increment = 5,
   CurrentValue = 30,
   Callback = function(Value)
      cycleSpeed = Value
   end,
})

MainTab:CreateSlider({
   Name = "Launch Power",
   Range = {100, 1000},
   Increment = 50,
   CurrentValue = 300,
   Callback = function(Value)
      launchPower = Value
   end,
})

MainTab:CreateToggle({
   Name = "Cycle FOV",
   CurrentValue = false,
   Callback = function(Value)
        cycleFOVEnabled = Value
   end,
})

MainTab:CreateSlider({
   Name = "Cycle FOV Value",
   Range = {70, 120},
   Increment = 5,
   CurrentValue = 120,
   Callback = function(Value)
      cycleFOV = Value
   end,
})

-- FLY
MainTab:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
        flyEnabled = Value
        local character = player.Character
        if not character then return end
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        
        if Value then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Name = "FlyVelocity"
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Parent = humanoidRootPart
            
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not flyEnabled then
                    connection:Disconnect()
                    if humanoidRootPart:FindFirstChild("FlyVelocity") then
                        humanoidRootPart.FlyVelocity:Destroy()
                    end
                    return
                end
                
                local moveDirection = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + Workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - Workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - Workspace.CurrentCamera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + Workspace.CurrentCamera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDirection = moveDirection - Vector3.new(0, 1, 0)
                end
                
                bodyVelocity.Velocity = moveDirection * flySpeed
            end)
        else
            if humanoidRootPart and humanoidRootPart:FindFirstChild("FlyVelocity") then
                humanoidRootPart.FlyVelocity:Destroy()
            end
        end
   end,
})

MainTab:CreateSlider({
   Name = "Fly Speed",
   Range = {10, 200},
   Increment = 5,
   CurrentValue = 50,
   Callback = function(Value)
      flySpeed = Value
   end,
})

-- NOCLIP
MainTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
        noclipEnabled = Value
        
        if Value then
            local connection
            connection = RunService.Stepped:Connect(function()
                if not noclipEnabled then
                    connection:Disconnect()
                    return
                end
                
                local character = player.Character
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
   end,
})

-- NOCLIP FLY (INVISIBLE)
MainTab:CreateToggle({
   Name = "NoClipFly (Invisible)",
   CurrentValue = false,
   Callback = function(Value)
        noclipFlyEnabled = Value
        invisibleEnabled = Value
        
        local character = player.Character
        if not character then return end
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        
        if Value then
            -- Make invisible
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part.Transparency = 1
                end
                if part:IsA("Accessory") then
                    part:Destroy()
                end
            end
            
            -- Enable fly
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Name = "FlyVelocity"
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Parent = humanoidRootPart
            
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not noclipFlyEnabled then
                    connection:Disconnect()
                    if humanoidRootPart:FindFirstChild("FlyVelocity") then
                        humanoidRootPart.FlyVelocity:Destroy()
                    end
                    
                    -- Restore visibility
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 0
                            part.CanCollide = true
                        end
                    end
                    return
                end
                
                -- Noclip
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                
                -- Fly controls
                local moveDirection = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + Workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - Workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - Workspace.CurrentCamera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + Workspace.CurrentCamera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDirection = moveDirection - Vector3.new(0, 1, 0)
                end
                
                bodyVelocity.Velocity = moveDirection * flySpeed
            end)
        else
            if humanoidRootPart and humanoidRootPart:FindFirstChild("FlyVelocity") then
                humanoidRootPart.FlyVelocity:Destroy()
            end
            
            -- Restore visibility and collision
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                    part.CanCollide = true
                end
            end
        end
   end,
})

-- AUTO E
MainTab:CreateToggle({
   Name = "Auto E (Proximity)",
   CurrentValue = false,
   Flag = "AutoEToggle",
   Callback = function(Value)
        autoEEnabled = Value
        
        if Value then
            spawn(function()
                while autoEEnabled do
                    local character = player.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local hrp = character.HumanoidRootPart
                        
                        for _, obj in pairs(Workspace:GetDescendants()) do
                            if obj:IsA("ProximityPrompt") then
                                local parent = obj.Parent
                                if parent and (parent.Position - hrp.Position).Magnitude <= autoERadius then
                                    fireproximityprompt(obj)
                                end
                            end
                        end
                    end
                    wait(0.3)
                end
            end)
        end
   end,
})

MainTab:CreateSlider({
   Name = "Auto E Radius",
   Range = {5, 50},
   Increment = 1,
   CurrentValue = 10,
   Callback = function(Value)
      autoERadius = Value
   end,
})

-- ESP TAB
local ESPTab = Window:CreateTab("ESP", 4483362458)

local function createESP(plr)
    if plr == player then return end
    
    local function addESP(character)
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "ESP"
        billboardGui.AlwaysOnTop = true
        billboardGui.Size = UDim2.new(0, 100, 0, 100)
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)
        billboardGui.Parent = character:WaitForChild("Head")
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.BackgroundTransparency = 1
        nameLabel.Size = UDim2.new(1, 0, 0.3, 0)
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextColor3 = espColor
        nameLabel.TextSize = 14
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.Text = plr.Name
        nameLabel.Parent = billboardGui
        
        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Name = "DistanceLabel"
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Position = UDim2.new(0, 0, 0.3, 0)
        distanceLabel.Size = UDim2.new(1, 0, 0.3, 0)
        distanceLabel.Font = Enum.Font.SourceSans
        distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        distanceLabel.TextSize = 12
        distanceLabel.TextStrokeTransparency = 0.5
        distanceLabel.Parent = billboardGui
        
        local uidLabel = Instance.new("TextLabel")
        uidLabel.Name = "UIDLabel"
        uidLabel.BackgroundTransparency = 1
        uidLabel.Position = UDim2.new(0, 0, 0.6, 0)
        uidLabel.Size = UDim2.new(1, 0, 0.4, 0)
        uidLabel.Font = Enum.Font.SourceSans
        uidLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        uidLabel.TextSize = 10
        uidLabel.TextStrokeTransparency = 0.5
        uidLabel.Text = "UID: " .. tostring(plr.UserId)
        uidLabel.Parent = billboardGui
        
        local connection = RunService.RenderStepped:Connect(function()
            if not espEnabled or not character or not character:FindFirstChild("HumanoidRootPart") then
                billboardGui:Destroy()
                connection:Disconnect()
                return
            end
            
            local myChar = player.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                local distance = (myChar.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                distanceLabel.Text = math.floor(distance) .. " studs"
            end
            
            nameLabel.Visible = espNames
            distanceLabel.Visible = espDistance
            uidLabel.Visible = showUID
        end)
        
        table.insert(espConnections, connection)
    end
    
    if plr.Character then
        addESP(plr.Character)
    end
    plr.CharacterAdded:Connect(addESP)
end

ESPTab:CreateToggle({
   Name = "Enable ESP",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
        espEnabled = Value
        
        if Value then
            for _, plr in pairs(game.Players:GetPlayers()) do
                createESP(plr)
            end
            
            game.Players.PlayerAdded:Connect(function(plr)
                if espEnabled then
                    createESP(plr)
                end
            end)
        else
            for _, connection in pairs(espConnections) do
                connection:Disconnect()
            end
            espConnections = {}
            
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character then
                    for _, obj in pairs(plr.Character:GetDescendants()) do
                        if obj.Name == "ESP" then
                            obj:Destroy()
                        end
                    end
                end
            end
        end
   end,
})

ESPTab:CreateToggle({
   Name = "Show Names",
   CurrentValue = true,
   Callback = function(Value)
        espNames = Value
   end,
})

ESPTab:CreateToggle({
   Name = "Show Distance",
   CurrentValue = true,
   Callback = function(Value)
        espDistance = Value
   end,
})

ESPTab:CreateToggle({
   Name = "Show UID",
   CurrentValue = false,
   Callback = function(Value)
        showUID = Value
   end,
})

ESPTab:CreateColorPicker({
   Name = "ESP Color",
   Color = Color3.fromRGB(255, 0, 0),
   Callback = function(Value)
        espColor = Value
   end
})

-- AIMBOT TAB
local AimbotTab = Window:CreateTab("Aimbot", 4483362458)

local function isWhitelisted(plr)
    for _, whitelisted in pairs(whitelistedPlayers) do
        if whitelisted == plr.Name then
            return true
        end
    end
    return false
end

local function predictPosition(targetPart)
    if not aimPrediction then return targetPart.Position end
    
    local velocity = targetPart.AssemblyLinearVelocity
    local distance = (player.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude
    local timeToTarget = distance / 500
    
    return targetPart.Position + (velocity * timeToTarget)
end

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = aimFOV
    
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild(aimPart) then
            if teamCheck and plr.Team == player.Team then
                continue
            end
            
            if isWhitelisted(plr) then
                continue
            end
            
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local screenPoint = Workspace.CurrentCamera:WorldToScreenPoint(plr.Character[aimPart].Position)
                local mouseLocation = UserInputService:GetMouseLocation()
                local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mouseLocation).Magnitude
                
                if distance < shortestDistance then
                    closestPlayer = plr
                    shortestDistance = distance
                end
            end
        end
    end
    
    return closestPlayer
end

AimbotTab:CreateToggle({
   Name = "Aim Lock (Smooth)",
   CurrentValue = false,
   Callback = function(Value)
        aimLockEnabled = Value
        
        if Value then
            spawn(function()
                while aimLockEnabled do
                    local target = getClosestPlayer()
                    if target and target.Character and target.Character:FindFirstChild(aimPart) then
                        local targetPos = predictPosition(target.Character[aimPart])
                        local currentCFrame = Workspace.CurrentCamera.CFrame
                        local targetCFrame = CFrame.new(currentCFrame.Position, targetPos)
                        
                        Workspace.CurrentCamera.CFrame = currentCFrame:Lerp(targetCFrame, aimSmoothness)
                    end
                    wait()
                end
            end)
        end
   end,
})

AimbotTab:CreateToggle({
   Name = "Aim Assist",
   CurrentValue = false,
   Callback = function(Value)
        aimAssistEnabled = Value
        
        if Value then
            spawn(function()
                while aimAssistEnabled do
                    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                        local target = getClosestPlayer()
                        if target and target.Character and target.Character:FindFirstChild(aimPart) then
                            local targetPos = predictPosition(target.Character[aimPart])
                            local currentCFrame = Workspace.CurrentCamera.CFrame
                            local targetCFrame = CFrame.new(currentCFrame.Position, targetPos)
                            Workspace.CurrentCamera.CFrame = currentCFrame:Lerp(targetCFrame, aimSmoothness * 0.5)
                        end
                    end
                    wait()
                end
            end)
        end
   end,
})

AimbotTab:CreateSlider({
   Name = "FOV",
   Range = {50, 500},
   Increment = 10,
   CurrentValue = 100,
   Callback = function(Value)
      aimFOV = Value
   end,
})

AimbotTab:CreateSlider({
   Name = "Smoothness",
   Range = {0.05, 1},
   Increment = 0.05,
   CurrentValue = 0.2,
   Callback = function(Value)
      aimSmoothness = Value
   end,
})

AimbotTab:CreateDropdown({
   Name = "Aim Part",
   Options = {"Head", "Torso", "HumanoidRootPart"},
   CurrentOption = "Head",
   Callback = function(Value)
        aimPart = Value
   end,
})

AimbotTab:CreateToggle({
   Name = "Prediction",
   CurrentValue = true,
   Callback = function(Value)
        aimPrediction = Value
   end,
})

AimbotTab:CreateToggle({
   Name = "Team Check",
   CurrentValue = true,
   Callback = function(Value)
        teamCheck = Value
   end,
})

AimbotTab:CreateInput({
   Name = "Add to Whitelist",
   PlaceholderText = "Enter player name...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      if Text ~= "" then
          table.insert(whitelistedPlayers, Text)
          Rayfield:Notify({
             Title = "Whitelist Updated",
             Content = Text .. " added to whitelist",
             Duration = 2,
             Image = 4483362458,
          })
      end
   end,
})

AimbotTab:CreateButton({
   Name = "Clear Whitelist",
   Callback = function()
      whitelistedPlayers = {}
      Rayfield:Notify({
         Title = "Whitelist Cleared",
         Content = "All players removed from whitelist",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

-- MAGNORE TAB
local MagnoreTab = Window:CreateTab("Magnore", 4483362458)

local function startMagnore()
    magnoreEnabled = true
    
    spawn(function()
        while magnoreEnabled do
            for _, targetName in pairs(magnoreTargets) do
                local targetPlayer = game.Players:FindFirstChild(targetName)
                if targetPlayer and targetPlayer.Character then
                    local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if targetHRP then
                        targetHRP.CFrame = targetHRP.CFrame * CFrame.Angles(0, math.rad(magnoreSpeed), 0)
                        
                        local randomDirection = Vector3.new(
                            math.random(-1, 1),
                            math.random(0, 1),
                            math.random(-1, 1)
                        ).Unit
                        
                        targetHRP.Velocity = randomDirection * magnorePower
                        targetHRP.AssemblyLinearVelocity = randomDirection * magnorePower
                    end
                end
            end
            wait(0.01)
        end
    end)
end

MagnoreTab:CreateToggle({
   Name = "Enable Magnore",
   CurrentValue = false,
   Callback = function(Value)
        magnoreEnabled = Value
        if Value then
            startMagnore()
        end
   end,
})

MagnoreTab:CreateInput({
   Name = "Add Target",
   PlaceholderText = "Enter player name...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      if Text ~= "" then
          table.insert(magnoreTargets, Text)
          Rayfield:Notify({
             Title = "Target Added",
             Content = Text .. " added to Magnore targets",
             Duration = 2,
             Image = 4483362458,
          })
      end
   end,
})

MagnoreTab:CreateButton({
   Name = "Clear Targets",
   Callback = function()
      magnoreTargets = {}
      Rayfield:Notify({
         Title = "Targets Cleared",
         Content = "All Magnore targets removed",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

MagnoreTab:CreateSlider({
   Name = "Spin Speed",
   Range = {10, 100},
   Increment = 5,
   CurrentValue = 50,
   Callback = function(Value)
      magnoreSpeed = Value
   end,
})

MagnoreTab:CreateSlider({
   Name = "Launch Power",
   Range = {100, 2000},
   Increment = 100,
   CurrentValue = 500,
   Callback = function(Value)
      magnorePower = Value
   end,
})

-- VISUALS TAB
local VisualsTab = Window:CreateTab("Visuals", 4483362458)

VisualsTab:CreateButton({
   Name = "Day",
   Callback = function()
        Lighting.ClockTime = 14
        Lighting.Brightness = 2
   end,
})

VisualsTab:CreateButton({
   Name = "Night",
   Callback = function()
        Lighting.ClockTime = 0
        Lighting.Brightness = 0
   end,
})

VisualsTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        else
            Lighting.Brightness = 1
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
        end
   end,
})

VisualsTab:CreateButton({
   Name = "Remove Fog",
   Callback = function()
        Lighting.FogEnd = 100000
        for _, obj in pairs(Lighting:GetChildren()) do
            if obj:IsA("Atmosphere") then
                obj.Density = 0
            end
        end
   end,
})

VisualsTab:CreateButton({
   Name = "Low Graphics",
   Callback = function()
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end
        settings().Rendering.QualityLevel = 1
   end,
})

-- FREECAM TAB
local FreecamTab = Window:CreateTab("Freecam", 4483362458)

FreecamTab:CreateToggle({
   Name = "Freecam",
   CurrentValue = false,
   Callback = function(Value)
        freecamEnabled = Value
        
        if Value then
            local camera = Workspace.CurrentCamera
            camera.CameraType = Enum.CameraType.Scriptable
            
            local connection
            connection = RunService.RenderStepped:Connect(function()
                if not freecamEnabled then
                    camera.CameraType = Enum.CameraType.Custom
                    connection:Disconnect()
                    return
                end
                
                local moveDirection = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDirection = moveDirection - Vector3.new(0, 1, 0)
                end
                
                camera.CFrame = camera.CFrame + (moveDirection * freecamSpeed)
            end)
        else
            Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
   end,
})

FreecamTab:CreateSlider({
   Name = "Freecam Speed",
   Range = {0.1, 5},
   Increment = 0.1,
   CurrentValue = 1,
   Callback = function(Value)
      freecamSpeed = Value
   end,
})

-- GAME INFO TAB
local InfoTab = Window:CreateTab("Game Info", 4483362458)

InfoTab:CreateParagraph({Title = "Player", Content = player.Name})
InfoTab:CreateParagraph({Title = "Game Version", Content = tostring(game.PlaceVersion)})
InfoTab:CreateParagraph({Title = "Game ID", Content = tostring(game.PlaceId)})
InfoTab:CreateParagraph({Title = "User ID", Content = tostring(player.UserId)})

InfoTab:CreateButton({
   Name = "Read Game Assets",
   Callback = function()
        local assetCount = 0
        local assetTypes = {}
        
        for _, obj in pairs(Workspace:GetDescendants()) do
            assetCount = assetCount + 1
            local className = obj.ClassName
            assetTypes[className] = (assetTypes[className] or 0) + 1
        end
        
        local output = "Total Assets: " .. assetCount .. "\n\n"
        for className, count in pairs(assetTypes) do
            output = output .. className .. ": " .. count .. "\n"
        end
        
        Rayfield:Notify({
           Title = "Game Assets",
           Content = "Check console for full list (F9)",
           Duration = 3,
           Image = 4483362458,
        })
        
        print("=== GAME ASSETS ===")
        print(output)
   end,
})

-- MACRO TAB
local MacroTab = Window:CreateTab("Macro", 4483362458)

MacroTab:CreateToggle({
   Name = "Record Macro",
   CurrentValue = false,
   Callback = function(Value)
        macroRecording = Value
        
        if Value then
            recordedMacro = {}
            macroStartTime = tick()
            
            Rayfield:Notify({
               Title = "Recording Started",
               Content = "Your actions are being recorded",
               Duration = 2,
               Image = 4483362458,
            })
            
            local moveConnection
            local keyConnection
            
            moveConnection = RunService.Heartbeat:Connect(function()
                if not macroRecording then
                    moveConnection:Disconnect()
                    return
                end
                
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    table.insert(recordedMacro, {
                        type = "position",
                        time = tick() - macroStartTime,
                        cframe = character.HumanoidRootPart.CFrame
                    })
                end
            end)
            
            keyConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not macroRecording or gameProcessed then
                    return
                end
                
                if input.KeyCode == Enum.KeyCode.E then
                    table.insert(recordedMacro, {
                        type = "key",
                        time = tick() - macroStartTime,
                        key = "E"
                    })
                end
            end)
        else
            Rayfield:Notify({
               Title = "Recording Stopped",
               Content = "Macro saved with " .. #recordedMacro .. " actions",
               Duration = 2,
               Image = 4483362458,
            })
        end
   end,
})

MacroTab:CreateToggle({
   Name = "Play Macro",
   CurrentValue = false,
   Callback = function(Value)
        macroPlaying = Value
        
        if Value and #recordedMacro > 0 then
            spawn(function()
                local startTime = tick()
                local actionIndex = 1
                
                while macroPlaying and actionIndex <= #recordedMacro do
                    local currentTime = tick() - startTime
                    local action = recordedMacro[actionIndex]
                    
                    if currentTime >= action.time then
                        local character = player.Character
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            if action.type == "position" then
                                character.HumanoidRootPart.CFrame = action.cframe
                            elseif action.type == "key" and action.key == "E" then
                                for _, obj in pairs(Workspace:GetDescendants()) do
                                    if obj:IsA("ProximityPrompt") then
                                        fireproximityprompt(obj)
                                    end
                                end
                            end
                        end
                        actionIndex = actionIndex + 1
                    end
                    
                    wait()
                end
                
                macroPlaying = false
            end)
        end
   end,
})

MacroTab:CreateButton({
   Name = "Clear Macro",
   Callback = function()
      recordedMacro = {}
      Rayfield:Notify({
         Title = "Macro Cleared",
         Content = "Recorded actions deleted",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

-- EXECUTOR TAB
local ExecutorTab = Window:CreateTab("Executor", 4483362458)

local codeInput = ""

ExecutorTab:CreateInput({
   Name = "Loadstring Input",
   PlaceholderText = "Enter loadstring code...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      codeInput = Text
   end,
})

ExecutorTab:CreateButton({
   Name = "Execute Loadstring",
   Callback = function()
        pcall(function()
            loadstring(codeInput)()
        end)
   end,
})

-- SCRIPT EDITOR TAB
local ScriptsTab = Window:CreateTab("Scripts", 4483362458)

local currentScriptName = ""
local currentScriptCode = ""

ScriptsTab:CreateInput({
   Name = "Script Name",
   PlaceholderText = "Enter script name...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      currentScriptName = Text
   end,
})

ScriptsTab:CreateInput({
   Name = "Script Code",
   PlaceholderText = "Enter Lua code...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      currentScriptCode = Text
   end,
})

ScriptsTab:CreateButton({
   Name = "Save Script",
   Callback = function()
        if currentScriptName ~= "" and currentScriptCode ~= "" then
            _G.SavedScripts[currentScriptName] = currentScriptCode
            Rayfield:Notify({
               Title = "Script Saved",
               Content = "Script '" .. currentScriptName .. "' has been saved!",
               Duration = 3,
               Image = 4483362458,
            })
        else
            Rayfield:Notify({
               Title = "Error",
               Content = "Please enter both name and code!",
               Duration = 3,
               Image = 4483362458,
            })
        end
   end,
})

ScriptsTab:CreateButton({
   Name = "Load & Execute Script",
   Callback = function()
        if currentScriptName ~= "" and _G.SavedScripts[currentScriptName] then
            pcall(function()
                loadstring(_G.SavedScripts[currentScriptName])()
            end)
            Rayfield:Notify({
               Title = "Script Executed",
               Content = "Script '" .. currentScriptName .. "' executed!",
               Duration = 3,
               Image = 4483362458,
            })
        else
            Rayfield:Notify({
               Title = "Error",
               Content = "Script not found!",
               Duration = 3,
               Image = 4483362458,
            })
        end
   end,
})

ScriptsTab:CreateButton({
   Name = "View Saved Scripts",
   Callback = function()
        local scriptList = "Saved Scripts:\n"
        for name, _ in pairs(_G.SavedScripts) do
            scriptList = scriptList .. "- " .. name .. "\n"
        end
        Rayfield:Notify({
           Title = "Saved Scripts",
           Content = scriptList,
           Duration = 5,
           Image = 4483362458,
        })
   end,
})

-- SETTINGS TAB
local SettingsTab = Window:CreateTab("Settings", 4483362458)

SettingsTab:CreateButton({
   Name = "🚨 PANIC BUTTON 🚨",
   Callback = function()
        activatePanic()
   end,
})

SettingsTab:CreateButton({
   Name = "Destroy GUI",
   Callback = function()
        Rayfield:Destroy()
   end,
})

SettingsTab:CreateKeybind({
   Name = "Toggle UI",
   CurrentKeybind = "K",
   HoldToInteract = false,
   Flag = "ToggleUI",
   Callback = function(Keybind)
   end,
})

SettingsTab:CreateKeybind({
   Name = "Panic Keybind",
   CurrentKeybind = "P",
   HoldToInteract = false,
   Flag = "PanicKey",
   Callback = function(Keybind)
        activatePanic()
   end,
})

Rayfield:LoadConfiguration()
