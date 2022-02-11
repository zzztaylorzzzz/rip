local studio = false
local r15 = false
if not owner then owner = game:GetService("Players"):FindFirstChild(script.Parent.Name) studio = true print("Preparing script") wait() script.Parent = workspace print("Running") end
local char = owner.Character

local upperTorso = char:FindFirstChild("UpperTorso")
if upperTorso then r15 = true end

if not r15 then print("This script only works for r15 body types") script:Destroy() end

local vampireIndicator = Instance.new("BoolValue")
vampireIndicator.Name, vampireIndicator.Value, vampireIndicator.Parent = "Vampire", true, char

local animate = char:FindFirstChild("Animate")
local hum = char:FindFirstChild("Humanoid")
local head = char.Head
local rarm = char:FindFirstChild("RightUpperArm")
local larm = char:FindFirstChild("LeftUpperArm")
local rlarm = char:FindFirstChild("RightLowerArm")
local llarm = char:FindFirstChild("LeftLowerArm")
local rhand = char:FindFirstChild("RightHand")
local lhand = char:FindFirstChild("LeftHand")
local lowerTorso = char:FindFirstChild("LowerTorso")
local lleg, rleg = char:FindFirstChild("LeftUpperLeg"), char:FindFirstChild("RightUpperLeg")
local llleg, rlleg = char:FindFirstChild("LeftLowerLeg"), char:FindFirstChild("RightLowerLeg")
local lfoot, rfoot = char:FindFirstChild("LeftFoot"), char:FindFirstChild("RightFoot")
local hrp = char.HumanoidRootPart
hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

local rarmmotor = rarm.RightShoulder
local larmmotor = larm.LeftShoulder
local rlarmmotor = rlarm.RightElbow
local llarmmotor = llarm.LeftElbow
local rhandmotor = rhand.RightWrist
local lhandmotor = lhand.LeftWrist
local torsomotor = upperTorso.Waist
local ltorsomotor = lowerTorso.Root
local llegmotor, rlegmotor = lleg.LeftHip, rleg.RightHip
local lllegmotor, rllegmotor = llleg.LeftKnee, rlleg.RightKnee
local lfootmotor, rfootmotor = lfoot.LeftAnkle, rfoot.RightAnkle
local headmotor = head.Neck

local torsoOrig, ltorsoOrig, headOrig, rarmOrig, larmOrig = upperTorso.Waist.C0, lowerTorso.Root.C0, head.Neck.C0, rarmmotor.C0, larmmotor.C0
local rlarmOrig, llarmOrig = rlarmmotor.C0, llarmmotor.C0
local lhandOrig = lhandmotor.C0
local rhandOrig = rhandmotor.C0
local rlegOrig = rlegmotor.C0
local rllegOrig = rllegmotor.C0
local rfootOrig = rfootmotor.C0
local llegOrig = llegmotor.C0
local lllegOrig = lllegmotor.C0
local lfootOrig = lfootmotor.C0

local torsoName, rarmName, larmName, rlarmName, llarmName, headName = "UpperTorso", "RightUpperArm", "LeftUpperArm", "RightLowerArm", "LeftLowerArm", "Head"
local rhandName = rhand.Name
local lhandName = lhand.Name
local rlegName = rleg.Name
local rllegName = rlleg.Name
local rfootName = rfoot.Name
local llegName = lleg.Name
local lllegName = llleg.Name
local lfootName = lfoot.Name


local players = game:GetService("Players")
local runServ = game:GetService("RunService")
local tweenServ = game:GetService("TweenService")
local phys = game:GetService("PhysicsService")
local debris = game:GetService("Debris")
local lighting = game:GetService("Lighting")

local stunned = false

local primaryScript, remote, remoteValue, playerRemote;
remote = Instance.new("RemoteEvent")
remote.Parent, remote.Name = script, "vampEvents"
remoteValue = Instance.new("ObjectValue")
remoteValue.Name, remoteValue.Value = "vampRemote", remote
playerRemote = Instance.new("RemoteEvent")
playerRemote.Name, playerRemote.Parent = "playerRemote", char

local escSuccess, escFail = 15, 25

local grabCollision;
for _, group in pairs(phys:GetCollisionGroups()) do if group.name == "grabCollision" then print("Found!") phys:RemoveCollisionGroup("grabCollision") end end
phys:CreateCollisionGroup("grabCollision")
phys:CollisionGroupSetCollidable("grabCollision", "Default", false)

if studio then
	primaryScript = script.primaryScript:Clone()
elseif not studio then
	primaryScript = NLS([[local debris = game:GetService("Debris")
local tweenServ = game:GetService("TweenService")
local input = game:GetService("UserInputService")
local runServ = game:GetService("RunService")
local phys = game:GetService("PhysicsService")
local pfind = game:GetService("PathfindingService")

local lighting = game:GetService("Lighting")
local Ang = CFrame.Angles	
local aSin = math.asin
local aTan = math.atan

warn("Added")

local Cam = game.Workspace.CurrentCamera
--Cam.FieldOfView = 90
local deadScript = false
local remote = script:WaitForChild("vampRemote").Value
local playerRemote = script.Parent:WaitForChild("playerRemote")


local Plr = game:GetService("Players").LocalPlayer
local gui = Plr:WaitForChild("PlayerGui")
local Mouse = Plr:GetMouse()
local Body = Plr.Character or Plr.CharacterAdded:wait()
local Head = Body:WaitForChild("Head")
local Hum = Body:WaitForChild("Humanoid")
local Core = Body:WaitForChild("HumanoidRootPart")
local IsR6 = (Hum.RigType.Value==0)	
local Trso = (IsR6 and Body:WaitForChild("Torso")) or Body:WaitForChild("UpperTorso")
local Neck = (IsR6 and Trso:WaitForChild("Neck")) or Head:WaitForChild("Neck")	
local Waist = (not IsR6 and Trso:WaitForChild("Waist"))
local upperTorso = Body:WaitForChild("UpperTorso")
local screen;

local ambienttracker = script:WaitForChild("AmbientTracker")
local odambienttracker = script:WaitForChild("ODAmbientTracker")
local ambienttween = tweenServ:Create(lighting, TweenInfo.new(0.5), {Ambient = Color3.fromRGB(135, 180, 137)})
local odambienttween = tweenServ:Create(lighting, TweenInfo.new(0.5), {OutdoorAmbient = Color3.fromRGB(135, 180, 137)})
local vampAmb = false
local cce, blur = Instance.new("ColorCorrectionEffect", game:GetService("Lighting")), Instance.new("BlurEffect", game:GetService("Lighting"))
cce.Name = "zenvetierem"
blur.Name = "zenvetierem"
blur.Size = 0
local biting, victim;

--Plr.CameraMode = Enum.CameraMode.LockFirstPerson
--input.MouseIconEnabled = false

local stunned = false
local vampire = false
local maxStamina = 100
local stamina = 100
local sprinting = false
local sprintDisabled = false
local jumpPower = 35
local sprintSpeed = 20
local walkSpeed = 16
local vampWalk, vampSprint, vampJump = 18, 28, 50
local bitingSpeed =  8
local grabCD = false
local drainCD = false
usingP, usingS = false, false
local ability = false
local abilityLock = false
local crouching = false

local MseGuide = false


local TurnCharacterToMouse = false


local HeadHorFactor = 1
local HeadVertFactor = 0.6
local BodyHorFactor = 0.5
local BodyVertFactor = 0.4


local UpdateSpeed = 0.5

local NeckOrgnC0 = Neck.C0	
local WaistOrgnC0 = (not IsR6 and Waist.C0)	



Neck.MaxVelocity = 1/3

if TurnCharacterToMouse == true then
	MseGuide = true
	HeadHorFactor = 0
	BodyHorFactor = 0
end

for _,v in pairs(Body:GetChildren()) do
	if v:IsA("BasePart") and v.Name ~= "Head" then
		v.LocalTransparencyModifier = 0
	end
end
Hum.CameraOffset = (Core.CFrame:ToWorldSpace(CFrame.new(0, 1, 0.7))):pointToObjectSpace(Head.CFrame.p)
local fallen = false
local running;
running = game:GetService("RunService").RenderStepped:Connect(function()
	if not deadScript then
		if ambienttracker.Value == Color3.fromRGB(0, 0, 0) and odambienttracker.Value == Color3.fromRGB(0, 0, 0) and victim then
			vampAmb = false
			lighting.Ambient = Color3.fromRGB(0, 0, 0)
		else
			if vampire and not vampAmb and lighting.Ambient ~= Color3.fromRGB(135, 180, 137) then
				ambienttween = tweenServ:Create(lighting, TweenInfo.new(0.25), {Ambient = Color3.fromRGB(135, 180, 137)})
				odambienttween = tweenServ:Create(lighting, TweenInfo.new(0.25), {OutdoorAmbient = Color3.fromRGB(36, 48, 36)})
				ambienttween:Play()
				task.delay(0.25, function()
					vampAmb = true
				end)
			elseif vampire and vampAmb and lighting.Ambient ~= Color3.fromRGB(135, 180, 137) then
				lighting.Ambient = Color3.fromRGB(135, 180, 137)
				lighting.OutdoorAmbient = Color3.fromRGB(36, 48, 36)
			elseif not vampire then
				vampAmb = false
				ambienttween = tweenServ:Create(lighting, TweenInfo.new(0.25), {Ambient = ambienttracker.Value})
				odambienttween = tweenServ:Create(lighting, TweenInfo.new(0.25), {OutdoorAmbient = odambienttracker.Value})
				ambienttween:Play()
				odambienttween:Play()
			end
		end
		if Hum.Health > 0 then
			cce.Saturation = -0.8 - (-0.8 * (Hum.Health/Hum.MaxHealth))
			blur.Size = 8 - (8 * (Hum.Health/Hum.MaxHealth))
		else
			deadScript = true
		end
		for _,v in pairs(Body:GetChildren()) do
			if v:IsA("BasePart") and v.Name ~= "Head" then
				v.LocalTransparencyModifier = 0
			end
		end
		Hum.CameraOffset = (Core.CFrame:ToWorldSpace(CFrame.new(0, 1, 0.7))):pointToObjectSpace(Head.CFrame.p)
		if Hum.PlatformStand == true and not fallen then
			print("pstand")
			if crouching then crouching = false remote:FireServer("uncrouch") end
			if Cam.CameraType ~= Enum.CameraType.Scriptable then
				for _,v in pairs(Plr.Character:GetDescendants()) do if v == Plr.Character.Head or v.Parent:IsA("Accessory") and v:IsA("BasePart") then v.Transparency = 1 end end
				Cam.CameraSubject = workspace
				Cam.CameraType = Enum.CameraType.Scriptable
			end
			--tweenServ:Create(Cam, TweenInfo.new(0.1), {CFrame = Head.CFrame}):Play()
			Cam.CFrame = Head.CFrame
		elseif Hum.Health > 0 then
			if Cam.CameraType ~= Enum.CameraType.Custom then
				for _,v in pairs(Plr.Character:GetDescendants()) do if v == Plr.Character.Head or v.Parent:IsA("Accessory") and v:IsA("BasePart") then v.Transparency = 0 end end
				Cam.CameraSubject = Hum
				Cam.CameraType = Enum.CameraType.Custom
			end
		end
		local CamCF = Cam.CoordinateFrame
		if ((IsR6 and Body["Torso"]) or Body["UpperTorso"])~=nil and Body["Head"]~=nil then	
			local TrsoLV = Trso.CFrame.lookVector
			local HdPos = Head.CFrame.p
			if IsR6 and Neck or Neck and Waist then	--[Make sure the Neck still exists.]
				if Cam.CameraSubject:IsDescendantOf(Body) or Cam.CameraSubject:IsDescendantOf(Plr) then
					local Dist = nil;
					local Diff = nil;
					if not MseGuide then	
						Dist = (Head.CFrame.p-CamCF.p).magnitude
						Diff = Head.CFrame.Y-CamCF.Y
						--if not IsR6 then	
						--	Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang((aSin(Diff/Dist)*HeadVertFactor), -(((HdPos-CamCF.p).Unit):Cross(TrsoLV)).Y*HeadHorFactor, 0), UpdateSpeed/2)
						--	Waist.C0 = Waist.C0:lerp(WaistOrgnC0*Ang((aSin(Diff/Dist)*BodyVertFactor), -(((HdPos-CamCF.p).Unit):Cross(TrsoLV)).Y*BodyHorFactor, 0), UpdateSpeed/2)
						--else	
						--	Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang(-(aSin(Diff/Dist)*HeadVertFactor), 0, -(((HdPos-CamCF.p).Unit):Cross(TrsoLV)).Y*HeadHorFactor),UpdateSpeed/2)
						--end
					else
						local Point = Mouse.Hit.p
						Dist = (Head.CFrame.p-Point).magnitude
						Diff = Head.CFrame.Y-Point.Y
						--if not IsR6 then
						--	Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang(-(aTan(Diff/Dist)*HeadVertFactor), (((HdPos-Point).Unit):Cross(TrsoLV)).Y*HeadHorFactor, 0), UpdateSpeed/2)
						--	Waist.C0 = Waist.C0:lerp(WaistOrgnC0*Ang(-(aTan(Diff/Dist)*BodyVertFactor), (((HdPos-Point).Unit):Cross(TrsoLV)).Y*BodyHorFactor, 0), UpdateSpeed/2)
						--else
						--	Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang((aTan(Diff/Dist)*HeadVertFactor), 0, (((HdPos-Point).Unit):Cross(TrsoLV)).Y*HeadHorFactor), UpdateSpeed/2)
						--end
					end
				end
			end
		end
	end
	--if TurnCharacterToMouse == true then
	--	Hum.AutoRotate = false
	--	Core.CFrame = Core.CFrame:lerp(CFrame.new(Core.Position, Vector3.new(Mouse.Hit.p.x, Core.Position.Y, Mouse.Hit.p.z)), UpdateSpeed / 2)
	--else
	--	Hum.AutoRotate = true
	--end
end)

Hum.Died:Connect(function()
	if victim then
		biting = false
		vampire = false
		remote:FireServer("release", victim.Name)
		playerRemote.OnClientEvent:Wait()
		victim = false
	end

	--== UI STUFF ==--
	local deathgui = Instance.new("ScreenGui")
	deathgui.Name, deathgui.IgnoreGuiInset, deathgui.Parent = "DeathStatus", true, Plr.PlayerGui
	local team = Instance.new("TextLabel")
	local name = Instance.new("TextLabel")
	local cause = Instance.new("TextLabel")
	local icon = Instance.new("ImageLabel")
	team.Parent, name.Parent, cause.Parent, icon.Parent = deathgui, deathgui, deathgui, cause
	--Attributes
	name.TextXAlignment = Enum.TextXAlignment.Right
	team.Name, name.Name, cause.Name = "zenvetierem", "zenvetierem", "zenvetierem"
	team.Text, name.Text, cause.Text = "Survivor", Plr.Name, "Died"
	team.TextScaled, name.TextScaled, cause.TextScaled = true, true, true
	team.Size, name.Size, cause.Size = UDim2.new(0.073, 0, 0.061, 0), UDim2.new(0.15, 0, 0.052, 0), UDim2.new(0.05, 0, 0.05, 0)
	team.Position, name.Position, cause.Position = UDim2.new(-1.188, 0, 0.42, 0), UDim2.new(-1.111, 0, 0.481, 0), UDim2.new(-1.211, 0, 0.533, 0)
	team.TextColor3, name.TextColor3, cause.TextColor3 = Color3.fromRGB(0, 245, 8), Color3.fromRGB(104, 232, 102), Color3.fromRGB(255, 255, 255)
	team.TextStrokeTransparency, name.TextStrokeTransparency, cause.TextStrokeTransparency = 0.95, 0.85, 0.95
	team.BackgroundTransparency, name.BackgroundTransparency, cause.BackgroundTransparency = 1, 1, 1
	team.Font, name.Font, cause.Font = Enum.Font.PermanentMarker, Enum.Font.Arial, Enum.Font.Nunito

	icon.BackgroundTransparency = 1
	icon.Size, icon.Position = UDim2.new(0.5, 0, 0.85, 0), UDim2.new(-1.994, 0, 0.067, 0)
	icon.Image = "rbxassetid://7168806205"
	--Gradients
	local nameGrad, teamGrad, causeGrad = Instance.new("UIGradient"), Instance.new("UIGradient"), Instance.new("UIGradient")
	nameGrad.Parent, teamGrad.Parent, causeGrad.Parent = name, team, cause
	nameGrad.Rotation, teamGrad.Rotation, causeGrad.Rotation = 90, 90, 90
	nameGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(0.639, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
	}
	teamGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(6, 255, 47)),
		ColorSequenceKeypoint.new(0.644, Color3.fromRGB(58, 239, 17)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 12))
	}
	causeGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(0.649, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
	}

	--== Camera / Sceneic stuff ==--
	Cam.CameraType = Enum.CameraType.Scriptable
	local tempworld = Instance.new("Model") tempworld.Name = "zenvetierem"
	debris:AddItem(tempworld, 7)
	local cameraPos;
	if Plr.Character:FindFirstChild("Head") then
		local position = Plr.Character.Head.Position + Plr.Character.Head.CFrame:vectorToWorldSpace(Vector3.new(0, 0, -4))
		cameraPos = CFrame.new(position, Plr.Character.Head.Position)
	else
		cameraPos = workspace.CurrentCamera.CFrame
	end

	for _,v in pairs(workspace:GetChildren()) do v.Archivable = true
		if not v:IsA("Terrain") and not v:IsA("Camera") then local tempInstance = v:Clone() tempInstance.Parent = tempworld end
	end
	for _,v in pairs(tempworld:GetDescendants()) do v.Archivable = true
		if v:IsA("BasePart") then v.Anchored = true v.Position = v.Position + Vector3.new(5000, 5000, 0) end
	end

	local tween = tweenServ:Create(cce, TweenInfo.new(2), {Brightness = -1}) tween:Play()
	local diefunc = game:GetService("RunService").Heartbeat:Connect(function() Cam.CFrame = Head.CFrame end)
	wait(2)
	blur.Size = 0
	local tween = tweenServ:Create(cce, TweenInfo.new(1), {Brightness = 0, Contrast = 0, Saturation = 0, TintColor = Color3.fromRGB(255, 255, 255)}) tween:Play()
	local tween = tweenServ:Create(team, TweenInfo.new(1), {Position = UDim2.new(0.188, 0, 0.42, 0)}) tween:Play()
	local tween = tweenServ:Create(name, TweenInfo.new(1), {Position = UDim2.new(0.111, 0, 0.481, 0)}) tween:Play()
	local tween = tweenServ:Create(cause, TweenInfo.new(1), {Position = UDim2.new(0.211, 0, 0.533, 0)}) tween:Play()
	local tween = tweenServ:Create(icon, TweenInfo.new(1), {Position = UDim2.new(0.994, 0, 0.067, 0)}) tween:Play()
	diefunc:Disconnect()
	Cam.CFrame = cameraPos + Vector3.new(5000, 5000, 0)
	tempworld.Parent = workspace
end)

----- GUI Stuff ---
local staminaL, staminaR, healthL, healthR;
local barL, barR;
local healthRadial, staminaRadial;

local function loadGui()
	local CircleProgressGui = Instance.new("ScreenGui")
	CircleProgressGui.Name = "CircleProgressGui"

	local Health = Instance.new("Frame")
	Health.Name = "Health"
	Health.AnchorPoint = Vector2.new(0.5, 0.5)
	Health.Size = UDim2.new(0.0537205, 0, 0.1388455, 0)
	Health.BackgroundTransparency = 1
	Health.Position = UDim2.new(0.5, 0, 0.912, 0)
	Health.BorderSizePixel = 0
	Health.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Health.Parent = CircleProgressGui

	local LeftBG = Instance.new("ImageLabel")
	LeftBG.Name = "LeftBG"
	LeftBG.ZIndex = 3
	LeftBG.Size = UDim2.new(0.5, 0, 1, 0)
	LeftBG.BackgroundTransparency = 1
	LeftBG.BorderSizePixel = 0
	LeftBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftBG.ImageColor3 = Color3.fromRGB(22, 22, 22)
	LeftBG.ImageRectOffset = Vector2.new(-500, 0)
	LeftBG.ImageRectSize = Vector2.new(1000, 2000)
	LeftBG.Image = "rbxassetid://7036402637"
	LeftBG.Parent = Health

	local LeftFrame = Instance.new("Frame")
	LeftFrame.Name = "LeftFrame"
	LeftFrame.ZIndex = 2
	LeftFrame.Size = UDim2.new(2, 0, 1, 0)
	LeftFrame.BackgroundTransparency = 1
	LeftFrame.BorderSizePixel = 0
	LeftFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	LeftFrame.Parent = LeftBG

	local LeftBG1 = Instance.new("ImageLabel")
	LeftBG1.Name = "LeftBG"
	LeftBG1.ZIndex = 3
	LeftBG1.Size = UDim2.new(0.5, 0, 1, 0)
	LeftBG1.BackgroundTransparency = 1
	LeftBG1.BorderSizePixel = 0
	LeftBG1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftBG1.ImageRectOffset = Vector2.new(-500, 0)
	LeftBG1.ImageRectSize = Vector2.new(1000, 2000)
	LeftBG1.Image = "rbxassetid://7036407423"
	LeftBG1.Parent = LeftFrame

	local RightBG = Instance.new("ImageLabel")
	RightBG.Name = "RightBG"
	RightBG.Size = UDim2.new(0.5, 0, 1, 0)
	RightBG.BackgroundTransparency = 1
	RightBG.Position = UDim2.new(0.5, 0, 0, 0)
	RightBG.BorderSizePixel = 0
	RightBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightBG.ImageColor3 = Color3.fromRGB(22, 22, 22)
	RightBG.ImageRectOffset = Vector2.new(500, 0)
	RightBG.ImageRectSize = Vector2.new(1000, 2000)
	RightBG.Image = "rbxassetid://7036402637"
	RightBG.Parent = Health

	local RightFrame = Instance.new("Frame")
	RightFrame.Name = "RightFrame"
	RightFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	RightFrame.Size = UDim2.new(2, 0, 1, 0)
	RightFrame.BackgroundTransparency = 1
	RightFrame.Position = UDim2.new(0, 0, 0.5, 0)
	RightFrame.BorderSizePixel = 0
	RightFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightFrame.Parent = RightBG

	local RightBG1 = Instance.new("ImageLabel")
	RightBG1.Name = "RightBG"
	RightBG1.Size = UDim2.new(0.5, 0, 1, 0)
	RightBG1.BackgroundTransparency = 1
	RightBG1.Position = UDim2.new(0.5, 0, 0, 0)
	RightBG1.BorderSizePixel = 0
	RightBG1.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
	RightBG1.ImageRectOffset = Vector2.new(500, 0)
	RightBG1.ImageRectSize = Vector2.new(1000, 2000)
	RightBG1.Image = "rbxassetid://7036407423"
	RightBG1.Parent = RightFrame

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.Parent = Health

	local Inner = Instance.new("Frame")
	Inner.Name = "Inner"
	Inner.ZIndex = -1
	Inner.Size = UDim2.new(1, 0, 1, 0)
	Inner.BackgroundTransparency = 1
	Inner.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
	Inner.Parent = Health

	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.ZIndex = -1
	ImageLabel.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.ImageColor3 = Color3.fromRGB(53, 53, 53)
	ImageLabel.Image = "http://www.roblox.com/asset/?id=1584320567"
	ImageLabel.Parent = Inner

	local Label = Instance.new("TextLabel")
	Label.Name = "Label"
	Label.BorderMode = Enum.BorderMode.Inset
	Label.ZIndex = 0
	Label.Size = UDim2.new(0.5, 0, 0.5, 0)
	Label.BorderColor3 = Color3.fromRGB(255, 255, 255)
	Label.BackgroundTransparency = 1
	Label.Position = UDim2.new(0.25, 0, 0.25, 0)
	Label.BorderSizePixel = 2
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label.FontSize = Enum.FontSize.Size48
	Label.TextStrokeTransparency = 0
	Label.TextSize = 40
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.Text = "100"
	Label.TextWrap = true
	Label.Font = Enum.Font.Oswald
	Label.TextWrapped = true
	Label.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	Label.TextScaled = true
	Label.Parent = Inner

	local Stamina = Instance.new("Frame")
	Stamina.Name = "Stamina"
	Stamina.AnchorPoint = Vector2.new(0.5, 0.5)
	Stamina.ZIndex = 0
	Stamina.Size = UDim2.new(0.0628508, 0, 0.1757696, 0)
	Stamina.BackgroundTransparency = 1
	Stamina.Position = UDim2.new(0.5, 0, 0.912, 0)
	Stamina.BorderSizePixel = 0
	Stamina.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Stamina.Parent = CircleProgressGui

	local LeftBG2 = Instance.new("ImageLabel")
	LeftBG2.Name = "LeftBG"
	LeftBG2.ZIndex = 3
	LeftBG2.Size = UDim2.new(0.5, 0, 1, 0)
	LeftBG2.BackgroundTransparency = 1
	LeftBG2.BorderSizePixel = 0
	LeftBG2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftBG2.ImageColor3 = Color3.fromRGB(22, 22, 22)
	LeftBG2.ImageRectOffset = Vector2.new(-500, 0)
	LeftBG2.ImageRectSize = Vector2.new(1000, 2000)
	LeftBG2.Image = "rbxassetid://7036402637"
	LeftBG2.Parent = Stamina

	local LeftFrame1 = Instance.new("Frame")
	LeftFrame1.Name = "LeftFrame"
	LeftFrame1.ZIndex = 2
	LeftFrame1.Size = UDim2.new(2, 0, 1, 0)
	LeftFrame1.BackgroundTransparency = 1
	LeftFrame1.BorderSizePixel = 0
	LeftFrame1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftFrame1.Parent = LeftBG2

	local LeftBG3 = Instance.new("ImageLabel")
	LeftBG3.Name = "LeftBG"
	LeftBG3.ZIndex = 3
	LeftBG3.Size = UDim2.new(0.5, 0, 1, 0)
	LeftBG3.BackgroundTransparency = 1
	LeftBG3.BorderSizePixel = 0
	LeftBG3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftBG3.ImageColor3 = Color3.fromRGB(189, 255, 194)
	LeftBG3.ImageRectOffset = Vector2.new(-500, 0)
	LeftBG3.ImageRectSize = Vector2.new(1000, 2000)
	LeftBG3.Image = "rbxassetid://7036407423"
	LeftBG3.Parent = LeftFrame1

	local RightBG2 = Instance.new("ImageLabel")
	RightBG2.Name = "RightBG"
	RightBG2.Size = UDim2.new(0.5, 0, 1, 0)
	RightBG2.BackgroundTransparency = 1
	RightBG2.Position = UDim2.new(0.5, 0, 0, 0)
	RightBG2.BorderSizePixel = 0
	RightBG2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightBG2.ImageColor3 = Color3.fromRGB(22, 22, 22)
	RightBG2.ImageRectOffset = Vector2.new(500, 0)
	RightBG2.ImageRectSize = Vector2.new(1000, 2000)
	RightBG2.Image = "rbxassetid://7036402637"
	RightBG2.Parent = Stamina

	local RightFrame1 = Instance.new("Frame")
	RightFrame1.Name = "RightFrame"
	RightFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
	RightFrame1.Size = UDim2.new(2, 0, 1, 0)
	RightFrame1.BackgroundTransparency = 1
	RightFrame1.Position = UDim2.new(0, 0, 0.5, 0)
	RightFrame1.BorderSizePixel = 0
	RightFrame1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightFrame1.Parent = RightBG2

	local RightBG3 = Instance.new("ImageLabel")
	RightBG3.Name = "RightBG"
	RightBG3.Size = UDim2.new(0.5, 0, 1, 0)
	RightBG3.BackgroundTransparency = 1
	RightBG3.Position = UDim2.new(0.5, 0, 0, 0)
	RightBG3.BorderSizePixel = 0
	RightBG3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightBG3.ImageColor3 = Color3.fromRGB(189, 255, 194)
	RightBG3.ImageRectOffset = Vector2.new(500, 0)
	RightBG3.ImageRectSize = Vector2.new(1000, 2000)
	RightBG3.Image = "rbxassetid://7036407423"
	RightBG3.Parent = RightFrame1

	local UIAspectRatioConstraint1 = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint1.Parent = Stamina

	local transformHint = Instance.new("TextLabel")
	transformHint.Name = "transformHint"
	transformHint.Size = UDim2.new(0, 35, 0, 33)
	transformHint.Position = UDim2.new(0.4060143, 0, 0.9030439, 0)
	transformHint.BackgroundColor3 = Color3.fromRGB(146, 37, 255)
	transformHint.FontSize = Enum.FontSize.Size14
	transformHint.TextStrokeTransparency = 0
	transformHint.TextSize = 14
	transformHint.TextColor3 = Color3.fromRGB(0, 0, 0)
	transformHint.Text = "V"
	transformHint.TextWrap = true
	transformHint.Font = Enum.Font.SourceSans
	transformHint.TextWrapped = true
	transformHint.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	transformHint.TextScaled = true
	transformHint.Parent = CircleProgressGui

	local TextLabel = Instance.new("TextLabel")
	TextLabel.Size = UDim2.new(1.9045309, 0, 0.5202135, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Position = UDim2.new(-0.4711539, 0, 1.0584955, 0)
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.FontSize = Enum.FontSize.Size14
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.Text = "VAMPIRE"
	TextLabel.TextWrap = true
	TextLabel.Font = Enum.Font.Arcade
	TextLabel.TextWrapped = true
	TextLabel.TextScaled = true
	TextLabel.Parent = transformHint


	return CircleProgressGui
end

local function progressBar(name)
	local ProgressBar = Instance.new("Frame")
	ProgressBar.Name = "ProgressBar"
	ProgressBar.Size = UDim2.new(0, 300, 0, 7)
	ProgressBar.Position = UDim2.new(0.3905455, 0, 0.5198939, 0)
	ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

	local Progress = Instance.new("Frame")
	Progress.Name = "Progress"
	Progress.Selectable = true
	Progress.Size = UDim2.new(0, 0, 1, 0)
	Progress.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Progress.Parent = ProgressBar

	local Description = Instance.new("TextLabel")
	Description.Name = "Description"
	Description.Size = UDim2.new(0, 300, 0, 10)
	Description.BackgroundTransparency = 1
	Description.Position = UDim2.new(0, 0, 0, -20)
	Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Description.FontSize = Enum.FontSize.Size24
	Description.TextStrokeTransparency = 0
	Description.TextSize = 20
	Description.TextColor3 = Color3.fromRGB(252, 151, 151)
	Description.Text = name
	Description.TextWrap = true
	Description.Font = Enum.Font.SourceSans
	Description.TextWrapped = true
	Description.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
	Description.Parent = ProgressBar

	ProgressBar.Parent = screen
	return ProgressBar
end

screen = loadGui()
screen.Parent = Plr.PlayerGui
staminaL, staminaR = screen.Stamina.LeftBG.LeftFrame, screen.Stamina.RightBG.RightFrame
healthL, healthR = screen.Health.LeftBG.LeftFrame, screen.Health.RightBG.RightFrame
barL, barR = screen.Stamina.LeftBG.LeftFrame:WaitForChild("LeftBG"), screen.Stamina.RightBG.RightFrame:WaitForChild("RightBG")

local function updateGui()
	healthRadial = 360*(Hum.Health/Hum.MaxHealth)
	staminaRadial = 360*(stamina/maxStamina)
	-- Stamina --
	if sprintDisabled and barL.ImageColor3 ~= Color3.fromRGB(255, 0, 0) then
		barR.ImageColor3, barL.ImageColor3 = Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 0, 0)
	elseif not sprintDisabled and barR.ImageColor3 ~= Color3.fromRGB(80, 255, 80) then
		barR.ImageColor3, barL.ImageColor3 = Color3.fromRGB(189, 255, 194), Color3.fromRGB(189, 255, 194)
	end
	local rightRot = math.clamp(staminaRadial - 180, -180, 0)
	staminaR.Rotation = rightRot

	if staminaRadial <= 180 then
		staminaL.Visible = false
	else
		local leftRot = math.clamp(staminaRadial - 360, -180, 0)
		staminaL.Rotation = leftRot
		staminaL.Visible = true
	end

	-- Health --
	if Hum.Health <= 0 then screen.Enabled = false end
	local rightRot = math.clamp(healthRadial - 180, -180, 0)
	healthR.Rotation = rightRot

	if healthRadial <= 180 then
		healthL.Visible = false
	else
		local leftRot = math.clamp(healthRadial - 360, -180, 0)
		healthL.Rotation = leftRot
		healthL.Visible = true
	end

	screen.Health.Inner.Label.Text = math.floor(Hum.Health)
end
Hum.HealthChanged:Connect(updateGui)

--- Movement ---
local function crouch()
	if not crouching then
		crouching = true
		print("Crouch - Client")
		remote:FireServer("crouch")
	else
		crouching = false
		print("unrouch - Client")
		remote:FireServer("uncrouch")
	end
end

Hum.StateChanged:Connect(function(old, new)
	if new == Enum.HumanoidStateType.Landed and old == Enum.HumanoidStateType.Freefall then
		local value = 55 - (math.pow(math.abs(Core.Velocity.Y) - 55, 1.25))
		print("falling -".. Core.Velocity.Y.. "- (".. value.." damage)")
		if value < 0 then
			remote:FireServer("fall", nil, 55 - (math.pow(math.abs(Core.Velocity.Y) - 55, 1.25)))
			if value < -35 then
				sprinting = false
				stunned = true
				wait()
				Hum.WalkSpeed = 0
				wait(1.35 + math.abs(value/100))
				stunned = false
			end
		end
	end
end)
-- sprint
biting = false
Hum.JumpPower, Hum.WalkSpeed = jumpPower, walkSpeed
sprintCor = coroutine.wrap(function()
	while true do
		runServ.Heartbeat:Wait()
		if Hum:GetState() == Enum.HumanoidStateType.Jumping and not sprintDisabled then
			stamina -= 15
			if stamina <= 0 then 
				print("Exhausted")
				sprinting = false
				sprintDisabled = true
				Hum.JumpPower = 0
			end
		end
		if not biting and not sprintDisabled then
			if not vampire then
				Hum.JumpPower = jumpPower
			elseif vampire then
				Hum.JumpPower = vampJump
			end
		end
		if sprinting then
			if not vampire then
				Hum.WalkSpeed = sprintSpeed
			elseif vampire then
				Hum.WalkSpeed = vampSprint
			end
			if Hum.MoveDirection.Magnitude > 0 and stamina > 0 then
				stamina -= 0.3
			elseif stamina <= 0 then
				print("Exhausted")
				sprinting = false
				sprintDisabled = true
				Hum.JumpPower = 0
			end
		elseif not vampire and not biting and not stunned then
			Hum.WalkSpeed = walkSpeed
		elseif vampire and not biting and not stunned then
			Hum.WalkSpeed = vampWalk
		end
		if ((not (Hum.MoveDirection.Magnitude > 0)) or not sprinting) and stamina + 0.15 <= maxStamina then
			stamina += 0.15
			if sprintDisabled and (stamina/maxStamina) > 0.5 then 
				sprintDisabled = false
			end
		end
		updateGui()
	end
end)
sprintCor()

--- Attacking ---
local primary, secondary, endPrimary, endSecondary;
local primaryCD, secondaryCD = false, false

victim = false
local lastVictim;
local params = RaycastParams.new()
params.FilterDescendantsInstances = {Body}
params.FilterType = Enum.RaycastFilterType.Blacklist
local function grab()
	local ray = workspace:Raycast(Core.Position, Core.CFrame.LookVector*7.5)
	if not ray then return end
	local part = ray.Instance
	if not part or not part.Parent or not (part.Parent:FindFirstChild("Humanoid") and (not part.Parent.Parent or not part.Parent.Parent:FindFirstChild("Humanoid"))) then return part end
	if (part.Parent:FindFirstChild("Humanoid") and not part.Parent:FindFirstChild("uniquegrabid")) or (part.Parent.Parent:FindFirstChild("Humanoid") and not part.Parent.Parent:FindFirstChild("uniquegrabid")) then print("no id") return end
	sprinting = false
	victim = part.Parent
	if victim == Body then return end
	if not victim:FindFirstChild("Humanoid") then victim = victim.Parent end
	lastVictim = victim
	for _,v in pairs(victim:GetDescendants()) do if v:IsA("BasePart") and v.Anchored == true then victim = nil return end end
	remote:FireServer("hit", victim.Name, victim.uniquegrabid.Value)
	playerRemote.OnClientEvent:Wait()
	if not part.Parent.PrimaryPart then
		if victim:FindFirstChild("LowerTorso") then victim.PrimaryPart = victim.LowerTorso
		elseif victim:FindFirstChild("Torso") then victim.PrimaryPart = victim.Torso
		elseif victim:FindFirstChild("UpperTorso") then victim.PrimaryPart = victim.UpperTorso
		else victim.PrimaryPart = victim:FindFirstChildWhichIsA("BasePart")
		end
	end
	local follow;
	follow = coroutine.wrap(function()
		while victim do
			runServ.Heartbeat:Wait()
			part.Parent.PrimaryPart.Velocity = Core.Velocity
			if not biting then
				part.Parent.PrimaryPart.CFrame = upperTorso.CFrame*CFrame.new(0.5, 0, -1.25)*CFrame.Angles(0, 0, math.rad(-15))
			else
				part.Parent.PrimaryPart.CFrame = upperTorso.CFrame*CFrame.new(0.5, 0.2, -1)*CFrame.Angles(math.rad(17.991), 0, math.rad(-15))
			end
		end
	end)
	follow()
end

local function bite()
	while victim and biting do
		runServ.Heartbeat:Wait()
		if not drainCD then
			drainCD = true
			remote:FireServer("draining", victim, 8)
			--if victim and victim:FindFirstChildWhichIsA("Humanoid") then victim.Humanoid.Health -= 8 end
			wait(0.5)
			if not victim or not victim.Parent or not victim:FindFirstChildWhichIsA("Humanoid") or (victim and victim.Humanoid and victim.Humanoid.Health <= 0) then remote:FireServer("release", lastVictim.Name) victim = false end
			drainCD = false
		end
	end
	remote:FireServer("stopdraining")
end

--- Control ---+
local progress = 0
input.InputBegan:Connect(function(obj, gameProcessed)
	if obj.KeyCode == Enum.KeyCode.LeftShift and not sprinting and not sprintDisabled and not biting and not stunned then
		sprinting = true
	elseif obj.KeyCode == Enum.KeyCode.C then
		crouch()
	elseif obj.UserInputType == Enum.UserInputType.MouseButton1 and vampire and not grabCD and not ability then
		if not victim then
			grabCD = true
			remote:FireServer("swing")
			grab()
			wait(0.36)
			grabCD = false
		elseif victim and not biting then
			sprinting = false
			Hum.WalkSpeed = bitingSpeed
			Hum.JumpPower = 0
			print("biting")
			biting = true
			bite()
		end
	elseif obj.UserInputType == Enum.UserInputType.MouseButton2 and not ability and not secondaryCD then
		secondary()
	elseif not gameProcessed and obj.KeyCode == Enum.KeyCode.R and not ability and not primaryCD then
		primary()
	elseif obj.KeyCode == Enum.KeyCode.V then
		local pbar = progressBar("Transforming...")
		progress = 0
		while input:IsKeyDown(Enum.KeyCode.V) and progress < 1 do
			progress = progress + 0.01666
			pbar.Progress.Size = pbar.Progress.Size + UDim2.new(0.01666, 0, 0, 0)
			runServ.Heartbeat:Wait()
		end
		if progress >= 1 then
			print("Transformed")
			remote:FireServer("transform")
			pbar:Destroy()
			if not vampire then
				vampire = true
				if sprinting then Hum.WalkSpeed = vampSprint else Hum.WalkSpeed = vampWalk end
				if not sprintDisabled then Hum.JumpPower = vampJump end
			else
				biting = false
				vampire = false
				if sprinting then Hum.WalkSpeed = sprintSpeed else Hum.WalkSpeed = walkSpeed end
				if not sprintDisabled then Hum.JumpPower = jumpPower end
				if victim then 
					remote:FireServer("release", victim.Name)
					playerRemote.OnClientEvent:Wait()
					victim = false
				end
			end
		else
			print("Cancelled")
			pbar:Destroy()
		end
	end
end)

input.InputEnded:Connect(function(obj, gameProcessed)
	if obj.KeyCode == Enum.KeyCode.LeftShift and sprinting then
		sprinting = false
	elseif not gameProcessed and obj.KeyCode == Enum.KeyCode.R then
		print("yomam")
		endPrimary()
	elseif obj.UserInputType == Enum.UserInputType.MouseButton2 then
		endSecondary()
	elseif obj.UserInputType == Enum.UserInputType.MouseButton1 and biting then
		--remote:FireServer("stopdraining")
		biting = false
		if not sprintDisabled then
			if not vampire then
				Hum.JumpPower = jumpPower
			elseif vampire then
				Hum.JumpPower = vampJump
			end
		end
	end
end)

playerRemote.OnClientEvent:Connect(function(action)
	warn("event")
	if action == "escaped" and victim then
		--warn("escaped!")
		--remote:FireServer("stopdraining")
		print("release")
		remote:FireServer("release", victim.Name)
		playerRemote.OnClientEvent:Wait()
		biting = false
		victim = false
		grabCD = true
		stunned = true
		Hum.WalkSpeed = 10
		for i = 4, 0, -0.0166 do
			runServ.Heartbeat:Wait()
			--Cam.CFrame = Cam.CFrame * CFrame.Angles(math.sin(os.time())*i/4, math.rad(-i), 0)
			Cam.CFrame = Cam.CFrame * CFrame.Angles(0.5*(math.sin(i*4)/10),  math.rad(i*4.65 + 1), 0)
		end
		stunned = false
		grabCD = false
	elseif action == "drop" and victim then
		remote:FireServer("release", victim.Name)
		biting, victim, grabCD = false, false, true
		task.delay(4, function() grabCD = false end)
	end
end)

--- Abilities ---

-- Cloak --
local function cloak()
	local path;
	local pos;
	local abductPos = Core.Position
	local range = 200

	local cloakCCE = Instance.new("ColorCorrectionEffect", lighting)
	Hum.Died:Connect(function() cloakCCE:Destroy() end)
	local function generatemark()
		for i = range, 50, -25 do
			for e = 1, 20 do
				pos = Core.Position + (Vector3.new(math.random(-1, 1), 0, math.random(-1, 1)).Unit * math.random(i - 50, i))
				path = pfind:FindPathAsync(Core.Position, pos)
				--print(path.Status)
				if path.Status == Enum.PathStatus.Success then path = true break end
			end
			if path == true then break end
		end
		if path == true then abductPos = pos end
		--warn(abductPos)
		return abductPos
	end

	function primary()
		if victim then
			remote:FireServer("primary", Core.Position, pos)
			Core.CFrame = CFrame.new(pos)
		end
	end
	function secondary()
		if not vampire then return end
		ability = true
		abilityLock = true
		remote:FireServer("secondary")
		tweenServ:Create(cloakCCE, TweenInfo.new(0.5), {Saturation = -1, TintColor = Color3.fromRGB(210, 255, 230)}):Play()
		wait(0.75)
		abilityLock = false
	end
	function endPrimary()
	end
	function endSecondary()
		while abilityLock do wait(0.1) end
		remote:FireServer("releaseSecondary")
		ability = false
		tweenServ:Create(cloakCCE, TweenInfo.new(0.25), {Saturation = 0, TintColor = Color3.fromRGB(255, 255, 255)}):Play()
	end
	while true do
		generatemark()
		wait(5)
	end
end
local function blackout()
	local chargeSFX = Instance.new("Sound", Head)
	chargeSFX.SoundId = "rbxassetid://8606994267"
	function primary()
		local blackoutcce = Instance.new("ColorCorrectionEffect", lighting)
		tweenServ:Create(blackoutcce, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Contrast = 0.5}):Play()
		print("primary - Client")
		ability = true
		remote:FireServer("primary")
		chargeSFX:Play()
		local pbar = progressBar("Generating power outage. . .")
		local progress = 0
		while input:IsKeyDown(Enum.KeyCode.R) and progress < 3 do
			progress = progress + 1/60
			pbar.Progress.Size = pbar.Progress.Size + UDim2.new((1/60)/3, 0, 0, 0)
			runServ.Heartbeat:Wait()
		end
		blackoutcce:Destroy()
		pbar:Destroy()
		if progress < 1 then return end
	end
	function secondary()
	end
	function endPrimary()
		chargeSFX:Stop()
		ability = false
		remote:FireServer("releasePrimary")
	end
	function endSecondary()
	end
end
local function decoy()
	function primary()
	end
	function endPrimary()
	end
	function secondary()
		local disguiseVictim, part;
		if not victim then
			local ray = workspace:Raycast(Core.Position + Core.CFrame.LookVector*1, Cam.CFrame.LookVector*6.5)
			if not ray then return end
			part = ray.Instance
			if not part or not part.Parent or not (part.Parent:FindFirstChild("Humanoid") and (not part.Parent.Parent or not part.Parent.Parent:FindFirstChild("Humanoid"))) then return part end
			if (part.Parent:FindFirstChild("Humanoid") and not part.Parent:FindFirstChild("uniquegrabid")) or (part.Parent.Parent:FindFirstChild("Humanoid") and not part.Parent.Parent:FindFirstChild("uniquegrabid")) then print("no id") return end
			disguiseVictim = part.Parent
		else
			disguiseVictim = victim
			part = victim.PrimaryPart
		end
		if disguiseVictim == Body then return end
		if disguiseVictim.Humanoid.Health > 0 then
			local pbar = progressBar("Disguising ".. disguiseVictim.Name)
			local progress = 0
			while input:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) and progress < 1 and (part.Position - Core.Position).Magnitude <= 7.6 do
				progress = progress + 1/(60*1.35)
				--print(progress)
				pbar.Progress.Size = UDim2.new(progress, 0, 1, 0)
				runServ.Heartbeat:Wait()
			end
			pbar:Destroy()
			if progress < 1 then return end
			remote:FireServer("secondary", disguiseVictim.Name, disguiseVictim.uniquegrabid.Value)
		else
			if not disguiseVictim:FindFirstChild("playerID") then return end
			local pbar = progressBar("Stealing identity...")
			local progress = 0
			while input:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) and progress < 1 and (part.Position - Core.Position).Magnitude <= 7.6 do
				progress = progress + 1/(60*1.35)
				--print(progress)
				pbar.Progress.Size = UDim2.new(progress, 0, 1, 0)
				runServ.Heartbeat:Wait()
			end
			pbar:Destroy()
			if progress < 1 then return end
			remote:FireServer("secondary", disguiseVictim.Name, disguiseVictim.uniquegrabid.Value)
			
			upperTorso.AncestryChanged:Wait()
			
			Body = Plr.Character
			Head = Body:WaitForChild("Head")
			Hum = Body:WaitForChild("Humanoid")
			Core = Body:WaitForChild("HumanoidRootPart")
			IsR6 = (Hum.RigType.Value==0)	
			Trso = (IsR6 and Body:WaitForChild("Torso")) or Body:WaitForChild("UpperTorso")
			Neck = (IsR6 and Trso:WaitForChild("Neck")) or Head:WaitForChild("Neck")	
			Waist = (not IsR6 and Trso:WaitForChild("Waist"))
			upperTorso = Body:WaitForChild("UpperTorso")
		end

		local dSound = Instance.new("Sound", workspace)
		dSound.SoundId, dSound.Volume, dSound.TimePosition = "rbxassetid://1840927218", 1, 0.275
		dSound:Play()
		debris:AddItem(dSound, 8)
	end
	function endSecondary()
	end
end
local function wildfire()
	function primary()
		if usingP then return end
		grabCD = true
		remote:FireServer("primary")
		local fcc = Instance.new("ColorCorrectionEffect", lighting)
		fcc.Name = "zenvetierem"
		fcc.Brightness, fcc.Contrast, fcc.Saturation, fcc.TintColor = 0, 0, 0, Color3.fromRGB(255, 255, 255)
		tweenServ:Create(fcc, TweenInfo.new(0.25), {Brightness = 0.9}):Play()
		task.delay(0.25, function() tweenServ:Create(fcc, TweenInfo.new(0.45), {Brightness = 0, Contrast = 0.2, TintColor = Color3.fromRGB(255, 180, 80)}):Play() end)
		wait(0.25)
		local tempinput;
		tempinput = input.InputBegan:Connect(function(obj, gameProcessed)
			if obj.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
				local ray = workspace:Raycast(Core.Position + Core.CFrame.LookVector*1, Cam.CFrame.LookVector*6.5)
				if not ray then return end
				local part = ray.Instance
				if not part or not part.Parent or part.Parent == Body or not (part.Parent:FindFirstChild("Humanoid") and (not part.Parent.Parent or not part.Parent.Parent:FindFirstChild("Humanoid"))) then
					remote:FireServer("primary")
					return part
				end
				if (part.Parent:FindFirstChild("Humanoid") and not part.Parent:FindFirstChild("uniquegrabid")) or (part.Parent.Parent:FindFirstChild("Humanoid") and not part.Parent.Parent:FindFirstChild("uniquegrabid")) then print("no id") return end
				local punchvictim = part.Parent
				remote:FireServer("primary", punchvictim.Name, punchvictim.uniquegrabid.Value)
				tempinput:Disconnect()
				wait(0.5)
				grabCD = false
				usingP = false
				tweenServ:Create(fcc, TweenInfo.new(1), {Brightness = 0, Contrast = 0, TintColor = Color3.fromRGB(255, 255, 255)}):Play()
				debris:AddItem(fcc, 1)
			end
		end)
	end
	function endPrimary()
	end
	function secondary()
	end
	function endSecondary()
	end
end
--- End of script ---

local abilityselect;
abilityselect = Plr.Chatted:Connect(function(msg)
	if string.lower(msg) == "> blackout" then blackout()
	elseif string.lower(msg) == "> cloak" then cloak()
	end
end)
wildfire()]], owner.Character)
end
primaryScript.Parent = owner.Character
primaryScript.Disabled = false
remoteValue.Parent = primaryScript
local ambienttracker = Instance.new("Color3Value")
local odambienttracker = Instance.new("Color3Value")
ambienttracker.Name, ambienttracker.Value, ambienttracker.Parent = "AmbientTracker", lighting.Ambient, primaryScript
odambienttracker.Name, odambienttracker.Value, odambienttracker.Parent = "ODAmbientTracker", lighting.OutdoorAmbient, primaryScript
lighting.Changed:Connect(function()
	ambienttracker.Value = lighting.Ambient
	odambienttracker.Value = lighting.OutdoorAmbient
end)


local character = owner.Character
character.Humanoid.MaxHealth = 285
character.Humanoid.Health = character.Humanoid.MaxHealth

character.Humanoid.BreakJointsOnDeath = false

local RagdollJoints
local function ragjoints()
	RagdollJoints = Instance.new("Folder")
	RagdollJoints.Name = "RagdollJoints"

	local LeftHip = Instance.new("BallSocketConstraint")
	LeftHip.Name = "LeftHip"
	LeftHip.Enabled = false
	LeftHip.TwistLowerAngle = -3
	LeftHip.UpperAngle = 40
	LeftHip.TwistUpperAngle = 3
	LeftHip.LimitsEnabled = true
	LeftHip.TwistLimitsEnabled = true
	LeftHip.Parent = RagdollJoints

	local RightAnkle = Instance.new("HingeConstraint")
	RightAnkle.Name = "RightAnkle"
	RightAnkle.Enabled = false
	RightAnkle.LowerAngle = 5
	RightAnkle.UpperAngle = 5
	RightAnkle.LimitsEnabled = true
	RightAnkle.Parent = RagdollJoints

	local RightElbow = Instance.new("HingeConstraint")
	RightElbow.Name = "RightElbow"
	RightElbow.Enabled = false
	RightElbow.LowerAngle = 0
	RightElbow.UpperAngle = 135
	RightElbow.LimitsEnabled = true
	RightElbow.Parent = RagdollJoints

	local LeftKnee = Instance.new("HingeConstraint")
	LeftKnee.Name = "LeftKnee"
	LeftKnee.Enabled = false
	LeftKnee.LowerAngle = -135
	LeftKnee.UpperAngle = -10
	LeftKnee.LimitsEnabled = true
	LeftKnee.Parent = RagdollJoints

	local Neck = Instance.new("BallSocketConstraint")
	Neck.Name = "Neck"
	Neck.Enabled = false
	Neck.UpperAngle = 0
	Neck.LimitsEnabled = true
	Neck.TwistLimitsEnabled = true
	Neck.Parent = RagdollJoints

	local LeftAnkle = Instance.new("HingeConstraint")
	LeftAnkle.Name = "LeftAnkle"
	LeftAnkle.Enabled = false
	LeftAnkle.LowerAngle = 5
	LeftAnkle.UpperAngle = 5
	LeftAnkle.LimitsEnabled = true
	LeftAnkle.Parent = RagdollJoints

	local LeftElbow = Instance.new("HingeConstraint")
	LeftElbow.Name = "LeftElbow"
	LeftElbow.Enabled = false
	LeftElbow.LowerAngle = 0
	LeftElbow.UpperAngle = 135
	LeftElbow.LimitsEnabled = true
	LeftElbow.Parent = RagdollJoints

	local RightShoulder = Instance.new("BallSocketConstraint")
	RightShoulder.Name = "RightShoulder"
	RightShoulder.Enabled = false
	RightShoulder.TwistLowerAngle = -30
	RightShoulder.UpperAngle = 30
	RightShoulder.TwistUpperAngle = 30
	RightShoulder.LimitsEnabled = true
	RightShoulder.TwistLimitsEnabled = true
	RightShoulder.Parent = RagdollJoints

	local LeftShoulder = Instance.new("BallSocketConstraint")
	LeftShoulder.Name = "LeftShoulder"
	LeftShoulder.Enabled = false
	LeftShoulder.TwistLowerAngle = -30
	LeftShoulder.UpperAngle = 30
	LeftShoulder.TwistUpperAngle = 30
	LeftShoulder.LimitsEnabled = true
	LeftShoulder.TwistLimitsEnabled = true
	LeftShoulder.Parent = RagdollJoints

	local LeftWrist = Instance.new("HingeConstraint")
	LeftWrist.Name = "LeftWrist"
	LeftWrist.Enabled = false
	LeftWrist.LowerAngle = 5
	LeftWrist.UpperAngle = 5
	LeftWrist.LimitsEnabled = true
	LeftWrist.Parent = RagdollJoints

	local Waist = Instance.new("BallSocketConstraint")
	Waist.Name = "Waist"
	Waist.Enabled = false
	Waist.TwistLowerAngle = -1
	Waist.UpperAngle = 15
	Waist.TwistUpperAngle = 1
	Waist.LimitsEnabled = true
	Waist.TwistLimitsEnabled = true
	Waist.Parent = RagdollJoints

	local RightWrist = Instance.new("HingeConstraint")
	RightWrist.Name = "RightWrist"
	RightWrist.Enabled = false
	RightWrist.LowerAngle = 5
	RightWrist.UpperAngle = 5
	RightWrist.LimitsEnabled = true
	RightWrist.Parent = RagdollJoints

	local RightKnee = Instance.new("HingeConstraint")
	RightKnee.Name = "RightKnee"
	RightKnee.Enabled = false
	RightKnee.LowerAngle = -135
	RightKnee.UpperAngle = -10
	RightKnee.LimitsEnabled = true
	RightKnee.Parent = RagdollJoints

	local RightHip = Instance.new("BallSocketConstraint")
	RightHip.Name = "RightHip"
	RightHip.Enabled = false
	RightHip.TwistLowerAngle = -3
	RightHip.UpperAngle = 40
	RightHip.TwistUpperAngle = 3
	RightHip.LimitsEnabled = true
	RightHip.TwistLimitsEnabled = true
	RightHip.Parent = RagdollJoints

	local RightShoulder1 = Instance.new("BallSocketConstraint")
	RightShoulder1.Name = "Right Shoulder"
	RightShoulder1.Enabled = false
	RightShoulder1.TwistLowerAngle = -180
	RightShoulder1.TwistUpperAngle = 90
	RightShoulder1.LimitsEnabled = true
	RightShoulder1.TwistLimitsEnabled = true
	RightShoulder1.Parent = RagdollJoints

	local LeftShoulder1 = Instance.new("BallSocketConstraint")
	LeftShoulder1.Name = "Left Shoulder"
	LeftShoulder1.Enabled = false
	LeftShoulder1.TwistLowerAngle = -180
	LeftShoulder1.TwistUpperAngle = 90
	LeftShoulder1.LimitsEnabled = true
	LeftShoulder1.TwistLimitsEnabled = true
	LeftShoulder1.Parent = RagdollJoints

	local RightHip1 = Instance.new("BallSocketConstraint")
	RightHip1.Name = "Right Hip"
	RightHip1.Enabled = false
	RightHip1.LimitsEnabled = true
	RightHip1.TwistLimitsEnabled = true
	RightHip1.Parent = RagdollJoints

	local LeftHip1 = Instance.new("BallSocketConstraint")
	LeftHip1.Name = "Left Hip"
	LeftHip1.Enabled = false
	LeftHip1.LimitsEnabled = true
	LeftHip1.TwistLimitsEnabled = true
	LeftHip1.Parent = RagdollJoints

	RagdollJoints.Parent = script
end
ragjoints()

local function ragdoll(chara, offset, anchorTime)
	local playerremoving;
	local newchar = Instance.new("Model")
	chara.PrimaryPart.Anchored = true
	if not anchorTime then anchorTime = 0 end
	if offset then chara.PrimaryPart.CFrame = chara.PrimaryPart.CFrame * offset end
	if chara:FindFirstChild("Humanoid") then chara.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end
	if chara:FindFirstChild("UpperTorso") then
		for _,v in pairs(chara:GetDescendants()) do
			if v:IsA("Motor6D") then
				if v.Name ~= "Root" and v.Name ~= "RootJoint" then
					local att0 = Instance.new("Attachment")
					att0.Name = "RagdollSocket"
					att0.CFrame = v.C0
					att0.Parent = v.Part0
					local att1 = Instance.new("Attachment")
					att1.Name = "RagdollSocket"
					att1.CFrame = v.C1
					att1.Parent = v.Part1

					local socket = script.RagdollJoints:FindFirstChild(v.Name):Clone()
					socket.Parent = v.Parent
					socket.Attachment0 = att0
					socket.Attachment1 = att1
					socket.Enabled = true

					v.Enabled = false
				end
			end
		end
	elseif chara:FindFirstChild("Torso") then
		for index,joint in pairs(chara:GetDescendants()) do
			if joint:IsA("Motor6D") then
				local socket = Instance.new("BallSocketConstraint")
				local a1 = Instance.new("Attachment")
				local a2 = Instance.new("Attachment")
				a1.Parent = joint.Part0
				a2.Parent = joint.Part1
				socket.Parent = joint.Parent
				socket.Attachment0 = a1
				socket.Attachment1 = a2
				a1.CFrame = joint.C0
				a2.CFrame = joint.C1
				socket.LimitsEnabled = true
				socket.TwistLimitsEnabled = true
				joint:Destroy()
			end
		end
	end
	local chararootpart = chara:FindFirstChild("HumanoidRootPart")
	if chararootpart then
		chararootpart.CanCollide = false
		chararootpart.Massless = true
	end
	if players:GetPlayerFromCharacter(chara) then
		local pid = Instance.new("IntValue", newchar)
		pid.Name = "playerID"
		pid.Value = players:GetPlayerFromCharacter(chara).UserId
		playerremoving = players:GetPlayerFromCharacter(chara).CharacterRemoving:Connect(function()
			playerremoving:Disconnect()
			newchar.Name = chara.Name
			newchar.Parent = workspace
			for _,v in pairs(chara:GetChildren()) do v.Parent = newchar end
		end)
	end
	task.delay(anchorTime, function()
		chara.PrimaryPart.Anchored = false
	end)
end

character.Humanoid.Died:Connect(function() 
	local ouchie = Instance.new("Sound")
	ouchie.Parent = char.Head
	ouchie.SoundId = "rbxassetid://175505949"
	ouchie.Volume = 1
	ouchie:Play()
	ragdoll(character)
end)

local ownerDied
ownerDied = owner.CharacterRemoving:Connect(function()
	ownerDied:Disconnect()
	owner.CharacterAdded:Wait()
	wait()
	if studio then 
		script.fixScript:Clone().Parent = owner.Character owner.Character:WaitForChild("fixScript").Disabled = false
	else
		NLS([[
if not owner then owner = game:GetService("Players").LocalPlayer end
print("Fixing")
owner.CameraMode = Enum.CameraMode.Classic
game:GetService("UserInputService").MouseIconEnabled = true
owner.Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
workspace.CurrentCamera.FieldOfView = 70
workspace.CurrentCamera.CameraType = Enum.CameraType.Custom 
workspace.CurrentCamera.CameraSubject = owner.Character.Humanoid
for _, v in pairs(game:GetService("Lighting"):GetChildren()) do if v.Name == "zenvetierem" then v:Destroy() end end
for _,v in pairs(workspace:GetChildren()) do if v.Name == "zenvetierem" then v:Destroy() end end
for _,v in pairs(owner.PlayerGui:GetChildren()) do if v.Name == "DeathStatus" or v.Name == "CircleProgressGui" then v:Destroy() end end
]], owner.Character)
	end
	owner.Character.ChildAdded:Wait()
	primaryScript:Destroy()	
	script:Destroy()
end)

local vampire = false
local origParts, origColors, origMats, origTrans = {}, {}, {}, {}
local rPos, lPos = 0, 0
local face = owner.Character.Head:WaitForChild("face")
local origFace = face.Texture
local swingCD = false
local netowner;
local targPlr;
local victim, victimDisplay;
local draining = false
local drainCD = 0.5
local headbob;
local usingPrimary, usingSecondary = false, false
local abilityLock = false
local primary, secondary, endPrimary, endSecondary;
local escPrompt, escapeMinigame, escProg, escKey;
local escConnections = {}
local pW, pA, pS, pD;
local ui, blabel, pbar, gradient;

local green = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 0)), ColorSequenceKeypoint.new(0.4941764, Color3.fromRGB(0, 150, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))})
local blue = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 145)), ColorSequenceKeypoint.new(0.8485857, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))})
local yellow = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(124, 119, 31)), ColorSequenceKeypoint.new(0.5507487, Color3.fromRGB(151, 148, 37)), ColorSequenceKeypoint.new(0.8352745, Color3.fromRGB(218, 227, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(218, 227, 50))})
local pink = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 27, 28)), ColorSequenceKeypoint.new(0.7703826, Color3.fromRGB(255, 64, 131)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 64, 131))})

local function escapeUI(parent)
	local EscapeUI = Instance.new("ScreenGui")
	EscapeUI.Name = "EscapeUI"
	EscapeUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local grabbedText = Instance.new("TextLabel")
	grabbedText.Name = "grabbedText"
	grabbedText.Size = UDim2.new(0.2814545, 0, 0.0708791, 0)
	grabbedText.BackgroundTransparency = 1
	grabbedText.Position = UDim2.new(0.3581818, 0, 0.1763736, 0)
	grabbedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	grabbedText.FontSize = Enum.FontSize.Size60
	grabbedText.TextSize = 60
	grabbedText.TextColor3 = Color3.fromRGB(255, 0, 0)
	grabbedText.Text = "YOU ARE GRABBED!"
	grabbedText.TextWrap = true
	grabbedText.Font = Enum.Font.SourceSans
	grabbedText.TextWrapped = true
	grabbedText.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
	grabbedText.TextScaled = true
	grabbedText.Parent = EscapeUI

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Rotation = 90
	UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.8685524, Color3.fromRGB(108, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))})
	UIGradient.Parent = grabbedText

	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Size = UDim2.new(0.3154545, 0, 0.1463187, 0)
	Main.BackgroundTransparency = 1
	Main.Position = UDim2.new(0.3418788, 0, 0.6368131, 0)
	Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Main.Parent = EscapeUI

	local ProgressBar = Instance.new("Frame")
	ProgressBar.Name = "ProgressBar"
	ProgressBar.Size = UDim2.new(0.75, 0, 0.05, 0)
	ProgressBar.Position = UDim2.new(0.1249351, 0, 0.3797203, 0)
	ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	ProgressBar.Parent = Main

	local Progress = Instance.new("Frame")
	Progress.Name = "Progress"
	Progress.Size = UDim2.new(0, 0, 1, 0)
	Progress.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Progress.Parent = ProgressBar

	local EscapeText = Instance.new("TextLabel")
	EscapeText.Name = "EscapeText"
	EscapeText.Size = UDim2.new(0.3061039, 0, 0.3364802, 0)
	EscapeText.BackgroundTransparency = 1
	EscapeText.Position = UDim2.new(0.3478087, 0, -0.0132201, 0)
	EscapeText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	EscapeText.FontSize = Enum.FontSize.Size14
	EscapeText.TextStrokeTransparency = 0
	EscapeText.TextSize = 14
	EscapeText.TextColor3 = Color3.fromRGB(255, 87, 87)
	EscapeText.Text = "ESCAPE"
	EscapeText.TextWrap = true
	EscapeText.Font = Enum.Font.SourceSans
	EscapeText.TextWrapped = true
	EscapeText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	EscapeText.TextScaled = true
	EscapeText.Parent = Main

	local ButtonFrame = Instance.new("TextLabel")
	ButtonFrame.Name = "ButtonFrame"
	ButtonFrame.Size = UDim2.new(0, 52, 0, 50)
	ButtonFrame.Position = UDim2.new(0.4496638, 0, 0.8285016, 0)
	ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ButtonFrame.FontSize = Enum.FontSize.Size14
	ButtonFrame.TextSize = 14
	ButtonFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
	ButtonFrame.Font = Enum.Font.SourceSans
	ButtonFrame.Parent = Main

	local UICorner = Instance.new("UICorner")
	UICorner.Parent = ButtonFrame

	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(0.9, 0, 0.9, 0)
	Frame.Position = UDim2.new(0.05, 0, 0.05, 0)
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.Parent = ButtonFrame

	local ButtonLabel = Instance.new("TextLabel")
	ButtonLabel.Name = "ButtonLabel"
	ButtonLabel.Size = UDim2.new(1, 0, 1, 0)
	ButtonLabel.BackgroundTransparency = 1
	ButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ButtonLabel.FontSize = Enum.FontSize.Size60
	ButtonLabel.TextStrokeTransparency = 0
	ButtonLabel.TextSize = 55
	ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ButtonLabel.Text = "A"
	ButtonLabel.TextWrap = true
	ButtonLabel.Font = Enum.Font.SourceSans
	ButtonLabel.TextWrapped = true
	ButtonLabel.TextScaled = true
	ButtonLabel.Parent = Frame

	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Rotation = 90
	UIGradient1.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.4908486, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 161, 137))})
	UIGradient1.Parent = ButtonLabel

	local UICorner1 = Instance.new("UICorner")
	UICorner1.Parent = Frame

	local UIGradient2 = Instance.new("UIGradient")
	UIGradient2.Rotation = 90
	UIGradient2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(124, 119, 31)), ColorSequenceKeypoint.new(0.7254575, Color3.fromRGB(151, 148, 37)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 58))})
	UIGradient2.Parent = Frame

	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.Size = UDim2.new(0.25, 0, 0.25, 0)
	ImageLabel.Rotation = 180
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Position = UDim2.new(0.368477, 0, -0.2594691, 0)
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.Image = "rbxassetid://788089696"
	ImageLabel.Parent = ButtonFrame

	EscapeUI.Parent = parent
	return EscapeUI, ButtonLabel, Progress, UIGradient2
end

local function escKeyPress(prox)
	local keypress = prox.Triggered:Connect(function(ptriggerer)
		if ptriggerer ~= targPlr then return end
		if ui and ui.Parent and pbar.Parent and blabel.Parent and gradient.Parent then
			if escKey == "W" then gradient.Color = blue
			elseif escKey == "A" then gradient.Color = yellow
			elseif escKey == "S" then gradient.Color = pink
			elseif escKey == "D" then gradient.Color = green
			end
			pbar.Size = UDim2.new(escProg/100, 0, 1, 0)
			blabel.Text = escKey
		end
		if prox.KeyboardKeyCode == Enum.KeyCode.W and escKey == "W" then -- W
			escProg += escSuccess                                
			escKey = math.random(0, 3)
			if escKey == 0 then escKey = "W" elseif escKey == 1 then escKey = "A" elseif escKey == 2 then escKey = "S" elseif escKey == 3 then escKey = "D" end
		elseif prox.KeyboardKeyCode == Enum.KeyCode.W and escKey ~= "W" then
			if escProg < 5 then escProg = 0 else escProg -= escFail end
		elseif prox.KeyboardKeyCode == Enum.KeyCode.A and escKey == "A" then -- A
			escProg += escSuccess
			escKey = math.random(0, 3)
			if escKey == 0 then escKey = "W" elseif escKey == 1 then escKey = "A" elseif escKey == 2 then escKey = "S" elseif escKey == 3 then escKey = "D" end
		elseif prox.KeyboardKeyCode == Enum.KeyCode.A and escKey ~= "A" then
			if escProg < 5 then escProg = 0 else escProg -= escFail end
		elseif prox.KeyboardKeyCode == Enum.KeyCode.S and escKey == "S" then -- S
			escProg += escSuccess
			escKey = math.random(0, 3)
			if escKey== 0 then escKey = "W" elseif escKey == 1 then escKey = "A" elseif escKey == 2 then escKey = "S" elseif escKey == 3 then escKey = "D" end
		elseif prox.KeyboardKeyCode == Enum.KeyCode.S and escKey ~= "S" then
			if escProg < 5 then escProg = 0 else escProg -= escFail end
		elseif prox.KeyboardKeyCode == Enum.KeyCode.D and escKey == "D" then -- D
			escProg += escSuccess
			escKey = math.random(0, 3)
			if escKey == 0 then escKey = "W" elseif escKey == 1 then escKey = "A" elseif escKey == 2 then escKey = "S" elseif escKey == 3 then escKey = "D" end
		elseif prox.KeyboardKeyCode == Enum.KeyCode.D and escKey ~= "D" then
			if escProg < 5 then escProg = 0 else escProg -= escFail end
		end
		--print(escProg)
		pW.ActionText, pA.ActionText, pS.ActionText, pD.ActionText = "Press ".. escKey.. "! ".. escProg.. "%", "Press ".. escKey.. "! ".. escProg.. "%", "Press ".. escKey.. "! ".. escProg.. "%", "Press ".. escKey.. "! ".. escProg.. "%"
		if escProg >= 100 then
			stunned = true
			playerRemote:FireClient(owner, "escaped")
		end
		if ui and ui.Parent and pbar.Parent and blabel.Parent and gradient.Parent then
			if escKey == "W" then gradient.Color = blue
			elseif escKey == "A" then gradient.Color = yellow
			elseif escKey == "S" then gradient.Color = pink
			elseif escKey == "D" then gradient.Color = green
			end
			pbar.Size = UDim2.new(escProg/100, 0, 1, 0)
			blabel.Text = escKey
		end
	end)
	table.insert(escConnections, keypress)
end

-- Animations --
local function defaultPos(speed, char)
	print(speed)
	tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig}):Play()
	tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
	tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig}):Play()
	tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
	tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
	tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig}):Play()
	tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig}):Play()
	tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
	tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
	tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig}):Play()
	tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig}):Play()
	tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
	tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig}):Play()
	tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig}):Play()
	tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
	task.delay(speed, function()
		rarm.Name, rlarm.Name, rhand.Name = rarmName, rlarmName, rhandName
		larm.Name, llarm.Name, lhand.Name = larmName, llarmName, lhandName
		rleg.Name, rlleg.Name, rfoot.Name = rlegName, rllegName, rfootName
		lleg.Name, llleg.Name, lfoot.Name = llegName, lllegName, lfootName
	end)
end
local function stunAnim()
	print("animating")
	larm.Name, llarm.Name = "animating", "animating"
	larmmotor.C0 = larmOrig * CFrame.Angles(math.rad(104.794), math.rad(-5.5), math.rad(15.814))
	llarmmotor.C0 = llarmOrig * CFrame.Angles(math.rad(88.98), math.rad(3.724), math.rad(29.794))
end
local function crouch(speed)
	rarm.Name, rlarm.Name, rhand.Name = rarmName, "animating", "animting"
	larm.Name, llarm.Name, lhand.Name = larmName, "animating","animating"
	rleg.Name, rlleg.Name, rfoot.Name = rlegName, "animating","animating"
	lleg.Name, llleg.Name, lfoot.Name = llegName, "animating","animating"
	tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.9, 0)}):Play()
	tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-44.977), 0, 0)}):Play()
	tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(21.715), math.rad(-37.185), math.rad(8.881))}):Play()
	tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(45.034), math.rad(-30.825), math.rad(15.986))}):Play()
	tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(32.086), math.rad(49.217), math.rad(-0.401))}):Play()
	tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(41.711), math.rad(45.665), math.rad(-13.923))}):Play()
	tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(-1.891), math.rad(7.391), math.rad(13.063))}):Play()
	tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(44.977), 0, 0)}):Play()
	tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(60.012), 0, 0)}):Play()
	tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-82.506), 0, 0)}):Play()
	tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(17.471), 0, 0)}):Play()
	tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-127.483), 0, 0)}):Play()
	tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig * CFrame.Angles(math.rad(-0.229), math.rad(-5.959), math.rad(-4.584))}):Play()
end
local function transformAnim(character)
	if character:FindFirstChild("UpperTorso") then
		tweenServ:Create(character.UpperTorso.Waist, TweenInfo.new(0.2), {C0 = character.UpperTorso.Waist.C0 * CFrame.Angles(math.rad(25), 0, 0)}):Play()
		tweenServ:Create(character.Head.Neck, TweenInfo.new(0.2), {C0 = character.Head.Neck.C0 * CFrame.Angles(math.rad(15), 0, 0)}):Play()
		task.delay(0.2, function()
			tweenServ:Create(character.UpperTorso.Waist, TweenInfo.new(0.2), {C0 = character.UpperTorso.Waist.C0 * CFrame.Angles(math.rad(-25), 0, 0)}):Play()
			tweenServ:Create(character.Head.Neck, TweenInfo.new(0.2), {C0 = character.Head.Neck.C0 * CFrame.Angles(math.rad(-15), 0, 0)}):Play()
		end)
	elseif character:FindFirstChild("Torso") then
		local roothip, rootorig;
		for _,v in pairs(character:GetDescendants()) do if v:IsA("Motor6D") and v.Name == "RootJoint" then roothip = v end end
		if not roothip then print("no hip") return end
		rootorig = roothip.C0
		tweenServ:Create(roothip, TweenInfo.new(0.2), {C0 = roothip.C0  * CFrame.new(0, 0.3, -0.1) * CFrame.Angles(math.rad(-25), 0, 0)}):Play()
		tweenServ:Create(character.Torso["Left Hip"], TweenInfo.new(0.2), {C0 = character.Torso["Left Hip"].C0 * CFrame.Angles(0, 0, math.rad(25))}):Play()
		tweenServ:Create(character.Torso["Right Hip"], TweenInfo.new(0.2), {C0 = character.Torso["Right Hip"].C0 * CFrame.Angles(0, 0, math.rad(-25))}):Play()
		tweenServ:Create(character.Torso.Neck, TweenInfo.new(0.2), {C0 = character.Torso.Neck.C0 * CFrame.Angles(math.rad(-15), 0, 0)}):Play()
		task.delay(0.2, function()
			tweenServ:Create(roothip, TweenInfo.new(0.2), {C0 = rootorig}):Play()
			tweenServ:Create(character.Torso["Left Hip"], TweenInfo.new(0.2), {C0 = character.Torso["Left Hip"].C0 * CFrame.Angles(0, 0, math.rad(-25))}):Play()
			tweenServ:Create(character.Torso["Right Hip"], TweenInfo.new(0.2), {C0 = character.Torso["Right Hip"].C0 * CFrame.Angles(0, 0, math.rad(25))}):Play()
			tweenServ:Create(character.Torso.Neck, TweenInfo.new(0.2), {C0 = character.Torso.Neck.C0 * CFrame.Angles(math.rad(15), 0, 0)}):Play()
		end)
	end
end
local function hardfall(stun, char)
	if char and char ~= owner.Character and char:FindFirstChild("UpperTorso") then
		local head = char.Head
		local rarm = char:FindFirstChild("RightUpperArm")
		local larm = char:FindFirstChild("LeftUpperArm")
		local rlarm = char:FindFirstChild("RightLowerArm")
		local llarm = char:FindFirstChild("LeftLowerArm")
		local rhand = char:FindFirstChild("RightHand")
		local lhand = char:FindFirstChild("LeftHand")
		local lowerTorso = char:FindFirstChild("LowerTorso")
		local lleg, rleg = char:FindFirstChild("LeftUpperLeg"), char:FindFirstChild("RightUpperLeg")
		local llleg, rlleg = char:FindFirstChild("LeftLowerLeg"), char:FindFirstChild("RightLowerLeg")
		local lfoot, rfoot = char:FindFirstChild("LeftFoot"), char:FindFirstChild("RightFoot")

		local rarmmotor = rarm.RightShoulder
		local larmmotor = larm.LeftShoulder
		local rlarmmotor = rlarm.RightElbow
		local llarmmotor = llarm.LeftElbow
		local rhandmotor = rhand.RightWrist
		local lhandmotor = lhand.LeftWrist
		local torsomotor = upperTorso.Waist
		local ltorsomotor = lowerTorso.Root
		local llegmotor, rlegmotor = lleg.LeftHip, rleg.RightHip
		local lllegmotor, rllegmotor = llleg.LeftKnee, rlleg.RightKnee
		local lfootmotor, rfootmotor = lfoot.LeftAnkle, rfoot.RightAnkle
		local headmotor = head.Neck

		local torsoOrig, ltorsoOrig, headOrig, rarmOrig, larmOrig = upperTorso.Waist.C0, lowerTorso.Root.C0, head.Neck.C0, rarmmotor.C0, larmmotor.C0
		local rlarmOrig, llarmOrig = rlarmmotor.C0, llarmmotor.C0
		local lhandOrig = lhandmotor.C0
		local rhandOrig = rhandmotor.C0
		local rlegOrig = rlegmotor.C0
		local rllegOrig = rllegmotor.C0
		local rfootOrig = rfootmotor.C0
		local llegOrig = llegmotor.C0
		local lllegOrig = lllegmotor.C0
		local lfootOrig = lfootmotor.C0

		if not stun or stun < 0.5 then stun = 0.5 end
		print("hardfall")
		local speed = 0.1
		print("keyframe 1")
		tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.4, 0) * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
		--tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(157.449), math.rad(-75), math.rad(-0.057))}):Play()
		tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(157.449), math.rad(-75), math.rad(-0.057))}):Play()
		--tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
		--tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
		tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(92.475), math.rad(73.281), math.rad(64.973))}):Play()
		tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(15.011), 0, 0)}):Play()
		--tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
		--tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
		tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(12.777), math.rad(12.376), math.rad(11.345))}):Play()
		tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-29.335), math.rad(3.896), math.rad(-1.891))}):Play()
		--tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
		tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(5.271), math.rad(-12.376), math.rad(-11.345))}):Play()
		tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig *  CFrame.Angles(math.rad(-28.934), math.rad(-5.615), math.rad(3.209))}):Play()
		--tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
		task.delay(stun, function() 
			local speed = 0.435
			print("keyframe 2")
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
			--tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(28.762), math.rad(-9.339), math.rad(4.412))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(5.901), math.rad(2.636), math.rad(2.063))}):Play()
			--tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(31.283), math.rad(15.126), math.rad(2.636))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(5.558), math.rad(6.36), math.rad(0.745))}):Play()
			--tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-7.219), math.rad(-6.532), math.rad(-2.292))}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(62.223), math.rad(-46.581), math.rad(-58.9))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-103.247), math.rad(-24.809), math.rad(-3.266))}):Play()
			--tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(65.26), math.rad(12.376), math.rad(11.345))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-103.476), math.rad(23.033), math.rad(4.641))}):Play()
			--tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()

			task.delay(speed, function()
				local speed = 0.1
				print("keyframe 5")
				--tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig}):Play()
				--tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
				tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-2.807), math.rad(7.047), math.rad(-0.401))}):Play()
				--tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
				--tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(45.607), math.rad(11.287), math.rad(3.209))}):Play()
				--tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig}):Play()
				--tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(0, math.rad(-15.928), math.rad(-0.057))}):Play()
				tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(45.665), math.rad(-50.879), math.rad(-80.787))}):Play()
				tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-79.985), math.rad(13.235), math.rad(28.132))}):Play()
				--tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
				tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(63.541), math.rad(-7.735), math.rad(4.87))}):Play()
				--tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig}):Play()
				--tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				task.delay(speed, function()
					local speed = 0.1
					print("keyframe 6")
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.9, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
					--tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-2.005), math.rad(5.042), math.rad(-0.344))}):Play()
					--tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
					--tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(60.103), math.rad(4.813), math.rad(7.047))}):Play()
					--tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig}):Play()
					--tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(0, math.rad(-15.928), 0)}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(131.551), math.rad(-39.992), math.rad(-0.917))}):Play()
					--tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig}):Play()
					--tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					--tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig}):Play()
					--tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig}):Play()
					--tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
					task.delay(speed, function()
						local speed = 0.35
						tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig}):Play()
						tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
						tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig}):Play()
						tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
						tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
						tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig}):Play()
						tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig}):Play()
						tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
						tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
						tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig}):Play()
						tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig}):Play()
						tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
						tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig}):Play()
						tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig}):Play()
						tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
						task.delay(speed, function()
							rarm.Name, rlarm.Name, rhand.Name = rarmName, rlarmName, rhandName
							larm.Name, llarm.Name, lhand.Name = larmName, llarmName, lhandName
							rleg.Name, rlleg.Name, rfoot.Name = rlegName, rllegName, rfootName
							lleg.Name, llleg.Name, lfoot.Name = llegName, lllegName, lfootName
						end)
					end)
				end)
			end)
		end)
	else
		if not stun or stun < 0.5 then stun = 0.5 end
		print("hardfall")
		local speed = 0.1
		print("keyframe 1")
		tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.4, 0) * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
		--tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(157.449), math.rad(-75), math.rad(-0.057))}):Play()
		tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(157.449), math.rad(-75), math.rad(-0.057))}):Play()
		--tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
		--tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
		tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(92.475), math.rad(73.281), math.rad(64.973))}):Play()
		tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(15.011), 0, 0)}):Play()
		--tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
		--tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
		tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(12.777), math.rad(12.376), math.rad(11.345))}):Play()
		tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-29.335), math.rad(3.896), math.rad(-1.891))}):Play()
		--tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
		tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(5.271), math.rad(-12.376), math.rad(-11.345))}):Play()
		tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig *  CFrame.Angles(math.rad(-28.934), math.rad(-5.615), math.rad(3.209))}):Play()
		--tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
		task.delay(stun, function() 
			local speed = 0.435
			print("keyframe 2")
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
			--tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(28.762), math.rad(-9.339), math.rad(4.412))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(5.901), math.rad(2.636), math.rad(2.063))}):Play()
			--tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(31.283), math.rad(15.126), math.rad(2.636))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(5.558), math.rad(6.36), math.rad(0.745))}):Play()
			--tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-7.219), math.rad(-6.532), math.rad(-2.292))}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(62.223), math.rad(-46.581), math.rad(-58.9))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-103.247), math.rad(-24.809), math.rad(-3.266))}):Play()
			--tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(65.26), math.rad(12.376), math.rad(11.345))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-103.476), math.rad(23.033), math.rad(4.641))}):Play()
			--tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()

			task.delay(speed, function()
				local speed = 0.1
				print("keyframe 5")
				--tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig}):Play()
				--tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
				tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-2.807), math.rad(7.047), math.rad(-0.401))}):Play()
				--tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
				--tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(45.607), math.rad(11.287), math.rad(3.209))}):Play()
				--tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig}):Play()
				--tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(0, math.rad(-15.928), math.rad(-0.057))}):Play()
				tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(45.665), math.rad(-50.879), math.rad(-80.787))}):Play()
				tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-79.985), math.rad(13.235), math.rad(28.132))}):Play()
				--tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
				tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(63.541), math.rad(-7.735), math.rad(4.87))}):Play()
				--tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig}):Play()
				--tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				task.delay(speed, function()
					local speed = 0.1
					print("keyframe 6")
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.9, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
					--tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-2.005), math.rad(5.042), math.rad(-0.344))}):Play()
					--tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
					--tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(60.103), math.rad(4.813), math.rad(7.047))}):Play()
					--tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig}):Play()
					--tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(0, math.rad(-15.928), 0)}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(131.551), math.rad(-39.992), math.rad(-0.917))}):Play()
					--tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig}):Play()
					--tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					--tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig}):Play()
					--tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig}):Play()
					--tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
					task.delay(speed, function()
						print("defaultPos")
						defaultPos(0.35)
					end)
				end)
			end)
		end)
	end
end

-- Ability related animations --

local function flamepunchStart(speedM)
	local durations = {0.1, 0.1, 0.1, 0.3, 0.4} -- default animation durations
	local frame = 1
	if not speedM then speedM = 1 end

	larm.Name, llarm.Name, rarm.Name, rlarm.Name = "animating", "animating", "animating", "animating"
	local speed = 0.1
	warn(frame)
	tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-7.506), 0, 0)}):Play()
	tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-15), 0, 0)}):Play()
	tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(30), 0, 0)}):Play()
	tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(-15), 0, 0)}):Play()
	tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(30), 0, 0)}):Play()
	tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-15), 0, 0)}):Play()
	task.delay(speed, function()
		speed = durations[frame]*speedM warn(frame)
		frame += 1 
		tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-3.724), 0, 0)}):Play()
		tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-27.559), math.rad(34.206), math.rad(16.387))}):Play()
		tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(50.478), math.rad(16.673), math.rad(3.724))}):Play()
		tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(18.793), math.rad(-3.209), math.rad(2.292))}):Play()
		tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(48.759), 0, 0)}):Play()
		tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-7.506), 0, 0)}):Play()
		task.delay(speed, function()
			speed = durations[frame]*speedM warn(frame)
			frame += 1
			--tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * }):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-24.351), math.rad(28.934), math.rad(13.063))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(47.097), math.rad(15.47), math.rad(4.526))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(52.712), math.rad(-4.584), math.rad(5.959))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(67.494), 0, 0)}):Play()
			--tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * }):Play()
			task.delay(speed, function()
				speed = durations[frame]*speedM warn(frame)
				frame += 1
				tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(7.506), 0, 0)}):Play()
				tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-21.601), math.rad(23.491), math.rad(10.256))}):Play()
				tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(43.831), math.rad(14.324), math.rad(5.214))}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(82.735), math.rad(-4.584), math.rad(5.959))}):Play()
				tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(66.807), math.rad(4.297), math.rad(-8.422))}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(7.506), 0, 0)}):Play()
				task.delay(speed, function()
					speed = durations[frame]*speedM warn(frame)
					frame += 1
					tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(4.297), 0, 0)}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-15.355), math.rad(6.589), math.rad(3.839))}):Play()
					tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(34.091), math.rad(10.542), math.rad(6.875))}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(90.241), math.rad(-4.584), math.rad(5.959))}):Play()
					tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(68.64), math.rad(17.074), math.rad(-34.148))}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(4.297), 0, 0)}):Play()
					task.delay(speed, function()
						speed = durations[frame]*speedM warn(frame)
						frame += 1
						tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(66.979), math.rad(-2.349), math.rad(15.241))}):Play()
						tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(83.308), math.rad(-13.121), math.rad(72.536))}):Play()
						tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(72.651), math.rad(15.928), math.rad(-23.778))}):Play()
						tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(80.615), math.rad(30.138), math.rad(-72.995))}):Play()
						tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
						tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
						task.delay(speed, function()
							larmmotor.C0 = larmOrig * CFrame.Angles(math.rad(66.979), math.rad(-2.349), math.rad(15.241))
							llarmmotor.C0 = llarmOrig * CFrame.Angles(math.rad(83.308), math.rad(-13.121), math.rad(72.536))
							rarmmotor.C0 = rarmOrig * CFrame.Angles(math.rad(72.651), math.rad(15.928), math.rad(-23.778))
							rlarmmotor.C0 = rlarmOrig * CFrame.Angles(math.rad(80.615), math.rad(30.138), math.rad(-72.995))
						end)
					end)
				end)
			end)
		end)
	end)
end
local function flamepunch(speedM, endDuration, ending)
	if not endDuration then endDuration = 0.5 end
	if not speedM then speedM = 1 end
	local speed = 0.15
	tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(0, math.rad(-37.471), 0)}):Play()
	tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(73.167), math.rad(1.432), math.rad(-7.277))}):Play()
	tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(97.116), math.rad(-42.8), math.rad(83.136))}):Play()
	tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(2.063), math.rad(5.329), math.rad(-59.874))}):Play()
	tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(0, math.rad(37.471), 0)}):Play()
	tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(-26.7), math.rad(-18.507), math.rad(11.001))}):Play()
	tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(42.456), math.rad(-19.366), math.rad(-52.941))}):Play()
	task.delay(0.3, function()
		speed = 0.1
		tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
		tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
		tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(143.068), math.rad(4.011), math.rad(-27.044))}):Play()
		tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(29.106), math.rad(-19.882), math.rad(8.938))}):Play()
		tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(34.263), math.rad(-64.171), math.rad(-43.144))}):Play()
		task.delay(endDuration, function()
			local speed = 0.4
			if not ending then
				tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(66.979), math.rad(-2.349), math.rad(15.241))}):Play()
				tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(83.308), math.rad(-13.121), math.rad(72.536))}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(72.651), math.rad(15.928), math.rad(-23.778))}):Play()
				tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(80.615), math.rad(30.138), math.rad(-72.995))}):Play()
				tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
				tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
				tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
			else
				defaultPos(0.5)
			end
		end)
	end)
end

local fallsound = nil
local falldb = false
local function falldamage(player, action, target, value)
	if falldb then return end
	print(value)
	if not fallsound or fallsound.Parent then
		fallsound = Instance.new("Sound", hrp)
		fallsound.Volume, fallsound.SoundId = "1", "rbxassetid://1055286841"
		fallsound.Name = "fallsound"
	end
	fallsound:Play()
	if value < -35 then
		print(math.abs(value/70))
		hardfall(math.abs(value/85))
		if hum.Health + value <= 0 then wait(0.05) end
	end
	if victim then
		local fallvictim = victim
		falldb = true
		if fallvictim.PrimaryPart then
			fallvictim.PrimaryPart.CanCollide = true
		end
		--hrp.CFrame = hrp.CFrame * CFrame.new(0, 0.25, 0)
		fallvictim.Humanoid.Health += value*1.25
		if fallvictim.Humanoid.Health <= 0 then playerRemote:FireClient(owner, "drop") if fallvictim.PrimaryPart then fallvictim.PrimaryPart.Anchored = true end end
		wait()
		if fallvictim.Humanoid.Health <= 0 then ragdoll(fallvictim, CFrame.new(0, 2, 0), 1) end
		hum.Health += value
		falldb = false
	else
		hum.Health += value
	end
end
local tform = Instance.new("Sound", hrp)
tform.SoundId = "rbxassetid://8628032099"
tform.Volume = 1
tform.RollOffMaxDistance = 100
tform.Name = "Transform"
---- Remote ----
remote.OnServerEvent:Connect(function(player, action, target, value)
	if player ~= owner then return end
	if action == "crouch" then
		crouch(0.1)
	elseif action == "uncrouch" then
		defaultPos(0.1)
	elseif action == "fall" then
		print("fall server")
		falldamage(player, action, target, value)
	elseif action == "transform" then
		tform.Pitch = (100 + math.random(0, 15))/100
		tform:Play()
		if not vampire then
			vampire = true
			face.Texture = "rbxassetid://1111587497"
			transformAnim(char)
			for _,v in pairs(owner.Character:GetDescendants()) do
				if v:IsA("BasePart") and not v.Parent:IsA("Accessory") then
					table.insert(origParts, v)
					table.insert(origColors, v.Color)
					table.insert(origMats, v.Material)
					table.insert(origTrans, v.Transparency)
					if (v.Name == "Torso" or v.Name == "UpperTorso" or v.Name == "LowerTorso") and not char:FindFirstChildWhichIsA("Shirt") and not char:FindFirstChildWhichIsA("Pants") then
					elseif (v.Name == "LeftUpperLeg" or v.Name == "LeftLowerLeg" or v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "Right Leg" or v.Name == "Left Leg") and not char:FindFirstChild("Pants") then
					else
						v.Color = Color3.fromRGB(255, 255, 255)
					end
				elseif v:IsA("BasePart") and v.Parent:IsA("Accessory") then
					table.insert(origParts, v)
					table.insert(origColors, v.Color)
					table.insert(origMats, v.Material)
					table.insert(origTrans, v.Transparency)
				elseif v:IsA("Decal") then
					table.insert(origParts, v)
					table.insert(origColors, v.Color3)
					table.insert(origMats, 0)
					table.insert(origTrans, v.Transparency)
				end
			end
		else
			vampire = false
			face.Texture = origFace
			transformAnim(char)
			for i,v in pairs(origParts) do
				if v and v.Parent and not v:IsA("Decal") then
					v.Color = origColors[i]
				end
			end
		end
	elseif action == "swing" and not swingCD then
		swingCD = true
		rarmmotor.C0, rlarmmotor.C0, larmmotor.C0, llarmmotor.C0 = rarmOrig, rlarmOrig, larmOrig, llarmOrig
		llarm.Name, larm.Name, rarm.Name, rlarm.Name = llarmName, larmName, rarmName, rlarmName
		rarm.Name = "animating"
		local torsoGoal1, headGoal1 = upperTorso.Waist.C0 * CFrame.Angles(math.rad(10), 0, 0), head.Neck.C0 * CFrame.Angles(math.rad(-10), 0, 0)
		local rarmGoal1 = rarmmotor.C0 * CFrame.Angles(math.rad(165), math.rad(90), math.rad(10))
		local torsoGoal2, headGoal2 = upperTorso.Waist.C0 * CFrame.Angles(math.rad(-10), 0, 0), head.Neck.C0 * CFrame.Angles(math.rad(10), 0, 0)
		local rarmGoal2 = rarmmotor.C0 * CFrame.Angles(math.rad(20), math.rad(35), math.rad(-20))
		tweenServ:Create(upperTorso.Waist, TweenInfo.new(0.125), {C0 = torsoGoal1}):Play()
		tweenServ:Create(head.Neck, TweenInfo.new(0.125), {C0 = headGoal1}):Play()
		tweenServ:Create(rarmmotor, TweenInfo.new(0.125), {C0 = rarmGoal1}):Play()
		task.delay(0.125, function()
			tweenServ:Create(upperTorso.Waist, TweenInfo.new(0.15), {C0 = torsoGoal2}):Play()
			tweenServ:Create(head.Neck, TweenInfo.new(0.15), {C0 = headGoal2}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(0.15), {C0 = rarmGoal2}):Play()
		end)
		task.delay(0.3, function()
			swingCD = false
			upperTorso.Waist.C0, head.Neck.C0 = torsoOrig, headOrig
			if victim then
				rarmmotor.C0 = rarmOrig * CFrame.Angles(math.rad(74.886), math.rad(-14.725), math.rad(37.242))
				rlarmmotor.C0 = rlarmOrig * CFrame.Angles(math.rad(-1.948), math.rad(1.146), math.rad(-27.502))
			else
				rarm.Name = rarmName
				rarmmotor.C0 = rarmOrig
			end
		end)
	elseif action == "hit" then
		for _,v in pairs(workspace:GetDescendants()) do if v.Name == target and v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChild("uniquegrabid") and v.uniquegrabid.Value == value then target = v end end
		victim = target
		victim.Archivable = true
		targPlr = players:GetPlayerFromCharacter(target)
		victimDisplay = victim.Humanoid.DisplayDistanceType
		victim.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		for _,v in pairs(target:GetDescendants()) do if v:isA("BasePart") then
				if v:FindFirstChild("blackoutLight") then
					tweenServ:Create(v.blackoutLight, TweenInfo.new(0.1), {Brightness = 0}):Play()
				end
				if v.Anchored then victim = nil return end
				pcall(function() phys:SetPartCollisionGroup(v, "grabCollision") end)
				netowner = v:GetNetworkOwner()
				v:SetNetworkOwner(owner)
			end
		end
		victim.Humanoid.PlatformStand = true
		playerRemote:FireClient(owner)
		for _,v in pairs(target:GetDescendants()) do if v:isA("BasePart") then
				if v.Anchored then victim = nil return end
				pcall(function() phys:SetPartCollisionGroup(v, "grabCollision") end)
				v:SetNetworkOwner(owner)
			end
		end
		victim.Humanoid.PlatformStand = true
		larm.Name, llarm.Name, rarm.Name, rlarm.Name = "animating", "animating", "animating", "animating"
		torsomotor.C0 = torsoOrig * CFrame.Angles(math.rad(-4.011), 0, 0)
		larmmotor.C0 = larmOrig * CFrame.Angles(math.rad(75.287), math.rad(-1.662), math.rad(0.63))
		llarmmotor.C0 = llarmOrig * CFrame.Angles(math.rad(28.533), math.rad(-4.641), math.rad(49.79))
		rarmmotor.C0 = rarmOrig * CFrame.Angles(math.rad(74.886), math.rad(-14.725), math.rad(37.242))
		rlarmmotor.C0 = rlarmOrig * CFrame.Angles(math.rad(-1.948), math.rad(1.146), math.rad(-27.502))
		--task.delay(2, function() stunned = true playerRemote:FireClient(owner, "escaped") end)
		if targPlr then
			--if true then
			ui, blabel, pbar, gradient = escapeUI(targPlr:FindFirstChildWhichIsA("PlayerGui"))
			escProg = 0
			escKey = math.random(0, 3)
			if escKey == 0 then escKey = "W" elseif escKey == 1 then escKey = "A" elseif escKey == 2 then escKey = "S" elseif escKey == 3 then escKey = "D" end
			pW = Instance.new("ProximityPrompt")
			pW.Parent = victim
			pW.Name = "Escape!"
			pW.ActionText = "Press ".. escKey.. ""
			blabel.Text = escKey
			pW.ObjectText = "Hit the correct key to escape!"
			pW.KeyboardKeyCode = Enum.KeyCode.W
			pW.MaxActivationDistance = 0.1
			pW.RequiresLineOfSight = false
			pA, pS, pD = pW:Clone(), pW:Clone(), pW:Clone()
			pA.KeyboardKeyCode, pS.KeyboardKeyCode, pD.KeyboardKeyCode = Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D
			pA.Parent, pS.Parent, pD.Parent = pW.Parent, pW.Parent, pW.Parent
			pW.UIOffset, pA.UIOffset, pS.UIOffset, pD.UIOffset = Vector2.new(0, 75), Vector2.new(-250, 0), Vector2.new(0, -75), Vector2.new(250, 0)
			escKeyPress(pW) escKeyPress(pA) escKeyPress(pS) escKeyPress(pD)
		end
	elseif action == "release" then
		if #escConnections > 0 then
			for _,v in pairs(escConnections) do v:Disconnect() end
			escConnections = {}
			pW:Destroy() pA:Destroy() pS:Destroy() pD:Destroy()
			ui:Destroy()
		end
		if not victim or not victim.Parent then 
			victim = nil
			rarmmotor.C0, rlarmmotor.C0, larmmotor.C0, llarmmotor.C0 = rarmOrig, rlarmOrig, larmOrig, llarmOrig
			llarm.Name, larm.Name, rarm.Name, rlarm.Name = llarmName, larmName, rarmName, rlarmName
			return
		end
		victim.Archivable = true
		target = victim
		victim = nil
		targPlr = players:GetPlayerFromCharacter(target)
		for _,v in pairs(target:GetDescendants()) do 
			if v:IsA("BasePart") then
				pcall(function() phys:SetPartCollisionGroup(v, "Default") end)
			end
		end
		if target:FindFirstChildWhichIsA("Humanoid") then target.Humanoid.PlatformStand = false end
		for _,v in pairs(target:GetDescendants()) do 
			if v:IsA("BasePart") then
				if v:FindFirstChild("blackoutLight") and target.Humanoid.Health > 0 then
					tweenServ:Create(v.blackoutLight, TweenInfo.new(0.1), {Brightness = 1}):Play()
				end
				pcall(function() phys:SetPartCollisionGroup(v, "Default") end)
			end
		end
		target.Humanoid.DisplayDistanceType = victimDisplay
		if not target:FindFirstChildWhichIsA("Humanoid") or target:FindFirstChildWhichIsA("Humanoid").Health <= 0 then
			ragdoll(target)
			wait(0.1)
			playerRemote:FireClient(owner)
		else
			playerRemote:FireClient(owner)
			for _,v in pairs(target:GetDescendants()) do
				if v:IsA("BasePart") and not v.Anchored then
					if targPlr then
						v:SetNetworkOwner(targPlr)
					else
						v:SetNetworkOwner(nil)
					end
				end
			end
			warn('check')
			warn(target.Humanoid:GetState())
			local bjoints  = target.Humanoid.BreakJointsOnDeath
			local fallconnection;
			fallconnection = target.Humanoid.StateChanged:Connect(function(old, new)
				if not (new == Enum.HumanoidStateType.Landed and old == Enum.HumanoidStateType.Freefall) then return end
				target.Humanoid.BreakJointsOnDeath = false
				local falldmg = 55 - (math.pow(math.abs(target:FindFirstChildWhichIsA("BasePart").Velocity.Y) - 55, 1.25))
				if falldmg > 0 then return end
				print(falldmg)
				local newfallsound = Instance.new("Sound", target:FindFirstChildWhichIsA("BasePart"))
				newfallsound.Volume, newfallsound.SoundId = "1", "rbxassetid://1055286841"
				newfallsound.Name = "fallsound"
				debris:AddItem(newfallsound, 5)
				newfallsound:Play()
				if falldmg <= -35 then
					if target:FindFirstChild("UpperTorso") then
						local ws = target.Humanoid.WalkSpeed
						target.Humanoid.WalkSpeed = 0
						hardfall(math.abs(falldmg/85), target)
						task.delay(1.35 + math.abs(falldmg/100), function() target.Humanoid.WalkSpeed = ws end)
					end
					if hum.Health + falldmg <= 0 then wait(0.05) end
				end
				target.Humanoid.Health += falldmg
				wait()
				if target.Humanoid.Health <= 0 then ragdoll(target) end
				target.Humanoid.BreakJointsOnDeath = bjoints
			end)
			task.delay(4, function() fallconnection:Disconnect() end)
		end
		if not stunned then
			rarmmotor.C0, rlarmmotor.C0, larmmotor.C0, llarmmotor.C0 = rarmOrig, rlarmOrig, larmOrig, llarmOrig
			llarm.Name, larm.Name, rarm.Name, rlarm.Name = llarmName, larmName, rarmName, rlarmName
		else
			rarmmotor.C0, rlarmmotor.C0 = rarmOrig, rlarmOrig
			rarm.Name, rlarm.Name = rarmName, rlarmName
			stunAnim()
			task.delay(4.25, function()
				print('over')
				stunned = false
				tweenServ:Create(larmmotor, TweenInfo.new(0.25), {C0 = larmOrig}):Play()
				tweenServ:Create(llarmmotor, TweenInfo.new(0.25), {C0 = llarmOrig}):Play()
				task.delay(0.25, function() larm.Name, llarm.Name = larmName, llarmName end)
			end)
		end
		playerRemote:FireClient(owner)
	elseif action == "draining" and target then
		if draining == false then
			headbob = runServ.Heartbeat:Connect(function()
				headmotor.C0 = headOrig * CFrame.Angles(math.rad(-16.272 - math.sin(tick()*40)*3), math.rad(-35.691), math.rad(5.901))
			end)
		end
		draining = true
		larm.Name, llarm.Name, rarm.Name, rlarm.Name = "animating", "animating", "animating", "animating"
		torsomotor.C0 = torsoOrig * CFrame.Angles(math.rad(-17.991), 0, 0)
		larmmotor.C0 = larmOrig * CFrame.new(0, -0.094, -0.344) * CFrame.Angles(math.rad(90.871), math.rad(-14.725), math.rad(54.087))
		llarmmotor.C0 = llarmOrig * CFrame.Angles(math.rad(-1.432), math.rad(-7.907), math.rad(21.543))
		rarmmotor.C0 = rarmOrig * CFrame.new(0, -0.13, 0.083) * CFrame.Angles(math.rad(145.016), math.rad(51.452), math.rad(15.642))
		rlarmmotor.C0 = rlarmOrig * CFrame.Angles(math.rad(47.555), math.rad(16.444), math.rad(-37.185))
		if target:FindFirstChildWhichIsA("Humanoid") then
			if target:FindFirstChildWhichIsA("Humanoid").Health - value <= 0 then
				target:FindFirstChildWhichIsA("Humanoid").BreakJointsOnDeath = false
				print(target:FindFirstChildWhichIsA("Humanoid").BreakJointsOnDeath)
			end
			target:FindFirstChildWhichIsA("Humanoid").Health -= value
		end
		char.Humanoid.Health += 6
	elseif action == "stopdraining" then
		draining = false
		pcall(function() headbob:Disconnect() end)
		if victim then
			torsomotor.C0 = torsoOrig * CFrame.Angles(math.rad(-4.011), 0, 0)
			larmmotor.C0 = larmOrig * CFrame.Angles(math.rad(75.287), math.rad(-1.662), math.rad(0.63))
			llarmmotor.C0 = llarmOrig * CFrame.Angles(math.rad(28.533), math.rad(-4.641), math.rad(49.79))
			rarmmotor.C0 = rarmOrig * CFrame.Angles(math.rad(74.886), math.rad(-14.725), math.rad(37.242))
			rlarmmotor.C0 = rlarmOrig * CFrame.Angles(math.rad(-1.948), math.rad(1.146), math.rad(-27.502))
			headmotor.C0 = headOrig
		else
			rarmmotor.C0, rlarmmotor.C0, larmmotor.C0, llarmmotor.C0, torsomotor.C0, headmotor.C0 = rarmOrig, rlarmOrig, larmOrig, llarmOrig, torsoOrig, headOrig
			llarm.Name, larm.Name, rarm.Name, rlarm.Name = llarmName, larmName, rarmName, rlarmName
		end
		--- Abilities ---
	elseif action == "releasePrimary" and usingPrimary then
		endPrimary()
	elseif action == "primary" then
		print("primary - Server")
		primary(player, action, target, value)
	elseif action == "secondary" and not usingSecondary then
		secondary(player, action, target, value)
	elseif action == "releaseSecondary" then
		endSecondary()
	end
end)

---- Unique Values ----
local function assignID(human)
	local stringer = Instance.new("StringValue")
	stringer.Value, stringer.Name, stringer.Parent = tostring(math.random(1000000, 9999999)), "uniquegrabid", human.Parent
	local removal;
	removal = stringer.AncestryChanged:Connect(function() if not stringer.Parent and human then removal:Disconnect() assignID(human) end end)
end

for _,v in pairs(workspace:GetDescendants()) do
	v.Archivable = true
	if v:IsA("Humanoid") and not v.Parent:FindFirstChild("uniquegrabid") then
		assignID(v)
	end
end
workspace.DescendantAdded:Connect(function(v) pcall(function() v.Parent.Archivable = true v.Archivable = true if v:IsA("Humanoid") then assignID(v) end end) end)

--- Abilities ---
local function cloak()
	local stars = Instance.new("ParticleEmitter")
	stars.Name = "stars"
	stars.LightInfluence = 1
	stars.Lifetime = NumberRange.new(0.5, 0.5)
	stars.SpreadAngle = Vector2.new(90, 50)
	stars.Transparency = NumberSequence.new(0, 1)
	stars.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 156, 255)), ColorSequenceKeypoint.new(0.4394343, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5690516, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(234, 156, 255))})
	--stars.Color = ColorSequence.new(Color3.fromRGB(234, 156, 255))
	stars.VelocitySpread = 90
	stars.Size = NumberSequence.new(0.5)
	stars.RotSpeed = NumberRange.new(100, 100)
	stars.Rate = 0
	stars.Texture = "http://www.roblox.com/asset/?id=8596298150"
	stars.Rotation = NumberRange.new(360, 360)
	stars.Parent = hrp
	local function particles()
		local Abduct1 = Instance.new("ParticleEmitter")
		Abduct1.Name = "Abduct"
		Abduct1.LightInfluence = 1
		Abduct1.Lifetime = NumberRange.new(1, 1)
		Abduct1.SpreadAngle = Vector2.new(180, 180)
		Abduct1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(0.4984663, 0.9), NumberSequenceKeypoint.new(0.601227, 0.5), NumberSequenceKeypoint.new(1, 1)})
		Abduct1.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(96, 138, 255)), ColorSequenceKeypoint.new(0.500832, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))})
		Abduct1.VelocitySpread = 180
		Abduct1.Speed = NumberRange.new(7.5, 7.5)
		Abduct1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6874996), NumberSequenceKeypoint.new(0.196319, 1.9999999), NumberSequenceKeypoint.new(1, 0)})
		Abduct1.Acceleration = Vector3.new(0, 5, 0)
		Abduct1.Rate = 0
		Abduct1.Rotation = NumberRange.new(-180, 180)
		Abduct1.Shape = Enum.ParticleEmitterShape.Sphere
		local Abduct2 = Abduct1:Clone()
		return Abduct1, Abduct2
	end
	local function tpsound(parent)
		local sound = Instance.new("Sound")
		sound.Parent = parent
		sound.SoundId = "rbxassetid://4922194603"
		sound.Volume = 0.5
		sound:Play()
		debris:AddItem(sound, 2)
	end

	local cloak, uncloak, rumble = Instance.new("Sound"), Instance.new("Sound"), Instance.new("Sound")
	cloak.SoundId, uncloak.SoundId, rumble.SoundId = "rbxassetid://8597182703", "rbxassetid://8597098422", "rbxassetid://8597099689"
	cloak.RollOffMaxDistance, uncloak.RollOffMaxDistance = 100, 100
	cloak.Parent, uncloak.Parent, rumble.Parent = hrp, hrp, head
	rumble.RollOffMaxDistance = 5
	rumble.Looped = true
	function primary(player, action, target, value)
		local entry, exit = Instance.new("Part", script), Instance.new("Part", script)
		entry.Size, exit.Size = Vector3.new(0.4, 0.4, 0.4), Vector3.new(0.4, 0.4, 0.4)
		entry.Transparency, entry.Anchored, exit.Transparency, exit.Anchored = 1, true, 1, true
		entry.CanCollide, exit.CanCollide = false, false
		entry.Position, exit.Position = target, value
		local p1, p2 = particles()
		p1.Parent, p2.Parent = entry, exit
		tpsound(entry); tpsound(exit)
		p1:Emit(21)
		p2:Emit(21)
		debris:AddItem(entry, 4)
		debris:AddItem(exit, 4)
	end
	function secondary(player, action, target, value)
		rarmmotor.C0, rlarmmotor.C0, larmmotor.C0, llarmmotor.C0 = rarmOrig, rlarmOrig, larmOrig, llarmOrig
		llarm.Name, larm.Name, rarm.Name, rlarm.Name = llarmName, larmName, rarmName, rlarmName
		usingSecondary = true
		abilityLock = true
		for _,v in pairs(origParts) do
			if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
				v.Material = Enum.Material.Glass v.Color = Color3.fromRGB(70, 70, 70) v.Transparency = 0.05
			elseif v:IsA("Decal") then
				v.Transparency = 1
			end
		end
		for _,v in pairs(char:GetChildren()) do if v:IsA("Shirt") or v:IsA("Pants") then v.Parent = script end end
		cloak:Play()
		rumble:Play()
		larm.Name, llarm.Name, rarm.Name, rlarm.Name = "animating", "animating", "animating", "animating"
		tweenServ:Create(torsomotor, TweenInfo.new(0.033), {C0 = torsoOrig * CFrame.Angles(math.rad(4.011), math.rad(-2.005), math.rad(0.115))}):Play()
		tweenServ:Create(larmmotor, TweenInfo.new(0.033), {C0 = larmOrig * CFrame.new(0, -0.02, 0.02) * CFrame.Angles(math.rad(15.47), math.rad(0.688), math.rad(1.891))}):Play()
		tweenServ:Create(rarmmotor, TweenInfo.new(0.033), {C0 = rarmOrig * CFrame.Angles(math.rad(-8.021), math.rad(0.057), math.rad(-0.745))}):Play()
		tweenServ:Create(headmotor, TweenInfo.new(0.033), {C0 = headOrig * CFrame.Angles(math.rad(-10.256), math.rad(8.537), math.rad(0.802))}):Play()
		task.delay(0.033, function()
			stars:Emit(15)
			tweenServ:Create(larmmotor, TweenInfo.new(0.166), {C0 = larmOrig * CFrame.new(0, -0.1, 0.1) * CFrame.Angles(math.rad(77.006), 0, 0)}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(0.166), {C0 = rarmOrig * CFrame.Angles(math.rad(-13.98), 0, math.rad(0.458))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(0.166), {C0 = headOrig * CFrame.Angles(math.rad(-10.256), math.rad(8.537), math.rad(0.802))}):Play()
		end)
		task.delay(0.167, function()
			for _,v in pairs(origParts) do
				if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and not v.Parent:IsA("Accessory") then
					tweenServ:Create(v, TweenInfo.new(0.35), {Transparency = 0.99}):Play()
				elseif v:IsA("BasePart") and v.Parent:IsA("Accessory") then
					tweenServ:Create(v, TweenInfo.new(0.35), {Transparency = 1}):Play()
				end
			end
			tweenServ:Create(torsomotor, TweenInfo.new(0.35), {C0 = torsoOrig * CFrame.Angles(math.rad(5.558), math.rad(-25.898), math.rad(2.235))}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(0.35), {C0 = larmOrig * CFrame.new(0.058, -0.134, -0.233) * CFrame.Angles(math.rad(84.855), math.rad(-7.964), math.rad(81.933))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(0.35), {C0 = rarmOrig * CFrame.Angles(math.rad(-25.783), math.rad(9.053), math.rad(-10.199))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(0.35), {C0 = headOrig * CFrame.Angles(math.rad(-27.215), math.rad(22.059), math.rad(7.105))}):Play()
		end)
		task.delay(0.35, function() for i,v in pairs(origParts) do if v:IsA("BasePart") then v.Material = origMats[i] end end abilityLock = false end)
	end
	function endSecondary(player, action, target, value)
		if not usingSecondary then return end
		while abilityLock do wait(0.05) end
		usingSecondary = false
		for i,v in pairs(origParts) do 
			if v:IsA("BasePart") then
				v.Color, v.Transparency, v.Material = Color3.fromRGB(255, 255, 255), origTrans[i], origMats[i]
			elseif v:IsA("Decal") then
				v.Transparency = origTrans[i]
			end
		end
		for _,v in pairs(script:GetChildren()) do if v:IsA("Shirt") or v:IsA("Pants") then v.Parent = char end end
		uncloak:Play()
		rumble:Stop()
		stars:Emit(15)
		tweenServ:Create(torsomotor, TweenInfo.new(0.3), {C0 = torsoOrig * CFrame.Angles(0, math.rad(-6.016), 0)}):Play()
		tweenServ:Create(larmmotor, TweenInfo.new(0.3), {C0 = larmOrig * CFrame.new(0.058, -0.134, -0.233) * CFrame.Angles(math.rad(92.533), math.rad(3.266), math.rad(-2.464))}):Play()
		tweenServ:Create(rarmmotor, TweenInfo.new(0.3), {C0 = rarmOrig * CFrame.new(0.01, 0, 0.099) * CFrame.Angles(math.rad(28.533), math.rad(22.002), math.rad(-3.667))}):Play()
		tweenServ:Create(headmotor, TweenInfo.new(0.3), {C0 = headOrig * CFrame.Angles(math.rad(-11.173), math.rad(-6.303), math.rad(-5.443))}):Play()
		task.delay(0.3, function() 
			tweenServ:Create(torsomotor, TweenInfo.new(0.2), {C0 = torsoOrig * CFrame.Angles(0, math.rad(0.974), 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(0.2), {C0 = larmOrig * CFrame.new(0.089, 0.066, 0.065) * CFrame.Angles(math.rad(28.82), math.rad(13.35), math.rad(-34.893))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(0.2), {C0 = rarmOrig *  CFrame.new(0.01, -0.1, 0.099) * CFrame.Angles(math.rad(80.157), math.rad(21.429), math.rad(-26.872))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(0.2), {C0 = headOrig * CFrame.Angles(math.rad(-6.245), math.rad(-2.235), math.rad(-5.558))}):Play()
		end)
		task.delay(0.433, function() 
			tweenServ:Create(torsomotor, TweenInfo.new(0.2), {C0 = torsoOrig * CFrame.Angles(0, math.rad(0.974), 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(0.2), {C0 = larmOrig * CFrame.new(0.089, 0.066, 0.065) * CFrame.Angles(math.rad(21.772), math.rad(1.948), math.rad(-9.798))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(0.2), {C0 = rarmOrig *  CFrame.new(0.01, -0.1, 0.099) * CFrame.Angles(math.rad(64.572), math.rad(13.923), math.rad(-8.48))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(0.2), {C0 = headOrig * CFrame.Angles(math.rad(-6.245), math.rad(-2.235), math.rad(-5.558))}):Play()
		end)
		task.delay(.933, function() 
			if rarmmotor.C0 == rarmOrig *  CFrame.new(0.01, -0.1, 0.099) * CFrame.Angles(math.rad(64.572), math.rad(13.923), math.rad(-8.48)) then
				tweenServ:Create(torsomotor, TweenInfo.new(0.2), {C0 = torsoOrig}):Play()
				tweenServ:Create(larmmotor, TweenInfo.new(0.2), {C0 = larmOrig}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(0.2), {C0 = rarmOrig}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(0.2), {C0 = headOrig}):Play()
				llarm.Name, larm.Name, rarm.Name, rlarm.Name = llarmName, larmName, rarmName, rlarmName
			end
		end)

	end
end

local function blackout()
	local powOut = Instance.new("Sound", workspace)
	local lights, brightness = {}, {}
	local playerLights = {}
	local light = 0
	local lightDelay = 0
	local ambientInc = 0
	local onCD = false
	function primary(player, action, target, value)
		if onCD then print("Cooldown") return end
		usingPrimary = true
		larm.Name, llarm.Name, rarm.Name, rlarm.Name = "animating", "animating", "animating", "animating"
		tweenServ:Create(torsomotor, TweenInfo.new(0.15), {C0 = torsoOrig * CFrame.Angles(math.rad(-15.011), 0, 0)}):Play()
		tweenServ:Create(larmmotor, TweenInfo.new(0.15), {C0 = larmOrig * CFrame.Angles(math.rad(63.197), math.rad(-30.882), math.rad(12.147))}):Play()
		tweenServ:Create(llarmmotor, TweenInfo.new(0.15), {C0 = llarmOrig * CFrame.Angles(math.rad(60.332), math.rad(2.12), math.rad(19.251))}):Play()
		tweenServ:Create(rarmmotor, TweenInfo.new(0.15), {C0 = rarmOrig * CFrame.Angles(math.rad(52.655), math.rad(35.122), math.rad(-2.005))}):Play()
		tweenServ:Create(rlarmmotor, TweenInfo.new(0.15), {C0 = rlarmOrig * CFrame.Angles(math.rad(67.265), math.rad(-2.807), math.rad(-19.652))}):Play()
		tweenServ:Create(headmotor, TweenInfo.new(0.15), {C0 = headOrig * CFrame.Angles(math.rad(-15.011), 0, 0)}):Play()
		for i = 1, 4, 0.1 do
			if not usingPrimary then
				print("severed")
				rarmmotor.C0, rlarmmotor.C0, larmmotor.C0, llarmmotor.C0, torsomotor.C0, headmotor.C0 = rarmOrig, rlarmOrig, larmOrig, llarmOrig, torsoOrig, headOrig
				llarm.Name, larm.Name, rarm.Name, rlarm.Name = llarmName, larmName, rarmName, rlarmName
				return
			end
			wait(0.1)
		end
		tweenServ:Create(torsomotor, TweenInfo.new(0.25), {C0 = torsoOrig * CFrame.Angles(math.rad(30.023), 0, 0)}):Play()
		tweenServ:Create(larmmotor, TweenInfo.new(0.25), {C0 = larmOrig * CFrame.Angles(math.rad(141.005), math.rad(-9.855), math.rad(-21.314))}):Play()
		tweenServ:Create(llarmmotor, TweenInfo.new(0.25), {C0 = llarmOrig * CFrame.Angles(math.rad(-1.719), math.rad(-10.428), math.rad(-10.199))}):Play()
		tweenServ:Create(rarmmotor, TweenInfo.new(0.25), {C0 = rarmOrig * CFrame.Angles(math.rad(136.593), math.rad(33.575), math.rad(34.492))}):Play()
		tweenServ:Create(rlarmmotor, TweenInfo.new(0.25), {C0 = rlarmOrig * CFrame.Angles(math.rad(-6.704), math.rad(-9.282), math.rad(3.667))}):Play()
		tweenServ:Create(headmotor, TweenInfo.new(0.25), {C0 = headOrig * CFrame.Angles(math.rad(44.977), 0, 0)}):Play()
		task.delay(1.25, function()
			tweenServ:Create(torsomotor, TweenInfo.new(0.35), {C0 = torsoOrig}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(0.35), {C0 = larmOrig}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(0.35), {C0 = llarmOrig}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(0.35), {C0 = rarmOrig}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(0.35), {C0 = rlarmOrig}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(0.35), {C0 = headOrig}):Play()
			task.delay(0.35, function() 
				rarmmotor.C0, rlarmmotor.C0, larmmotor.C0, llarmmotor.C0, torsomotor.C0, headmotor.C0 = rarmOrig, rlarmOrig, larmOrig, llarmOrig, torsoOrig, headOrig
				llarm.Name, larm.Name, rarm.Name, rlarm.Name = llarmName, larmName, rarmName, rlarmName
			end)
		end)
		local powOut = Instance.new("Sound", workspace)
		powOut.Volume, powOut.SoundId = 0.25, "rbxassetid://6426748384"
		local detonateSFX = Instance.new("Sound", head)
		detonateSFX.SoundId, detonateSFX.Volume, detonateSFX.RollOffMaxDistance = "rbxassetid://8606996314", 0.5, 50
		detonateSFX:Play()
		powOut:Play()
		for _,v in pairs(workspace:GetDescendants()) do 
			if v:IsA("Light") then
				table.insert(lights, v) table.insert(brightness, v.Brightness)
				v.Brightness = 0
				if v.Parent:IsA("Part") and v.Parent.Material == Enum.Material.Neon then
					Instance.new("BoolValue", v.Parent).Name = "Neon"
					v.Parent.Material = Enum.Material.SmoothPlastic
				end
			elseif v:IsA("Humanoid") and not v.Parent:FindFirstChild("Vampire") and v.Health > 0 then
				local lightP;
				if v:FindFirstChild("HumanoidRootPart") then lightP = v.HumanoidRootPart else lightP = v.Parent:FindFirstChildWhichIsA("BasePart") end
				if lightP then
					local light = Instance.new("PointLight")
					light.Brightness, light.Color, light.Range, light.Shadows = 0, Color3.fromRGB(255, 255, 255), 8, true
					light.Name, light.Parent = "blackoutLight", lightP
					tweenServ:Create(light, TweenInfo.new(math.random(15, 40)/10), {Brightness = 1}):Play()
					table.insert(playerLights, light)
				end
			end
		end
		local ambient = lighting.Ambient
		local odambient = lighting.OutdoorAmbient
		tweenServ:Create(lighting, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Ambient = Color3.fromRGB(0, 0, 0)}):Play()
		tweenServ:Create(lighting, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {OutdoorAmbient = Color3.fromRGB(0, 0, 0)}):Play()
		wait(25)
		--wait(10) -- debug
		lightDelay = 10/#lights
		for i = 1, #lights do
			wait(lightDelay)
			ambientInc = 1/#lights
			lighting.Ambient = lighting.Ambient:Lerp(ambient, ambientInc)
			lighting.OutdoorAmbient = lighting.OutdoorAmbient:Lerp(odambient, ambientInc)
			light = math.random(1, #lights)
			if lights[light] and lights[light].Parent then
				lights[light].Brightness = brightness[light]
				if lights[light].Parent:FindFirstChild("Neon") then lights[light].Parent.Material = Enum.Material.Neon end
			end
			table.remove(lights, light)
			table.remove(brightness, light)
		end
		for _,light in pairs(playerLights) do
			tweenServ:Create(light, TweenInfo.new(1), {Brightness = 0}):Play()
			task.delay(1, function() light:Destroy() end)
		end
		playerLights = {}
		lighting.Ambient = ambient
		lighting.OutdoorAmbient = odambient
		lights, brightness = {}, {}
	end
	function secondary(player, action, target, value)
		warn("Crouch - Server")
		crouch()
	end
	function endPrimary(player, action, target, value)
		usingPrimary = false
	end
	function endSecondary(player, action, target, value)
		warn("Uncrouch - Server")
		defaultPos(0.15)
	end
end

local function decoy()
	local disguiseFace;
	function primary(player, action, target, value)
	end
	function secondary(player, action, target, value)
		for _,v in pairs(workspace:GetDescendants()) do if v.Name == target and v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChild("uniquegrabid") and v.uniquegrabid.Value == value then target = v end end
		if target.Humanoid.Health > 0 then
			local decoyParts, decoyColors = {}, {}
			local decoytform = Instance.new("Sound", target.Head)
			decoytform.SoundId = "rbxassetid://8628032099"
			decoytform.Volume = 1
			decoytform.RollOffMaxDistance = 100
			decoytform.Name = "Transform"
			local alert = Instance.new("ProximityPrompt", target)
			alert.Enabled = false
			alert.RequiresLineOfSight, alert.MaxActivationDistance, alert.UIOffset, alert.ActionText, alert.KeyboardKeyCode = false, 0.01, Vector2.new(0, 200), "YOU HAVE BEEN DISGUISED", Enum.KeyCode.Minus
			wait(5)
			alert.Enabled = true
			decoytform.Pitch = (100 + math.random(0, 15))/100
			decoytform:Play()
			local disguiseFace = target.Head:FindFirstChildWhichIsA("Decal").Texture
			target.Head:FindFirstChildWhichIsA("Decal").Texture = "rbxassetid://1111587497"
			transformAnim(target)
			for _,v in pairs(target:GetDescendants()) do
				if v:IsA("BasePart") and not v.Parent:IsA("Accessory") then
					table.insert(decoyParts, v)
					table.insert(decoyColors, v.Color)

					if (v.Name == "Torso" or v.Name == "UpperTorso" or v.Name == "LowerTorso") and not target:FindFirstChildWhichIsA("Shirt") and not target:FindFirstChildWhichIsA("Pants") then
					elseif (v.Name == "LeftUpperLeg" or v.Name == "LeftLowerLeg" or v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "Right Leg" or v.Name == "Left Leg") and not target:FindFirstChild("Pants") then
					else
						v.Color = Color3.fromRGB(255, 255, 255)
					end
				end
			end
			wait(15)
			alert.Enabled = false
			decoytform:Play()
			target.Head:FindFirstChildWhichIsA("Decal").Texture = disguiseFace
			transformAnim(target)
			for i,v in pairs(decoyParts) do
				v.Color = decoyColors[i]
			end
			task.delay(1, function() alert:Destroy() end)
		else
			local desc1, desc2 = game.Players:GetHumanoidDescriptionFromUserId(owner.UserId), game.Players:GetHumanoidDescriptionFromUserId(target:FindFirstChild("playerID").Value)
			for _,v in pairs(char:GetDescendants()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then v:Destroy() end end
			for _,v in pairs(target:GetDescendants()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then v:Destroy() end end
			char.Humanoid:ApplyDescription(desc2); target.Humanoid:ApplyDescription(desc1)

			animate = char:FindFirstChild("Animate")
			hum = char:FindFirstChild("Humanoid")
			head = char.Head
			rarm = char:FindFirstChild("RightUpperArm")
			larm = char:FindFirstChild("LeftUpperArm")
			rlarm = char:FindFirstChild("RightLowerArm")
			llarm = char:FindFirstChild("LeftLowerArm")
			rhand = char:FindFirstChild("RightHand")
			lhand = char:FindFirstChild("LeftHand")
			upperTorso = char:FindFirstChild("UpperTorso")
			lowerTorso = char:FindFirstChild("LowerTorso")
			lleg, rleg = char:FindFirstChild("LeftUpperLeg"), char:FindFirstChild("RightUpperLeg")
			llleg, rlleg = char:FindFirstChild("LeftLowerLeg"), char:FindFirstChild("RightLowerLeg")
			lfoot, rfoot = char:FindFirstChild("LeftFoot"), char:FindFirstChild("RightFoot")
			hrp = char.HumanoidRootPart
			hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

			rarmmotor = rarm.RightShoulder
			larmmotor = larm.LeftShoulder
			rlarmmotor = rlarm.RightElbow
			llarmmotor = llarm.LeftElbow
			rhandmotor = rhand.RightWrist
			lhandmotor = lhand.LeftWrist
			torsomotor = upperTorso.Waist
			ltorsomotor = lowerTorso.Root
			llegmotor, rlegmotor = lleg.LeftHip, rleg.RightHip
			lllegmotor, rllegmotor = llleg.LeftKnee, rlleg.RightKnee
			lfootmotor, rfootmotor = lfoot.LeftAnkle, rfoot.RightAnkle
			headmotor = head.Neck

			torsoOrig, ltorsoOrig, headOrig, rarmOrig, larmOrig = upperTorso.Waist.C0, lowerTorso.Root.C0, head.Neck.C0, rarmmotor.C0, larmmotor.C0
			rlarmOrig, llarmOrig = rlarmmotor.C0, llarmmotor.C0
			lhandOrig = lhandmotor.C0
			rhandOrig = rhandmotor.C0
			rlegOrig = rlegmotor.C0
			rllegOrig = rllegmotor.C0
			rfootOrig = rfootmotor.C0
			llegOrig = llegmotor.C0
			lllegOrig = lllegmotor.C0
			lfootOrig = lfootmotor.C0

			torsoName, rarmName, larmName, rlarmName, llarmName, headName = "UpperTorso", "RightUpperArm", "LeftUpperArm", "RightLowerArm", "LeftLowerArm", "Head"
			rhandName = rhand.Name
			lhandName = lhand.Name
			rlegName = rleg.Name
			rllegName = rlleg.Name
			rfootName = rfoot.Name
			llegName = lleg.Name
			lllegName = llleg.Name
			lfootName = lfoot.Name
			if vampire then
				origParts, origColors, origMats, origTrans = {}, {}, {}, {}
				for _,v in pairs(owner.Character:GetDescendants()) do
					if v:IsA("BasePart") and not v.Parent:IsA("Accessory") then
						table.insert(origParts, v)
						table.insert(origColors, v.Color)
						table.insert(origMats, v.Material)
						table.insert(origTrans, v.Transparency)
						if (v.Name == "Torso" or v.Name == "UpperTorso" or v.Name == "LowerTorso") and not char:FindFirstChildWhichIsA("Shirt") and not char:FindFirstChildWhichIsA("Pants") then
						elseif (v.Name == "LeftUpperLeg" or v.Name == "LeftLowerLeg" or v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "Right Leg" or v.Name == "Left Leg") and not char:FindFirstChild("Pants") then
						else
							v.Color = Color3.fromRGB(255, 255, 255)
						end
					elseif v:IsA("BasePart") and v.Parent:IsA("Accessory") then
						table.insert(origParts, v)
						table.insert(origColors, v.Color)
						table.insert(origMats, v.Material)
						table.insert(origTrans, v.Transparency)
					elseif v:IsA("Decal") then
						table.insert(origParts, v)
						table.insert(origColors, v.Color3)
						table.insert(origMats, 0)
						table.insert(origTrans, v.Transparency)
					end
				end
			end
		end
	end
end

local function wildfire()
	local firebrick, fire, firelight, firefollow;
	local handcolor, handmat;
	function primary(player, action, target, value)
		if not usingPrimary then
			handcolor, handmat = rhand.Color, rhand.Material
			usingPrimary = true
			firebrick = Instance.new("Part")
			firebrick.Size, firebrick.Transparency, firebrick.Anchored, firebrick.CanCollide = Vector3.new(1, 1, 1), 1, true, false
			firebrick.Parent = script
			fire = Instance.new("ParticleEmitter")
			fire.Name = "fire"
			fire.Lifetime = NumberRange.new(0, 1)
			fire.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.8006135, 0), NumberSequenceKeypoint.new(1, 1)})
			fire.LightEmission = 0.86
			fire.Color = ColorSequence.new(Color3.fromRGB(161, 94, 0), Color3.fromRGB(63, 0, 0))
			fire.Drag = -0.1
			fire.Size = NumberSequence.new(1.5)
			fire.Acceleration = Vector3.new(0, 0, 2)
			fire.Rate = 50
			fire.Texture = "rbxassetid://1038411245"
			fire.Parent = firebrick
			firelight = Instance.new("PointLight", firebrick)
			firelight.Brightness, firelight.Color, firelight.Range, firelight.Shadows = 0, Color3.fromRGB(255, 180, 80), 7, false
			tweenServ:Create(firelight, TweenInfo.new(0.2), {Brightness = 4}):Play()
			firefollow = coroutine.wrap(function()
				while usingPrimary do firebrick.Position = rhand.Position runServ.Heartbeat:Wait() end
			end)
			firefollow()
			flamepunchStart()
			rhand.Name = "flamepunch"
			rhand.Color = Color3.fromRGB(255, 180, 80)
			rhand.Material = Enum.Material.Neon
		else
			if not target then
				flamepunch()
			else
				for _,v in pairs(workspace:GetDescendants()) do if v.Name == target and v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChild("uniquegrabid") and v.uniquegrabid.Value == value then target = v end end
				flamepunch(1, 0.75, true)
				wait(0.3)
				local bjoints = target.Humanoid.BreakJointsOnDeath
				--target.Humanoid.PlatformStand = true
				local rot = (target.PrimaryPart.Position - hrp.Position).Unit * 90 print(rot)
				target.PrimaryPart.CFrame = target.PrimaryPart.CFrame * CFrame.new(0, -2.5, 0) * CFrame.Angles(math.rad(rot.X), math.rad(rot.Y), math.rad(rot.Z))
				target.Humanoid.Health -= 85
				local bv = Instance.new("BodyVelocity", target.PrimaryPart)
				--local bg = Instance.new("BodyGyro", target.PrimaryPart)
				--bg.P = 30000
				--bg.CFrame = CFrame.Angles(math.rad(-1*rot.Y), math.rad(rot.Z), math.rad(-1*rot.X))
				bv.MaxForce = Vector3.new(math.huge, 0, math.huge)
				--tweenServ:Create(bg, TweenInfo.new(0.25), {CFrame = CFrame.Angles(math.rad(rot.))}):Play()
				bv.Velocity = (((target.PrimaryPart.Position - hrp.Position).Unit * 40) * Vector3.new(1, 0, 1)) + Vector3.new(0, 0.5, 0)
				task.delay(0.45, function()
					tweenServ:Create(bv, TweenInfo.new(0.65), {Velocity = Vector3.new(0, 0, 0)}):Play()
					debris:AddItem(bv, 0.65)
				end)
				rhand.Color = handcolor
				rhand.Material = handmat
				rhand.Name = rhandName
				usingPrimary = false
				firebrick:Destroy()
			end
		end
	end
end
local abilityselect;
abilityselect = owner.Chatted:Connect(function(msg)
	if string.lower(msg) == "> blackout" then blackout()
	elseif string.lower(msg) == "> cloak" then cloak()
	elseif string.lower(msg) == "> decoy" then decoy()
	elseif string.lower(msg) == "> wildfire" then wildfire()
	end
end)
wildfire()
