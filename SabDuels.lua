local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

local OWNER = "sotirisgk89"

local CurrentSpeed = 16
local CurrentJump = 65
local CurrentFOV = 70

local Noclip = false
local AutoInteract = false
local AutoHit = false
local AutoAbility = false
local AbilityCooldown = false
local ESPEnabled = false
local InfiniteJump = false

local Window = Rayfield:CreateWindow({
	Name = "LuaServiceTeam",
	LoadingTitle = "LuaServiceTeam",
	LoadingSubtitle = LocalPlayer.Name == OWNER and "Owner Mode" or "Player Mode",
	KeySystem = false
})

Rayfield:Notify({
	Title = "LuaServiceTeam",
	Content = "You launched successfully",
	Duration = 4
})

Rayfield:Notify({
	Title = "LuaServiceTeam",
	Content = "Join our Discord link on Main tab",
	Duration = 4
})

local MainTab = Window:CreateTab("Main",4483362458)
local CombatTab = Window:CreateTab("Combat",4483362458)
local VisualTab = Window:CreateTab("Visual",4483362458)

MainTab:CreateLabel("Discord: discord.gg/XZafM7ESN")

-- SPEED
MainTab:CreateSlider({
	Name = "Speed",
	Range = {16,100},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(v)
		CurrentSpeed = v
	end
})

-- JUMP
MainTab:CreateButton({
	Name = "1.3x Jump",
	Callback = function()
		CurrentJump = 65
	end
})

-- FOV
MainTab:CreateSlider({
	Name = "FOV",
	Range = {70,120},
	Increment = 1,
	CurrentValue = 70,
	Callback = function(v)
		CurrentFOV = v
	end
})

-- INFINITE JUMP
MainTab:CreateToggle({
	Name = "Infinite Jump",
	CurrentValue = false,
	Callback = function(v)
		InfiniteJump = v
	end
})

UIS.JumpRequest:Connect(function()

	if InfiniteJump
	and LocalPlayer.Character then

		LocalPlayer.Character
		.Humanoid
		:ChangeState("Jumping")

	end

end)

-- APPLY MOVEMENT
task.spawn(function()

	while true do

		local char = LocalPlayer.Character

		if char then

			local hum =
			char:FindFirstChild("Humanoid")

			if hum then

				hum.WalkSpeed = CurrentSpeed
				hum.JumpPower = CurrentJump

			end

		end

		workspace.CurrentCamera.FieldOfView =
		CurrentFOV

		task.wait()

	end

end)

-- INVISIBLE
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

-- NOCLIP
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

-- AUTO INTERACT FOR UI BUTTONS
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

			local gui =
			LocalPlayer:FindFirstChild(
				"PlayerGui"
			)

			if gui then

				for _, obj in pairs(
					gui:GetDescendants()
				) do

					if obj:IsA("TextButton")
					or obj:IsA("ImageButton") then

						if obj.Visible then

							pcall(function()
								obj:Activate()
							end)

						end

					end

				end

			end

		end

		task.wait(0.5)

	end

end)

-- COMBAT
CombatTab:CreateToggle({
	Name = "Auto Slot 1 Hit",
	CurrentValue = false,
	Callback = function(v)
		AutoHit = v
	end
})

CombatTab:CreateToggle({
	Name = "Auto Slot 2 Ability",
	CurrentValue = false,
	Callback = function(v)
		AutoAbility = v
	end
})

local function EnemyNearby()

	local myRoot =
	LocalPlayer.Character and
	LocalPlayer.Character:FindFirstChild(
		"HumanoidRootPart"
	)

	if not myRoot then return false end

	for _, plr in pairs(
		Players:GetPlayers()
	) do

		if plr ~= LocalPlayer
		and plr.Character
		and plr.Character:FindFirstChild(
			"HumanoidRootPart"
		) then

			local dist =
			(
				myRoot.Position -
				plr.Character.HumanoidRootPart.Position
			).Magnitude

			if dist <= 3 then
				return true
			end

		end

	end

	return false

end

task.spawn(function()

	while true do

		if EnemyNearby() then

			if AutoHit then

				keypress(0x31)
				task.wait(0.05)
				keyrelease(0x31)

				mouse1click()

			end

			if AutoAbility
			and not AbilityCooldown then

				AbilityCooldown = true

				keypress(0x32)
				task.wait(0.05)
				keyrelease(0x32)

				mouse1click()

				task.delay(10,function()
					AbilityCooldown = false
				end)

			end

		end

		task.wait(0.1)

	end

end)

-- VISUALS
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

	end
})

VisualTab:CreateToggle({
	Name = "ESP + Tracers",
	CurrentValue = false,
	Callback = function(v)
		ESPEnabled = v
	end
})

local function SetupESP(plr)

	if plr == LocalPlayer then return end

	local function Apply(char)

		if not ESPEnabled then return end

		local h =
		Instance.new("Highlight")

		h.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

		h.Parent = char

	end

	if plr.Character then
		Apply(plr.Character)
	end

	plr.CharacterAdded:Connect(Apply)

end

for _, plr in pairs(
	Players:GetPlayers()
) do
	SetupESP(plr)
end

Players.PlayerAdded:Connect(SetupESP)

-- ANTI AFK
LocalPlayer.Idled:Connect(function()

	VirtualUser:Button2Down(
		Vector2.new(0,0),
		workspace.CurrentCamera.CFrame
	)

	task.wait(1)

	VirtualUser:Button2Up(
		Vector2.new(0,0),
		workspace.CurrentCamera.CFrame
	)

end)

-- TOGGLE UI
UIS.InputBegan:Connect(function(input)

	if input.KeyCode ==
	Enum.KeyCode.RightControl then

		Rayfield:Toggle()

	end

end)
