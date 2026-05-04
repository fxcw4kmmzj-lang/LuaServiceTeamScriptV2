--// LINORIA
local loadstring(game:HttpGet("https://raw.githubusercontent.com/fxcw4kmmzj-lang/LuaServiceTeamScriptV2/main/SabDuels.lua"))()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

local OWNER = "sotirisgk89"

-- STATES
local CurrentSpeed = 16
local CurrentJump = 65
local CurrentFOV = 70

local Noclip = false
local InfiniteJump = false
local AutoInteract = false
local AutoHit = false
local AutoAbility = false
local AbilityCooldown = false
local ESPEnabled = false

local SavedPosition = nil

-- WINDOW
local Window = Library:CreateWindow({
	Title = "LuaServiceTeam",
	Center = true,
	AutoShow = true
})

-- TABS
local Tabs = {
	Main = Window:AddTab("Main"),
	Combat = Window:AddTab("Combat"),
	Visual = Window:AddTab("Visual"),
	Extra = Window:AddTab("Extra")
}

-- GROUPS
local MainBox =
Tabs.Main:AddLeftGroupbox(
	"Player"
)

local CombatBox =
Tabs.Combat:AddLeftGroupbox(
	"Combat"
)

local VisualBox =
Tabs.Visual:AddLeftGroupbox(
	"Visual"
)

local ExtraBox =
Tabs.Extra:AddLeftGroupbox(
	"Extra"
)

-- INFO
ExtraBox:AddLabel(
	"Discord: discord.gg/XZafM7ESN"
)

ExtraBox:AddLabel(
	LocalPlayer.Name == OWNER
	and "Owner Mode"
	or "Player Mode"
)

--==================================
-- MOVEMENT
--==================================

MainBox:AddSlider(
	"Speed",
	{
		Text = "Speed",
		Default = 16,
		Min = 16,
		Max = 100,

		Callback = function(v)
			CurrentSpeed = v
		end
	}
)

MainBox:AddButton(
	"1.3x Jump",
	function()

		CurrentJump = 65

	end
)

MainBox:AddSlider(
	"FOV",
	{
		Text = "FOV",
		Default = 70,
		Min = 70,
		Max = 120,

		Callback = function(v)
			CurrentFOV = v
		end
	}
)

MainBox:AddToggle(
	"InfiniteJump",
	{
		Text = "Infinite Jump",

		Callback = function(v)
			InfiniteJump = v
		end
	}
)

UIS.JumpRequest:Connect(
	function()

		if InfiniteJump
		and LocalPlayer.Character then

			LocalPlayer.Character
			.Humanoid
			:ChangeState(
				"Jumping"
			)

		end

	end
)

-- Persistent stats
task.spawn(function()

	while true do

		local char =
		LocalPlayer.Character

		if char then

			local hum =
			char:FindFirstChild(
				"Humanoid"
			)

			if hum then

				hum.WalkSpeed =
				CurrentSpeed

				hum.JumpPower =
				CurrentJump

			end

		end

		workspace.CurrentCamera
		.FieldOfView =
		CurrentFOV

		task.wait()

	end

end)

--==================================
-- INVISIBLE
--==================================

MainBox:AddToggle(
	"Invisible",
	{
		Text = "Invisible",

		Callback = function(v)

			if LocalPlayer.Character then

				for _, part in pairs(
					LocalPlayer.Character
					:GetDescendants()
				) do

					if part:IsA(
						"BasePart"
					) then

						part.Transparency =
						v and 1 or 0

					end

				end

			end

		end
	}
)

--==================================
-- NOCLIP
--==================================

MainBox:AddToggle(
	"Noclip",
	{
		Text = "Noclip",

		Callback = function(v)
			Noclip = v
		end
	}
)

RunService.Stepped:Connect(
	function()

		if Noclip
		and LocalPlayer
		.Character then

			for _, p in pairs(
				LocalPlayer
				.Character
				:GetDescendants()
			) do

				if p:IsA(
					"BasePart"
				) then

					p.CanCollide =
					false

				end

			end

		end

	end
)

--==================================
-- AUTO INTERACT
--==================================

MainBox:AddToggle(
	"AutoInteract",
	{
		Text = "Auto Interact",

		Callback = function(v)
			AutoInteract = v
		end
	}
)

task.spawn(function()

	while true do

		if AutoInteract
		and LocalPlayer
		.Character then

			local hrp =
			LocalPlayer
			.Character
			:FindFirstChild(
				"HumanoidRootPart"
			)

			if hrp then

				-- Prompts
				for _, obj in pairs(
					workspace
					:GetDescendants()
				) do

					if obj:IsA(
						"ProximityPrompt"
					) then

						local p =
						obj.Parent

						if p
						and p:IsA(
							"BasePart"
						) then

							local dist =
							(
								hrp.Position -
								p.Position
							).Magnitude

							if dist <= 2 then

								fireproximityprompt(
									obj
								)

							end

						end

					end

				end

				-- UI Buttons
				local gui =
				LocalPlayer
				.PlayerGui

				for _, btn in pairs(
					gui:GetDescendants()
				) do

					if btn:IsA(
						"TextButton"
					)
					or btn:IsA(
						"ImageButton"
					) then

						if btn.Visible then

							pcall(
								function()

									btn:Activate()

								end
							)

						end

					end

				end

			end

		end

		task.wait(0.2)

	end

end)

--==================================
-- COMBAT
--==================================

CombatBox:AddToggle(
	"AutoHit",
	{
		Text = "Auto Slot 1 Hit",

		Callback = function(v)
			AutoHit = v
		end
	}
)

CombatBox:AddToggle(
	"AutoAbility",
	{
		Text = "Auto Slot 2 Ability",

		Callback = function(v)
			AutoAbility = v
		end
	}
)

--==================================
-- FULLBRIGHT
--==================================

VisualBox:AddToggle(
	"FullBright",
	{
		Text = "FullBright",

		Callback = function(v)

			if v then

				Lighting
				.Brightness =
				5

			else

				Lighting
				.Brightness =
				1

			end

		end
	}
)

--==================================
-- LOW GRAPHICS
--==================================

VisualBox:AddButton(
	"Low Graphics",
	function()

		for _, obj in pairs(
			workspace
			:GetDescendants()
		) do

			if obj:IsA(
				"BasePart"
			) then

				obj.Material =
				Enum.Material
				.SmoothPlastic

			end

		end

	end
)

--==================================
-- SAVE POSITION
--==================================

ExtraBox:AddButton(
	"Save Position",
	function()

		if LocalPlayer
		.Character then

			SavedPosition =
			LocalPlayer
			.Character
			.HumanoidRootPart
			.CFrame

		end

	end
)

ExtraBox:AddButton(
	"Teleport Back",
	function()

		if SavedPosition
		and LocalPlayer
		.Character then

			LocalPlayer
			.Character
			.HumanoidRootPart
			.CFrame =
			SavedPosition

		end

	end
)

--==================================
-- ANTI AFK
--==================================

LocalPlayer.Idled:Connect(
	function()

		VirtualUser
		:Button2Down(
			Vector2.new(
				0,0
			),
			workspace
			.CurrentCamera
			.CFrame
		)

		task.wait(1)

		VirtualUser
		:Button2Up(
			Vector2.new(
				0,0
			),
			workspace
			.CurrentCamera
			.CFrame
		)

	end
)
