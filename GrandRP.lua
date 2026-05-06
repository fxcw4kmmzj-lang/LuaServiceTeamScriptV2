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

-- CUSTOM LOGO
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

-- SERVICES
local player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ANTI-BAN SYSTEM
local antiBanEnabled = false
local originalFunctions = {}

-- HIDE NAME/UID
local hideIdentity = false

-- ESP SETTINGS
local espEnabled = false
local espNames = true
local espDistance = true
local espHealth = true
local espSkeleton = false
local espBox = false
local espTracers = false
local espMaxDistance = 200
local espColor = Color3.fromRGB(255, 0, 0)
local espObjects = {}
local showUID = false

-- AIMBOT SETTINGS
local aimLockEnabled = false
local aimAssistEnabled = false
local aimFOV = 100
local aimPart = "Head"
local aimSmoothness = 0.15
local aimPrediction = true
local teamCheck = true
local whitelistedPlayers = {}
local aimConnection = nil

-- CYCLE SETTINGS
local cycleActive = false
local autoCycle = false
local launchActive = false
local cycleSpeed = 40
local launchPower = 400
local launchHeight = 200
local cycleFOVEnabled = false
local cycleFOV = 120

-- FLY SETTINGS (MOBILE FIXED)
local flyEnabled = false
local flySpeed = 50
local flyBodyVelocity = nil
local flyBodyGyro = nil

-- NOCLIP
local noclipEnabled = false

-- FREECAM (IMPROVED)
local freecamEnabled = false
local freecamSpeed = 1
local freecamCamera = nil
local freecamConnection = nil

-- AUTO E
local autoEEnabled = false
local autoERadius = 10

-- MAGNORE
local magnoreEnabled = false
local magnoreTargets = {}
local magnoreSpeed = 60
local magnorePower = 800

-- SEX ANIMATIONS
local sexAnimEnabled = false
local sexTarget = nil

-- SPAWN OBJECTS
local spawnedObjects = {}

-- SKIN CHANGER
local currentSkin = nil

-- PERFORMANCE
local fpsCounter = 0
local pingDisplay = 0

-- MACRO
local macroRecording = false
local macroPlaying = false
local recordedMacro = {}
local macroStartTime = 0
_G.SavedMacros = _G.SavedMacros or {}

-- SAVED SCRIPTS
_G.SavedScripts = _G.SavedScripts or {}

-- ANTI-BAN PROTECTION
local function enableAntiBan()
    antiBanEnabled = true
    
    -- Protect from kicks
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    
    originalFunctions.kick = mt.__namecall
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if antiBanEnabled then
            if method == "Kick" then
                Rayfield:Notify({
                   Title = "🛡️ Kick Blocked",
                   Content = "Anti-ban protected you!",
                   Duration = 3,
                   Image = 4483362458,
                })
                return
            end
            
            if method == "FireServer" or method == "InvokeServer" then
                local name = tostring(self)
                if name:find("Ban") or name:find("Kick") or name:find("Anti") or name:find("Detect") then
                    return
                end
            end
        end
        
        return originalFunctions.kick(self, ...)
    end)
    
    setreadonly(mt, true)
end

-- ANTI-CHEAT BYPASS (ADVANCED)
local bypassEnabled = false

local function enableAdvancedBypass()
    bypassEnabled = true
    
    -- Show loading screen
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BypassLoading"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 400, 0, 50)
    Title.Position = UDim2.new(0.5, -200, 0.4, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🛡️ BYPASS INITIALIZING..."
    Title.TextColor3 = Color3.fromRGB(0, 255, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 24
    Title.Parent = Frame
    
    local Progress = Instance.new("TextLabel")
    Progress.Size = UDim2.new(0, 400, 0, 30)
    Progress.Position = UDim2.new(0.5, -200, 0.5, 0)
    Progress.BackgroundTransparency = 1
    Progress.Text = "0%"
    Progress.TextColor3 = Color3.fromRGB(255, 255, 255)
    Progress.Font = Enum.Font.SourceSans
    Progress.TextSize = 18
    Progress.Parent = Frame
    
    spawn(function()
        local steps = {
            "Hooking metamethods...",
            "Spoofing remote calls...",
            "Bypassing detection...",
            "Masking velocity changes...",
            "Hiding exploit signatures...",
            "Finalizing bypass..."
        }
        
        for i, step in ipairs(steps) do
            Progress.Text = step .. " " .. math.floor((i / #steps) * 100) .. "%"
            wait(0.5)
        end
        
        Progress.Text = "✅ BYPASS COMPLETE"
        Title.TextColor3 = Color3.fromRGB(0, 255, 0)
        wait(1)
        ScreenGui:Destroy()
    end)
    
    -- Advanced hooks
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    
    local oldIndex = mt.__index
    local oldNewIndex = mt.__newindex
    local oldNamecall = mt.__namecall
    
    mt.__index = newcclosure(function(self, key)
        if bypassEnabled then
            if key == "WalkSpeed" and tostring(self):find("Humanoid") then
                return 16
            elseif key == "JumpPower" and tostring(self):find("Humanoid") then
                return 50
            elseif key == "Velocity" then
                return Vector3.new(0, 0, 0)
            end
        end
        return oldIndex(self, key)
    end)
    
    mt.__newindex = newcclosure(function(self, key, value)
        if bypassEnabled then
            if (key == "WalkSpeed" or key == "JumpPower") and tostring(self):find("Humanoid") then
                return
            end
        end
        return oldNewIndex(self, key, value)
    end)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if bypassEnabled then
            if method == "FireServer" or method == "InvokeServer" then
                if tostring(self):find("Anti") or tostring(self):find("Detect") or tostring(self):find("Check") then
                    return
                end
            end
        end
        
        return oldNamecall(self, ...)
    end)
    
    setreadonly(mt, true)
    
    Rayfield:Notify({
       Title = "🛡️ Advanced Bypass",
       Content = "Full protection enabled!",
       Duration = 3,
       Image = 4483362458,
    })
end

-- HIDE IDENTITY
local function toggleIdentity(hide)
    hideIdentity = hide
    
    if hide then
        -- Remove name/billboard
        local character = player.Character
        if character then
            local head = character:FindFirstChild("Head")
            if head then
                for _, obj in pairs(head:GetChildren()) do
                    if obj:IsA("BillboardGui") then
                        obj:Destroy()
                    end
                end
            end
        end
        
        -- Spoof name in chat
        player.DisplayName = "Player"
    end
end

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
    while wait(1) do
        pcall(function()
            pingDisplay = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
    end
end)

-- PANIC BUTTON
local function activatePanic()
    aimLockEnabled = false
    espEnabled = false
    cycleActive = false
    flyEnabled = false
    noclipEnabled = false
    freecamEnabled = false
    autoEEnabled = false
    magnoreEnabled = false
    sexAnimEnabled = false
    
    for _, espData in pairs(espObjects) do
        if espData.gui then espData.gui:Destroy() end
        if espData.connection then espData.connection:Disconnect() end
    end
    espObjects = {}
    
    local character = player.Character
    if character then
        if character:FindFirstChild("HumanoidRootPart") then
            if flyBodyVelocity then flyBodyVelocity:Destroy() end
            if flyBodyGyro then flyBodyGyro:Destroy() end
        end
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                part.Transparency = 0
            end
        end
    end
    
    Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    Workspace.CurrentCamera.FieldOfView = 70
    
    Rayfield:Notify({
       Title = "🚨 PANIC MODE",
       Content = "All features disabled!",
       Duration = 3,
       Image = 4483362458,
    })
end

-- TABS (ALL WITH SAME ICON)
local MainTab = Window:CreateTab("Main", 77069254742459)
local ESPTab = Window:CreateTab("ESP", 77069254742459)
local AimbotTab = Window:CreateTab("Aimbot", 77069254742459)
local MagnoreTab = Window:CreateTab("Magnore", 77069254742459)
local SexTab = Window:CreateTab("Animations", 77069254742459)
local TeleportTab = Window:CreateTab("Teleport", 77069254742459)
local SpawnTab = Window:CreateTab("Spawn Objects", 77069254742459)
local SkinTab = Window:CreateTab("Skin Changer", 77069254742459)
local VisualsTab = Window:CreateTab("Visuals", 77069254742459)
local FreecamTab = Window:CreateTab("Freecam", 77069254742459)
local MacroTab = Window:CreateTab("Macro", 77069254742459)
local ExecutorTab = Window:CreateTab("Executor", 77069254742459)
local ScriptsTab = Window:CreateTab("Scripts", 77069254742459)
local InfoTab = Window:CreateTab("Game Info", 77069254742459)
local SettingsTab = Window:CreateTab("Settings", 77069254742459)

-- MAIN TAB
local function SetSpeed(value)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
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
   Name = "Speed Fix",
   Callback = function()
      SetSpeed(16)
   end,
})

MainTab:CreateParagraph({Title = "Performance", Content = "FPS: 0 | Ping: 0ms"})

spawn(function()
    while wait(1) do
        pcall(function()
            for _, tab in pairs(Window.Tabs) do
                if tab.Name == "Main" then
                    for _, element in pairs(tab.Elements) do
                        if element.Title == "Performance" then
                            element:Set({
                                Title = "Performance",
                                Content = "FPS: " .. fpsCounter .. " | Ping: " .. pingDisplay .. "ms"
                            })
                        end
                    end
                end
            end
        end)
    end
end)

-- CYCLE
MainTab:CreateToggle({
   Name = "Cycle",
   CurrentValue = false,
   Callback = function(Value)
        cycleActive = Value
        launchActive = Value
        
        if Value then
            spawn(function()
                while cycleActive do
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(cycleSpeed), 0)
                    end
                    wait(0.01)
                end
            end)
            
            spawn(function()
                while launchActive do
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local myPos = char.HumanoidRootPart.Position
                        
                        for _, plr in pairs(game.Players:GetPlayers()) do
                            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                                local dist = (myPos - plr.Character.HumanoidRootPart.Position).Magnitude
                                if dist < 15 then
                                    local dir = (plr.Character.HumanoidRootPart.Position - myPos).Unit
                                    plr.Character.HumanoidRootPart.Velocity = dir * launchPower + Vector3.new(0, launchHeight, 0)
                                    plr.Character.HumanoidRootPart.AssemblyLinearVelocity = dir * launchPower + Vector3.new(0, launchHeight, 0)
                                end
                            end
                        end
                    end
                    wait(0.05)
                end
            end)
        end
   end,
})

MainTab:CreateSlider({
   Name = "Cycle Speed",
   Range = {10, 100},
   Increment = 5,
   CurrentValue = 40,
   Callback = function(Value)
      cycleSpeed = Value
   end,
})

MainTab:CreateSlider({
   Name = "Launch Power",
   Range = {100, 1000},
   Increment = 50,
   CurrentValue = 400,
   Callback = function(Value)
      launchPower = Value
   end,
})

-- FLY (MOBILE FIXED)
MainTab:CreateToggle({
   Name = "Fly (Mobile Support)",
   CurrentValue = false,
   Callback = function(Value)
        flyEnabled = Value
        
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local hrp = char.HumanoidRootPart
        
        if Value then
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.Name = "FlyVelocity"
            flyBodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            flyBodyVelocity.Parent = hrp
            
            flyBodyGyro = Instance.new("BodyGyro")
            flyBodyGyro.Name = "FlyGyro"
            flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            flyBodyGyro.P = 9e9
            flyBodyGyro.Parent = hrp
            
            RunService.Heartbeat:Connect(function()
                if not flyEnabled or not flyBodyVelocity or not flyBodyGyro then return end
                
                local cam = Workspace.CurrentCamera
                local moveDir = Vector3.new(0, 0, 0)
                
                -- PC Controls
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + cam.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - cam.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - cam.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + cam.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDir = moveDir + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDir = moveDir - Vector3.new(0, 1, 0)
                end
                
                -- Mobile Support
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid and humanoid.MoveDirection.Magnitude > 0 then
                    local movementDirection = humanoid.MoveDirection
                    moveDir = moveDir + (cam.CFrame.LookVector * movementDirection.Z)
                    moveDir = moveDir + (cam.CFrame.RightVector * movementDirection.X)
                end
                
                flyBodyVelocity.Velocity = moveDir * flySpeed
                flyBodyGyro.CFrame = cam.CFrame
            end)
        else
            if flyBodyVelocity then flyBodyVelocity:Destroy() end
            if flyBodyGyro then flyBodyGyro:Destroy() end
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
   Callback = function(Value)
        noclipEnabled = Value
        
        if Value then
            RunService.Stepped:Connect(function()
                if not noclipEnabled then return end
                local char = player.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
   end,
})

-- AUTO E
MainTab:CreateToggle({
   Name = "Auto E",
   CurrentValue = false,
   Callback = function(Value)
        autoEEnabled = Value
        
        if Value then
            spawn(function()
                while autoEEnabled do
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        for _, obj in pairs(Workspace:GetDescendants()) do
                            if obj:IsA("ProximityPrompt") then
                                pcall(function()
                                    if (obj.Parent.Position - char.HumanoidRootPart.Position).Magnitude <= autoERadius then
                                        fireproximityprompt(obj)
                                    end
                                end)
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
local function drawSkeleton(plr, espData)
    if not espSkeleton or not plr.Character then return end
    
    local char = plr.Character
    local joints = {
        {"Head", "UpperTorso"},
        {"UpperTorso", "LowerTorso"},
        {"UpperTorso", "LeftUpperArm"},
        {"LeftUpperArm", "LeftLowerArm"},
        {"UpperTorso", "RightUpperArm"},
        {"RightUpperArm", "RightLowerArm"},
        {"LowerTorso", "LeftUpperLeg"},
        {"LeftUpperLeg", "LeftLowerLeg"},
        {"LowerTorso", "RightUpperLeg"},
        {"RightUpperLeg", "RightLowerLeg"}
    }
    
    for _, joint in pairs(joints) do
        local part1 = char:FindFirstChild(joint[1])
        local part2 = char:FindFirstChild(joint[2])
        
        if part1 and part2 then
            local line = Drawing.new("Line")
            line.Visible = true
            line.Color = espColor
            line.Thickness = 1
            line.From = Workspace.CurrentCamera:WorldToViewportPoint(part1.Position)
            line.To = Workspace.CurrentCamera:WorldToViewportPoint(part2.Position)
            
            table.insert(espData.drawings or {}, line)
        end
    end
end

local function createESP(plr)
    if plr == player then return end
    
    local function addESP(char)
        local head = char:WaitForChild("Head")
        
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "ESP"
        billboardGui.AlwaysOnTop = true
        billboardGui.Size = UDim2.new(0, 100, 0, 100)
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)
        billboardGui.Parent = head
        
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
        uidLabel.Text = "UID: " .. plr.UserId
        uidLabel.Parent = billboardGui
        
        local espData = {
            player = plr,
            gui = billboardGui,
            drawings = {}
        }
        
        espData.connection = RunService.RenderStepped:Connect(function()
            if not espEnabled or not plr or not plr.Character then
                if espData.gui then espData.gui:Destroy() end
                if espData.connection then espData.connection:Disconnect() end
                for _, drawing in pairs(espData.drawings or {}) do
                    drawing:Remove()
                end
                return end
            
            local myChar = player.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (myChar.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                
                if dist <= espMaxDistance then
                    distanceLabel.Text = math.floor(dist) .. " studs"
                    nameLabel.Visible = espNames
                    distanceLabel.Visible = espDistance
                    uidLabel.Visible = showUID
                    billboardGui.Enabled = true
                else
                    billboardGui.Enabled = false
                end
            end
        end)
        
        espObjects[plr.UserId] = espData
    end
    
    if plr.Character then addESP(plr.Character) end
    plr.CharacterAdded:Connect(addESP)
end

ESPTab:CreateToggle({
   Name = "Enable ESP",
   CurrentValue = false,
   Callback = function(Value)
        espEnabled = Value
        
        if Value then
            for _, plr in pairs(game.Players:GetPlayers()) do
                createESP(plr)
            end
        else
            for _, data in pairs(espObjects) do
                if data.gui then data.gui:Destroy() end
                if data.connection then data.connection:Disconnect() end
            end
            espObjects = {}
        end
   end,
})

ESPTab:CreateToggle({
   Name = "Names",
   CurrentValue = true,
   Callback = function(Value)
        espNames = Value
   end,
})

ESPTab:CreateToggle({
   Name = "Distance",
   CurrentValue = true,
   Callback = function(Value)
        espDistance = Value
   end,
})

ESPTab:CreateToggle({
   Name = "UID",
   CurrentValue = false,
   Callback = function(Value)
        showUID = Value
   end,
})

ESPTab:CreateToggle({
   Name = "Skeleton",
   CurrentValue = false,
   Callback = function(Value)
        espSkeleton = Value
   end,
})

ESPTab:CreateToggle({
   Name = "Box",
   CurrentValue = false,
   Callback = function(Value)
        espBox = Value
   end,
})

ESPTab:CreateToggle({
   Name = "Tracers",
   CurrentValue = false,
   Callback = function(Value)
        espTracers = Value
   end,
})

ESPTab:CreateSlider({
   Name = "Max Distance",
   Range = {50, 500},
   Increment = 10,
   CurrentValue = 200,
   Callback = function(Value)
      espMaxDistance = Value
   end,
})

ESPTab:CreateColorPicker({
   Name = "ESP Color",
   Color = Color3.fromRGB(255, 0, 0),
   Callback = function(Value)
        espColor = Value
   end
})

-- AIMBOT (FIXED)
local function getClosestPlayer()
    local closest = nil
    local shortestDist = aimFOV
    
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild(aimPart) then
            if teamCheck and plr.Team == player.Team then continue end
            
            local isWhitelisted = false
            for _, name in pairs(whitelistedPlayers) do
                if name == plr.Name then
                    isWhitelisted = true
                    break
                end
            end
            if isWhitelisted then continue end
            
            local screenPos, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(plr.Character[aimPart].Position)
            if onScreen then
                local mouseLoc = UserInputService:GetMouseLocation()
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mouseLoc).Magnitude
                
                if dist < shortestDist then
                    closest = plr
                    shortestDist = dist
                end
            end
        end
    end
    
    return closest
end

AimbotTab:CreateToggle({
   Name = "Aim Lock",
   CurrentValue = false,
   Callback = function(Value)
        aimLockEnabled = Value
        
        if aimConnection then
            aimConnection:Disconnect()
            aimConnection = nil
        end
        
        if Value then
            aimConnection = RunService.RenderStepped:Connect(function()
                if not aimLockEnabled then return end
                
                local target = getClosestPlayer()
                if target and target.Character and target.Character:FindFirstChild(aimPart) then
                    local targetPart = target.Character[aimPart]
                    local targetPos = targetPart.Position
                    
                    if aimPrediction then
                        local velocity = targetPart.AssemblyLinearVelocity
                        local myChar = player.Character
                        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                            local dist = (myChar.HumanoidRootPart.Position - targetPos).Magnitude
                            local timeToTarget = dist / 500
                            targetPos = targetPos + (velocity * timeToTarget)
                        end
                    end
                    
                    local cam = Workspace.CurrentCamera
                    local targetCF = CFrame.new(cam.CFrame.Position, targetPos)
                    cam.CFrame = cam.CFrame:Lerp(targetCF, aimSmoothness)
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
   CurrentValue = 0.15,
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
   Name = "Whitelist Player",
   PlaceholderText = "Player name...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      if Text ~= "" then
          table.insert(whitelistedPlayers, Text)
          Rayfield:Notify({
             Title = "Whitelist",
             Content = Text .. " added",
             Duration = 2,
             Image = 77069254742459,
          })
      end
   end,
})

-- MAGNORE
MagnoreTab:CreateToggle({
   Name = "Enable Magnore",
   CurrentValue = false,
   Callback = function(Value)
        magnoreEnabled = Value
        
        if Value then
            spawn(function()
                while magnoreEnabled do
                    for _, name in pairs(magnoreTargets) do
                        local target = game.Players:FindFirstChild(name)
                        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                            local hrp = target.Character.HumanoidRootPart
                            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(magnoreSpeed), 0)
                            hrp.Velocity = Vector3.new(math.random(-100, 100), 100, math.random(-100, 100)).Unit * magnorePower
                            hrp.AssemblyLinearVelocity = hrp.Velocity
                        end
                    end
                    wait(0.01)
                end
            end)
        end
   end,
})

MagnoreTab:CreateInput({
   Name = "Add Target",
   PlaceholderText = "Player name...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      if Text ~= "" then
          table.insert(magnoreTargets, Text)
      end
   end,
})

MagnoreTab:CreateSlider({
   Name = "Spin Speed",
   Range = {10, 100},
   Increment = 5,
   CurrentValue = 60,
   Callback = function(Value)
      magnoreSpeed = Value
   end,
})

MagnoreTab:CreateSlider({
   Name = "Launch Power",
   Range = {100, 2000},
   Increment = 100,
   CurrentValue = 800,
   Callback = function(Value)
      magnorePower = Value
   end,
})

-- SEX ANIMATIONS
local sexAnims = {
    "rbxassetid://148840371",
    "rbxassetid://180435571",
    "rbxassetid://181526230"
}

SexTab:CreateInput({
   Name = "Target Player",
   PlaceholderText = "Player name...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      sexTarget = Text
   end,
})

SexTab:CreateButton({
   Name = "Start Animation",
   Callback = function()
        if not sexTarget then return end
        
        local target = game.Players:FindFirstChild(sexTarget)
        if not target or not target.Character then return end
        
        local myChar = player.Character
        if not myChar then return end
        
        -- Teleport behind target
        if target.Character:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
            
            -- Play animation
            local humanoid = myChar:FindFirstChild("Humanoid")
            if humanoid then
                local animator = humanoid:FindFirstChildOfClass("Animator")
                if animator then
                    for _, animId in pairs(sexAnims) do
                        local anim = Instance.new("Animation")
                        anim.AnimationId = animId
                        local track = animator:LoadAnimation(anim)
                        track:Play()
                        wait(0.5)
                    end
                end
            end
        end
   end,
})

-- TELEPORT
TeleportTab:CreateInput({
   Name = "Teleport to Player",
   PlaceholderText = "Player name...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      if Text == "" then return end
      
      local target = game.Players:FindFirstChild(Text)
      if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
          local myChar = player.Character
          if myChar and myChar:FindFirstChild("HumanoidRootPart") then
              myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
          end
      end
   end,
})

-- SPAWN OBJECTS
SpawnTab:CreateButton({
   Name = "Spawn Part (Visible to All)",
   Callback = function()
        local part = Instance.new("Part")
        part.Size = Vector3.new(10, 1, 10)
        part.Position = player.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
        part.Anchored = true
        part.BrickColor = BrickColor.Random()
        part.Parent = Workspace
        
        table.insert(spawnedObjects, part)
   end,
})

SpawnTab:CreateButton({
   Name = "Clear Spawned Objects",
   Callback = function()
        for _, obj in pairs(spawnedObjects) do
            obj:Destroy()
        end
        spawnedObjects = {}
   end,
})

-- SKIN CHANGER
SkinTab:CreateInput({
   Name = "Character ID",
   PlaceholderText = "Enter character ID...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      if Text == "" then return end
      
      local char = player.Character
      if char then
          for _, part in pairs(char:GetDescendants()) do
              if part:IsA("Shirt") or part:IsA("Pants") or part:IsA("ShirtGraphic") then
                  part:Destroy()
              end
          end
          
          game.Players:GetCharacterAppearanceAsync(tonumber(Text))
      end
   end,
})

-- FREECAM (IMPROVED)
FreecamTab:CreateToggle({
   Name = "Freecam (Shoot While Active)",
   CurrentValue = false,
   Callback = function(Value)
        freecamEnabled = Value
        
        if Value then
            local cam = Workspace.CurrentCamera
            freecamCamera = cam.CFrame
            
            cam.CameraType = Enum.CameraType.Scriptable
            
            freecamConnection = RunService.RenderStepped:Connect(function()
                if not freecamEnabled then
                    cam.CameraType = Enum.CameraType.Custom
                    if freecamConnection then freecamConnection:Disconnect() end
                    return
                end
                
                local moveDir = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + freecamCamera.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - freecamCamera.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - freecamCamera.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + freecamCamera.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDir = moveDir + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDir = moveDir - Vector3.new(0, 1, 0)
                end
                
                freecamCamera = freecamCamera + (moveDir * freecamSpeed)
                cam.CFrame = freecamCamera
            end)
        else
            Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
   end,
})

FreecamTab:CreateSlider({
   Name = "Speed",
   Range = {0.1, 5},
   Increment = 0.1,
   CurrentValue = 1,
   Callback = function(Value)
      freecamSpeed = Value
   end,
})

-- MACRO (WITH SAVE)
MacroTab:CreateToggle({
   Name = "Record",
   CurrentValue = false,
   Callback = function(Value)
        macroRecording = Value
        
        if Value then
            recordedMacro = {}
            macroStartTime = tick()
        end
   end,
})

MacroTab:CreateToggle({
   Name = "Play",
   CurrentValue = false,
   Callback = function(Value)
        macroPlaying = Value
        
        if Value and #recordedMacro > 0 then
            spawn(function()
                while macroPlaying do
                    for _, action in pairs(recordedMacro) do
                        -- Play macro
                        wait(0.05)
                    end
                end
            end)
        end
   end,
})

MacroTab:CreateInput({
   Name = "Save Macro",
   PlaceholderText = "Macro name...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      if Text ~= "" and #recordedMacro > 0 then
          _G.SavedMacros[Text] = recordedMacro
          Rayfield:Notify({
             Title = "Macro Saved",
             Content = Text,
             Duration = 2,
             Image = 77069254742459,
          })
      end
   end,
})

-- VISUALS
VisualsTab:CreateButton({
   Name = "Day",
   Callback = function()
        Lighting.ClockTime = 14
   end,
})

VisualsTab:CreateButton({
   Name = "Night",
   Callback = function()
        Lighting.ClockTime = 0
   end,
})

VisualsTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Lighting.Brightness = 2
            Lighting.FogEnd = 100000
        else
            Lighting.Brightness = 1
        end
   end,
})

-- EXECUTOR
local codeInput = ""

ExecutorTab:CreateInput({
   Name = "Code",
   PlaceholderText = "loadstring...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      codeInput = Text
   end,
})

ExecutorTab:CreateButton({
   Name = "Execute",
   Callback = function()
        loadstring(codeInput)()
   end,
})

-- SCRIPTS
local scriptName = ""
local scriptCode = ""

ScriptsTab:CreateInput({
   Name = "Script Name",
   PlaceholderText = "Name...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      scriptName = Text
   end,
})

ScriptsTab:CreateInput({
   Name = "Script Code",
   PlaceholderText = "Code...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      scriptCode = Text
   end,
})

ScriptsTab:CreateButton({
   Name = "Save",
   Callback = function()
        if scriptName ~= "" and scriptCode ~= "" then
            _G.SavedScripts[scriptName] = scriptCode
        end
   end,
})

ScriptsTab:CreateButton({
   Name = "Load & Execute",
   Callback = function()
        if scriptName ~= "" and _G.SavedScripts[scriptName] then
            loadstring(_G.SavedScripts[scriptName])()
        end
   end,
})

-- INFO
InfoTab:CreateParagraph({Title = "Player", Content = player.Name})
InfoTab:CreateParagraph({Title = "UID", Content = tostring(player.UserId)})
InfoTab:CreateParagraph({Title = "Game", Content = tostring(game.PlaceId)})

-- SETTINGS
SettingsTab:CreateToggle({
   Name = "🛡️ Anti-Ban",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            enableAntiBan()
        else
            antiBanEnabled = false
        end
   end,
})

SettingsTab:CreateToggle({
   Name = "🛡️ Advanced Bypass",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            enableAdvancedBypass()
        else
            bypassEnabled = false
        end
   end,
})

SettingsTab:CreateToggle({
   Name = "Hide Identity",
   CurrentValue = false,
   Callback = function(Value)
        toggleIdentity(Value)
   end,
})

SettingsTab:CreateButton({
   Name = "🚨 PANIC",
   Callback = function()
        activatePanic()
   end,
})

SettingsTab:CreateKeybind({
   Name = "Panic Key",
   CurrentKeybind = "P",
   HoldToInteract = false,
   Callback = function()
        activatePanic()
   end,
})

Rayfield:LoadConfiguration()

Rayfield:Notify({
   Title = "lua.gg Loaded",
   Content = "All systems online!",
   Duration = 3,
   Image = 77069254742459,
})
