--// LOAD RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// SERVICES
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--// STATES
local AutoE = false
local Noclip = false
local AutoAbility = false
local AutoHit = false

--// GUI
local Window = Rayfield:CreateWindow({
   Name = "LuaServiceTeam PvP Hub",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "Developer Panel",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "LST",
      FileName = "Config"
   },
   KeySystem = false
})

local MainTab = Window:CreateTab("Main", 4483362458)
local VisualTab = Window:CreateTab("Visual", 4483362458)

--==================================
-- SPEED
--==================================

MainTab:CreateSlider({
   Name = "Speed",
   Range = {16,100},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v)

      if LocalPlayer.Character then
         LocalPlayer.Character.Humanoid.WalkSpeed = v
      end

   end
})

--==================================
-- JUMP 1.3X
--==================================

MainTab:CreateButton({
   Name = "1.3x Jump",
   Callback = function()

      if LocalPlayer.Character then

         local hum = LocalPlayer.Character:FindFirstChild("Humanoid")

         if hum then
            hum.JumpPower = hum.JumpPower * 1.3
         end

      end

   end
})

--==================================
-- INVISIBLE
--==================================

MainTab:CreateToggle({
   Name = "Invisible",
   CurrentValue = false,
   Callback = function(v)

      if LocalPlayer.Character then

         for _, part in pairs(
            LocalPlayer.Character:GetDescendants()
         ) do

            if part:IsA("BasePart") then

               if v then
                  part.Transparency = 1
               else
                  part.Transparency = 0
               end

            end

         end

      end

   end
})

--==================================
-- NOCLIP
--==================================

MainTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Callback = function(v)
      Noclip = v
   end
})

RunService.Stepped:Connect(function()

   if Noclip and LocalPlayer.Character then

      for _, part in pairs(
         LocalPlayer.Character:GetDescendants()
      ) do

         if part:IsA("BasePart") then
            part.CanCollide = false
         end

      end

   end

end)

--==================================
-- AUTO E
--==================================

MainTab:CreateToggle({
   Name = "Auto E",
   CurrentValue = false,
   Callback = function(v)
      AutoE = v
   end
})

task.spawn(function()

   while true do

      if AutoE and LocalPlayer.Character then

         local hrp =
         LocalPlayer.Character:FindFirstChild(
            "HumanoidRootPart"
         )

         if hrp then

            for _, prompt in pairs(
               workspace:GetDescendants()
            ) do

               if prompt:IsA("ProximityPrompt") then

                  local p = prompt.Parent

                  if p and p:IsA("BasePart") then

                     local dist =
                     (hrp.Position - p.Position).Magnitude

                     if dist <= 10 then
                        fireproximityprompt(prompt)
                     end

                  end

               end

            end

         end

      end

      task.wait(0.2)

   end

end)

--==================================
-- AUTO SLOT 2 ABILITY
--==================================

MainTab:CreateToggle({
   Name = "Auto Slot 2 Ability",
   CurrentValue = false,
   Callback = function(v)
      AutoAbility = v
   end
})

--==================================
-- AUTO SLOT 1 HIT
--==================================

MainTab:CreateToggle({
   Name = "Auto Slot 1 Hit",
   CurrentValue = false,
   Callback = function(v)
      AutoHit = v
   end
})

task.spawn(function()

   while true do

      if LocalPlayer.Character then

         local myRoot =
         LocalPlayer.Character:FindFirstChild(
            "HumanoidRootPart"
         )

         if myRoot then

            for _, plr in pairs(
               Players:GetPlayers()
            ) do

               if plr ~= LocalPlayer
               and plr.Character
               and plr.Character:FindFirstChild(
                  "HumanoidRootPart"
               ) then

                  local enemyRoot =
                  plr.Character.HumanoidRootPart

                  local offset =
                  enemyRoot.Position - myRoot.Position

                  local horizontal =
                  Vector3.new(
                     offset.X,
                     0,
                     offset.Z
                  ).Magnitude

                  local vertical =
                  math.abs(offset.Y)

                  -- Slot 2 ability
                  if AutoAbility
                  and horizontal <= 2
                  and vertical <= 2 then

                     keypress(0x32) -- 2
                     task.wait(0.05)
                     keyrelease(0x32)

                     mouse1click()

                  end

                  -- Slot 1 hit
                  if AutoHit
                  and horizontal <= 1
                  and vertical <= 2 then

                     keypress(0x31) -- 1
                     task.wait(0.05)
                     keyrelease(0x31)

                     mouse1click()

                  end

               end

            end

         end

      end

      task.wait(0.1)

   end

end)

--==================================
-- FULLBRIGHT
--==================================

VisualTab:CreateToggle({
   Name = "FullBright",
   CurrentValue = false,
   Callback = function(v)

      if v then

         Lighting.Brightness = 5
         Lighting.ClockTime = 14
         Lighting.FogEnd = 100000

      else

         Lighting.Brightness = 1

      end

   end
})

--==================================
-- LOW GRAPHICS
--==================================

VisualTab:CreateButton({
   Name = "Low Graphics",
   Callback = function()

      for _, obj in pairs(
         workspace:GetDescendants()
      ) do

         if obj:IsA("BasePart") then
            obj.Material =
            Enum.Material.SmoothPlastic
         end

      end

      Lighting.GlobalShadows = false

   end
})

--==================================
-- UI TOGGLE
--==================================

UIS.InputBegan:Connect(function(input)

   if input.KeyCode == Enum.KeyCode.RightControl then
      Rayfield:Toggle()
   end

end)
