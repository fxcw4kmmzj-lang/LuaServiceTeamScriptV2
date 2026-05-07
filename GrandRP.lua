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
local Players = game:GetService("Players")

-- PROTECTED PLAYER (ADMIN)
local PROTECTED_PLAYER = "sotirisgk89"
local protectedPlayerInGame = false

-- Check for protected player
spawn(function()
    while wait(5) do
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Name == PROTECTED_PLAYER then
                protectedPlayerInGame = true
                
                -- Add crown to protected player
                if plr.Character and plr.Character:FindFirstChild("Head") then
                    local head = plr.Character.Head
                    if not head:FindFirstChild("AdminCrown") then
                        local crown = Instance.new("BillboardGui")
                        crown.Name = "AdminCrown"
                        crown.Size = UDim2.new(0, 50, 0, 50)
                        crown.StudsOffset = Vector3.new(0, 3, 0)
                        crown.AlwaysOnTop = true
                        crown.Parent = head
                        
                        local crownLabel = Instance.new("TextLabel")
                        crownLabel.Size = UDim2.new(1, 0, 1, 0)
                        crownLabel.BackgroundTransparency = 1
                        crownLabel.Text = "👑"
                        crownLabel.TextSize = 40
                        crownLabel.Parent = crown
                    end
                end
                break
            end
        end
    end
end)

-- Helper function to check if player is protected
local function isProtectedPlayer(plr)
    if not plr then return false end
    return plr.Name == PROTECTED_PLAYER
end

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
local aimSmoothness = 0.1
local aimPrediction = true
local teamCheck = true
local whitelistedPlayers = {}
local currentAimTarget = nil
local aimLockConnection = nil

-- CYCLE SETTINGS
local cycleActive = false
local autoCycle = false
local launchActive = false
local cycleSpeed = 40
local launchPower = 400
local launchHeight = 200
local cycleFOVEnabled = false
local cycleFOV = 120
local cycleConnection = nil
local launchConnection = nil

-- FLY SETTINGS
local flyEnabled = false
local flySpeed = 50
local flyBodyVelocity = nil
local flyBodyGyro = nil
local flyConnection = nil

-- NOCLIP
local noclipEnabled = false
local noclipConnection = nil

-- FREECAM
local freecamEnabled = false
local freecamSpeed = 1
local freecamCamera = nil
local freecamConnection = nil

-- AUTO E
local autoEEnabled = false
local autoERadius = 10
local autoEConnection = nil

-- MAGNORE
local magnoreEnabled = false
local magnoreTargets = {}
local magnoreSpeed = 60
local magnorePower = 800
local magnoreFly = false
local magnoreConnection = nil

-- SEX ANIMATIONS
local sexAnimEnabled = false
local sexTarget = nil
local sexAnimConnection = nil

-- RAGDOLL ALL
local ragdollAllEnabled = false

-- SPAWN OBJECTS
local spawnedObjects = {}

-- SKIN CHANGER
local currentSkin = nil

-- PERFORMANCE
local fpsCounter = 0
local pingDisplay = 0
local memoryUsage = 0

-- MACRO
local macroRecording = false
local macroPlaying = false
local recordedMacro = {}
local macroStartTime = 0
local macroRecordConnection = nil
local macroPlayConnection = nil
_G.SavedMacros = _G.SavedMacros or {}

-- SAVED SCRIPTS
_G.SavedScripts = _G.SavedScripts or {}

-- KILLALL SETTINGS
local killAllEnabled = false
local killAllConnection = nil

-- ANTI-CHEAT BYPASS
local bypassEnabled = false

-- TELEPORT SETTINGS
local teleportTarget = nil

-- CRASH SERVER
local crashEnabled = false

-- INFINITE YIELD COMMANDS
local commandsEnabled = false

-- CHAT SPAMMER
local chatSpamEnabled = false
local chatSpamMessage = "lua.gg on top"
local chatSpamDelay = 1

-- WALK ON WALLS
local wallWalkEnabled = false

-- PLATFORM MAKER
local platformEnabled = false
local platformPart = nil

-- AUTO FARM
local autoFarmEnabled = false
local autoFarmConnection = nil

-- CLICK TP
local clickTPEnabled = false

-- HITBOX EXPANDER
local hitboxEnabled = false
local hitboxSize = 10

-- ANTI AFK
local antiAFKEnabled = false

-- SERVER HOP
local serverHopEnabled = false

-- REJOIN
local rejoinEnabled = false

-- ANTI-BAN PROTECTION
local function enableAntiBan()
    antiBanEnabled = true
    
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
                   Image = 77069254742459,
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

-- ANTI-CHEAT BYPASS (COMPACT LOADING)
local function enableAdvancedBypass()
    bypassEnabled = true
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BypassLoading"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 250, 0, 80)
    Frame.Position = UDim2.new(0.5, -125, 0.5, -40)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.BorderSizePixel = 2
    Frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
    Frame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = Frame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = "🛡️ BYPASS"
    Title.TextColor3 = Color3.fromRGB(0, 255, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18
    Title.Parent = Frame
    
    local Progress = Instance.new("TextLabel")
    Progress.Size = UDim2.new(1, 0, 0, 20)
    Progress.Position = UDim2.new(0, 0, 0, 35)
    Progress.BackgroundTransparency = 1
    Progress.Text = "Initializing..."
    Progress.TextColor3 = Color3.fromRGB(255, 255, 255)
    Progress.Font = Enum.Font.SourceSans
    Progress.TextSize = 14
    Progress.Parent = Frame
    
    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(0, 0, 0, 4)
    Bar.Position = UDim2.new(0, 10, 0, 65)
    Bar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    Bar.BorderSizePixel = 0
    Bar.Parent = Frame
    
    spawn(function()
        local steps = {"Hooking...", "Spoofing...", "Masking...", "Complete!"}
        
        for i, step in ipairs(steps) do
            Progress.Text = step
            TweenService:Create(Bar, TweenInfo.new(0.3), {Size = UDim2.new(0, 230 * (i / #steps), 0, 4)}):Play()
            wait(0.3)
        end
        
        wait(0.5)
        ScreenGui:Destroy()
    end)
    
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
       Title = "🛡️ Bypass Active",
       Content = "Protection enabled",
       Duration = 2,
       Image = 77069254742459,
    })
end

-- HIDE IDENTITY
local function toggleIdentity(hide)
    hideIdentity = hide
    
    if hide then
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
        
        player.DisplayName = "Player"
    end
end

-- FPS/PING/MEMORY COUNTER
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

spawn(function()
    while wait(1) do
        pcall(function()
            pingDisplay = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            memoryUsage = math.floor(game:GetService("Stats"):GetTotalMemoryUsageMb())
        end)
    end
end)

-- PANIC BUTTON
local function activatePanic()
    -- Disable all features
    aimLockEnabled = false
    espEnabled = false
    cycleActive = false
    flyEnabled = false
    noclipEnabled = false
    freecamEnabled = false
    autoEEnabled = false
    magnoreEnabled = false
    sexAnimEnabled = false
    ragdollAllEnabled = false
    killAllEnabled = false
    chatSpamEnabled = false
    wallWalkEnabled = false
    platformEnabled = false
    autoFarmEnabled = false
    clickTPEnabled = false
    hitboxEnabled = false
    
    -- Disconnect all connections
    if aimLockConnection then aimLockConnection:Disconnect() end
    if cycleConnection then cycleConnection:Disconnect() end
    if launchConnection then launchConnection:Disconnect() end
    if flyConnection then flyConnection:Disconnect() end
    if noclipConnection then noclipConnection:Disconnect() end
    if freecamConnection then freecamConnection:Disconnect() end
    if autoEConnection then autoEConnection:Disconnect() end
    if magnoreConnection then magnoreConnection:Disconnect() end
    if sexAnimConnection then sexAnimConnection:Disconnect() end
    if killAllConnection then killAllConnection:Disconnect() end
    if autoFarmConnection then autoFarmConnection:Disconnect() end
    if macroRecordConnection then macroRecordConnection:Disconnect() end
    if macroPlayConnection then macroPlayConnection:Disconnect() end
    
    -- Clean ESP
    for _, espData in pairs(espObjects) do
        if espData.gui then espData.gui:Destroy() end
        if espData.connection then espData.connection:Disconnect() end
        if espData.drawings then
            for _, drawing in pairs(espData.drawings) do
                drawing:Remove()
            end
        end
    end
    espObjects = {}
    
    -- Reset character
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
    
    -- Reset camera
    Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    Workspace.CurrentCamera.FieldOfView = 70
    
    -- Clean spawned objects
    for _, obj in pairs(spawnedObjects) do
        pcall(function() obj:Destroy() end)
    end
    spawnedObjects = {}
    
    if platformPart then
        platformPart:Destroy()
        platformPart = nil
    end
    
    Rayfield:Notify({
       Title = "🚨 PANIC MODE",
       Content = "Everything disabled!",
       Duration = 3,
       Image = 77069254742459,
    })
end

-- TABS
local MainTab = Window:CreateTab("Main", 77069254742459)
local CombatTab = Window:CreateTab("Combat", 77069254742459)
local ESPTab = Window:CreateTab("ESP", 77069254742459)
local AimbotTab = Window:CreateTab("Aimbot", 77069254742459)
local MagnoreTab = Window:CreateTab("Magnore", 77069254742459)
local SexTab = Window:CreateTab("Animations", 77069254742459)
local TeleportTab = Window:CreateTab("Teleport", 77069254742459)
local MiscTab = Window:CreateTab("Misc", 77069254742459)
local SpawnTab = Window:CreateTab("Spawn", 77069254742459)
local SkinTab = Window:CreateTab("Skin", 77069254742459)
local VisualsTab = Window:CreateTab("Visuals", 77069254742459)
local FreecamTab = Window:CreateTab("Freecam", 77069254742459)
local MacroTab = Window:CreateTab("Macro", 77069254742459)
local ExecutorTab = Window:CreateTab("Executor", 77069254742459)
local ScriptsTab = Window:CreateTab("Scripts", 77069254742459)
local InfoTab = Window:CreateTab("Info", 77069254742459)
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
   Name = "Speed",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      SetSpeed(Value)
   end,
})

MainTab:CreateButton({
   Name = "Reset Speed",
   Callback = function()
      SetSpeed(16)
   end,
})

MainTab:CreateParagraph({Title = "Performance", Content = "Loading..."})

spawn(function()
    while wait(1) do
        pcall(function()
            for _, tab in pairs(Window.Tabs) do
                if tab.Name == "Main" then
                    for _, element in pairs(tab.Elements) do
                        if element.Title == "Performance" then
                            element:Set({
                                Title = "Performance",
                                Content = string.format("FPS: %d | Ping: %dms | RAM: %dMB", fpsCounter, pingDisplay, memoryUsage)
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
        
        if cycleConnection then cycleConnection:Disconnect() end
        if launchConnection then launchConnection:Disconnect() end
        
        if Value then
            cycleConnection = RunService.Heartbeat:Connect(function()
                if not cycleActive then return end
                
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(cycleSpeed), 0)
                end
            end)
            
            launchConnection = RunService.Heartbeat:Connect(function()
                if not launchActive then return end
                
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local myPos = char.HumanoidRootPart.Position
                    
                    for _, plr in pairs(Players:GetPlayers()) do
                        if plr ~= player and not isProtectedPlayer(plr) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (myPos - plr.Character.HumanoidRootPart.Position).Magnitude
                            if dist < 15 then
                                local dir = (plr.Character.HumanoidRootPart.Position - myPos).Unit
                                local launchVec = dir * launchPower + Vector3.new(0, launchHeight, 0)
                                plr.Character.HumanoidRootPart.Velocity = launchVec
                                plr.Character.HumanoidRootPart.AssemblyLinearVelocity = launchVec
                            end
                        end
                    end
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
   Name = "Fly",
   CurrentValue = false,
   Callback = function(Value)
        flyEnabled = Value
        
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local hrp = char.HumanoidRootPart
        
        if Value then
            if flyBodyVelocity then flyBodyVelocity:Destroy() end
            if flyBodyGyro then flyBodyGyro:Destroy() end
            
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
            
            flyConnection = RunService.Heartbeat:Connect(function()
                if not flyEnabled or not char or not char:FindFirstChild("HumanoidRootPart") then
                    if flyBodyVelocity then flyBodyVelocity:Destroy() end
                    if flyBodyGyro then flyBodyGyro:Destroy() end
                    return
                end
                
                local cam = Workspace.CurrentCamera
                local moveDir = Vector3.new(0, 0, 0)
                
                -- PC
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
                
                -- MOBILE
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid and humanoid.MoveDirection.Magnitude > 0 then
                    local mobileMoveDir = humanoid.MoveDirection
                    moveDir = moveDir + (cam.CFrame.LookVector * mobileMoveDir.Z)
                    moveDir = moveDir + (cam.CFrame.RightVector * mobileMoveDir.X)
                end
                
                if flyBodyVelocity then
                    flyBodyVelocity.Velocity = moveDir * flySpeed
                end
                if flyBodyGyro then
                    flyBodyGyro.CFrame = cam.CFrame
                end
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
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        if Value then
            noclipConnection = RunService.Stepped:Connect(function()
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
        
        if autoEConnection then
            autoEConnection:Disconnect()
            autoEConnection = nil
        end
        
        if Value then
            autoEConnection = RunService.Heartbeat:Connect(function()
                if not autoEEnabled then return end
                
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

-- COMBAT TAB
CombatTab:CreateButton({
   Name = "Kill All Players",
   Callback = function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and not isProtectedPlayer(plr) then
                pcall(function()
                    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                        plr.Character.Humanoid.Health = 0
                    end
                end)
            end
        end
   end,
})

CombatTab:CreateButton({
   Name = "Ragdoll All Players",
   Callback = function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and not isProtectedPlayer(plr) then
                pcall(function()
                    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        plr.Character.HumanoidRootPart.Velocity = Vector3.new(0, -100, 0)
                        
                        for _, part in pairs(plr.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                        
                        if plr.Character:FindFirstChild("Humanoid") then
                            plr.Character.Humanoid.PlatformStand = true
                        end
                    end
                end)
            end
        end
        
        Rayfield:Notify({
           Title = "Ragdoll All",
           Content = "All players ragdolled!",
           Duration = 2,
           Image = 77069254742459,
        })
   end,
})

CombatTab:CreateToggle({
   Name = "Hitbox Expander",
   CurrentValue = false,
   Callback = function(Value)
        hitboxEnabled = Value
        
        if Value then
            spawn(function()
                while hitboxEnabled do
                    for _, plr in pairs(Players:GetPlayers()) do
                        if plr ~= player and not isProtectedPlayer(plr) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            plr.Character.HumanoidRootPart.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                            plr.Character.HumanoidRootPart.Transparency = 0.7
                            plr.Character.HumanoidRootPart.CanCollide = false
                        end
                    end
                    wait(0.1)
                end
            end)
        end
   end,
})

CombatTab:CreateSlider({
   Name = "Hitbox Size",
   Range = {5, 30},
   Increment = 1,
   CurrentValue = 10,
   Callback = function(Value)
      hitboxSize = Value
   end,
})

-- ESP TAB (AUTO UPDATE)
local function drawLine(from, to, color)
    local line = Drawing.new("Line")
    line.From = from
    line.To = to
    line.Color = color
    line.Thickness = 1
    line.Visible = true
    return line
end

local function createESP(plr)
    if plr == player or isProtectedPlayer(plr) then return end
    
    local function addESP(char)
        local head = char:WaitForChild("Head")
        
        for _, obj in pairs(head:GetChildren()) do
            if obj.Name == "ESP" then obj:Destroy() end
        end
        
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
                for _, drawing in pairs(espData.drawings) do
                    drawing:Remove()
                end
                espObjects[plr.UserId] = nil
                return
            end
            
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
    plr.CharacterAdded:Connect(function(char)
        if espEnabled then addESP(char) end
    end)
end

ESPTab:CreateToggle({
   Name = "Enable ESP",
   CurrentValue = false,
   Callback = function(Value)
        espEnabled = Value
        
        if Value then
            for _, plr in pairs(Players:GetPlayers()) do
                createESP(plr)
            end
            
            Players.PlayerAdded:Connect(function(plr)
                if espEnabled then
                    createESP(plr)
                end
            end)
        else
            for _, data in pairs(espObjects) do
                if data.gui then data.gui:Destroy() end
                if data.connection then data.connection:Disconnect() end
                if data.drawings then
                    for _, drawing in pairs(data.drawings) do
                        drawing:Remove()
                    end
                end
            end
            espObjects = {}
        end
   end,
})

ESPTab:CreateToggle({Name = "Names", CurrentValue = true, Callback = function(Value) espNames = Value end})
ESPTab:CreateToggle({Name = "Distance", CurrentValue = true, Callback = function(Value) espDistance = Value end})
ESPTab:CreateToggle({Name = "UID", CurrentValue = false, Callback = function(Value) showUID = Value end})
ESPTab:CreateToggle({Name = "Skeleton", CurrentValue = false, Callback = function(Value) espSkeleton = Value end})
ESPTab:CreateToggle({Name = "Box", CurrentValue = false, Callback = function(Value) espBox = Value end})
ESPTab:CreateToggle({Name = "Tracers", CurrentValue = false, Callback = function(Value) espTracers = Value end})

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
   Name = "Color",
   Color = Color3.fromRGB(255, 0, 0),
   Callback = function(Value)
        espColor = Value
   end
})

-- AIMBOT (FIXED)
local function getClosestPlayer()
    local closest = nil
    local shortestDist = aimFOV
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and not isProtectedPlayer(plr) and plr.Character and plr.Character:FindFirstChild(aimPart) then
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
        
        if aimLockConnection then
            aimLockConnection:Disconnect()
            aimLockConnection = nil
        end
        
        if Value then
            aimLockConnection = RunService.RenderStepped:Connect(function()
                if not aimLockEnabled then
                    currentAimTarget = nil
                    return
                end
                
                local target = getClosestPlayer()
                
                if target and target.Character and target.Character:FindFirstChild(aimPart) then
                    currentAimTarget = target
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
                    local currentCF = cam.CFrame
                    local targetCF = CFrame.new(currentCF.Position, targetPos)
                    
                    cam.CFrame = currentCF:Lerp(targetCF, aimSmoothness)
                else
                    currentAimTarget = nil
                end
            end)
        else
            currentAimTarget = nil
        end
   end,
})

AimbotTab:CreateSlider({Name = "FOV", Range = {50, 500}, Increment = 10, CurrentValue = 100, Callback = function(Value) aimFOV = Value end})
AimbotTab:CreateSlider({Name = "Smoothness", Range = {0.05, 1}, Increment = 0.05, CurrentValue = 0.1, Callback = function(Value) aimSmoothness = Value end})
AimbotTab:CreateDropdown({Name = "Aim Part", Options = {"Head", "Torso", "HumanoidRootPart"}, CurrentOption = "Head", Callback = function(Value) aimPart = Value end})
AimbotTab:CreateToggle({Name = "Prediction", CurrentValue = true, Callback = function(Value) aimPrediction = Value end})
AimbotTab:CreateToggle({Name = "Team Check", CurrentValue = true, Callback = function(Value) teamCheck = Value end})

-- MAGNORE (WITH FLY)
MagnoreTab:CreateDropdown({
   Name = "Select Target",
   Options = (function()
       local names = {}
       for _, plr in pairs(Players:GetPlayers()) do
           if plr ~= player and not isProtectedPlayer(plr) then
               table.insert(names, plr.Name)
           end
       end
       return names
   end)(),
   CurrentOption = "None",
   Callback = function(Value)
      if Value ~= "None" then
          table.insert(magnoreTargets, Value)
          Rayfield:Notify({
             Title = "Magnore",
             Content = Value .. " added",
             Duration = 2,
             Image = 77069254742459,
          })
      end
   end,
})

MagnoreTab:CreateToggle({
   Name = "Enable Magnore",
   CurrentValue = false,
   Callback = function(Value)
        magnoreEnabled = Value
        
        if magnoreConnection then
            magnoreConnection:Disconnect()
            magnoreConnection = nil
        end
        
        if Value then
            magnoreConnection = RunService.Heartbeat:Connect(function()
                if not magnoreEnabled then return end
                
                for _, name in pairs(magnoreTargets) do
                    local target = Players:FindFirstChild(name)
                    if target and not isProtectedPlayer(target) and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = target.Character.HumanoidRootPart
                        
                        -- Spin
                        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(magnoreSpeed), 0)
                        
                        -- Launch
                        local launchDir = Vector3.new(math.random(-100, 100), 100, math.random(-100, 100)).Unit
                        hrp.Velocity = launchDir * magnorePower
                        hrp.AssemblyLinearVelocity = launchDir * magnorePower
                        
                        -- Fly up
                        if magnoreFly then
                            hrp.CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
                        end
                    end
                end
            end)
        end
   end,
})

MagnoreTab:CreateToggle({Name = "Magnore Fly", CurrentValue = false, Callback = function(Value) magnoreFly = Value end})
MagnoreTab:CreateSlider({Name = "Spin Speed", Range = {10, 100}, Increment = 5, CurrentValue = 60, Callback = function(Value) magnoreSpeed = Value end})
MagnoreTab:CreateSlider({Name = "Launch Power", Range = {100, 2000}, Increment = 100, CurrentValue = 800, Callback = function(Value) magnorePower = Value end})

MagnoreTab:CreateButton({
   Name = "Clear Targets",
   Callback = function()
      magnoreTargets = {}
   end,
})

-- SEX ANIMATIONS (REALISTIC)
SexTab:CreateDropdown({
   Name = "Select Target",
   Options = (function()
       local names = {}
       for _, plr in pairs(Players:GetPlayers()) do
           if plr ~= player and not isProtectedPlayer(plr) then
               table.insert(names, plr.Name)
           end
       end
       return names
   end)(),
   CurrentOption = "None",
   Callback = function(Value)
      if Value ~= "None" then
          sexTarget = Value
      end
   end,
})

SexTab:CreateButton({
   Name = "Start Animation",
   Callback = function()
        if not sexTarget then return end
        
        local target = Players:FindFirstChild(sexTarget)
        if not target or isProtectedPlayer(target) or not target.Character then return end
        
        local myChar = player.Character
        if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
        
        -- Position behind target
        if target.Character:FindFirstChild("HumanoidRootPart") then
            local targetHRP = target.Character.HumanoidRootPart
            local behindPos = targetHRP.CFrame * CFrame.new(0, 0, 2)
            
            myChar.HumanoidRootPart.CFrame = behindPos
            
            -- Sit target on "chair"
            local seat = Instance.new("Seat")
            seat.Size = Vector3.new(2, 0.5, 2)
            seat.Position = targetHRP.Position
            seat.Anchored = true
            seat.Transparency = 1
            seat.Parent = Workspace
            
            task.wait(0.1)
            
            if target.Character:FindFirstChild("Humanoid") then
                target.Character.Humanoid.Sit = true
            end
            
            task.wait(0.5)
            
            -- Freeze target and animate
            if target.Character:FindFirstChild("Humanoid") then
                target.Character.Humanoid.WalkSpeed = 0
                target.Character.Humanoid.JumpPower = 0
                
                -- Animate target
                spawn(function()
                    for i = 1, 50 do
                        if target.Character and target.Character:FindFirstChild("Head") and target.Character:FindFirstChild("HumanoidRootPart") then
                            -- Head bobbing
                            target.Character.Head.CFrame = target.Character.Head.CFrame * CFrame.Angles(math.rad(math.sin(i * 0.5) * 20), 0, 0)
                            
                            -- Leg spread
                            local leftLeg = target.Character:FindFirstChild("Left Leg") or target.Character:FindFirstChild("LeftUpperLeg")
                            local rightLeg = target.Character:FindFirstChild("Right Leg") or target.Character:FindFirstChild("RightUpperLeg")
                            
                            if leftLeg then
                                leftLeg.CFrame = leftLeg.CFrame * CFrame.Angles(0, 0, math.rad(10))
                            end
                            if rightLeg then
                                rightLeg.CFrame = rightLeg.CFrame * CFrame.Angles(0, 0, math.rad(-10))
                            end
                        end
                        wait(0.1)
                    end
                    
                    -- Restore
                    if target.Character:FindFirstChild("Humanoid") then
                        target.Character.Humanoid.WalkSpeed = 16
                        target.Character.Humanoid.JumpPower = 50
                    end
                    
                    seat:Destroy()
                end)
                
                -- Animate my character
                spawn(function()
                    for i = 1, 50 do
                        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                            myChar.HumanoidRootPart.CFrame = myChar.HumanoidRootPart.CFrame * CFrame.new(0, math.sin(i * 0.3) * 0.1, 0)
                        end
                        wait(0.1)
                    end
                end)
            end
        end
   end,
})

-- TELEPORT
TeleportTab:CreateDropdown({
   Name = "Select Player",
   Options = (function()
       local names = {}
       for _, plr in pairs(Players:GetPlayers()) do
           if plr ~= player and not isProtectedPlayer(plr) then
               table.insert(names, plr.Name)
           end
       end
       return names
   end)(),
   CurrentOption = "None",
   Callback = function(Value)
      if Value ~= "None" then
          local target = Players:FindFirstChild(Value)
          if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
              local myChar = player.Character
              if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                  myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
              end
          end
      end
   end,
})

-- MISC TAB
MiscTab:CreateToggle({
   Name = "Anti AFK",
   CurrentValue = false,
   Callback = function(Value)
        antiAFKEnabled = Value
        
        if Value then
            local VirtualUser = game:GetService("VirtualUser")
            player.Idled:Connect(function()
                if antiAFKEnabled then
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end
            end)
        end
   end,
})

MiscTab:CreateToggle({
   Name = "Click TP",
   CurrentValue = false,
   Callback = function(Value)
        clickTPEnabled = Value
        
        if Value then
            local mouse = player:GetMouse()
            mouse.Button1Down:Connect(function()
                if clickTPEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position)
                end
            end)
        end
   end,
})

MiscTab:CreateButton({
   Name = "Rejoin Server",
   Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
   end,
})

MiscTab:CreateButton({
   Name = "Server Hop",
   Callback = function()
        local servers = {}
        local req = game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        local body = game:GetService("HttpService"):JSONDecode(req)
        
        for _, server in pairs(body.data) do
            if server.id ~= game.JobId then
                table.insert(servers, server.id)
            end
        end
        
        if #servers > 0 then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], player)
        end
   end,
})

-- SPAWN TAB
SpawnTab:CreateButton({
   Name = "Spawn Part",
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
   Name = "Clear Objects",
   Callback = function()
        for _, obj in pairs(spawnedObjects) do
            obj:Destroy()
        end
        spawnedObjects = {}
   end,
})

-- SKIN CHANGER
SkinTab:CreateInput({
   Name = "User ID",
   PlaceholderText = "User ID...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      if Text ~= "" then
          local char = player.Character
          if char then
              for _, part in pairs(char:GetDescendants()) do
                  if part:IsA("Shirt") or part:IsA("Pants") or part:IsA("ShirtGraphic") then
                      part:Destroy()
                  end
              end
              
              Players:GetCharacterAppearanceAsync(tonumber(Text))
          end
      end
   end,
})

-- VISUALS
VisualsTab:CreateButton({Name = "Day", Callback = function() Lighting.ClockTime = 14 end})
VisualsTab:CreateButton({Name = "Night", Callback = function() Lighting.ClockTime = 0 end})
VisualsTab:CreateToggle({Name = "Fullbright", CurrentValue = false, Callback = function(Value) Lighting.Brightness = Value and 2 or 1; Lighting.FogEnd = Value and 100000 or 10000 end})
VisualsTab:CreateButton({Name = "Remove Fog", Callback = function() Lighting.FogEnd = 100000 end})

-- FREECAM
FreecamTab:CreateToggle({
   Name = "Freecam",
   CurrentValue = false,
   Callback = function(Value)
        freecamEnabled = Value
        
        if freecamConnection then
            freecamConnection:Disconnect()
            freecamConnection = nil
        end
        
        if Value then
            local cam = Workspace.CurrentCamera
            freecamCamera = cam.CFrame
            cam.CameraType = Enum.CameraType.Scriptable
            
            freecamConnection = RunService.RenderStepped:Connect(function()
                if not freecamEnabled then
                    cam.CameraType = Enum.CameraType.Custom
                    return
                end
                
                local moveDir = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + freecamCamera.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - freecamCamera.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - freecamCamera.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + freecamCamera.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
                
                freecamCamera = freecamCamera + (moveDir * freecamSpeed)
                cam.CFrame = freecamCamera
            end)
        else
            Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
   end,
})

FreecamTab:CreateSlider({Name = "Speed", Range = {0.1, 5}, Increment = 0.1, CurrentValue = 1, Callback = function(Value) freecamSpeed = Value end})

-- MACRO
local currentMacroName = ""

MacroTab:CreateToggle({Name = "Record", CurrentValue = false, Callback = function(Value) macroRecording = Value; if Value then recordedMacro = {}; macroStartTime = tick() end end})
MacroTab:CreateToggle({Name = "Play", CurrentValue = false, Callback = function(Value) macroPlaying = Value end})
MacroTab:CreateInput({Name = "Save As", PlaceholderText = "Name...", RemoveTextAfterFocusLost = false, Callback = function(Text) if Text ~= "" then _G.SavedMacros[Text] = recordedMacro end end})

-- EXECUTOR
local codeInput = ""
ExecutorTab:CreateInput({Name = "Code", PlaceholderText = "loadstring...", RemoveTextAfterFocusLost = false, Callback = function(Text) codeInput = Text end})
ExecutorTab:CreateButton({Name = "Execute", Callback = function() loadstring(codeInput)() end})

-- SCRIPTS
local scriptName = ""
local scriptCode = ""
ScriptsTab:CreateInput({Name = "Name", PlaceholderText = "Script name...", RemoveTextAfterFocusLost = false, Callback = function(Text) scriptName = Text end})
ScriptsTab:CreateInput({Name = "Code", PlaceholderText = "Code...", RemoveTextAfterFocusLost = false, Callback = function(Text) scriptCode = Text end})
ScriptsTab:CreateButton({Name = "Save", Callback = function() if scriptName ~= "" then _G.SavedScripts[scriptName] = scriptCode end end})
ScriptsTab:CreateButton({Name = "Execute", Callback = function() if scriptName ~= "" and _G.SavedScripts[scriptName] then loadstring(_G.SavedScripts[scriptName])() end end})

-- INFO
InfoTab:CreateParagraph({Title = "Player", Content = player.Name})
InfoTab:CreateParagraph({Title = "UID", Content = tostring(player.UserId)})
InfoTab:CreateParagraph({Title = "Game ID", Content = tostring(game.PlaceId)})
InfoTab:CreateParagraph({Title = "Players", Content = tostring(#Players:GetPlayers())})

-- SETTINGS
SettingsTab:CreateToggle({Name = "🛡️ Anti-Ban", CurrentValue = false, Callback = function(Value) if Value then enableAntiBan() else antiBanEnabled = false end end})
SettingsTab:CreateToggle({Name = "🛡️ Bypass", CurrentValue = false, Callback = function(Value) if Value then enableAdvancedBypass() else bypassEnabled = false end end})
SettingsTab:CreateToggle({Name = "Hide Identity", CurrentValue = false, Callback = function(Value) toggleIdentity(Value) end})
SettingsTab:CreateButton({Name = "🚨 PANIC", Callback = function() activatePanic() end})
SettingsTab:CreateKeybind({Name = "Panic Key", CurrentKeybind = "P", HoldToInteract = false, Callback = function() activatePanic() end})
SettingsTab:CreateButton({Name = "Destroy GUI", Callback = function() Rayfield:Destroy() end})

Rayfield:LoadConfiguration()

Rayfield:Notify({
   Title = "lua.gg Loaded",
   Content = "Ready to dominate!",
   Duration = 3,
   Image = 77069254742459,
})
