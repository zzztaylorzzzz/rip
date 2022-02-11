local debris = game:GetService("Debris")
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
	elseif string.lower(msg) == "> decoy" then decoy()
	elseif string.lower(msg) == "> wildfire" then wildfire()
	end
end)
wildfire()
