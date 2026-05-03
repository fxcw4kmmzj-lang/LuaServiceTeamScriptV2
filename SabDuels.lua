--// LOAD RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// SERVICES
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--// OWNER
local OWNER = "sotirisgk89"
local IsOwner = LocalPlayer.Name == OWNER

--// STATES
local CurrentSpeed = 16
local JumpMultiplier = 1.3

local Noclip = false
local AutoInteract = false
local AutoHit = false
local AutoAbility = false
local ESPEnabled = false

--// GUI
local Window = Rayfield:CreateWindow({
	Name = "LuaServiceTeam PvP",
	LoadingTitle = "Loading...",
	LoadingSubtitle = IsOwner and "Owner Mode" or "Player Mode",
	KeySystem = false
})

local MainTab = Window:CreateTab("Main",4483362458)
local VisualTab = Window:CreateTab("Visual",4483362458)

--===================================
-- MOVEMENT APPLY
--===================================

local function ApplyStats()

	local char = LocalPlayer.Character
	if not char then return end

	local hum = char:FindFirstChild("Humanoid")
	if not hum then return end

	hum.WalkSpeed = CurrentSpeed
	hum.JumpPower = 50 * JumpMultiplier

end

LocalPlayer.CharacterAdded:Connect(function()
	task.wait(1)
	ApplyStats()
end)

--===================================
-- SPEED
--===================================

MainTab:CreateSlider({
	Name = "Speed",
	Range = {16,100},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(v)

		CurrentSpeed = v
		ApplyStats()

	end
})

--===================================
-- JUMP
--===================================

MainTab:CreateButton({
	Name = "1.3x Jump",
	Callback = function()

		JumpMultiplier = 1.3
		ApplyStats()

	end
})

--===================================
-- INVISIBLE
--===================================

MainTab:CreateToggle({
	Name = "Invisible",
	CurrentValue = false,
	Callback = function(v)

		if LocalPlayer.Character then

			for _, part in pairs(
				LocalPlayer.Character:GetDescendants()
			) do

				if part:IsA("BasePart") then

					part.Transparency =
					v and 1 or 0

				end

			end

		end

	end
})

--===================================
-- NOCLIP
--===================================

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

--===================================
-- AUTO INTERACT
--===================================

MainTab:CreateToggle({
	Name = "Auto Interact",
	CurrentValue = false,
	Callback = function(v)
		AutoInteract = v
	end
})

task.spawn(function()

	while true do

		if AutoInteract then

			for _, prompt in pairs(
				workspace:GetDescendants()
			) do

				if prompt:IsA(
					"ProximityPrompt"
				) then

					prompt.HoldDuration = 0
					fireproximityprompt(prompt)

				end

			end

		end

		task.wait(0.2)

	end

end)

--===================================
-- AUTO HIT
--===================================

MainTab:CreateToggle({
	Name = "Auto Slot 1 Hit",
	CurrentValue = false,
	Callback = function(v)
		AutoHit = v
	end
})

--===================================
-- AUTO ABILITY
--===================================

MainTab:CreateToggle({
	Name = "Auto Slot 2 Ability",
	CurrentValue = false,
	Callback = function(v)
		AutoAbility = v
	end
})

local function GetNearbyEnemy()

	local myRoot =
	LocalPlayer.Character and
	LocalPlayer.Character:FindFirstChild(
		"HumanoidRootPart"
	)

	if not myRoot then return end

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

			local dist =
			(
				myRoot.Position -
				enemyRoot.Position
			).Magnitude

			if dist <= 3 then
				return true
			end

		end

	end

end

task.spawn(function()

	while true do

		local enemyClose =
		GetNearbyEnemy()

		if enemyClose then

			if AutoHit then

				keypress(0x31)
				task.wait(0.05)
				keyrelease(0x31)

				mouse1click()

			end

			if AutoAbility then

				keypress(0x32)
				task.wait(0.05)
				keyrelease(0x32)

				mouse1click()

			end

		end

		task.wait(0.15)

	end

end)

--===================================
-- FULLBRIGHT
--===================================

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

--===================================
-- LOW GRAPHICS
--===================================

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

--===================================
-- ESP
--===================================

local function AddESP(plr)

	if plr == LocalPlayer then return end

	plr.CharacterAdded:Connect(function(char)

		if not ESPEnabled then return end

		local highlight =
		Instance.new("Highlight")

		highlight.FillColor =
		Color3.fromRGB(255,0,0)

		highlight.Parent = char

	end)

end

for _, plr in pairs(
	Players:GetPlayers()
) do
	AddESP(plr)
end

Players.PlayerAdded:Connect(AddESP)

VisualTab:CreateToggle({
	Name = "Player ESP",
	CurrentValue = false,
	Callback = function(v)
		ESPEnabled = v
	end
})

--===================================
-- UI TOGGLE
--===================================

UIS.InputBegan:Connect(function(input)

	if input.KeyCode ==
	Enum.KeyCode.RightControl then

		Rayfield:Toggle()

	end

end)
