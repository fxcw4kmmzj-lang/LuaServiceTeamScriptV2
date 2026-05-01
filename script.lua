--// LOAD RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// SERVICES
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

--// STATES
local FlyEnabled = false
local FlySpeed = 60
local InfiniteJump = false
local SprintMode = false
local AutoInteract = false
local AutoRange = 10
local SavedPosition = nil

local Logs = {}

local function AddLog(msg)
	table.insert(Logs, tostring(msg))
	if #Logs > 30 then
		table.remove(Logs, 1)
	end
end

--// WINDOW
local Window = Rayfield:CreateWindow({
	Name = "LuaServiceTeam",
	LoadingTitle = "LuaServiceTeam Hub",
	LoadingSubtitle = "Developer Panel",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "LST_DEV",
		FileName = "Config"
	},
	KeySystem = false
})

--// TABS
local HomeTab = Window:CreateTab("Home", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)
local VisualTab = Window:CreateTab("Visual", 4483362458)
local WorldTab = Window:CreateTab("World", 4483362458)
local ConsoleTab = Window:CreateTab("Console", 4483362458)
local TrackerTab = Window:CreateTab("Players", 4483362458)

-- =========================
-- HOME
-- =========================

HomeTab:CreateLabel("LuaServiceTeam Dev Hub")

-- =========================
-- PLAYER
-- =========================

PlayerTab:CreateSlider({
	Name = "WalkSpeed",
	Range = {16,200},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(v)
		LocalPlayer.Character.Humanoid.WalkSpeed = v
	end
})

PlayerTab:CreateSlider({
	Name = "JumpPower",
	Range = {50,200},
	Increment = 5,
	CurrentValue = 50,
	Callback = function(v)
		LocalPlayer.Character.Humanoid.JumpPower = v
	end
})

-- Fly
PlayerTab:CreateToggle({
	Name = "Fly",
	CurrentValue = false,
	Callback = function(v)
		FlyEnabled = v
	end
})

PlayerTab:CreateSlider({
	Name = "Fly Speed",
	Range = {20,150},
	Increment = 5,
	CurrentValue = 60,
	Callback = function(v)
		FlySpeed = v
	end
})

-- Infinite Jump
PlayerTab:CreateToggle({
	Name = "Infinite Jump",
	CurrentValue = false,
	Callback = function(v)
		InfiniteJump = v
	end
})

-- Sprint
PlayerTab:CreateToggle({
	Name = "Sprint Mode",
	CurrentValue = false,
	Callback = function(v)
		SprintMode = v
	end
})

-- Gravity
PlayerTab:CreateSlider({
	Name = "Gravity",
	Range = {0,196},
	Increment = 5,
	CurrentValue = 196,
	Callback = function(v)
		workspace.Gravity = v
	end
})

-- FOV
PlayerTab:CreateSlider({
	Name = "FOV",
	Range = {40,120},
	Increment = 1,
	CurrentValue = 70,
	Callback = function(v)
		workspace.CurrentCamera.FieldOfView = v
	end
})

-- Save Position
PlayerTab:CreateButton({
	Name = "Save Position",
	Callback = function()
		SavedPosition =
		LocalPlayer.Character.HumanoidRootPart.CFrame

		AddLog("Position Saved")
	end
})

PlayerTab:CreateButton({
	Name = "Load Position",
	Callback = function()
		if SavedPosition then
			LocalPlayer.Character.HumanoidRootPart.CFrame =
			SavedPosition
		end
	end
})

-- Auto E
PlayerTab:CreateToggle({
	Name = "Auto Interact (E)",
	CurrentValue = false,
	Callback = function(v)
		AutoInteract = v
	end
})

PlayerTab:CreateSlider({
	Name = "Auto E Range",
	Range = {5,25},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(v)
		AutoRange = v
	end
})

-- =========================
-- VISUAL
-- =========================

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
	Name = "Show Names",
	Callback = function()

		for _, plr in pairs(
			Players:GetPlayers()
		) do

			if plr.Character and plr.Character:FindFirstChild("Head") then

				if not plr.Character.Head:FindFirstChild("DevName") then

					local gui = Instance.new("BillboardGui")
					gui.Name = "DevName"
					gui.Size = UDim2.new(0,100,0,30)
					gui.AlwaysOnTop = true
					gui.Parent = plr.Character.Head

					local label = Instance.new("TextLabel")
					label.Size = UDim2.new(1,0,1,0)
					label.BackgroundTransparency = 1
					label.Text = plr.Name
					label.TextColor3 = Color3.fromRGB(0,200,255)
					label.Parent = gui

				end

			end

		end

	end
})

-- =========================
-- WORLD
-- =========================

WorldTab:CreateButton({
	Name = "Day",
	Callback = function()
		Lighting.ClockTime = 14
	end
})

WorldTab:CreateButton({
	Name = "Night",
	Callback = function()
		Lighting.ClockTime = 0
	end
})

WorldTab:CreateButton({
	Name = "Low Graphics",
	Callback = function()

		for _, v in pairs(
			workspace:GetDescendants()
		) do

			if v:IsA("BasePart") then
				v.Material = Enum.Material.SmoothPlastic
			end

		end

		Lighting.GlobalShadows = false

	end
})

-- =========================
-- CONSOLE
-- =========================

local ConsoleText = ConsoleTab:CreateParagraph({
	Title = "Logs",
	Content = "Waiting..."
})

ConsoleTab:CreateInput({
	Name = "Command",
	PlaceholderText = "printpos",
	Callback = function(text)

		AddLog("> "..text)

		if text == "printpos" then
			AddLog(
				LocalPlayer.Character
				.HumanoidRootPart.Position
			)
		end

	end
})

ConsoleTab:CreateButton({
	Name = "Clear Logs",
	Callback = function()
		Logs = {}
	end
})

-- =========================
-- TRACKER
-- =========================

TrackerTab:CreateInput({
	Name = "Search Player",
	PlaceholderText = "name...",
	Callback = function(text)

		for _, plr in pairs(
			Players:GetPlayers()
		) do

			if string.find(
				string.lower(plr.Name),
				string.lower(text)
			) then

				AddLog("Found: "..plr.Name)

			end

		end

	end
})

TrackerTab:CreateButton({
	Name = "Player Count",
	Callback = function()
		AddLog(
			"Players: "..#Players:GetPlayers()
		)
	end
})

-- =========================
-- LOOPS
-- =========================

-- Console update
task.spawn(function()

	while true do

		ConsoleText:Set({
			Title = "Logs",
			Content = table.concat(
				Logs,
				"\n"
			)
		})

		task.wait(1)

	end

end)

-- Fly loop
task.spawn(function()

	while true do

		if FlyEnabled and LocalPlayer.Character then

			local hrp =
			LocalPlayer.Character:FindFirstChild(
				"HumanoidRootPart"
			)

			if hrp then

				hrp.Velocity =
				workspace.CurrentCamera.CFrame.LookVector
				* FlySpeed

			end

		end

		task.wait()

	end

end)

-- Auto E loop
task.spawn(function()

	while true do

		if AutoInteract and LocalPlayer.Character then

			local hrp =
			LocalPlayer.Character:FindFirstChild(
				"HumanoidRootPart"
			)

			if hrp then

				for _, obj in pairs(
					workspace:GetDescendants()
				) do

					if obj:IsA(
						"ProximityPrompt"
					) then

						local parent =
						obj.Parent

						if parent and parent:IsA(
							"BasePart"
						) then

							local distance =
							(
								hrp.Position -
								parent.Position
							).Magnitude

							if distance <= AutoRange then

								fireproximityprompt(obj)

							end

						end

					end

				end

			end

		end

		task.wait(0.2)

	end

end)

-- Infinite Jump
UIS.JumpRequest:Connect(function()

	if InfiniteJump then

		LocalPlayer.Character
		.Humanoid
		:ChangeState("Jumping")

	end

end)

-- Sprint
UIS.InputBegan:Connect(function(input)

	if SprintMode then

		if input.KeyCode ==
		Enum.KeyCode.LeftShift then

			LocalPlayer.Character
			.Humanoid
			.WalkSpeed = 100

		end

	end

end)

UIS.InputEnded:Connect(function(input)

	if input.KeyCode ==
	Enum.KeyCode.LeftShift then

		LocalPlayer.Character
		.Humanoid
		.WalkSpeed = 16

	end

end)

-- Anti AFK
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

-- Player events
Players.PlayerAdded:Connect(function(plr)
	AddLog(plr.Name.." joined")
end)

Players.PlayerRemoving:Connect(function(plr)
	AddLog(plr.Name.." left")
end)

-- Toggle UI
UIS.InputBegan:Connect(function(input)

	if input.KeyCode ==
	Enum.KeyCode.RightControl then

		Rayfield:Toggle()

	end

end)
