local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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
      Invite = "4z3jHQQTB",
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
                Logo.Image = "rbxassetid://4483362458"
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

-- ESP SETTINGS
local espEnabled = false
local espBoxes = true
local espNames = true
local espDistance = true
local espHealth = true
local espTracers = false
local espColor = Color3.fromRGB(255, 0, 0)
local espConnections = {}

-- AIMBOT SETTINGS
local aimLockEnabled = false
local aimAssistEnabled = false
local aimFOV = 100
local aimPart = "Head"

-- CYCLE SETTINGS
local cycleActive = false
local autoCycle = false
local launchActive = false

-- FLY SETTINGS
local flyEnabled = false
local flySpeed = 50

-- NOCLIP SETTINGS
local noclipEnabled = false

-- FREECAM SETTINGS
local freecamEnabled = false
local freecamSpeed = 1

-- AUTO E SETTINGS
local autoEEnabled = false
local autoERadius = 10

-- SAVED SCRIPTS
_G.SavedScripts = _G.SavedScripts or {}

-- MAIN TAB
local MainTab = Window:CreateTab("Main", 4483362458)

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

-- CYCLE FUNCTIONS
local function startCycle()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    cycleActive = true
    
    spawn(function()
        while cycleActive do
            humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
            wait(0.01)
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
                        
                        if distance < 10 then
                            local direction = (otherHRP.Position - myPosition).Unit
                            otherHRP.Velocity = direction * 200 + Vector3.new(0, 100, 0)
                        end
                    end
                end
            end
            
            wait(0.1)
        end
    end)
end

local function stopCycle()
    cycleActive = false
    launchActive = false
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
                    wait(0.5)
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
        billboardGui.Size = UDim2.new(0, 100, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)
        billboardGui.Parent = character:WaitForChild("Head")
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.BackgroundTransparency = 1
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextColor3 = espColor
        nameLabel.TextSize = 14
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.Text = plr.Name
        nameLabel.Parent = billboardGui
        
        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Name = "DistanceLabel"
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
        distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
        distanceLabel.Font = Enum.Font.SourceSans
        distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        distanceLabel.TextSize = 12
        distanceLabel.TextStrokeTransparency = 0.5
        distanceLabel.Parent = billboardGui
        
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

ESPTab:CreateColorPicker({
   Name = "ESP Color",
   Color = Color3.fromRGB(255, 0, 0),
   Callback = function(Value)
        espColor = Value
   end
})

-- AIMBOT TAB
local AimbotTab = Window:CreateTab("Aimbot", 4483362458)

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = aimFOV
    
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild(aimPart) then
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
   Name = "Aim Lock",
   CurrentValue = false,
   Callback = function(Value)
        aimLockEnabled = Value
        
        if Value then
            spawn(function()
                while aimLockEnabled do
                    local target = getClosestPlayer()
                    if target and target.Character and target.Character:FindFirstChild(aimPart) then
                        Workspace.CurrentCamera.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position, target.Character[aimPart].Position)
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
                            local currentCFrame = Workspace.CurrentCamera.CFrame
                            local targetCFrame = CFrame.new(currentCFrame.Position, target.Character[aimPart].Position)
                            Workspace.CurrentCamera.CFrame = currentCFrame:Lerp(targetCFrame, 0.2)
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

AimbotTab:CreateDropdown({
   Name = "Aim Part",
   Options = {"Head", "Torso", "HumanoidRootPart"},
   CurrentOption = "Head",
   Callback = function(Value)
        aimPart = Value
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
            local originalCFrame = camera.CFrame
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

Rayfield:LoadConfiguration()
