if not owner and game:GetService("Players"):FindFirstChild(script.Parent.Name) then
	owner = game:GetService("Players"):FindFirstChild(script.Parent.Name)
	studio = true
	print("Preparing script")
	wait()
	print("Running")
end


local tool, handle, mesh, particles, use, whispers;
local tweenServ = game:GetService("TweenService")
local runServ = game:GetService("RunService")
local debris = game:GetService("Debris")
local phys = game:GetService("PhysicsService")
local players = game:GetService("Players")



local origOwner = owner
local activeVampires = {"anti destroy", "stop it"}
local thescript;
function thescript(owner, infector)
	local entirescript = coroutine.wrap(function()
		local ability = Instance.new("StringValue")
		ability.Name = "Ability"
		ability.Parent = script
		local random = math.random(1, 5)
		if random == 1 then
			ability.Value = "Cloak"
		elseif random == 2 then
			ability.Value = "Decoy"
		elseif random == 3 then
			ability.Value = "Wildfire"
		elseif random == 4 then
			ability.Value = "Blackout"
		elseif random == 5 then
			ability.Value = "Infect"
		end

		local survived = false
		local isNPC = false
		if owner:IsA("Player") then
			table.insert(activeVampires, owner)
		else
			isNPC = true
		end
		local studio = false
		local r15 = false
		local char;
		if isNPC then
			char = owner
		else
			char = owner.Character
		end
		script.Name = "vampire"

		local players = game:GetService("Players")
		local runServ = game:GetService("RunService")
		local tweenServ = game:GetService("TweenService")
		local phys = game:GetService("PhysicsService")
		local debris = game:GetService("Debris")
		local lighting = game:GetService("Lighting")

		local upperTorso = char:FindFirstChild("UpperTorso")
		if upperTorso then r15 = true end

		local waiting = false

		local dietween;
		if not r15 then
			local newchar = players:CreateHumanoidModelFromDescription(players:GetHumanoidDescriptionFromUserId(69180633), Enum.HumanoidRigType.R15)
			--local newchar = players:CreateHumanoidModelFromDescription(players:GetHumanoidDescriptionFromUserId(owner.UserId), Enum.HumanoidRigType.R15)
			local desc = newchar:WaitForChild("Humanoid"):WaitForChild("HumanoidDescription")
			desc.BodyTypeScale, desc.DepthScale, desc.HeadScale, desc.HeightScale, desc.ProportionScale, desc.WidthScale = 0, 1, 1, 1, 1, 1
			--newchar.Name = owner.Name
			newchar.Parent = workspace
			newchar.Humanoid:ApplyDescription(desc)
			newchar.Humanoid.DisplayName = owner.Name
			newchar.PrimaryPart.CFrame = char.PrimaryPart.CFrame
			if not isNPC then
				owner.Character = newchar
				char:Destroy()
			end
			char = newchar
			char.PrimaryPart = char:FindFirstChild("HumanoidRootPart")
			local newhum = char:WaitForChild("Humanoid")
			while newhum.HipHeight ~= 2 do
				wait()
				newhum.HipHeight = 2
			end
			wait(1)
		end
		if char:FindFirstChild("Animate") then char.Animate:Destroy() end
		if char:FindFirstChild("Health") then char.Health:Destroy() end

		local animate = char:FindFirstChild("Animate")
		local hum = char:FindFirstChild("Humanoid")
		upperTorso = char:FindFirstChild("UpperTorso")
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

		local vampireIndicator = Instance.new("BoolValue")
		vampireIndicator.Name, vampireIndicator.Value, vampireIndicator.Parent = "Vampire", true, char

		local primaryScript, remote, remoteValue, playerRemote;
		remote = Instance.new("RemoteEvent")
		remote.Parent, remote.Name = script, "vampEvents"
		remoteValue = Instance.new("ObjectValue")
		remoteValue.Name, remoteValue.Value = "vampRemote", remote
		playerRemote = Instance.new("RemoteEvent")
		playerRemote.Name, playerRemote.Parent = "playerRemote", char

		local vampire = false
		local origParts, origColors, origMats, origTrans = {}, {}, {}, {}
		local rPos, lPos = 0, 0
		local face = char.Head:FindFirstChild("face")
		local origFace;
		if face then origFace = face.Texture end

		local tform = Instance.new("Sound", hrp)
		tform.SoundId = "rbxassetid://8628032099"
		tform.Volume = 1
		tform.RollOffMaxDistance = 100
		tform.Name = "Transform"

		local character = char

		local function crouch(speed)
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.9, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-44.977), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(21.715), math.rad(-37.185), math.rad(8.881))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(45.034), math.rad(-30.825), math.rad(15.986))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(32.086), math.rad(49.217), math.rad(-0.401))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(41.711), math.rad(45.665), math.rad(-13.923))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(-1.891), math.rad(7.391), math.rad(13.063))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(44.977), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(90.012), 0, 0)}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-82.506), 0, 0)}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(37.471), 0, 0)}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-127.483), 0, 0)}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig * CFrame.Angles(math.rad(-0.229), math.rad(-5.959), math.rad(-4.584))}):Play()
		end

		local function defaultPos(speed, char)
			--print(speed)
			if crouching then
				crouch(speed)
				return
			end
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			task.delay(speed, function()
				rarm.Name, rlarm.Name, rhand.Name = rarmName, rlarmName, rhandName
				larm.Name, llarm.Name, lhand.Name = larmName, llarmName, lhandName
				rleg.Name, rlleg.Name, rfoot.Name = rlegName, rllegName, rfootName
				lleg.Name, llleg.Name, lfoot.Name = llegName, lllegName, lfootName
			end)
		end


		local function infectStart(char)
			local speed = 0.067
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, 0, -0.6)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(7.506), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-0.115), math.rad(-1.948), math.rad(-7.219))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(7.448), math.rad(0.917), math.rad(-0.286))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(1.203), math.rad(-4.125), math.rad(-8.652))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(-0.115), math.rad(1.948), math.rad(7.219))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(7.448), math.rad(-0.917), math.rad(0.286))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(-1.203), math.rad(4.24), math.rad(4.125))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(7.506), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(4.985), 0, 0)}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-19.996), 0, 0)}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(6.646), 0, 0)}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-23.319), 0, 0)}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			wait(speed)
			speed = 0.133 - 0.067
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, 0, -0.9)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(15.011), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(7.391), math.rad(-1.948), math.rad(-7.219))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(10.657), math.rad(-7.964), math.rad(-1.662))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(1.719), math.rad(-8.365), math.rad(-17.246))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(7.391), math.rad(1.948), math.rad(7.219))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(11.345), math.rad(7.563), math.rad(2.12))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(-2.693), math.rad(8.365), math.rad(8.365))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(15.011), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(10.027), 0, 0)}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-39.992), 0, 0)}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig *  CFrame.Angles(math.rad(13.35), 0, 0)}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-46.639), 0, 0)}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			wait(speed)
			speed = 0.3 - 0.133
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.8, -3.1) * CFrame.Angles(math.rad(-22.517), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-59.989), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(82.621), math.rad(-24.408), math.rad(0.286))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(18.621), math.rad(-30.309), math.rad(-2.922))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(0.229), math.rad(-18.85), math.rad(-39.362))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(91.501), math.rad(30.768), math.rad(-10.199))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(20.798), math.rad(29.106), math.rad(4.297))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(-7.907), math.rad(18.105), math.rad(19.824))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(73.912), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(22.517), 0, 0)}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(30.023), 0, 0)}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-105.023), 0, 0)}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			wait(speed)
			speed = 0.367 - 0.3
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1, -3.3) * CFrame.Angles(math.rad(-37.529), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-52.483), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(54.546), math.rad(-5.157), math.rad(10.027))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(97.174), math.rad(-37.471), math.rad(-1.662))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(-19.137), math.rad(-64.343), math.rad(-15.584))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(47.326), math.rad(8.365), math.rad(-12.49))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(109.206), math.rad(46.123), math.rad(-8.422))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(-26.299), math.rad(58.27), math.rad(10.485))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-7.506), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(21.772), math.rad(13.808), math.rad(5.844))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(29.507), math.rad(-14.496), math.rad(-3.953))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-105.023), 0, 0)}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			-- Frame 5 should take 1.5 or 2 seconds, the next frames are the same as the animator's times
		end
		local function infectFinish(char)
			local infectSound = Instance.new("Sound", hrp)
			infectSound.SoundId, infectSound.Volume, infectSound.RollOffMaxDistance = "rbxassetid://8927235225", 0.5, 50
			infectSound:Play()
			local speed = 2.45
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1, -3.3) * CFrame.Angles(math.rad(-37.529), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-59.989), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.new(0, -0.033, 0.248) * CFrame.Angles(math.rad(64.802), math.rad(-10.256), math.rad(15.584))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(86.918), math.rad(-37.758), math.rad(-17.131))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(1.662), math.rad(-70.417), math.rad(2.922))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.new(0, -0.046, 0.347) * CFrame.Angles(math.rad(58.843), math.rad(8.365), math.rad(-12.49))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(87.032), math.rad(44.003), math.rad(-2.349))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.new(0.058, -0.141, -0.041) * CFrame.Angles(math.rad(-27.101), math.rad(57.067), math.rad(30.08))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-7.506), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(21.772), math.rad(13.808), math.rad(5.844))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(29.507), math.rad(-14.496), math.rad(-3.953))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-105.023), 0, 0)}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			wait(speed)
			speed = 0.1
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1, -3.3) * CFrame.Angles(math.rad(-37.529), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-63.77), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.new(0, -0.068, 0.343) * CFrame.Angles(math.rad(79.813), math.rad(-0.344), math.rad(15.814))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(75.229), math.rad(-45.034), math.rad(-13.866))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(-6.417), math.rad(-49.618), math.rad(-8.938))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.new(0, -0.049, 0.245) * CFrame.Angles(math.rad(51.566), math.rad(8.365), math.rad(-12.49))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(101.872), math.rad(45.607), math.rad(-6.303))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.new(0.1, -0.221, -0.079) * CFrame.Angles(math.rad(-27.158), math.rad(56.666), math.rad(35.638))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-15.011), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(21.772), math.rad(13.808), math.rad(5.844))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(29.507), math.rad(-14.496), math.rad(-3.953))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-105.023), 0, 0)}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			wait(speed)
			tform.Pitch = (100 + math.random(0, 15))/100
			tform:Play()
			if face then face.Texture = "rbxassetid://1111587497" end
			for _,v in pairs(character:GetDescendants()) do
				if v:IsA("BasePart") and not v.Parent:IsA("Accessory") then
					table.insert(origParts, v)
					table.insert(origColors, v.Color)
					table.insert(origMats, v.Material)
					table.insert(origTrans, v.Transparency)
					if (v.Name == "Torso" or v.Name == "UpperTorso" or v.Name == "LowerTorso") and not character:FindFirstChildWhichIsA("Shirt") and not character:FindFirstChildWhichIsA("Pants") then
					elseif (v.Name == "LeftUpperLeg" or v.Name == "LeftLowerLeg" or v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "Right Leg" or v.Name == "Left Leg") and not character:FindFirstChild("Pants") then
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
			speed = 0.1
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1, -3.3) * CFrame.Angles(math.rad(-37.529), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-44.977), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(63.598), math.rad(-10.199), math.rad(-7.678))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.new(0.195, 0.026, -0.035) * CFrame.Angles(math.rad(23.491), math.rad(-70.818), math.rad(-37.987))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(0.974), math.rad(-10.027), math.rad(-1.203))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(34.549), math.rad(32.659), math.rad(0.63))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(84.569), math.rad(31.398), math.rad(31.742))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(-27.273), math.rad(58.671), math.rad(12.834))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.new(0, 0.013, 0.099) * CFrame.Angles(math.rad(63.77), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(21.772), math.rad(13.808), math.rad(5.844))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(29.507), math.rad(-14.496), math.rad(-3.953))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-105.023), 0, 0)}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			wait(3)
			if not isNPC then playerRemote:FireClient(owner, "animFinished") end
		end
		local function infectRecover(char)
			local speed = 0.15
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1, -3) * CFrame.Angles(math.rad(-37.529), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-63.77), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(69.844), math.rad(-0.344), math.rad(15.814))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(102.445), math.rad(-45.264), math.rad(-5.443))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(-6.417), math.rad(-49.618), math.rad(-8.938))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(43.545), math.rad(8.365), math.rad(-12.49))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(127.712), math.rad(46.524), math.rad(-13.98))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(-26.7), math.rad(57.811), math.rad(18.277))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-15.011), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(40.565), math.rad(13.808), math.rad(5.844))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-115.566), math.rad(5.5), math.rad(3.896))}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig * CFrame.Angles(math.rad(10.829), math.rad(-2.807), math.rad(-0.859))}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(37.013), math.rad(-14.496), math.rad(-3.953))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-115.909), math.rad(-2.349), math.rad(-1.662))}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig * CFrame.Angles(math.rad(18.048), math.rad(4.526), math.rad(1.719))}):Play()
			wait(speed)

			if face then face.Texture = origFace end
			for i,v in pairs(origParts) do
				if v and v.Parent and not v:IsA("Decal") then
					v.Color = origColors[i]
				end
			end
			speed = 0.1
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1, -2.85) * CFrame.Angles(math.rad(-30.023), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-30.08), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(66.635), math.rad(5.329), math.rad(3.953))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(1.547), math.rad(4.354), math.rad(4.412))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(-131.265), math.rad(-73.224), math.rad(-165.069))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(86.058), math.rad(4.927), math.rad(-23.319))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(-3.094), math.rad(-2.979), math.rad(6.073))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(-52.483), math.rad(78.151), math.rad(67.781))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-15.011), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(40.565), math.rad(13.808), math.rad(5.844))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-115.566), math.rad(5.5), math.rad(3.896))}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig * CFrame.Angles(math.rad(10.829), math.rad(-2.807), math.rad(-0.859))}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(37.013), math.rad(-14.496), math.rad(-3.953))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-115.909), math.rad(-2.349), math.rad(-1.662))}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig * CFrame.Angles(math.rad(18.048), math.rad(4.526), math.rad(1.719))}):Play()
			wait(speed)
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.55, -2.7) * CFrame.Angles(math.rad(-11.23), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-11.287), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(64.687), math.rad(11.574), math.rad(-7.735))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(1.547), math.rad(4.354), math.rad(4.412))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(-19.079), math.rad(-57.353), math.rad(-11.173))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(58.843), math.rad(-0.63), math.rad(2.406))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(-3.094), math.rad(-2.979), math.rad(6.073))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(-7.792), math.rad(45.951), math.rad(-2.693))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-5.615), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(20.97), math.rad(9.969), math.rad(5.672))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-124.848), math.rad(9.683), math.rad(6.704))}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig * CFrame.Angles(math.rad(10.829), math.rad(-2.807), math.rad(-0.859))}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(20.168), math.rad(-10.657), math.rad(-4.125))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-96.2), math.rad(-3.38), math.rad(-1.146))}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig * CFrame.Angles(math.rad(13.522), math.rad(3.323), math.rad(1.432))}):Play()
			wait(speed)
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.1, -2.55) * CFrame.Angles(math.rad(7.506), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(7.448), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(31.971), math.rad(6.875), math.rad(-2.177))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(0.802), math.rad(2.177), math.rad(2.235))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(-6.532), math.rad(-28.992), math.rad(-2.005))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(29.393), math.rad(-0.63), math.rad(1.089))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(-1.604), math.rad(-1.432), math.rad(3.037))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(-3.839), math.rad(22.918), math.rad(-2.063))}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(3.724), 0, 0)}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(-31.455), math.rad(6.417), math.rad(4.125))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-66.062), math.rad(4.927), math.rad(0.516))}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig * CFrame.Angles(math.rad(5.443), math.rad(-1.375), math.rad(-0.516))}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(3.495), math.rad(-6.933), math.rad(-3.151))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-76.547), math.rad(-4.125), math.rad(-0.229))}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig * CFrame.Angles(math.rad(9.053), math.rad(2.177), math.rad(1.031))}):Play()
			wait(speed)
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, 0, -1.4) * CFrame.Angles(math.rad(15.011), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(15.986), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(24.981), 0, 0)}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(41.024), 0, 0)}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(-61.994), 0, 0)}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(-13.98), 0, 0)}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			wait(speed)
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, 0, -0.65) * CFrame.Angles(math.rad(37.013), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-19.996), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(8.995), 0, 0)}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(22.002), 0, 0)}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(-55.978), 0, 0)}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(-13.98), 0, 0)}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			wait(speed)
			if not isNPC then playerRemote:FireClient(owner, "gotUp") end
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(-19.996), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(8.995), 0, 0)}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(-13.006), 0, 0)}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(-13.98), 0, 0)}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			wait(speed)
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			wait(speed)
			waiting = false
		end
		dietween = tweenServ:Create(hum, TweenInfo.new(8), {Health = 0})
		dietween:Play()
		hum.AutoRotate = false
		hum.WalkSpeed = 0 hum.JumpPower = 0 infectStart()

		character.Humanoid.BreakJointsOnDeath = false
		character.Humanoid.Health = 100
		local newChild, charDied;
		waiting = true
		print("time's ticking..")
		local warning = Instance.new("ProximityPrompt", char)
		warning.RequiresLineOfSight, warning.MaxActivationDistance, warning.ClickablePrompt = false, 0.01, false
		warning.ObjectText, warning.ActionText, warning.KeyboardKeyCode = "You are being infected!", "Accept the script request to avoid death", Enum.KeyCode.Minus
		newChild = remote.OnServerEvent:Connect(function(player, msg)
			if player == owner and msg == "infected" then
				survived = true
				warning:Destroy()
				newChild:Disconnect()
				charDied:Disconnect()
				dietween:Pause()
				print("infected! :)")
				print(character.HumanoidRootPart.CFrame)
				if owner == origOwner then wait(1) end
				dietween:Pause()
				playerRemote:FireClient(owner, "start")
				wait(0.1)
				dietween:Pause()
				infectFinish()
				if infector then
					character.Humanoid.MaxHealth = 85
					character.Humanoid.Health = character.Humanoid.MaxHealth
					print(infector.Name)
					infector.Character.Humanoid.MaxHealth -= 79
					infector.Character.Humanoid.Health += 1
				end
				infectRecover()
				hum.AutoRotate = true
			end
		end)
		charDied = runServ.Heartbeat:Connect(function()
			local closestHum, closestHumDist = nil, math.huge
			if hum.Health > 1 then return end
			local speed, stun = 0.25, 0
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.4, 0) * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(157.449), math.rad(-75), math.rad(-0.057))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(92.475), math.rad(73.281), math.rad(64.973))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(15.011), 0, 0)}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(5.271), math.rad(-12.376), math.rad(-11.345))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-28.934), math.rad(-5.615), math.rad(3.209))}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(12.777), math.rad(12.376), math.rad(11.345))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-29.335), math.rad(3.896), math.rad(-1.891))}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			dietween:Pause()
			print(owner.Name)
			warning:Destroy()
			newChild:Disconnect()
			charDied:Disconnect()
			print("died :(")

			hum.Health = 100
			local newchar = Instance.new("Model")
			newchar.Parent = script
			for _,v in pairs(char:GetChildren()) do v.Parent = newchar end
			newchar.PrimaryPart = char.PrimaryPart
			newchar.Name = char.Name
			char:Destroy()
			char = newchar
			if not isNPC then owner:LoadCharacter() end
			wait(0.5)
			hum.WalkSpeed, hum.JumpPower, hum.AutoRotate = 16, 70, true
			hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			hum.Health = 100
			for _,v in pairs(newchar:GetDescendants()) do if v:IsA("BasePart") then v:SetNetworkOwner(nil) end end
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.4, 0) * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(157.449), math.rad(-75), math.rad(-0.057))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(92.475), math.rad(73.281), math.rad(64.973))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(15.011), 0, 0)}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(5.271), math.rad(-12.376), math.rad(-11.345))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-28.934), math.rad(-5.615), math.rad(3.209))}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(12.777), math.rad(12.376), math.rad(11.345))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-29.335), math.rad(3.896), math.rad(-1.891))}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			waiting = true
			while waiting do
				--print(waiting)
				wait(0.25)
				for _,v in pairs(workspace:GetDescendants()) do
					if v ~= hum and v:IsA("Humanoid") and v.Health > 0 and v.PlatformStand == false and v.Parent:FindFirstChildWhichIsA("BasePart") and not v.Parent:FindFirstChild("Vampire") and (v.Parent:FindFirstChildWhichIsA("BasePart").Position - hrp.Position).Magnitude < 15 then
						print("close enough!")
						waiting = false
					end
				end
			end
			vampire = true
			tform.Pitch = (100 + math.random(0, 15))/100
			tform:Play()
			if face then face.Texture = "rbxassetid://1111587497" end
			for _,v in pairs(char:GetDescendants()) do
				if v:IsA("BasePart") and not v.Parent:IsA("Accessory") then
					table.insert(origParts, v)
					table.insert(origColors, v.Color)
					table.insert(origMats, v.Material)
					table.insert(origTrans, v.Transparency)
					if (v.Name == "Torso" or v.Name == "UpperTorso" or v.Name == "LowerTorso") and not character:FindFirstChildWhichIsA("Shirt") and not character:FindFirstChildWhichIsA("Pants") then
					elseif (v.Name == "LeftUpperLeg" or v.Name == "LeftLowerLeg" or v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "Right Leg" or v.Name == "Left Leg") and not character:FindFirstChild("Pants") then
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

			task.delay(stun, function()
				local speed = 0.2
				tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.2, 0) * CFrame.Angles(math.rad(-97.517), 0, 0)}):Play()
				tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(7.506), 0, 0)}):Play()
				tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(87.376), math.rad(-58.671), math.rad(-42.915))}):Play()
				tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(1.375), math.rad(0.573), math.rad(0.516))}):Play()
				tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(108.747), math.rad(21.601), math.rad(26.127))}):Play()
				tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(12.834), math.rad(1.49), math.rad(0.057))}):Play()
				tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-8.136), math.rad(-1.891), math.rad(-0.229))}):Play()
				tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(42.8), math.rad(-12.376), math.rad(-11.345))}):Play()
				tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-57.582), math.rad(-14.095), math.rad(3.953))}):Play()
				tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
				tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(50.248), math.rad(12.376), math.rad(11.345))}):Play()
				tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-72.708), math.rad(16.501), math.rad(-1.203))}):Play()
				tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			end)
			task.delay(stun + 0.2, function()
				local speed = 0.2
				tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.2, 0) * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
				tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(6.245), 0, 0)}):Play()
				tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(93.335), math.rad(-26.929), math.rad(-28.877))}):Play()
				tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(2.75), math.rad(1.203), math.rad(0.974))}):Play()
				tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(111.097), math.rad(4.584), math.rad(9.167))}):Play()
				tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(10.657), math.rad(2.922), math.rad(0.229))}):Play()
				tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-16.272), math.rad(-3.667), math.rad(-0.745))}):Play()
				tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(51.28), math.rad(-20.97), math.rad(-25.611))}):Play()
				tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-70.818), math.rad(-17.819), math.rad(2.807))}):Play()
				tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
				tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(54.775), math.rad(12.376), math.rad(11.345))}):Play()
				tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-81.704), math.rad(18.793), math.rad(0.115))}):Play()
				tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			end)
			task.delay(stun + 0.4, function()
				local speed = 0.867 - 0.4
				tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
				tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(3.323), 0, 0)}):Play()
				tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(28.762), math.rad(-9.339), math.rad(4.412))}):Play()
				tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(5.901), math.rad(2.636), math.rad(2.063))}):Play()
				tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(31.283), math.rad(15.126), math.rad(2.636))}):Play()
				tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(5.558), math.rad(6.36), math.rad(0.745))}):Play()
				tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-7.219), math.rad(-6.532), math.rad(-2.292))}):Play()
				tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(62.223), math.rad(-46.581), math.rad(-58.9))}):Play()
				tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-103.247), math.rad(-24.809), math.rad(-3.266))}):Play()
				tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
				tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(65.26), math.rad(12.376), math.rad(11.345))}):Play()
				tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-103.476), math.rad(23.033), math.rad(4.641))}):Play()
				tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			end)
			task.delay(stun + 0.867, function()
				local speed = 0.967 - 0.867
				tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.95, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
				tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(2.693), 0, 0)}):Play()
				tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-2.807), math.rad(7.047), math.rad(-0.401))}):Play()
				tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(4.813), math.rad(2.12), math.rad(1.662))}):Play()
				tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(45.607), math.rad(11.287), math.rad(3.209))}):Play()
				tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(4.526), math.rad(5.157), math.rad(0.63))}):Play()
				tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(0, math.rad(-15.928), math.rad(-0.057))}):Play()
				tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(45.665), math.rad(-50.879), math.rad(-80.787))}):Play()
				tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-79.985), math.rad(13.235), math.rad(28.132))}):Play()
				tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
				tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(63.541), math.rad(-7.735), math.rad(4.87))}):Play()
				tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-82.964), math.rad(19.996), math.rad(0.344))}):Play()
				tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			end)
			task.delay(stun + 0.967, function()
				local speed = 1.067 - 0.967
				tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.9, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
				tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(2.063), 0, 0)}):Play()
				tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-2.005), math.rad(5.042), math.rad(-0.344))}):Play()
				tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(3.667), math.rad(1.604), math.rad(1.318))}):Play()
				tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(60.103), math.rad(4.813), math.rad(7.047))}):Play()
				tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(3.495), math.rad(3.953), math.rad(0.516))}):Play()
				tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(0, math.rad(-15.928), 0)}):Play()
				tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(131.551), math.rad(-39.992), math.rad(-0.917))}):Play()
				tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-60.848), math.rad(13.98), math.rad(20.34))}):Play()
				tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
				tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(48.759), math.rad(-6.474), math.rad(2.979))}):Play()
				tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-63.14), math.rad(15.756), math.rad(-2.521))}):Play()
				tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
			end)

		end)
		if not infector then
			print("original")
			task.delay(0.5, function()
				hum.MaxHealth = 265
				wait(0.35)
				hum.Health = 265
			end)

		end


		warn("continued")
		local stunned = false

		local escSuccess, escFail = 15, 25

		local grabCollision;
		for _, group in pairs(phys:GetCollisionGroups()) do if group.name == "grabCollision" then print("Found!") phys:RemoveCollisionGroup("grabCollision") end end
		phys:CreateCollisionGroup("grabCollision")
		phys:CollisionGroupSetCollidable("grabCollision", "Default", false)

		if script:FindFirstChild("primaryScript") then
			primaryScript = script.primaryScript:Clone()
		else
			primaryScript = NLS([[if not game:GetService("Players").LocalPlayer.Character or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") or game:GetService("Players").LocalPlayer.Character.Humanoid.Health <= 0 then print("intiated too late") return end
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

--wait(10) -- let player die

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

local Cam = game.Workspace.CurrentCamera
--Cam.FieldOfView = 90
local deadScript = false
local remote = script:WaitForChild("vampRemote").Value
local playerRemote = script.Parent:WaitForChild("playerRemote")

local ambienttracker = script:WaitForChild("AmbientTracker")
local odambienttracker = script:WaitForChild("ODAmbientTracker")
local ambienttween = tweenServ:Create(lighting, TweenInfo.new(0.5), {Ambient = Color3.fromRGB(135, 180, 137)})
local odambienttween = tweenServ:Create(lighting, TweenInfo.new(0.5), {OutdoorAmbient = Color3.fromRGB(135, 180, 137)})
local vampAmb = false
local cce, blur, dof = Instance.new("ColorCorrectionEffect", game:GetService("Lighting")), Instance.new("BlurEffect", game:GetService("Lighting")), Instance.new("DepthOfFieldEffect", lighting)
cce.Name = "zenvetierem"
blur.Name = "zenvetierem"
dof.Name = "zenvetierem"
dof.InFocusRadius = 10000
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
local walkSpeed = 14.75
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


-- Infected minion --
local fogS, fogE, fogC = lighting.FogStart, lighting.FogEnd, lighting.FogColor
print('client message')
--wait(2) -- simulate delay
remote:FireServer("infected")
playerRemote.OnClientEvent:Wait()
for _,v in pairs(Body:GetDescendants()) do
	if v:IsA("BasePart") then
		v.LocalTransparencyModifier = 0
	end
end
dof.NearIntensity, dof.InFocusRadius, dof.FocusDistance, dof.FarIntensity = 1, 2, 0.05, 0.75
lighting.FogStart, lighting.FogEnd, lighting.FogColor = 0, 20, Color3.fromRGB(0, 0, 0)
tweenServ:Create(lighting, TweenInfo.new(2.65), {FogStart = 0, FogEnd = 13}):Play()
tweenServ:Create(cce, TweenInfo.new(2.65, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TintColor = Color3.fromRGB(153, 70, 255)}):Play()
task.delay(2.65, function()
	lighting.FogColor, lighting.FogStart, lighting.FogEnd = Color3.fromRGB(128, 56, 148), 0, 20
	tweenServ:Create(lighting, TweenInfo.new(1), {FogStart = 0, FogEnd = 13, FogColor = Color3.fromRGB(0, 0, 0)}):Play()
	tweenServ:Create(cce, TweenInfo.new(1), {TintColor = Color3.fromRGB(255, 129, 129)}):Play()
end)
for _, anim in ipairs(Hum:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()) do anim:Stop() end
local headfollow, eyefollow, remoteWait, runservloop = true, false, nil, nil
local headinvis = false
Cam.CameraType = Enum.CameraType.Scriptable
remoteWait = playerRemote.OnClientEvent:Connect(function(info)
	if info == "animFinished" then
		headfollow = false
		eyefollow = true
		--if not headinvis then headinvis = true for _,v in pairs(Plr.Character:GetDescendants()) do if v == Plr.Character.Head or v.Parent:IsA("Accessory") and v:IsA("BasePart") then tweenServ:Create(v, TweenInfo.new(0.95), {Transparency = 1}):Play() end end end
	elseif info == "gotUp" then
		eyefollow = false
		remoteWait:Disconnect() runservloop:Disconnect()
	end
end)
runservloop = runServ.RenderStepped:Connect(function()
	for _,v in pairs(Body:GetDescendants()) do
		if v:IsA("BasePart") then
			v.LocalTransparencyModifier = 0
		end
	end
	if headfollow then
		Cam.CFrame = Cam.CFrame:Lerp(CFrame.new((Core.Position + Vector3.new(0, -1, 0)) + (Core.CFrame.LookVector*9), Head.Position), 0.8)
	elseif eyefollow then
		Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(Core.Position + Vector3.new(0, (Head.Position.Y - Core.Position.Y), 0) + (Core.CFrame.LookVector*9), Head.Position), 0.8)
	end
end)
while headfollow or eyefollow do wait(0.1) end
tweenServ:Create(lighting, TweenInfo.new(5), {FogStart = fogS, FogEnd = fogE, FogColor = fogC}):Play()
tweenServ:Create(cce, TweenInfo.new(5), {TintColor = Color3.fromRGB(255, 255, 255)}):Play()
tweenServ:Create(dof, TweenInfo.new(5), {NearIntensity = 0, InFocusRadius = 100, FocusDistance = 0.05, FarIntensity = 0}):Play()
for i = 0, 1, 0.1 do
	wait()
	Cam.CFrame = Cam.CFrame:Lerp(Head.CFrame, i)
end
Plr.CameraMode = Enum.CameraMode.LockFirstPerson
Cam.CameraSubject = Hum
Cam.CameraType = Enum.CameraType.Custom
wait()
Plr.CameraMode = Enum.CameraMode.Classic
for _,v in pairs(Plr.Character:GetDescendants()) do if v == Plr.Character.Head or v.Parent:IsA("Accessory") and v:IsA("BasePart") then v.Transparency = 0 end end
-- Infected Minion --

Cam.CameraSubject = Hum
for _,v in pairs(Body:GetDescendants()) do
	if v:IsA("BasePart") and v.Name ~= "Head" and not v.Parent:IsA("Accessory") then
		v.LocalTransparencyModifier = 0
	end
end
for _,v in pairs(Body:GetDescendants()) do
	if v:IsA("BasePart") and (v.Name == "Head" or v.Parent:IsA("Accessory")) then
		v.LocalTransparencyModifier = 1
	end
end
Hum.CameraOffset = (Core.CFrame:ToWorldSpace(CFrame.new(0, 1, 0.7))):pointToObjectSpace(Head.CFrame.p)
local fallen = false
local disableAmbient;
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
				odambienttween:Play()
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
		if deadScript then
			ambienttween = tweenServ:Create(lighting, TweenInfo.new(0.25), {Ambient = ambienttracker.Value})
			odambienttween = tweenServ:Create(lighting, TweenInfo.new(0.25), {OutdoorAmbient = odambienttracker.Value})
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
		if (Hum.PlatformStand == true or Hum.Sit == true) and not fallen then
			--print("pstand")
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
		--local CamCF = Cam.CoordinateFrame
		--if ((IsR6 and Body["Torso"]) or Body["UpperTorso"])~=nil and Body["Head"]~=nil then	
		--	local TrsoLV = Trso.CFrame.lookVector
		--	local HdPos = Head.CFrame.p
		--	if IsR6 and Neck or Neck and Waist then	--[Make sure the Neck still exists.]
		--		--if Cam.CameraSubject:IsDescendantOf(Body) or Cam.CameraSubject:IsDescendantOf(Plr) then
		--		--	--local Dist = nil;
		--		--	--local Diff = nil;
		--		--	--if not MseGuide then	
		--		--	--	Dist = (Head.CFrame.p-CamCF.p).magnitude
		--		--	--	Diff = Head.CFrame.Y-CamCF.Y
		--		--	--	--if not IsR6 then	
		--		--	--	--	Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang((aSin(Diff/Dist)*HeadVertFactor), -(((HdPos-CamCF.p).Unit):Cross(TrsoLV)).Y*HeadHorFactor, 0), UpdateSpeed/2)
		--		--	--	--	Waist.C0 = Waist.C0:lerp(WaistOrgnC0*Ang((aSin(Diff/Dist)*BodyVertFactor), -(((HdPos-CamCF.p).Unit):Cross(TrsoLV)).Y*BodyHorFactor, 0), UpdateSpeed/2)
		--		--	--	--else	
		--		--	--	--	Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang(-(aSin(Diff/Dist)*HeadVertFactor), 0, -(((HdPos-CamCF.p).Unit):Cross(TrsoLV)).Y*HeadHorFactor),UpdateSpeed/2)
		--		--	--	--end
		--		--	--else
		--		--	--	local Point = Mouse.Hit.p
		--		--	--	Dist = (Head.CFrame.p-Point).magnitude
		--		--	--	Diff = Head.CFrame.Y-Point.Y
		--		--	--	--if not IsR6 then
		--		--	--	--	Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang(-(aTan(Diff/Dist)*HeadVertFactor), (((HdPos-Point).Unit):Cross(TrsoLV)).Y*HeadHorFactor, 0), UpdateSpeed/2)
		--		--	--	--	Waist.C0 = Waist.C0:lerp(WaistOrgnC0*Ang(-(aTan(Diff/Dist)*BodyVertFactor), (((HdPos-Point).Unit):Cross(TrsoLV)).Y*BodyHorFactor, 0), UpdateSpeed/2)
		--		--	--	--else
		--		--	--	--	Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang((aTan(Diff/Dist)*HeadVertFactor), 0, (((HdPos-Point).Unit):Cross(TrsoLV)).Y*HeadHorFactor), UpdateSpeed/2)
		--		--	--	--end
		--		--	--end
		--		--end
		--	end
		--end
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
	if Plr.PlayerGui:FindFirstChild("VH3AbilityUI") then Plr.PlayerGui.VH3AbilityUI:Destroy() end
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
	team.Text, name.Text, cause.Text = "Vampire", Plr.Name, "Died"
	team.TextScaled, name.TextScaled, cause.TextScaled = true, true, true
	team.Size, name.Size, cause.Size = UDim2.new(0.073, 0, 0.061, 0), UDim2.new(0.15, 0, 0.052, 0), UDim2.new(0.05, 0, 0.05, 0)
	team.Position, name.Position, cause.Position = UDim2.new(-1.188, 0, 0.42, 0), UDim2.new(-1.111, 0, 0.481, 0), UDim2.new(-1.211, 0, 0.533, 0)
	team.TextColor3, name.TextColor3, cause.TextColor3 = Color3.fromRGB(155, 50, 255), Color3.fromRGB(194, 38, 255), Color3.fromRGB(255, 255, 255)
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
		ColorSequenceKeypoint.new(0, Color3.fromRGB(155, 50, 255)),
		ColorSequenceKeypoint.new(0.644, Color3.fromRGB(194, 38, 255)),
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
local abilities, primaryBar, secondaryBar, main, prim, sec

local function loadGui()
	local CircleProgressGui = Instance.new("ScreenGui")
	CircleProgressGui.Name = "CircleProgressGui"

	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.AnchorPoint = Vector2.new(1, 1)
	Main.Size = UDim2.new(0, 152, 0, 148)
	Main.BackgroundTransparency = 1
	Main.Position = UDim2.new(0.539, 0, 1.015, 0)
	Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Main.Parent = CircleProgressGui

	local Stamina = Instance.new("Frame")
	Stamina.Name = "Stamina"
	Stamina.AnchorPoint = Vector2.new(1, 1)
	Stamina.ZIndex = 0
	Stamina.Size = UDim2.new(0, 160, 0, 122)
	Stamina.BackgroundTransparency = 1
	Stamina.Position = UDim2.new(0.905, 0, 0.9, 0)
	Stamina.BorderSizePixel = 0
	Stamina.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Stamina.Parent = Main

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
	LeftBG.Parent = Stamina

	local LeftFrame = Instance.new("Frame")
	LeftFrame.Name = "LeftFrame"
	LeftFrame.ZIndex = 2
	LeftFrame.Size = UDim2.new(2, 0, 1, 0)
	LeftFrame.BackgroundTransparency = 1
	LeftFrame.BorderSizePixel = 0
	LeftFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftFrame.Parent = LeftBG

	local LeftBG1 = Instance.new("ImageLabel")
	LeftBG1.Name = "LeftBG"
	LeftBG1.ZIndex = 3
	LeftBG1.Size = UDim2.new(0.5, 0, 1, 0)
	LeftBG1.BackgroundTransparency = 1
	LeftBG1.BorderSizePixel = 0
	LeftBG1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftBG1.ImageColor3 = Color3.fromRGB(189, 255, 194)
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
	RightBG.Parent = Stamina

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
	RightBG1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightBG1.ImageColor3 = Color3.fromRGB(189, 255, 194)
	RightBG1.ImageRectOffset = Vector2.new(500, 0)
	RightBG1.ImageRectSize = Vector2.new(1000, 2000)
	RightBG1.Image = "rbxassetid://7036407423"
	RightBG1.Parent = RightFrame

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.Parent = Stamina

	local Health = Instance.new("Frame")
	Health.Name = "Health"
	Health.AnchorPoint = Vector2.new(1, 1)
	Health.Size = UDim2.new(0, 145, 0, 105)
	Health.BackgroundTransparency = 1
	Health.Position = UDim2.new(0.85, 0, 0.85, 0)
	Health.BorderSizePixel = 0
	Health.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Health.Parent = Main

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
	LeftBG2.Parent = Health

	local LeftFrame1 = Instance.new("Frame")
	LeftFrame1.Name = "LeftFrame"
	LeftFrame1.ZIndex = 2
	LeftFrame1.Size = UDim2.new(2, 0, 1, 0)
	LeftFrame1.BackgroundTransparency = 1
	LeftFrame1.BorderSizePixel = 0
	LeftFrame1.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	LeftFrame1.Parent = LeftBG2

	local LeftBG3 = Instance.new("ImageLabel")
	LeftBG3.Name = "LeftBG"
	LeftBG3.ZIndex = 3
	LeftBG3.Size = UDim2.new(0.5, 0, 1, 0)
	LeftBG3.BackgroundTransparency = 1
	LeftBG3.BorderSizePixel = 0
	LeftBG3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
	RightBG2.Parent = Health

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
	RightBG3.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
	RightBG3.ImageRectOffset = Vector2.new(500, 0)
	RightBG3.ImageRectSize = Vector2.new(1000, 2000)
	RightBG3.Image = "rbxassetid://7036407423"
	RightBG3.Parent = RightFrame1

	local UIAspectRatioConstraint1 = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint1.Parent = Health

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
	Label.Size = UDim2.new(0.75, 0, 0.5, 0)
	Label.BorderColor3 = Color3.fromRGB(255, 255, 255)
	Label.BackgroundTransparency = 1
	Label.Position = UDim2.new(0.135, 0, 0.25, 0)
	Label.BorderSizePixel = 2
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label.FontSize = Enum.FontSize.Size36
	Label.TextStrokeTransparency = 0
	Label.TextSize = 35
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.Text = "140"
	Label.TextWrap = true
	Label.Font = Enum.Font.Arcade
	Label.TextWrapped = true
	Label.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	Label.Parent = Inner

	local vampireActivated = Instance.new("TextLabel")
	vampireActivated.Name = "vampireActivated"
	vampireActivated.AnchorPoint = Vector2.new(1, 1)
	vampireActivated.Size = UDim2.new(0, 275, 0, 25)
	vampireActivated.BackgroundTransparency = 1
	vampireActivated.Position = UDim2.new(1.3976539, 0, 0.0094314, 0)
	vampireActivated.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	vampireActivated.FontSize = Enum.FontSize.Size14
	vampireActivated.TextSize = 14
	vampireActivated.TextColor3 = Color3.fromRGB(225, 0, 0)
	vampireActivated.Text = "VAMPIRE MODE ACTIVATED"
	vampireActivated.TextWrap = true
	vampireActivated.Font = Enum.Font.SciFi
	vampireActivated.TextWrapped = true
	vampireActivated.TextScaled = true
	vampireActivated.Parent = Main
	vampireActivated.Visible = false

	local transformHint = Instance.new("TextLabel")
	transformHint.Name = "transformHint"
	transformHint.AnchorPoint = Vector2.new(1, 1)
	transformHint.Size = UDim2.new(0, 35, 0, 33)
	transformHint.Position = UDim2.new(-0.406, 0, 0.6665135, 0)
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
	transformHint.Parent = Main

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

	local GrabUI = Instance.new("Frame")
	GrabUI.Name = "GrabUI"
	GrabUI.AnchorPoint = Vector2.new(1, 1)
	GrabUI.Size = UDim2.new(0, 355, 0, 87)
	GrabUI.BackgroundTransparency = 1
	GrabUI.Position = UDim2.new(1.6955162, 0, -0.2345001, 0)
	GrabUI.BorderSizePixel = 0
	GrabUI.BackgroundColor3 = Color3.fromRGB(44, 255, 139)
	GrabUI.Parent = Main
	GrabUI.Visible = false

	local MaxHP = Instance.new("Frame")
	MaxHP.Name = "MaxHP"
	MaxHP.Size = UDim2.new(0.6, 0, 0.085, 0)
	MaxHP.BorderColor3 = Color3.fromRGB(27, 42, 53)
	MaxHP.Position = UDim2.new(0.1989961, 0, 0.0831123, 0)
	MaxHP.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
	MaxHP.BorderSizePixel = 2
	MaxHP.Parent = GrabUI

	local HP = Instance.new("Frame")
	HP.Name = "HP"
	HP.Selectable = true
	HP.Size = UDim2.new(0.65, 0, 1, 0)
	HP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HP.Parent = MaxHP

	local Status = Instance.new("TextLabel")
	Status.Name = "Status"
	Status.Size = UDim2.new(1, 0, 0.3234071, 0)
	Status.BackgroundTransparency = 1
	Status.Position = UDim2.new(0, 0, 0.178, 0)
	Status.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Status.FontSize = Enum.FontSize.Size28
	Status.TextSize = 25
	Status.TextColor3 = Color3.fromRGB(252, 70, 70)
	Status.Text = "HOLD CLICK TO DRAIN ENERGY"
	Status.TextWrap = true
	Status.Font = Enum.Font.SciFi
	Status.TextWrapped = true
	Status.Parent = GrabUI

	local Player = Instance.new("TextLabel")
	Player.Name = "Player"
	Player.Size = UDim2.new(1, 0, 0.3234071, 0)
	Player.BackgroundTransparency = 1
	Player.Position = UDim2.new(-0.0028169, 0, 0.4883448, 0)
	Player.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Player.FontSize = Enum.FontSize.Size32
	Player.TextSize = 30
	Player.TextColor3 = Color3.fromRGB(252, 106, 140)
	Player.Text = "YOU GRABBED PLAYER1"
	Player.TextWrap = true
	Player.Font = Enum.Font.SciFi
	Player.TextWrapped = true
	Player.Parent = GrabUI

	return CircleProgressGui, vampireActivated, GrabUI
end
local function abilityGui()
	if abilities then abilities:Destroy() end
	local AbilityUI = Instance.new("ScreenGui")
	AbilityUI.Name = "VH3AbilityUI"
	AbilityUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local Frame = Instance.new("Frame")
	Frame.AnchorPoint = Vector2.new(1, 1)
	Frame.Size = UDim2.new(0, 365, 0, 255)
	Frame.BackgroundTransparency = 1
	Frame.Position = UDim2.new(1, 0, 1, 0)
	Frame.BackgroundColor3 = Color3.fromRGB(188, 71, 255)
	Frame.Parent = AbilityUI

	local AbilityDisplay = Instance.new("Frame")
	AbilityDisplay.Name = "AbilityDisplay"
	AbilityDisplay.Size = UDim2.new(1, 0, 0.3223775, 0)
	AbilityDisplay.BackgroundTransparency = 1
	AbilityDisplay.Position = UDim2.new(0, 0, 0.6679819, 0)
	AbilityDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AbilityDisplay.Parent = Frame

	local Rim = Instance.new("Frame")
	Rim.Name = "Rim"
	Rim.Size = UDim2.new(0.23, 0, 0.95, 0)
	Rim.Position = UDim2.new(0.76, 0, 0, 0)
	Rim.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Rim.Parent = AbilityDisplay

	local Inner = Instance.new("Frame")
	Inner.Name = "Inner"
	Inner.BorderMode = Enum.BorderMode.Inset
	Inner.Size = UDim2.new(0.95, 0, 0.95, 0)
	Inner.Position = UDim2.new(0.025, 0, 0.025, 0)
	Inner.BackgroundColor3 = Color3.fromRGB(193, 193, 255)
	Inner.Parent = Rim

	local Image = Instance.new("ImageLabel")
	Image.Name = "Image"
	Image.Size = UDim2.new(1, 0, 1, 0)
	Image.BackgroundTransparency = 1
	Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image.Image = "http://www.roblox.com/asset/?id=169044465"
	Image.Parent = Inner

	local AbilityName = Instance.new("TextLabel")
	AbilityName.Name = "AbilityName"
	AbilityName.Size = UDim2.new(0, 200, 0, 50)
	AbilityName.BackgroundTransparency = 1
	AbilityName.Position = UDim2.new(0.118, 0,0.163, 0)
	AbilityName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AbilityName.FontSize = Enum.FontSize.Size36
	AbilityName.TextStrokeTransparency = 0
	AbilityName.TextXAlignment = Enum.TextXAlignment.Right
	AbilityName.TextSize = 45
	AbilityName.TextColor3 = Color3.fromRGB(59, 67, 88)
	AbilityName.Text = "CLOAK"
	AbilityName.Font = Enum.Font.PermanentMarker
	AbilityName.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	AbilityName.Parent = AbilityDisplay

	local Secondary = Instance.new("Frame")
	Secondary.Name = "Secondary"
	Secondary.Size = UDim2.new(1, 0, 0.2769953, 0)
	Secondary.BackgroundTransparency = 1
	Secondary.Position = UDim2.new(0, 0, 0.3640923, 0)
	Secondary.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Secondary.Parent = Frame

	local chargeBar = Instance.new("Frame")
	chargeBar.Name = "chargeBar"
	chargeBar.Size = UDim2.new(0, 215, 0, 5)
	chargeBar.BorderColor3 = Color3.fromRGB(53, 43, 35)
	chargeBar.Position = UDim2.new(0.12, 0, 0.5, 0)
	chargeBar.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
	chargeBar.Parent = Secondary

	local charge = Instance.new("Frame")
	charge.Name = "charge"
	charge.Selectable = true
	charge.Size = UDim2.new(0.75, 0, 1, 0)
	charge.Position = UDim2.new(0.25, 0, 0, 0)
	charge.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	charge.Parent = chargeBar

	local Rclick = Instance.new("ImageLabel")
	Rclick.Name = "Rclick"
	Rclick.Size = UDim2.new(0, 35, 0, 35)
	Rclick.BackgroundTransparency = 1
	Rclick.Position = UDim2.new(0.013, 0, 0.286, 0)
	Rclick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Rclick.Image = "rbxassetid://7049040343"
	Rclick.Parent = Secondary

	local secondaryName = Instance.new("TextLabel")
	secondaryName.Name = "secondaryName"
	secondaryName.Size = UDim2.new(0.561, 0, 0.25, 0)
	secondaryName.BackgroundTransparency = 1
	secondaryName.Position = UDim2.new(0.1464706, 0, 0.5650546, 0)
	secondaryName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	secondaryName.FontSize = Enum.FontSize.Size14
	secondaryName.TextStrokeTransparency = 0
	secondaryName.TextSize = 14
	secondaryName.TextColor3 = Color3.fromRGB(149, 137, 137)
	secondaryName.Text = "Disappear"
	secondaryName.TextWrap = true
	secondaryName.Font = Enum.Font.Arcade
	secondaryName.TextWrapped = true
	secondaryName.TextXAlignment = Enum.TextXAlignment.Right
	secondaryName.TextStrokeColor3 = Color3.fromRGB(91, 5, 6)
	secondaryName.TextScaled = true
	secondaryName.Parent = Secondary

	local secondaryImage = Instance.new("ImageLabel")
	secondaryImage.Name = "secondaryImage"
	secondaryImage.BorderMode = Enum.BorderMode.Inset
	secondaryImage.Size = UDim2.new(0, 75, 1, 0)
	secondaryImage.BorderColor3 = Color3.fromRGB(255, 255, 255)
	secondaryImage.BackgroundTransparency = 0.35
	secondaryImage.Position = UDim2.new(0.7945205, 0, 0.0283151, 0)
	secondaryImage.BorderSizePixel = 2
	secondaryImage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	secondaryImage.Image = "rbxassetid://0"
	secondaryImage.Parent = Secondary

	local Primary = Instance.new("Frame")
	Primary.Name = "Primary"
	Primary.Size = UDim2.new(1, 0, 0.2769953, 0)
	Primary.BackgroundTransparency = 1
	Primary.Position = UDim2.new(0, 0, 0.0425237, 0)
	Primary.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Primary.Parent = Frame

	local Rbutton = Instance.new("ImageLabel")
	Rbutton.Name = "Rbutton"
	Rbutton.Size = UDim2.new(0, 30, 0, 30)
	Rbutton.BackgroundTransparency = 1
	Rbutton.Position = UDim2.new(0.02, 0, 0.314, 0)
	Rbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Rbutton.Image = "rbxassetid://4893250303"
	Rbutton.Parent = Primary

	local TextLabel = Instance.new("TextLabel")
	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Position = UDim2.new(0, 0, 1.e-07, 0)
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.FontSize = Enum.FontSize.Size28
	TextLabel.TextSize = 25
	TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.Text = "R"
	TextLabel.TextWrap = true
	TextLabel.Font = Enum.Font.SciFi
	TextLabel.TextWrapped = true
	TextLabel.Parent = Rbutton

	local primaryName = Instance.new("TextLabel")
	primaryName.Name = "primaryName"
	primaryName.Size = UDim2.new(0.561, 0, 0.25, 0)
	primaryName.BackgroundTransparency = 1
	primaryName.Position = UDim2.new(0.1464706, 0, 0.5650546, 0)
	primaryName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	primaryName.FontSize = Enum.FontSize.Size14
	primaryName.TextStrokeTransparency = 0
	primaryName.TextSize = 14
	primaryName.TextColor3 = Color3.fromRGB(149, 137, 137)
	primaryName.Text = "Phantom Abduction"
	primaryName.TextWrap = true
	primaryName.Font = Enum.Font.Arcade
	primaryName.TextWrapped = true
	primaryName.TextXAlignment = Enum.TextXAlignment.Right
	primaryName.TextStrokeColor3 = Color3.fromRGB(91, 5, 6)
	primaryName.TextScaled = true
	primaryName.Parent = Primary

	local chargeBar1 = Instance.new("Frame")
	chargeBar1.Name = "chargeBar"
	chargeBar1.Size = UDim2.new(0, 215, 0, 5)
	chargeBar1.BorderColor3 = Color3.fromRGB(53, 43, 35)
	chargeBar1.Position = UDim2.new(0.12, 0, 0.5, 0)
	chargeBar1.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
	chargeBar1.Parent = Primary

	local charge1 = Instance.new("Frame")
	charge1.Name = "charge"
	charge1.Selectable = true
	charge1.Size = UDim2.new(0.75, 0, 1, 0)
	charge1.Position = UDim2.new(0.25, 0, 0, 0)
	charge1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	charge1.Parent = chargeBar1

	local primaryImage = Instance.new("ImageLabel")
	primaryImage.Name = "primaryImage"
	primaryImage.BorderMode = Enum.BorderMode.Inset
	primaryImage.Size = UDim2.new(0, 75, 1, 0)
	primaryImage.BorderColor3 = Color3.fromRGB(255, 255, 255)
	primaryImage.BackgroundTransparency = 0.35
	primaryImage.Position = UDim2.new(0.7945205, 0, 0.0283151, 0)
	primaryImage.BorderSizePixel = 2
	primaryImage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	primaryImage.Image = "rbxassetid://0"
	primaryImage.Parent = Primary

	AbilityUI.Parent = game:GetService("StarterGui")
	return AbilityUI, chargeBar1, chargeBar, AbilityDisplay, Primary, Secondary
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

screen, vampActivatedGUI, grabUI = loadGui()
screen.Parent = Plr.PlayerGui
staminaL, staminaR = screen.Main.Stamina.LeftBG.LeftFrame, screen.Main.Stamina.RightBG.RightFrame
healthL, healthR = screen.Main.Health.LeftBG.LeftFrame, screen.Main.Health.RightBG.RightFrame
barL, barR = screen.Main.Stamina.LeftBG.LeftFrame:WaitForChild("LeftBG"), screen.Main.Stamina.RightBG.RightFrame:WaitForChild("RightBG")

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

	screen.Main.Health.Inner.Label.Text = math.floor(Hum.Health)
end
Hum.Changed:Connect(updateGui)

--- Movement ---
local sitDuration = 0
local sitting = false
local crouchcheck = runServ.Heartbeat:Connect(function()
	if Hum.MoveDirection.Magnitude == 0 and crouching then 
		sitDuration = sitDuration + 1/60
	else
		sitDuration = 0
	end
	if sitDuration >= 7 and not sitting then
		sitting = true
		remote:FireServer("sit")
	elseif sitDuration < 7 and sitting then
		sitting = false
		remote:FireServer("crouch")
	end
end)
local function crouch()
	if not crouching then
		crouching = true
		for _, anim in ipairs(Hum:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()) do anim:Stop() end
		--print("Crouch - Client")
		remote:FireServer("crouch")
	else
		crouching = false
		--print("unrouch - Client")
		remote:FireServer("uncrouch")
	end
end

Hum.StateChanged:Connect(function(old, new)
	if new == Enum.HumanoidStateType.Landed and old == Enum.HumanoidStateType.Freefall then
		local value = 55 - (math.pow(math.abs(Core.Velocity.Y) - 55, 1.25))
		--print("falling -".. Core.Velocity.Y.. "- (".. value.." damage)")
		if value < 0 then
			remote:FireServer("fall", nil, 55 - (math.pow(math.abs(Core.Velocity.Y) - 55, 1.25)))
			if value < -35 then
				crouching = true
				for _, anim in ipairs(Hum:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()) do anim:Stop() end
				sprinting = false
				stunned = true
				wait()
				Hum.WalkSpeed = 0
				wait(1.35 + math.abs(value/100))
				crouching = false
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
				--print("Exhausted")
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
				--("Exhausted")
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

local function raycheck(ray, range)
	if not ray then
		ray = workspace:Raycast(Core.Position + Core.CFrame.LookVector*1, Cam.CFrame.LookVector*range)
	end
	if not ray then return end
	local part = ray.Instance
	local parent = part.Parent
	while not parent == workspace and not parent == game and not parent:FindFirstChildWhichIsA("Humanoid") do
		parent = parent.Parent
	end
	print(parent)
	return parent, part
end

local primary, secondary, endPrimary, endSecondary;
local primaryCD, secondaryCD = false, false

victim = false
local lastVictim;
local params = RaycastParams.new()
params.FilterDescendantsInstances = {Body}
params.FilterType = Enum.RaycastFilterType.Blacklist
local function grab()
	local grabchar, part = raycheck(nil, 6.5)
	if not grabchar or not grabchar:FindFirstChildWhichIsA("Humanoid") or not grabchar:FindFirstChild("uniquegrabid") or grabchar == Body then return end
	sprinting = false
	victim = grabchar
	if victim == Body then return end
	if not victim:FindFirstChildWhichIsA("Humanoid") then victim = victim.Parent end
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
	grabUI.Visible = true
	grabUI.Player.Text, grabUI.Status.Text = ("YOU GRABBED ".. string.upper(victim.Name)), ("HOLD CLICK TO DRAIN ENERGY")
	grabUI.MaxHP.HP.Size = UDim2.new(victim.Humanoid.Health/victim.Humanoid.MaxHealth, 0, 1, 0)

	local follow, healthTrack;
	healthTrack = victim.Humanoid.HealthChanged:Connect(function()
		--print("HealthChanged")
		grabUI.MaxHP.HP.Size = UDim2.new(victim.Humanoid.Health/victim.Humanoid.MaxHealth, 0, 1, 0)
	end)
	follow = coroutine.wrap(function()
		while victim do
			if victim == Body then victim = nil break end
			runServ.Heartbeat:Wait()
			part.Parent.PrimaryPart.Velocity = Core.Velocity
			if not biting then
				part.Parent.PrimaryPart.CFrame = upperTorso.CFrame*CFrame.new(0.5, 0, -1.25)*CFrame.Angles(0, 0, math.rad(-15))
			else
				part.Parent.PrimaryPart.CFrame = upperTorso.CFrame*CFrame.new(0.5, 0.2, -1)*CFrame.Angles(math.rad(17.991), 0, math.rad(-15))
			end
		end
		healthTrack:Disconnect()
		grabUI.Visible = false
	end)
	follow()
end

local function bite()
	if victim and biting then grabUI.Status.Text = "DRAINING ENERGY..." end
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
	grabUI.Status.Text = "HOLD CLICK TO DRAIN ENERGY"
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
			wait(0.35)
			grabCD = false
		elseif victim and not biting then
			sprinting = false
			Hum.WalkSpeed = bitingSpeed
			Hum.JumpPower = 0
			--print("biting")
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
			--print("Transformed")
			remote:FireServer("transform")
			pbar:Destroy()
			if not vampire then
				vampActivatedGUI.Visible = true
				vampire = true
				if sprinting then Hum.WalkSpeed = vampSprint else Hum.WalkSpeed = vampWalk end
				if not sprintDisabled then Hum.JumpPower = vampJump end
			else
				vampActivatedGUI.Visible = false
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
			--print("Cancelled")
			pbar:Destroy()
		end
	end
end)

input.InputEnded:Connect(function(obj, gameProcessed)
	if obj.KeyCode == Enum.KeyCode.LeftShift and sprinting then
		sprinting = false
	elseif not gameProcessed and obj.KeyCode == Enum.KeyCode.R then
		--print("yomam")
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
	--warn("event")
	if action == "escaped" and victim then
		--warn("escaped!")
		--remote:FireServer("stopdraining")
		--print("release")
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
print("Transform - V")
print("Crouch - C")
print("Sprint - Shift")
print("(while transformed) Grab - Left Click || Drain - Hold Left Click")
print("untransform while grabbing a player to let go")

local infectcheck = Plr.Chatted:Connect(function() end);

local primCharge, secCharge, primEnabled, secEnabled = 100, 100, false, false
local primDrainRate, secDrainRate = 0, 0
local cooldownConnection;

local releaseP, releaseS = false, false

local function cooldowns(primRate, primCap, primDisable, primEnable, secRate, secCap, secDisable, secEnable)
	if cooldownConnection then cooldownConnection:Disconnect() end
	cooldownConnection = runServ.Heartbeat:Connect(function()
		if deadScript then cooldownConnection:Disconnect() return end
		if primCharge >= primEnable then
			primEnabled = true
		elseif primCharge <= primDisable then
			primEnabled = false
			--warn("Disable")
			if usingP and releaseP then
				warn("Cancelling")
				usingP = false endPrimary()
			end
		end
		if secCharge >= secEnable then
			secEnabled = true
		elseif secCharge <= secDisable then
			secEnabled = false
			--warn("Disable")
			if usingS and releaseS then
				warn("Cancelling")
				usingS = false endSecondary()
			end
		end

		if primCharge < primCap and primDrainRate <= 0 then 
			primCharge += primRate
		elseif primDrainRate > 0 then
			primCharge -= primDrainRate
		end
		if secCharge < secCap and secDrainRate <= 0 then
			secCharge += secRate
		elseif secDrainRate > 0 then
			secCharge -= secDrainRate
		end
		if primEnabled then primaryBar.charge.BackgroundColor3 = Color3.fromRGB(255, 255, 255) else primaryBar.charge.BackgroundColor3 = Color3.fromRGB(150, 150, 150) end
		if secEnabled then secondaryBar.charge.BackgroundColor3 = Color3.fromRGB(255, 255, 255) else secondaryBar.charge.BackgroundColor3 = Color3.fromRGB(150, 150, 150) end
		secondaryBar.charge.Position, secondaryBar.charge.Size = UDim2.new(1 - secCharge/100, 0, 0, 0), UDim2.new(secCharge/100, 0, 1, 0)
		primaryBar.charge.Position, primaryBar.charge.Size = UDim2.new(1 - primCharge/100, 0, 0, 0), UDim2.new(primCharge/100, 0, 1, 0)
	end)
end

local function cloak()
	if infectcheck.Connected then infectcheck:Disconnect() end
	releaseP, releaseS = false, true
	-- GUI --
	local name, primaryName, secondaryName = string.upper("Cloak"), "Phantom Abduct", "Disappear"
	abilities, primaryBar, secondaryBar, main, prim, sec = abilityGui()
	abilities.Parent = Plr.PlayerGui
	main.AbilityName.Text, prim.primaryName.Text, sec.secondaryName.Text = name, primaryName, secondaryName
	main.Rim.Inner.Image.Image, main.AbilityName.TextColor3, main.AbilityName.TextStrokeColor3 = "rbxassetid://169044465", Color3.fromRGB(59, 67, 88), Color3.fromRGB(255, 255, 255)
	prim.primaryImage.Image, prim.primaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(255, 255, 255)
	prim.primaryName.TextColor3, prim.primaryName.TextStrokeColor3 = Color3.fromRGB(149, 137, 137), Color3.fromRGB(175, 28, 28)
	sec.secondaryImage.Image, sec.secondaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(255, 255, 255)
	sec.secondaryName.TextColor3, sec.secondaryName.TextStrokeColor3 = Color3.fromRGB(149, 137, 137), Color3.fromRGB(175, 28, 28)
	-- GUI --
	primCharge, secCharge = 100, 100
	primEnabled, secEnabled = false, false
	cooldowns(0.03703703703, 100, 0, 100, 0.03703703703, 100, 0, 33.3333)
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
		if victim and primEnabled then
			primCharge = 0
			primEnabled = false
			remote:FireServer("primary", Core.Position, pos)
			Core.CFrame = CFrame.new(pos)
		end
	end
	function secondary()
		if not vampire or victim or not secEnabled then return end
		usingS = true
		ability = true
		abilityLock = true
		remote:FireServer("secondary")
		tweenServ:Create(cloakCCE, TweenInfo.new(0.5), {Saturation = -1, TintColor = Color3.fromRGB(210, 255, 230)}):Play()
		secDrainRate = 0.11111111111
		wait(0.75)
		abilityLock = false
	end
	function endPrimary()
	end
	function endSecondary()
		usingS = false
		while abilityLock do wait(0.1) end
		secDrainRate = 0
		remote:FireServer("releaseSecondary")
		ability = false
		tweenServ:Create(cloakCCE, TweenInfo.new(0.25), {Saturation = 0, TintColor = Color3.fromRGB(255, 255, 255)}):Play()
	end
	local markgenerator;
	markgenerator = coroutine.wrap(function()
		while abilities.Parent do
			generatemark()
			wait(5)
		end
	end)
	markgenerator()
end
local function blackout()
	if infectcheck.Connected then infectcheck:Disconnect() end
	releaseP, releaseS = false, true
	-- GUI --
	local name, primaryName, secondaryName = string.upper("Blackout"), "Power Surge", "Energy Drain"
	abilities, primaryBar, secondaryBar, main, prim, sec = abilityGui()
	abilities.Parent = Plr.PlayerGui
	main.AbilityName.Text, prim.primaryName.Text, sec.secondaryName.Text = name, primaryName, secondaryName
	main.Rim.Inner.Image.Image, main.Rim.Inner.BackgroundColor3, main.AbilityName.TextColor3, main.AbilityName.TextStrokeColor3 = "rbxassetid://589079979", Color3.fromRGB(248, 255, 167), Color3.fromRGB(47, 34, 181), Color3.fromRGB(155, 207, 255)
	prim.primaryImage.Image, prim.primaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(255, 255, 255)
	prim.primaryName.TextColor3, prim.primaryName.TextStrokeColor3 = Color3.fromRGB(76, 39, 149), Color3.fromRGB(175, 28, 28)
	sec.secondaryImage.Image, sec.secondaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(255, 255, 255)
	sec.secondaryName.TextColor3, sec.secondaryName.TextStrokeColor3 = Color3.fromRGB(76, 39, 149), Color3.fromRGB(175, 28, 28)
	-- GUI --
	primCharge, secCharge = 95, 0
	primEnabled, secEnabled = false, false
	--cooldowns(0.012345678901, 100, 0, 100, 0.03703703703, 100, 0, 33.3333)
	cooldowns(0.012345678901, 100, 0, 100, 0, 100, 0, 33.3333)
	print("Power surge - R")
	local chargeSFX = Instance.new("Sound", Head)
	chargeSFX.SoundId = "rbxassetid://8606994267"
	function primary()
		if not primEnabled then return end
		local blackoutcce = Instance.new("ColorCorrectionEffect", lighting)
		tweenServ:Create(blackoutcce, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Contrast = 0.5}):Play()
		--print("primary - Client")
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
		if progress < 3 then return else  primCharge, primEnabled = 0, false end
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
	if infectcheck.Connected then infectcheck:Disconnect() end
	releaseP, releaseS = false, false
	-- GUI --
	local name, primaryName, secondaryName = string.upper("Decoy"), "Clone Decoy", "Disguise"
	abilities, primaryBar, secondaryBar, main, prim, sec = abilityGui()
	abilities.Parent = Plr.PlayerGui
	main.AbilityName.Text, prim.primaryName.Text, sec.secondaryName.Text = name, primaryName, secondaryName
	main.Rim.Inner.Image.Image, main.Rim.Inner.BackgroundColor3, main.AbilityName.TextColor3, main.AbilityName.TextStrokeColor3 = "rbxassetid://434340147", Color3.fromRGB(251, 190, 255), Color3.fromRGB(255, 232, 193), Color3.fromRGB(190, 161, 206)
	prim.primaryImage.Image, prim.primaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(251, 190, 255)
	prim.primaryName.TextColor3, prim.primaryName.TextStrokeColor3 = Color3.fromRGB(255, 232, 193), Color3.fromRGB(175, 28, 28)
	sec.secondaryImage.Image, sec.secondaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(251, 190, 255)
	sec.secondaryName.TextColor3, sec.secondaryName.TextStrokeColor3 = Color3.fromRGB(255, 232, 193), Color3.fromRGB(175, 28, 28)
	-- GUI --
	primCharge, secCharge = 0, 85
	primEnabled, secEnabled = false, false
	--cooldowns(0.03703703703, 100, 0, 100, 0.03703703703, 100, 0, 100)
	cooldowns(0, 100, 0, 100, 0.03703703703, 100, 0, 100)
	print("Disguise - Right Click")
	print("Use on a character to disguise them as a vampire")
	print("Use on a player corpse to disguise as them")
	function primary()
	end
	function endPrimary()
	end
	function secondary()
		local disguiseVictim, part;
		if not secEnabled then return end
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
			secCharge, secEnabled = 0, false
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
			secCharge, secEnabled = 0, false

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
	if infectcheck.Connected then infectcheck:Disconnect() end
	releaseP, releaseS = true, true
	-- GUI --
	local name, primaryName, secondaryName = string.upper("Wildfire"), "Flame Punch", "Fire Cast"
	abilities, primaryBar, secondaryBar, main, prim, sec = abilityGui()
	abilities.Parent = Plr.PlayerGui
	main.AbilityName.Text, prim.primaryName.Text, sec.secondaryName.Text = name, primaryName, secondaryName
	main.Rim.Inner.Image.Image, main.AbilityName.TextColor3, main.AbilityName.TextStrokeColor3 = "rbxassetid://7501052126", Color3.fromRGB(255, 126, 20), Color3.fromRGB(125, 27, 18)
	prim.primaryImage.Image, prim.primaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(255, 133, 33)
	prim.primaryName.TextColor3, prim.primaryName.TextStrokeColor3 = Color3.fromRGB(255, 147, 24), Color3.fromRGB(175, 28, 28)
	sec.secondaryImage.Image, sec.secondaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(255, 133, 33)
	sec.secondaryName.TextColor3, sec.secondaryName.TextStrokeColor3 = Color3.fromRGB(255, 147, 24), Color3.fromRGB(175, 28, 28)
	-- GUI --
	primCharge, secCharge = 85, 0
	primEnabled, secEnabled = false, false
	--cooldowns(0.02564102564, 100, 0, 100, 0.03703703703, 100, 0, 33.3333)
	cooldowns(0.02564102564, 100, 0, 100, 0, 100, 0, 33.3333)
	print("Flame Punch - R")
	function primary()
		if usingP or primDrainRate > 0 or not primEnabled then return end
		local punchdb = false
		usingP = true
		grabCD = true
		remote:FireServer("primary")
		local fcc = Instance.new("ColorCorrectionEffect", lighting)
		fcc.Name = "zenvetierem"
		fcc.Brightness, fcc.Contrast, fcc.Saturation, fcc.TintColor = 0, 0, 0, Color3.fromRGB(255, 255, 255)
		tweenServ:Create(fcc, TweenInfo.new(0.25), {Brightness = 0.9}):Play()
		task.delay(0.25, function() tweenServ:Create(fcc, TweenInfo.new(0.45), {Brightness = 0, Contrast = 0.2, TintColor = Color3.fromRGB(255, 180, 80)}):Play() end)
		wait(0.25)
		primDrainRate = 0.05128205128
		local tempinput;
		tempinput = input.InputBegan:Connect(function(obj, gameProcessed)
			if obj.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
				local ray = workspace:Raycast(Core.Position + Core.CFrame.LookVector*1, Cam.CFrame.LookVector*6.5)
				local part = false
				if ray then part = ray.Instance end
				if not part or not part.Parent or part.Parent == Body or not (part.Parent:FindFirstChild("Humanoid") and (not part.Parent.Parent or not part.Parent.Parent:FindFirstChild("Humanoid"))) then
					remote:FireServer("primary")
					return part
				end
				if (part.Parent:FindFirstChild("Humanoid") and not part.Parent:FindFirstChild("uniquegrabid")) or (part.Parent.Parent:FindFirstChild("Humanoid") and not part.Parent.Parent:FindFirstChild("uniquegrabid")) then print("no id") return end
				local punchvictim = part.Parent
				remote:FireServer("primary", punchvictim.Name, punchvictim.uniquegrabid.Value)
				tempinput:Disconnect()
				primDrainRate = 0
				primCharge = 0
				primEnabled = false
				wait(0.5)
				grabCD = false
				usingP = false
				tweenServ:Create(fcc, TweenInfo.new(1), {Brightness = 0, Contrast = 0, TintColor = Color3.fromRGB(255, 255, 255)}):Play()
				debris:AddItem(fcc, 1)
			end
		end)
	end
	function endPrimary()
		usingP = false
	end
	function secondary()
	end
	function endSecondary()
	end

end
local function infect()
	if infectcheck.Connected then infectcheck:Disconnect() end
	releaseP, releaseS = true, true
	-- GUI --
	local name, primaryName, secondaryName = string.upper("Infect"), "Infect", "Lifesteal"
	abilities, primaryBar, secondaryBar, main, prim, sec = abilityGui()
	abilities.Parent = Plr.PlayerGui
	main.AbilityName.Text, prim.primaryName.Text, sec.secondaryName.Text = name, primaryName, secondaryName
	main.Rim.Inner.Image.Image, main.AbilityName.TextColor3, main.AbilityName.TextStrokeColor3 = "rbxassetid://497822691", Color3.fromRGB(179, 0, 255), Color3.fromRGB(206, 135, 199)
	main.Rim.Inner.BackgroundColor3, main.Rim.BackgroundColor3 = Color3.fromRGB(134, 64, 255), Color3.fromRGB(233, 62, 255)
	prim.primaryImage.Image, prim.primaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(255, 255, 255)
	prim.primaryName.TextColor3, prim.primaryName.TextStrokeColor3 = Color3.fromRGB(134, 64, 255), Color3.fromRGB(175, 28, 28)
	sec.secondaryImage.Image, sec.secondaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(255, 255, 255)
	sec.secondaryName.TextColor3, sec.secondaryName.TextStrokeColor3 = Color3.fromRGB(134, 64, 255), Color3.fromRGB(175, 28, 28)
	local infectgui
	local function createinfectgui()
		infectgui = Instance.new("ScreenGui")
		infectgui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		infectgui.Parent = Plr.PlayerGui
		infectgui.Enabled = false
		infectgui.Name = "zenvetierem"

		local Frame = Instance.new("Frame")
		Frame.AnchorPoint, Frame.Size, Frame.BackgroundTransparency, Frame.Position, Frame.BackgroundColor3, Frame.Parent = Vector2.new(1, 1), UDim2.new(0, 100, 0, 100), 2, UDim2.new(0.5422125, 0, 0.6076924, 0), Color3.fromRGB(116, 47, 255), infectgui

		local Rbutton = Instance.new("ImageLabel")
		Rbutton.Name, Rbutton.Size, Rbutton.BackgroundTransparency, Rbutton.Position, Rbutton.BackgroundColor3, Rbutton.Image, Rbutton.Parent = "Rbutton", UDim2.new(0, 30, 0, 30), 1, UDim2.new(0.02, 0, 0.314, 0), Color3.fromRGB(255, 255, 255), "rbxassetid://4893250303", Frame

		local TextLabel = Instance.new("TextLabel")
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Position = UDim2.new(0, 0, 1.e-07, 0)
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.FontSize = Enum.FontSize.Size28
		TextLabel.TextSize = 25
		TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.Text = "R"
		TextLabel.TextWrap = true
		TextLabel.Font = Enum.Font.SciFi
		TextLabel.TextWrapped = true
		TextLabel.Parent = Rbutton

		local TextLabel1 = Instance.new("TextLabel")
		TextLabel1.Size = UDim2.new(0, 71, 0, 50)
		TextLabel1.BackgroundTransparency = 1
		TextLabel1.Position = UDim2.new(0.39, 0, 0.21, 0)
		TextLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel1.FontSize = Enum.FontSize.Size28
		TextLabel1.TextSize = 25
		TextLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel1.Text = "Infect"
		TextLabel1.TextWrap = true
		TextLabel1.Font = Enum.Font.SourceSans
		TextLabel1.TextWrapped = true
		TextLabel1.Parent = Frame
	end
	createinfectgui()
	-- GUI --
	primCharge, secCharge = 100, 0
	primEnabled, secEnabled = false, false
	--cooldowns(0.03703703703, 100, 0, 100, 0.03703703703, 100, 0, 33.3333)
	cooldowns(0.03703703703, 100, 0, 100, 0, 100, 0, 33.3333)

	local infectcce = Instance.new("ColorCorrectionEffect", lighting)
	infectcce.Name = "zenvetierem"

	infectcheck = runServ.Heartbeat:Connect(function()
		if victim and victim:FindFirstChild("Humanoid") then
			if victim.Humanoid.Health/victim.Humanoid.MaxHealth <= 0.25 then
				grabUI.MaxHP.HP.BackgroundColor3 = Color3.fromRGB(106, 0, 255)
				infectgui.Enabled = true
			else
				grabUI.MaxHP.HP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				infectgui.Enabled = false
			end
		else
			infectgui.Enabled = false
		end
	end)
	function primary()
		if not victim or not victim:FindFirstChild("Humanoid") or victim.Humanoid.Health <= 0 or victim.Humanoid.Health/victim.Humanoid.MaxHealth > 0.25 then return end
		if victim then remote:FireServer("primary", victim.Name, victim:FindFirstChild("uniquegrabid")) else return end
	end
	function endPrimary()
	end
	function secondary()
	end
	function endSecondary()
	end
end
local function space()
	if infectcheck.Connected then infectcheck:Disconnect() end
	releaseP, releaseS = true, false
	-- GUI --
	local name, primaryName, secondaryName = string.upper("Space"), "Banish", "--X--"
	abilities, primaryBar, secondaryBar, main, prim, sec = abilityGui()
	abilities.Parent = Plr.PlayerGui
	main.AbilityName.Text, prim.primaryName.Text, sec.secondaryName.Text = name, primaryName, secondaryName
	main.Rim.Inner.Image.Image, main.AbilityName.TextColor3, main.AbilityName.TextStrokeColor3 = "rbxassetid://497822691", Color3.fromRGB(179, 0, 255), Color3.fromRGB(206, 135, 199)
	main.Rim.Inner.BackgroundColor3, main.Rim.BackgroundColor3 = Color3.fromRGB(134, 64, 255), Color3.fromRGB(233, 62, 255)
	prim.primaryImage.Image, prim.primaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(255, 255, 255)
	prim.primaryName.TextColor3, prim.primaryName.TextStrokeColor3 = Color3.fromRGB(134, 64, 255), Color3.fromRGB(175, 28, 28)
	sec.secondaryImage.Image, sec.secondaryImage.BorderColor3 = "rbxassetid://0", Color3.fromRGB(255, 255, 255)
	sec.secondaryName.TextColor3, sec.secondaryName.TextStrokeColor3 = Color3.fromRGB(134, 64, 255), Color3.fromRGB(175, 28, 28)
	-- GUI --
	primCharge, secCharge = 100, 0
	primEnabled, secEnabled = false, false
	local banishedPlrs = {}
	local drainRate = 0.1
	cooldowns(0.1, 100, 0, 100, 0, 100, 0, 33.3333)
	local active, inputCheck = false, nil
	function primary()
		if not primEnabled then return end
		if not active then
			active = true
			if #banishedPlrs <= 0 then
				remote:FireServer("primary", "", "equip")
				grabCD = true
				inputCheck = input.InputBegan:Connect(function(obj, processed) 
					if obj.UserInputType == Enum.UserInputType.MouseButton1 then
						local banishtarg, _ = raycheck(nil, 6.5)
						remote:FireServer("primary", "", "swing")
						if not banishtarg or banishtarg == Body then return end
						remote:FireServer("primary", banishtarg.Name, banishtarg:FindFirstChild("uniquegrabid").Value)
						table.insert(banishedPlrs, banishtarg)
						primDrainRate = drainRate
						active = false
						inputCheck:Disconnect()
						grabCD = false
						usingP = true
					end
				end)
			end
			if victim then
				remote:FireServer("primary", "", "equip")
				wait(1)
				remote:FireServer("primary", victim.Name, victim:FindFirstChild("uniquegrabid").Value)
				remote:FireServer("primary", Body.Name, Body:FindFirstChild("uniquegrabid").Value)
				table.insert(banishedPlrs, Body)
				primDrainRate = drainRate
				active = false
				inputCheck:Disconnect()
				grabCD = false
				usingP = true
			end
		end

	end
	function endPrimary()
		if primCharge > 0 then return end
		usingP = false
		grabCD = false
		warn("STOPPING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
		primDrainRate = 0
		primCharge = 0
		banishedPlrs = {}
		remote:FireServer("primary", "", "empty")
	end
	function secondary()
	end
	function endSecondary()
	end
end
--- End of script ---

local abilityselect;
abilityselect = Plr.Chatted:Connect(function(msg)
	grabUI.MaxHP.HP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	if string.lower(msg) == "> blackout" then blackout()
	elseif string.lower(msg) == "> cloak" then cloak()
	elseif string.lower(msg) == "> decoy" then decoy()
	elseif string.lower(msg) == "> wildfire" then wildfire()
	elseif string.lower(msg) == "> infect" then infect()
	elseif string.lower(msg) == "> space" then space()
	end
end)
if script.Ability.Value == "Cloak" then
	cloak()
elseif script.Ability.Value == "Decoy" then
	decoy()
elseif script.Ability.Value == "Wildfire" then
	wildfire()
elseif script.Ability.Value == "Blackout" then
	blackout()
elseif script.Ability.Value == "Infect" then
	infect()
elseif script.Ability.Value == "Space" then
	space()
end

local animate;
animate = coroutine.wrap(function()
	local Character = script.Parent
	local Humanoid = Character:WaitForChild("Humanoid")
	local pose = "Standing"

	local userNoUpdateOnLoopSuccess, userNoUpdateOnLoopValue = pcall(function() return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop") end)
	local userNoUpdateOnLoop = userNoUpdateOnLoopSuccess and userNoUpdateOnLoopValue

	local userEmoteToRunThresholdChange do
		local success, value = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserEmoteToRunThresholdChange")
		end)
		userEmoteToRunThresholdChange = success and value
	end

	local userPlayEmoteByIdAnimTrackReturn do
		local success, value = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserPlayEmoteByIdAnimTrackReturn2")
		end)
		userPlayEmoteByIdAnimTrackReturn = success and value
	end

	local AnimationSpeedDampeningObject = script:FindFirstChild("ScaleDampeningPercent")
	local HumanoidHipHeight = 2

	local EMOTE_TRANSITION_TIME = 0.1

	local currentAnim = ""
	local currentAnimInstance = nil
	local currentAnimTrack = nil
	local currentAnimKeyframeHandler = nil
	local currentAnimSpeed = 1.0

	local runAnimTrack = nil
	local runAnimKeyframeHandler = nil

	local PreloadedAnims = {}

	local animTable = {}
	local animNames = { 
		idle = 	{	
			--{ id = "http://www.roblox.com/asset/?id=507766666", weight = 1 },
			--{ id = "http://www.roblox.com/asset/?id=507766951", weight = 1 },
			{ id = "http://www.roblox.com/asset/?id=507766388", weight = 9 }
		},
		walk = 	{ 	
			{ id = "http://www.roblox.com/asset/?id=507777826", weight = 10 } 
		}, 
		run = 	{
			{ id = "http://www.roblox.com/asset/?id=913376220", weight = 10 } 
		}, 
		swim = 	{
			{ id = "http://www.roblox.com/asset/?id=507784897", weight = 10 } 
		}, 
		swimidle = 	{
			{ id = "http://www.roblox.com/asset/?id=507785072", weight = 10 } 
		}, 
		jump = 	{
			{ id = "http://www.roblox.com/asset/?id=507765000", weight = 10 } 
		}, 
		fall = 	{
			{ id = "http://www.roblox.com/asset/?id=507767968", weight = 10 } 
		}, 
		climb = {
			{ id = "http://www.roblox.com/asset/?id=507765644", weight = 10 } 
		}, 
		sit = 	{
			{ id = "http://www.roblox.com/asset/?id=2506281703", weight = 10 } 
		},	
		toolnone = {
			{ id = "http://www.roblox.com/asset/?id=507768375", weight = 10 } 
		},
		toolslash = {
			{ id = "http://www.roblox.com/asset/?id=522635514", weight = 10 } 
		},
		toollunge = {
			{ id = "http://www.roblox.com/asset/?id=522638767", weight = 10 } 
		},
		wave = {
			{ id = "http://www.roblox.com/asset/?id=507770239", weight = 10 } 
		},
		point = {
			{ id = "http://www.roblox.com/asset/?id=507770453", weight = 10 } 
		},
		dance = {
			{ id = "http://www.roblox.com/asset/?id=507771019", weight = 10 }, 
			{ id = "http://www.roblox.com/asset/?id=507771955", weight = 10 }, 
			{ id = "http://www.roblox.com/asset/?id=507772104", weight = 10 } 
		},
		dance2 = {
			{ id = "http://www.roblox.com/asset/?id=507776043", weight = 10 }, 
			{ id = "http://www.roblox.com/asset/?id=507776720", weight = 10 }, 
			{ id = "http://www.roblox.com/asset/?id=507776879", weight = 10 } 
		},
		dance3 = {
			{ id = "http://www.roblox.com/asset/?id=507777268", weight = 10 }, 
			{ id = "http://www.roblox.com/asset/?id=507777451", weight = 10 }, 
			{ id = "http://www.roblox.com/asset/?id=507777623", weight = 10 } 
		},
		laugh = {
			{ id = "http://www.roblox.com/asset/?id=507770818", weight = 10 } 
		},
		cheer = {
			{ id = "http://www.roblox.com/asset/?id=507770677", weight = 10 } 
		},
	}

	-- Existance in this list signifies that it is an emote, the value indicates if it is a looping emote
	local emoteNames = { wave = false, point = false, dance = true, dance2 = true, dance3 = true, laugh = false, cheer = false}

	math.randomseed(tick())

	function findExistingAnimationInSet(set, anim)
		if set == nil or anim == nil then
			return 0
		end

		for idx = 1, set.count, 1 do 
			if set[idx].anim.AnimationId == anim.AnimationId then
				return idx
			end
		end

		return 0
	end

	function configureAnimationSet(name, fileList)
		if (animTable[name] ~= nil) then
			for _, connection in pairs(animTable[name].connections) do
				connection:disconnect()
			end
		end
		animTable[name] = {}
		animTable[name].count = 0
		animTable[name].totalWeight = 0	
		animTable[name].connections = {}

		local allowCustomAnimations = true

		local success, msg = pcall(function() allowCustomAnimations = game:GetService("StarterPlayer").AllowCustomAnimations end)
		if not success then
			allowCustomAnimations = true
		end

		-- check for config values
		local config = script:FindFirstChild(name)
		if (allowCustomAnimations and config ~= nil) then
			table.insert(animTable[name].connections, config.ChildAdded:connect(function(child) configureAnimationSet(name, fileList) end))
			table.insert(animTable[name].connections, config.ChildRemoved:connect(function(child) configureAnimationSet(name, fileList) end))

			local idx = 0
			for _, childPart in pairs(config:GetChildren()) do
				if (childPart:IsA("Animation")) then
					local newWeight = 1
					local weightObject = childPart:FindFirstChild("Weight")
					if (weightObject ~= nil) then
						newWeight = weightObject.Value
					end
					animTable[name].count = animTable[name].count + 1
					idx = animTable[name].count
					animTable[name][idx] = {}
					animTable[name][idx].anim = childPart
					animTable[name][idx].weight = newWeight
					animTable[name].totalWeight = animTable[name].totalWeight + animTable[name][idx].weight
					table.insert(animTable[name].connections, childPart.Changed:connect(function(property) configureAnimationSet(name, fileList) end))
					table.insert(animTable[name].connections, childPart.ChildAdded:connect(function(property) configureAnimationSet(name, fileList) end))
					table.insert(animTable[name].connections, childPart.ChildRemoved:connect(function(property) configureAnimationSet(name, fileList) end))
				end
			end
		end

		-- fallback to defaults
		if (animTable[name].count <= 0) then
			for idx, anim in pairs(fileList) do
				animTable[name][idx] = {}
				animTable[name][idx].anim = Instance.new("Animation")
				animTable[name][idx].anim.Name = name
				animTable[name][idx].anim.AnimationId = anim.id
				animTable[name][idx].weight = anim.weight
				animTable[name].count = animTable[name].count + 1
				animTable[name].totalWeight = animTable[name].totalWeight + anim.weight
			end
		end

		-- preload anims
		for i, animType in pairs(animTable) do
			for idx = 1, animType.count, 1 do
				if PreloadedAnims[animType[idx].anim.AnimationId] == nil then
					Humanoid:LoadAnimation(animType[idx].anim)
					PreloadedAnims[animType[idx].anim.AnimationId] = true
				end				
			end
		end
	end

	------------------------------------------------------------------------------------------------------------

	function configureAnimationSetOld(name, fileList)
		if (animTable[name] ~= nil) then
			for _, connection in pairs(animTable[name].connections) do
				connection:disconnect()
			end
		end
		animTable[name] = {}
		animTable[name].count = 0
		animTable[name].totalWeight = 0	
		animTable[name].connections = {}

		local allowCustomAnimations = true

		local success, msg = pcall(function() allowCustomAnimations = game:GetService("StarterPlayer").AllowCustomAnimations end)
		if not success then
			allowCustomAnimations = true
		end

		-- check for config values
		local config = script:FindFirstChild(name)
		if (allowCustomAnimations and config ~= nil) then
			table.insert(animTable[name].connections, config.ChildAdded:connect(function(child) configureAnimationSet(name, fileList) end))
			table.insert(animTable[name].connections, config.ChildRemoved:connect(function(child) configureAnimationSet(name, fileList) end))
			local idx = 1
			for _, childPart in pairs(config:GetChildren()) do
				if (childPart:IsA("Animation")) then
					table.insert(animTable[name].connections, childPart.Changed:connect(function(property) configureAnimationSet(name, fileList) end))
					animTable[name][idx] = {}
					animTable[name][idx].anim = childPart
					local weightObject = childPart:FindFirstChild("Weight")
					if (weightObject == nil) then
						animTable[name][idx].weight = 1
					else
						animTable[name][idx].weight = weightObject.Value
					end
					animTable[name].count = animTable[name].count + 1
					animTable[name].totalWeight = animTable[name].totalWeight + animTable[name][idx].weight
					idx = idx + 1
				end
			end
		end

		-- fallback to defaults
		if (animTable[name].count <= 0) then
			for idx, anim in pairs(fileList) do
				animTable[name][idx] = {}
				animTable[name][idx].anim = Instance.new("Animation")
				animTable[name][idx].anim.Name = name
				animTable[name][idx].anim.AnimationId = anim.id
				animTable[name][idx].weight = anim.weight
				animTable[name].count = animTable[name].count + 1
				animTable[name].totalWeight = animTable[name].totalWeight + anim.weight
				-- print(name .. " [" .. idx .. "] " .. anim.id .. " (" .. anim.weight .. ")")
			end
		end

		-- preload anims
		for i, animType in pairs(animTable) do
			for idx = 1, animType.count, 1 do 
				Humanoid:LoadAnimation(animType[idx].anim)
			end
		end
	end

	-- Setup animation objects
	function scriptChildModified(child)
		local fileList = animNames[child.Name]
		if (fileList ~= nil) then
			configureAnimationSet(child.Name, fileList)
		end	
	end

	script.ChildAdded:connect(scriptChildModified)
	script.ChildRemoved:connect(scriptChildModified)


	for name, fileList in pairs(animNames) do 
		configureAnimationSet(name, fileList)
	end	

	-- ANIMATION

	-- declarations
	local toolAnim = "None"
	local toolAnimTime = 0

	local jumpAnimTime = 0
	local jumpAnimDuration = 0.31

	local toolTransitionTime = 0.1
	local fallTransitionTime = 0.2

	local currentlyPlayingEmote = false

	-- functions

	function stopAllAnimations()
		local oldAnim = currentAnim

		-- return to idle if finishing an emote
		if (emoteNames[oldAnim] ~= nil and emoteNames[oldAnim] == false) then
			oldAnim = "idle"
		end

		if currentlyPlayingEmote then
			oldAnim = "idle"
			currentlyPlayingEmote = false
		end

		currentAnim = ""
		currentAnimInstance = nil
		if (currentAnimKeyframeHandler ~= nil) then
			currentAnimKeyframeHandler:disconnect()
		end

		if (currentAnimTrack ~= nil) then
			currentAnimTrack:Stop()
			currentAnimTrack:Destroy()
			currentAnimTrack = nil
		end

		-- clean up walk if there is one
		if (runAnimKeyframeHandler ~= nil) then
			runAnimKeyframeHandler:disconnect()
		end

		if (runAnimTrack ~= nil) then
			runAnimTrack:Stop()
			runAnimTrack:Destroy()
			runAnimTrack = nil
		end

		return oldAnim
	end

	function getHeightScale()
		if Humanoid then
			if not Humanoid.AutomaticScalingEnabled then
				return 1
			end

			local scale = Humanoid.HipHeight / HumanoidHipHeight
			if AnimationSpeedDampeningObject == nil then
				AnimationSpeedDampeningObject = script:FindFirstChild("ScaleDampeningPercent")
			end
			if AnimationSpeedDampeningObject ~= nil then
				scale = 1 + (Humanoid.HipHeight - HumanoidHipHeight) * AnimationSpeedDampeningObject.Value / HumanoidHipHeight
			end
			return scale
		end	
		return 1
	end

	local function rootMotionCompensation(speed)
		local speedScaled = speed * 1.25
		local heightScale = getHeightScale()
		local runSpeed = speedScaled / heightScale
		return runSpeed
	end

	local smallButNotZero = 0.0001
	local function setRunSpeed(speed)
		local normalizedWalkSpeed = 0.5 -- established empirically using current `913402848` walk animation
		local normalizedRunSpeed  = 1
		local runSpeed = rootMotionCompensation(speed)

		local walkAnimationWeight = smallButNotZero
		local runAnimationWeight = smallButNotZero
		local walkAnimationTimewarp = runSpeed/normalizedWalkSpeed
		local runAnimationTimerwarp = runSpeed/normalizedRunSpeed

		if runSpeed <= normalizedWalkSpeed then
			walkAnimationWeight = 1
		elseif runSpeed < normalizedRunSpeed then
			local fadeInRun = (runSpeed - normalizedWalkSpeed)/(normalizedRunSpeed - normalizedWalkSpeed)
			walkAnimationWeight = 1 - fadeInRun
			runAnimationWeight  = fadeInRun
			walkAnimationTimewarp = 1
			runAnimationTimerwarp = 1
		else
			runAnimationWeight = 1
		end
		currentAnimTrack:AdjustWeight(walkAnimationWeight)
		runAnimTrack:AdjustWeight(runAnimationWeight)
		currentAnimTrack:AdjustSpeed(walkAnimationTimewarp)
		runAnimTrack:AdjustSpeed(runAnimationTimerwarp)
	end

	function setAnimationSpeed(speed)
		if currentAnim == "walk" then
			setRunSpeed(speed)
		else
			if speed ~= currentAnimSpeed then
				currentAnimSpeed = speed
				currentAnimTrack:AdjustSpeed(currentAnimSpeed)
			end
		end
	end

	function keyFrameReachedFunc(frameName)
		if (frameName == "End") then
			if currentAnim == "walk" then
				if userNoUpdateOnLoop == true then
					if runAnimTrack.Looped ~= true then
						runAnimTrack.TimePosition = 0.0
					end
					if currentAnimTrack.Looped ~= true then
						currentAnimTrack.TimePosition = 0.0
					end
				else
					runAnimTrack.TimePosition = 0.0
					currentAnimTrack.TimePosition = 0.0
				end
			else
				local repeatAnim = currentAnim
				-- return to idle if finishing an emote
				if (emoteNames[repeatAnim] ~= nil and emoteNames[repeatAnim] == false) then
					repeatAnim = "idle"
				end

				if currentlyPlayingEmote then
					if currentAnimTrack.Looped then
						-- Allow the emote to loop
						return
					end

					repeatAnim = "idle"
					currentlyPlayingEmote = false
				end

				local animSpeed = currentAnimSpeed
				playAnimation(repeatAnim, 0.15, Humanoid)
				setAnimationSpeed(animSpeed)
			end
		end
	end

	function rollAnimation(animName)
		local roll = math.random(1, animTable[animName].totalWeight) 
		local origRoll = roll
		local idx = 1
		while (roll > animTable[animName][idx].weight) do
			roll = roll - animTable[animName][idx].weight
			idx = idx + 1
		end
		return idx
	end

	local function switchToAnim(anim, animName, transitionTime, humanoid)
		-- switch animation		
		if (anim ~= currentAnimInstance) then

			if (currentAnimTrack ~= nil) then
				currentAnimTrack:Stop(transitionTime)
				currentAnimTrack:Destroy()
			end

			if (runAnimTrack ~= nil) then
				runAnimTrack:Stop(transitionTime)
				runAnimTrack:Destroy()
				if userNoUpdateOnLoop == true then
					runAnimTrack = nil
				end
			end

			currentAnimSpeed = 1.0

			-- load it to the humanoid; get AnimationTrack
			currentAnimTrack = humanoid:LoadAnimation(anim)
			currentAnimTrack.Priority = Enum.AnimationPriority.Core

			-- play the animation
			currentAnimTrack:Play(transitionTime)
			currentAnim = animName
			currentAnimInstance = anim

			-- set up keyframe name triggers
			if (currentAnimKeyframeHandler ~= nil) then
				currentAnimKeyframeHandler:disconnect()
			end
			currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)

			-- check to see if we need to blend a walk/run animation
			if animName == "walk" then
				local runAnimName = "run"
				local runIdx = rollAnimation(runAnimName)

				runAnimTrack = humanoid:LoadAnimation(animTable[runAnimName][runIdx].anim)
				runAnimTrack.Priority = Enum.AnimationPriority.Core
				runAnimTrack:Play(transitionTime)		

				if (runAnimKeyframeHandler ~= nil) then
					runAnimKeyframeHandler:disconnect()
				end
				runAnimKeyframeHandler = runAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)	
			end
		end
	end

	function playAnimation(animName, transitionTime, humanoid) 	
		local idx = rollAnimation(animName)
		local anim = animTable[animName][idx].anim

		switchToAnim(anim, animName, transitionTime, humanoid)
		currentlyPlayingEmote = false
	end

	function playEmote(emoteAnim, transitionTime, humanoid)
		switchToAnim(emoteAnim, emoteAnim.Name, transitionTime, humanoid)
		currentlyPlayingEmote = true
	end

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------

	local toolAnimName = ""
	local toolAnimTrack = nil
	local toolAnimInstance = nil
	local currentToolAnimKeyframeHandler = nil

	function toolKeyFrameReachedFunc(frameName)
		if (frameName == "End") then
			playToolAnimation(toolAnimName, 0.0, Humanoid)
		end
	end


	function playToolAnimation(animName, transitionTime, humanoid, priority)	 		
		local idx = rollAnimation(animName)
		local anim = animTable[animName][idx].anim

		if (toolAnimInstance ~= anim) then

			if (toolAnimTrack ~= nil) then
				toolAnimTrack:Stop()
				toolAnimTrack:Destroy()
				transitionTime = 0
			end

			-- load it to the humanoid; get AnimationTrack
			toolAnimTrack = humanoid:LoadAnimation(anim)
			if priority then
				toolAnimTrack.Priority = priority
			end

			-- play the animation
			toolAnimTrack:Play(transitionTime)
			toolAnimName = animName
			toolAnimInstance = anim

			currentToolAnimKeyframeHandler = toolAnimTrack.KeyframeReached:connect(toolKeyFrameReachedFunc)
		end
	end

	function stopToolAnimations()
		local oldAnim = toolAnimName

		if (currentToolAnimKeyframeHandler ~= nil) then
			currentToolAnimKeyframeHandler:disconnect()
		end

		toolAnimName = ""
		toolAnimInstance = nil
		if (toolAnimTrack ~= nil) then
			toolAnimTrack:Stop()
			toolAnimTrack:Destroy()
			toolAnimTrack = nil
		end

		return oldAnim
	end

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------
	-- STATE CHANGE HANDLERS

	function onRunning(speed)
		if crouching then return end
		local movedDuringEmote =
			userEmoteToRunThresholdChange and currentlyPlayingEmote and Humanoid.MoveDirection == Vector3.new(0, 0, 0)
		local speedThreshold = movedDuringEmote and Humanoid.WalkSpeed or 0.75
		if speed > speedThreshold then
			local scale = 16.0
			playAnimation("walk", 0.2, Humanoid)
			setAnimationSpeed(speed / scale)
			pose = "Running"
		else
			if emoteNames[currentAnim] == nil and not currentlyPlayingEmote then
				playAnimation("idle", 0.2, Humanoid)
				pose = "Standing"
			end
		end
	end

	function onDied()
		pose = "Dead"
	end

	function onJumping()
		if crouching then return end
		playAnimation("jump", 0.1, Humanoid)
		jumpAnimTime = jumpAnimDuration
		pose = "Jumping"
	end

	function onClimbing(speed)
		if crouching then return end
		local scale = 5.0
		playAnimation("climb", 0.1, Humanoid)
		setAnimationSpeed(speed / scale)
		pose = "Climbing"
	end

	function onGettingUp()
		if crouching then return end
		pose = "GettingUp"
	end

	function onFreeFall()
		if crouching then return end
		if (jumpAnimTime <= 0) then
			playAnimation("fall", fallTransitionTime, Humanoid)
		end
		pose = "FreeFall"
	end

	function onFallingDown()
		if crouching then return end
		pose = "FallingDown"
	end

	function onSeated()
		if crouching then return end
		pose = "Seated"
	end

	function onPlatformStanding()
		if crouching then return end
		pose = "PlatformStanding"
	end

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------

	function onSwimming(speed)
		if crouching then return end
		if speed > 1.00 then
			local scale = 10.0
			playAnimation("swim", 0.4, Humanoid)
			setAnimationSpeed(speed / scale)
			pose = "Swimming"
		else
			playAnimation("swimidle", 0.4, Humanoid)
			pose = "Standing"
		end
	end

	function animateTool()
		if (toolAnim == "None") then
			playToolAnimation("toolnone", toolTransitionTime, Humanoid, Enum.AnimationPriority.Idle)
			return
		end

		if (toolAnim == "Slash") then
			playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
			return
		end

		if (toolAnim == "Lunge") then
			playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
			return
		end
	end

	function getToolAnim(tool)
		for _, c in ipairs(tool:GetChildren()) do
			if c.Name == "toolanim" and c.className == "StringValue" then
				return c
			end
		end
		return nil
	end

	local lastTick = 0

	function stepAnimate(currentTime)
		local amplitude = 1
		local frequency = 1
		local deltaTime = currentTime - lastTick
		lastTick = currentTime

		local climbFudge = 0
		local setAngles = false

		if (jumpAnimTime > 0) then
			jumpAnimTime = jumpAnimTime - deltaTime
		end

		if (pose == "FreeFall" and jumpAnimTime <= 0) then
			playAnimation("fall", fallTransitionTime, Humanoid)
		elseif (pose == "Seated") then
			playAnimation("sit", 0.5, Humanoid)
			return
		elseif (pose == "Running") then
			playAnimation("walk", 0.2, Humanoid)
		elseif (pose == "Dead" or pose == "GettingUp" or pose == "FallingDown" or pose == "Seated" or pose == "PlatformStanding") then
			stopAllAnimations()
			amplitude = 0.1
			frequency = 1
			setAngles = true
		end

		-- Tool Animation handling
		local tool = Character:FindFirstChildOfClass("Tool")
		if tool and tool:FindFirstChild("Handle") then
			local animStringValueObject = getToolAnim(tool)

			if animStringValueObject then
				toolAnim = animStringValueObject.Value
				-- message recieved, delete StringValue
				animStringValueObject.Parent = nil
				toolAnimTime = currentTime + .3
			end

			if currentTime > toolAnimTime then
				toolAnimTime = 0
				toolAnim = "None"
			end

			animateTool()		
		else
			stopToolAnimations()
			toolAnim = "None"
			toolAnimInstance = nil
			toolAnimTime = 0
		end
	end

	-- connect events
	Humanoid.Died:connect(onDied)
	Humanoid.Running:connect(onRunning)
	Humanoid.Jumping:connect(onJumping)
	Humanoid.Climbing:connect(onClimbing)
	Humanoid.GettingUp:connect(onGettingUp)
	Humanoid.FreeFalling:connect(onFreeFall)
	Humanoid.FallingDown:connect(onFallingDown)
	Humanoid.Seated:connect(onSeated)
	Humanoid.PlatformStanding:connect(onPlatformStanding)
	Humanoid.Swimming:connect(onSwimming)

	-- setup emote chat hook
	game:GetService("Players").LocalPlayer.Chatted:connect(function(msg)
		local emote = ""
		if (string.sub(msg, 1, 3) == "/e ") then
			emote = string.sub(msg, 4)
		elseif (string.sub(msg, 1, 7) == "/emote ") then
			emote = string.sub(msg, 8)
		end

		if (pose == "Standing" and emoteNames[emote] ~= nil) then
			playAnimation(emote, EMOTE_TRANSITION_TIME, Humanoid)
		end
	end)

	-- emote bindable hook

	if Character.Parent ~= nil then
		-- initialize to idle
		playAnimation("idle", 0.1, Humanoid)
		pose = "Standing"
	end

	-- loop to handle timed state transitions and tool animations
	while Character.Parent ~= nil do
		local _, currentGameTime = wait(0.1)
		stepAnimate(currentGameTime)
	end


end)
animate()]], script)
		end
		primaryScript.Disabled = true
		local abilityInd = script.Ability:Clone()
		if infector then abilityInd.Value = script.Ability.Value primaryScript.Name = "minion" end
		abilityInd.Parent = primaryScript
		wait()
		primaryScript.Parent = char
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

		warn("Made it past the script stuff..")
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

		local function ragdoll(chara, offset, anchorTime, velocity, velocityPart)
			local playerremoving, chararemoving;
			local newchar = Instance.new("Model")
			if chara.PrimaryPart then chara.PrimaryPart.Anchored = true end
			if not anchorTime then anchorTime = 0 end
			if offset then chara.PrimaryPart.CFrame = chara.PrimaryPart.CFrame * offset end
			if chara:FindFirstChild("Humanoid") then chara.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end

			--if chara == char then
			--	--ltorsomotor.C0 = ltorsoOrig
			--	--torsomotor.C0 = torsoOrig
			--	--larmmotor.C0 = larmOrig
			--	--llarmmotor.C0 = llarmOrig
			--	--lhandmotor.C0 = lhandOrig
			--	--rarmmotor.C0 = rarmOrig
			--	--rlarmmotor.C0 = rlarmOrig
			--	--rhandmotor.C0 = rhandOrig
			--	--headmotor.C0 = headOrig
			--	--rlegmotor.C0 = rlegOrig
			--	--rllegmotor.C0 = rllegOrig
			--	--rfootmotor.C0 = rfootOrig
			--	--llegmotor.C0 = llegOrig
			--	--lllegmotor.C0 = lllegOrig
			--	--lfootmotor.C0 = lfootOrig
			--	rarm.Name, rlarm.Name, rhand.Name = rarmName, rlarmName, rhandName
			--	larm.Name, llarm.Name, lhand.Name = larmName, llarmName, lhandName
			--	rleg.Name, rlleg.Name, rfoot.Name = rlegName, rllegName, rfootName
			--	lleg.Name, llleg.Name, lfoot.Name = llegName, lllegName, lfootName
			--end

			if chara:FindFirstChild("UpperTorso") then
				for _,v in pairs(chara:GetDescendants()) do
					if v:IsA("BasePart") then v.Massless = true end
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

							v:Destroy()
						end
					end
				end
				for _,v in pairs(chara:GetDescendants()) do if v:IsA("Attachment") and v.Name ~= "RagdollSocket" then v:Destroy() end end
			elseif chara:FindFirstChild("Torso") then
				for index,joint in pairs(chara:GetDescendants()) do
					if joint:IsA("BasePart") then joint.Massless = true end
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

			local tempclone = chara:Clone()
			if chara:FindFirstChild("playerID") and not players:GetPlayerFromCharacter(chara) then
				chararemoving = chara.AncestryChanged:Connect(function()
					if not chara:IsDescendantOf(game) then
						tempclone.Parent = script
						tempclone.Humanoid.Health = 1
						for _,v in pairs(tempclone:GetDescendants()) do
							if v:IsA("BasePart") then
								v.Anchored = false
								if v.Name ~= "HumanoidRootPart" then v.CanCollide = true end
							end
						end
						tempclone.Humanoid.Health = 0
						chararemoving:Disconnect()
					end
				end)
			elseif players:GetPlayerFromCharacter(chara) then
				local pid = Instance.new("IntValue", newchar)
				pid.Name = "playerID"
				pid.Value = players:GetPlayerFromCharacter(chara).UserId
				playerremoving = players:GetPlayerFromCharacter(chara).CharacterRemoving:Connect(function()
					playerremoving:Disconnect()
					newchar.Name = chara.Name
					newchar.Parent = script
					for _,v in pairs(chara:GetChildren()) do v.Parent = newchar end
				end)
			end
			task.delay(anchorTime, function()
				for _,v in pairs(chara:GetDescendants()) do if v:IsA("BasePart") then v.Anchored = false end end
				if velocity and velocityPart then
					--print(velocity)
					wait(0.1)
					velocityPart.AssemblyLinearVelocity = velocity
				end
			end)
		end

		hum.Died:Connect(function() 
			local ouchie = Instance.new("Sound")
			ouchie.Parent = char.Head
			ouchie.SoundId = "rbxassetid://175505949"
			ouchie.Volume = 1
			ouchie:Play()
			ragdoll(char)
			wait(7)
			if not isNPC and char == owner.Character then
				owner:LoadCharacter()
			end
		end)
		if not isNPC then
			local ownerDied
			ownerDied = owner.CharacterRemoving:Connect(function()
				ownerDied:Disconnect()
				owner.CharacterAdded:Wait()
				wait()
				if script:FindFirstChild("fixScript") then 
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
for _,v in pairs(owner.PlayerGui:GetChildren()) do if v.Name == "DeathStatus" or v.Name == "CircleProgressGui" or v.Name == "VH3AbilityUI" then v:Destroy() end end
]], owner.Character)
				end
				print(owner.Name)
				if not isNPC then
					for _,v in pairs(workspace:GetDescendants()) do if v.Name == "BlackoutActive" then print(v.Name) v.AncestryChanged:Wait() end end
					if table.find(activeVampires, owner) then table.remove(activeVampires, table.find(activeVampires, owner)) end
					if #activeVampires <= 0 then
						for _,v in pairs(script:GetChildren()) do if v:IsA("Model") and v:FindFirstChildWhichIsA("Humanoid") then v.Parent = workspace end end
						warn("DELETE")
						script:Destroy()
					end
				end

			end)
		end
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
					if escProg - escFail <= 0  then escProg = 0 else escProg -= escFail end
				elseif prox.KeyboardKeyCode == Enum.KeyCode.A and escKey == "A" then -- A
					escProg += escSuccess
					escKey = math.random(0, 3)
					if escKey == 0 then escKey = "W" elseif escKey == 1 then escKey = "A" elseif escKey == 2 then escKey = "S" elseif escKey == 3 then escKey = "D" end
				elseif prox.KeyboardKeyCode == Enum.KeyCode.A and escKey ~= "A" then
					if escProg - escFail <= 0  then escProg = 0 else escProg -= escFail end
				elseif prox.KeyboardKeyCode == Enum.KeyCode.S and escKey == "S" then -- S
					escProg += escSuccess
					escKey = math.random(0, 3)
					if escKey== 0 then escKey = "W" elseif escKey == 1 then escKey = "A" elseif escKey == 2 then escKey = "S" elseif escKey == 3 then escKey = "D" end
				elseif prox.KeyboardKeyCode == Enum.KeyCode.S and escKey ~= "S" then
					if escProg - escFail <= 0 then escProg = 0 else escProg -= escFail end
				elseif prox.KeyboardKeyCode == Enum.KeyCode.D and escKey == "D" then -- D
					escProg += escSuccess
					escKey = math.random(0, 3)
					if escKey == 0 then escKey = "W" elseif escKey == 1 then escKey = "A" elseif escKey == 2 then escKey = "S" elseif escKey == 3 then escKey = "D" end
				elseif prox.KeyboardKeyCode == Enum.KeyCode.D and escKey ~= "D" then
					if escProg - escFail <= 0  then escProg = 0 else escProg -= escFail end
				end
				--print(escProg)
				pW.ActionText, pA.ActionText, pS.ActionText, pD.ActionText = "", "", "", ""
				pW.ObjectText, pA.ObjectText, pS.ObjectText, pD.ObjectText = "", "", "", ""
				if escKey == "W" then
					pW.ActionText = "Press ".. escKey.. "! ".. escProg.. "%"
					pW.ObjectText = "Hit the correct key to escape!"
				elseif escKey == "A" then
					pA.ActionText = "Press ".. escKey.. "! ".. escProg.. "%"
					pA.ObjectText = "Hit the correct key to escape!"
				elseif escKey == "S" then
					pS.ActionText = "Press ".. escKey.. "! ".. escProg.. "%"
					pS.ObjectText = "Hit the correct key to escape!"
				elseif escKey == "D" then
					pD.ActionText = "Press ".. escKey.. "! ".. escProg.. "%"
					pD.ObjectText = "Hit the correct key to escape!"
				end

				if escProg >= 100 then
					stunned = true
					if not isNPC then
						playerRemote:FireClient(owner, "escaped")
					else

					end
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
		warn("escape keys")
		-- Animations --
		local crouching = false
		local running = false
		local armAnimating = false
		local larmtween, llarmtween, rarmtween, rlarmtween
		local function isMoving()
			local speed = (hrp.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
			if armAnimating then return end
			if speed > 5 and vampire and not running and not usingPrimary and not usingSecondary and not victim and not crouching then
				running = true
				larm.Name, llarm.Name, rarm.Name, rlarm.Name = "animating", "animating", "animating", "animating"
				larmtween = tweenServ:Create(larmmotor, TweenInfo.new(0.15), {C0 = larmOrig * CFrame.Angles(math.rad(-33.023), math.rad(-75), math.rad(-90.012))})
				llarmtween = tweenServ:Create(llarmmotor, TweenInfo.new(0.15), {C0 = llarmOrig * CFrame.Angles(math.rad(15.063), 0, math.rad(-23.09))})
				rarmtween = tweenServ:Create(rarmmotor, TweenInfo.new(0.15), {C0 = rarmOrig * CFrame.Angles(math.rad(-28.023), math.rad(75), math.rad(90.012))})
				rlarmtween = tweenServ:Create(rlarmmotor, TweenInfo.new(0.15), {C0 = rlarmOrig * CFrame.Angles(math.rad(15.063), 0, math.rad(23.09))})
				larmtween:Play() llarmtween:Play() rarmtween:Play() rlarmtween:Play()
			elseif ((speed < 5 and running) or (not vampire and running)) and not usingPrimary and not usingSecondary and not victim and not crouching then
				running = false
				larm.Name, llarm.Name, rarm.Name, rlarm.Name = larmName, llarmName, rarmName, rlarmName
				larmtween = tweenServ:Create(larmmotor, TweenInfo.new(0.15), {C0 = larmOrig})
				llarmtween = tweenServ:Create(llarmmotor, TweenInfo.new(0.15), {C0 = llarmOrig})
				rarmtween = tweenServ:Create(rarmmotor, TweenInfo.new(0.15), {C0 = rarmOrig})
				rlarmtween = tweenServ:Create(rlarmmotor, TweenInfo.new(0.15), {C0 = rlarmOrig})
				larmtween:Play() llarmtween:Play() rarmtween:Play() rlarmtween:Play()
			end
		end
		hum.Running:Connect(function(speed)
			--print("running")
			isMoving()
		end)
		local function sit(speed)
			warn("sit - server")
			rarm.Name, rlarm.Name, rhand.Name = rarmName, rlarmName, rhandName
			larm.Name, llarm.Name, lhand.Name = larmName, llarmName, lhandName
			rleg.Name, rlleg.Name, rfoot.Name = rlegName, rllegName, rfootName
			lleg.Name, llleg.Name, lfoot.Name = llegName, lllegName, lfootName
			tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -2, 0)}):Play()
			tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(15), 0, 0)}):Play()
			tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(75.516), math.rad(-3.839), math.rad(14.496))}):Play()
			tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(8.251), math.rad(-10.256), math.rad(51.967))}):Play()
			tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig * CFrame.Angles(math.rad(9.683), math.rad(-30.768), math.rad(39.534))}):Play()
			tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(75), math.rad(-6.474), math.rad(-8.422))}):Play()
			tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(2.922), math.rad(5.959), math.rad(-52.254))}):Play()
			tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig * CFrame.Angles(math.rad(12.433), math.rad(49.905), math.rad(-51.051))}):Play()
			tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.new(0, 0.299, -0.551) * CFrame.Angles(math.rad(156.761), math.rad(13.808), math.rad(5.844))}):Play()
			tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.new(0, -0.136, 0.082) * CFrame.Angles(math.rad(-142.495), 0, 0)}):Play()
			tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig * CFrame.Angles(math.rad(-16.387), math.rad(0.573), math.rad(-3.38))}):Play()
			tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.new(0, 0.3, -0.55) * CFrame.Angles(math.rad(156.761), math.rad(-13.808), math.rad(-5.844))}):Play()
			tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.new(0, -0.135, 0.083) * CFrame.Angles(math.rad(-142.495), 0, 0)}):Play()
			tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig * CFrame.Angles(math.rad(-15.011), 0, 0)}):Play()
			tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
			task.delay(speed, function()
				tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
			end)
		end

		while waiting do wait(0.1) end
		if infector then defaultPos(0.25) end
		warn("got past waiting")

		local function stunAnim()
			--print("animating")
			larm.Name, llarm.Name = "animating", "animating"
			larmmotor.C0 = larmOrig * CFrame.Angles(math.rad(104.794), math.rad(-5.5), math.rad(15.814))
			llarmmotor.C0 = llarmOrig * CFrame.Angles(math.rad(88.98), math.rad(3.724), math.rad(29.794))
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
			if char and (char ~= owner.Character or char ~= owner) and char:FindFirstChild("UpperTorso") then
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
				tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.4, 0) * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
				tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
				tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(157.449), math.rad(-75), math.rad(-0.057))}):Play()
				tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
				tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(92.475), math.rad(73.281), math.rad(64.973))}):Play()
				tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(15.011), 0, 0)}):Play()
				tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
				tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(5.271), math.rad(-12.376), math.rad(-11.345))}):Play()
				tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-28.934), math.rad(-5.615), math.rad(3.209))}):Play()
				tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
				tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(12.777), math.rad(12.376), math.rad(11.345))}):Play()
				tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-29.335), math.rad(3.896), math.rad(-1.891))}):Play()
				tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				task.delay(stun, function()
					local speed = 0.2
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.2, 0) * CFrame.Angles(math.rad(-97.517), 0, 0)}):Play()
					tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(7.506), 0, 0)}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(87.376), math.rad(-58.671), math.rad(-42.915))}):Play()
					tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(1.375), math.rad(0.573), math.rad(0.516))}):Play()
					tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(108.747), math.rad(21.601), math.rad(26.127))}):Play()
					tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(12.834), math.rad(1.49), math.rad(0.057))}):Play()
					tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-8.136), math.rad(-1.891), math.rad(-0.229))}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(42.8), math.rad(-12.376), math.rad(-11.345))}):Play()
					tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-57.582), math.rad(-14.095), math.rad(3.953))}):Play()
					tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(50.248), math.rad(12.376), math.rad(11.345))}):Play()
					tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-72.708), math.rad(16.501), math.rad(-1.203))}):Play()
					tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				end)
				task.delay(stun + 0.2, function()
					local speed = 0.2
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.2, 0) * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
					tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(6.245), 0, 0)}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(93.335), math.rad(-26.929), math.rad(-28.877))}):Play()
					tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(2.75), math.rad(1.203), math.rad(0.974))}):Play()
					tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(111.097), math.rad(4.584), math.rad(9.167))}):Play()
					tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(10.657), math.rad(2.922), math.rad(0.229))}):Play()
					tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-16.272), math.rad(-3.667), math.rad(-0.745))}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(51.28), math.rad(-20.97), math.rad(-25.611))}):Play()
					tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-70.818), math.rad(-17.819), math.rad(2.807))}):Play()
					tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(54.775), math.rad(12.376), math.rad(11.345))}):Play()
					tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-81.704), math.rad(18.793), math.rad(0.115))}):Play()
					tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				end)
				task.delay(stun + 0.4, function()
					local speed = 0.867 - 0.4
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
					tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(3.323), 0, 0)}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(28.762), math.rad(-9.339), math.rad(4.412))}):Play()
					tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(5.901), math.rad(2.636), math.rad(2.063))}):Play()
					tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(31.283), math.rad(15.126), math.rad(2.636))}):Play()
					tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(5.558), math.rad(6.36), math.rad(0.745))}):Play()
					tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-7.219), math.rad(-6.532), math.rad(-2.292))}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(62.223), math.rad(-46.581), math.rad(-58.9))}):Play()
					tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-103.247), math.rad(-24.809), math.rad(-3.266))}):Play()
					tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(65.26), math.rad(12.376), math.rad(11.345))}):Play()
					tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-103.476), math.rad(23.033), math.rad(4.641))}):Play()
					tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				end)
				task.delay(stun + 0.867, function()
					local speed = 0.967 - 0.867
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.95, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
					tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(2.693), 0, 0)}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-2.807), math.rad(7.047), math.rad(-0.401))}):Play()
					tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(4.813), math.rad(2.12), math.rad(1.662))}):Play()
					tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(45.607), math.rad(11.287), math.rad(3.209))}):Play()
					tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(4.526), math.rad(5.157), math.rad(0.63))}):Play()
					tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(0, math.rad(-15.928), math.rad(-0.057))}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(45.665), math.rad(-50.879), math.rad(-80.787))}):Play()
					tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-79.985), math.rad(13.235), math.rad(28.132))}):Play()
					tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(63.541), math.rad(-7.735), math.rad(4.87))}):Play()
					tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-82.964), math.rad(19.996), math.rad(0.344))}):Play()
					tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				end)
				task.delay(stun + 0.967, function()
					local speed = 1.067 - 0.967
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.9, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
					tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(2.063), 0, 0)}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-2.005), math.rad(5.042), math.rad(-0.344))}):Play()
					tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(3.667), math.rad(1.604), math.rad(1.318))}):Play()
					tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(60.103), math.rad(4.813), math.rad(7.047))}):Play()
					tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(3.495), math.rad(3.953), math.rad(0.516))}):Play()
					tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(0, math.rad(-15.928), 0)}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(131.551), math.rad(-39.992), math.rad(-0.917))}):Play()
					tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-60.848), math.rad(13.98), math.rad(20.34))}):Play()
					tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(48.759), math.rad(-6.474), math.rad(2.979))}):Play()
					tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-63.14), math.rad(15.756), math.rad(-2.521))}):Play()
					tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				end)
				task.delay(stun + 1.15, function()
					defaultPos(0.35)
				end)

			else
				armAnimating = true
				if not stun or stun < 0.5 then stun = 0.5 end
				print("hardfall")
				local speed = 0.1
				tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.4, 0) * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
				tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig}):Play()
				tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(157.449), math.rad(-75), math.rad(-0.057))}):Play()
				tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig}):Play()
				tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
				tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(92.475), math.rad(73.281), math.rad(64.973))}):Play()
				tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(15.011), 0, 0)}):Play()
				tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
				tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig}):Play()
				tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(5.271), math.rad(-12.376), math.rad(-11.345))}):Play()
				tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-28.934), math.rad(-5.615), math.rad(3.209))}):Play()
				tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
				tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(12.777), math.rad(12.376), math.rad(11.345))}):Play()
				tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-29.335), math.rad(3.896), math.rad(-1.891))}):Play()
				tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				task.delay(stun, function()
					local speed = 0.2
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.2, 0) * CFrame.Angles(math.rad(-97.517), 0, 0)}):Play()
					tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(7.506), 0, 0)}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(87.376), math.rad(-58.671), math.rad(-42.915))}):Play()
					tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(1.375), math.rad(0.573), math.rad(0.516))}):Play()
					tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(108.747), math.rad(21.601), math.rad(26.127))}):Play()
					tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(12.834), math.rad(1.49), math.rad(0.057))}):Play()
					tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-8.136), math.rad(-1.891), math.rad(-0.229))}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(42.8), math.rad(-12.376), math.rad(-11.345))}):Play()
					tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-57.582), math.rad(-14.095), math.rad(3.953))}):Play()
					tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(50.248), math.rad(12.376), math.rad(11.345))}):Play()
					tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-72.708), math.rad(16.501), math.rad(-1.203))}):Play()
					tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				end)
				task.delay(stun + 0.2, function()
					local speed = 0.2
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1.2, 0) * CFrame.Angles(math.rad(-90.012), 0, 0)}):Play()
					tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(6.245), 0, 0)}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(93.335), math.rad(-26.929), math.rad(-28.877))}):Play()
					tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(2.75), math.rad(1.203), math.rad(0.974))}):Play()
					tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(111.097), math.rad(4.584), math.rad(9.167))}):Play()
					tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(10.657), math.rad(2.922), math.rad(0.229))}):Play()
					tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-16.272), math.rad(-3.667), math.rad(-0.745))}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(51.28), math.rad(-20.97), math.rad(-25.611))}):Play()
					tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-70.818), math.rad(-17.819), math.rad(2.807))}):Play()
					tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(54.775), math.rad(12.376), math.rad(11.345))}):Play()
					tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-81.704), math.rad(18.793), math.rad(0.115))}):Play()
					tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				end)
				task.delay(stun + 0.4, function()
					local speed = 0.867 - 0.4
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
					tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(3.323), 0, 0)}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(28.762), math.rad(-9.339), math.rad(4.412))}):Play()
					tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(5.901), math.rad(2.636), math.rad(2.063))}):Play()
					tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(31.283), math.rad(15.126), math.rad(2.636))}):Play()
					tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(5.558), math.rad(6.36), math.rad(0.745))}):Play()
					tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(math.rad(-7.219), math.rad(-6.532), math.rad(-2.292))}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(62.223), math.rad(-46.581), math.rad(-58.9))}):Play()
					tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-103.247), math.rad(-24.809), math.rad(-3.266))}):Play()
					tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(65.26), math.rad(12.376), math.rad(11.345))}):Play()
					tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-103.476), math.rad(23.033), math.rad(4.641))}):Play()
					tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				end)
				task.delay(stun + 0.867, function()
					local speed = 0.967 - 0.867
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.95, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
					tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(2.693), 0, 0)}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-2.807), math.rad(7.047), math.rad(-0.401))}):Play()
					tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(4.813), math.rad(2.12), math.rad(1.662))}):Play()
					tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(45.607), math.rad(11.287), math.rad(3.209))}):Play()
					tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(4.526), math.rad(5.157), math.rad(0.63))}):Play()
					tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(0, math.rad(-15.928), math.rad(-0.057))}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(45.665), math.rad(-50.879), math.rad(-80.787))}):Play()
					tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-79.985), math.rad(13.235), math.rad(28.132))}):Play()
					tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(63.541), math.rad(-7.735), math.rad(4.87))}):Play()
					tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-82.964), math.rad(19.996), math.rad(0.344))}):Play()
					tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				end)
				task.delay(stun + 0.967, function()
					local speed = 1.067 - 0.967
					tweenServ:Create(ltorsomotor, TweenInfo.new(speed), {C0 = ltorsoOrig * CFrame.new(0, -0.9, 0) * CFrame.Angles(math.rad(-37.471), 0, 0)}):Play()
					tweenServ:Create(torsomotor, TweenInfo.new(speed), {C0 = torsoOrig * CFrame.Angles(math.rad(2.063), 0, 0)}):Play()
					tweenServ:Create(larmmotor, TweenInfo.new(speed), {C0 = larmOrig * CFrame.Angles(math.rad(-2.005), math.rad(5.042), math.rad(-0.344))}):Play()
					tweenServ:Create(llarmmotor, TweenInfo.new(speed), {C0 = llarmOrig * CFrame.Angles(math.rad(3.667), math.rad(1.604), math.rad(1.318))}):Play()
					tweenServ:Create(lhandmotor, TweenInfo.new(speed), {C0 = lhandOrig}):Play()
					tweenServ:Create(rarmmotor, TweenInfo.new(speed), {C0 = rarmOrig * CFrame.Angles(math.rad(60.103), math.rad(4.813), math.rad(7.047))}):Play()
					tweenServ:Create(rlarmmotor, TweenInfo.new(speed), {C0 = rlarmOrig * CFrame.Angles(math.rad(3.495), math.rad(3.953), math.rad(0.516))}):Play()
					tweenServ:Create(rhandmotor, TweenInfo.new(speed), {C0 = rhandOrig}):Play()
					tweenServ:Create(headmotor, TweenInfo.new(speed), {C0 = headOrig * CFrame.Angles(0, math.rad(-15.928), 0)}):Play()
					tweenServ:Create(llegmotor, TweenInfo.new(speed), {C0 = llegOrig * CFrame.Angles(math.rad(131.551), math.rad(-39.992), math.rad(-0.917))}):Play()
					tweenServ:Create(lllegmotor, TweenInfo.new(speed), {C0 = lllegOrig * CFrame.Angles(math.rad(-60.848), math.rad(13.98), math.rad(20.34))}):Play()
					tweenServ:Create(lfootmotor, TweenInfo.new(speed), {C0 = lfootOrig}):Play()
					tweenServ:Create(rlegmotor, TweenInfo.new(speed), {C0 = rlegOrig * CFrame.Angles(math.rad(48.759), math.rad(-6.474), math.rad(2.979))}):Play()
					tweenServ:Create(rllegmotor, TweenInfo.new(speed), {C0 = rllegOrig * CFrame.Angles(math.rad(-63.14), math.rad(15.756), math.rad(-2.521))}):Play()
					tweenServ:Create(rfootmotor, TweenInfo.new(speed), {C0 = rfootOrig}):Play()
				end)
				task.delay(stun + 1.15, function()
					defaultPos(0.35)
					armAnimating = false
					isMoving()
				end)
			end

		end
		local function swing()
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
				elseif running then
					larm.Name, llarm.Name, rarm.Name, rlarm.Name = "animating", "animating", "animating", "animating"
					larmtween = tweenServ:Create(larmmotor, TweenInfo.new(0.15), {C0 = larmOrig * CFrame.Angles(math.rad(-33.023), math.rad(-75), math.rad(-90.012))})
					llarmtween = tweenServ:Create(llarmmotor, TweenInfo.new(0.15), {C0 = llarmOrig * CFrame.Angles(math.rad(15.063), 0, math.rad(-23.09))})
					rarmtween = tweenServ:Create(rarmmotor, TweenInfo.new(0.15), {C0 = rarmOrig * CFrame.Angles(math.rad(-28.023), math.rad(75), math.rad(90.012))})
					rlarmtween = tweenServ:Create(rlarmmotor, TweenInfo.new(0.15), {C0 = rlarmOrig * CFrame.Angles(math.rad(15.063), 0, math.rad(23.09))})
					larmtween:Play() llarmtween:Play() rarmtween:Play() rlarmtween:Play()
				else
					rarm.Name = rarmName
					rarmmotor.C0 = rarmOrig
				end
			end)
		end


		-- Ability related anims --
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
			larm.Name, llarm.Name, rarm.Name, rlarm.Name = "animating", "animating", "animating", "animating"
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
						larm.Name, llarm.Name, rarm.Name, rlarm.Name = "animating", "animating", "animating", "animating"
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
			if not fallsound or fallsound.Parent then
				fallsound = Instance.new("Sound", hrp)
				fallsound.Volume, fallsound.SoundId = "1", "rbxassetid://1055286841"
				fallsound.Name = "fallsound"
			end
			fallsound:Play()
			if value < -35 then
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
				if fallvictim.Humanoid.Health <= 0 and not isNPC then
					if not isNPC then 
						playerRemote:FireClient(owner, "drop")
					else

					end
					if fallvictim.PrimaryPart then 
						fallvictim.PrimaryPart.Anchored = true
					end
				end
				wait()
				if fallvictim.Humanoid.Health <= 0 then ragdoll(fallvictim, CFrame.new(0, 2, 0), 1) end
				hum.Health += value
				falldb = false
			else
				hum.Health += value
			end
		end

		---- Remote functions ----
		local function drain(player, action, target, value)
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
				end
				target:FindFirstChildWhichIsA("Humanoid").Health -= value
			end
			char.Humanoid.Health += 6
		end
		---- Remote ----
		warn("now onto the remote stuff")
		remote.OnServerEvent:Connect(function(player, action, target, value)
			if player ~= owner then return end
			if action == "crouch" then
				crouching = true
				crouch(0.1) 
			elseif action == "uncrouch" then
				crouching = false
				defaultPos(0.1)
			elseif action == "sit" then
				sit(0.25)
			elseif action == "fall" then
				falldamage(player, action, target, value)
			elseif action == "transform" then
				tform.Pitch = (100 + math.random(0, 15))/100
				tform:Play()
				if not vampire then
					hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
					vampire = true
					if face then face.Texture = "rbxassetid://1111587497" end
					transformAnim(char)
					for _,v in pairs(char:GetDescendants()) do
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
					hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
					vampire = false
					if face then face.Texture = origFace end
					transformAnim(char)
					for i,v in pairs(origParts) do
						if v and v.Parent and not v:IsA("Decal") then
							v.Color = origColors[i]
						end
					end
				end
			elseif action == "swing" and not swingCD then
				swing()
			elseif action == "hit" then
				for _,v in pairs(workspace:GetDescendants()) do if v.Name == target and v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChild("uniquegrabid") and v.uniquegrabid.Value == value then target = v end end
				victim = target
				if not victim then return end
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
						if not isNPC then
							v:SetNetworkOwner(owner)
						else
							v:SetNetworkOwner(nil)
						end
					end
				end
				victim.Humanoid.PlatformStand = true
				if not isNPC then playerRemote:FireClient(owner) end
				for _,v in pairs(target:GetDescendants()) do if v:isA("BasePart") then
						if v.Anchored then victim = nil return end
						pcall(function() phys:SetPartCollisionGroup(v, "grabCollision") end)
						if not isNPC then v:SetNetworkOwner(owner) else v:SetNetworkOwner(nil) end
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
					pW.ActionText, pA.ActionText, pS.ActionText, pD.ActionText = "", "", "", ""
					pW.ObjectText, pA.ObjectText, pS.ObjectText, pD.ObjectText = "", "", "", ""
					if escKey == "W" then
						pW.ActionText = "Press ".. escKey.. "! ".. escProg.. "%"
						pW.ObjectText = "Hit the correct key to escape!"
					elseif escKey == "A" then
						pA.ActionText = "Press ".. escKey.. "! ".. escProg.. "%"
						pA.ObjectText = "Hit the correct key to escape!"
					elseif escKey == "S" then
						pS.ActionText = "Press ".. escKey.. "! ".. escProg.. "%"
						pS.ObjectText = "Hit the correct key to escape!"
					elseif escKey == "D" then
						pD.ActionText = "Press ".. escKey.. "! ".. escProg.. "%"
						pD.ObjectText = "Hit the correct key to escape!"
					end
					if not ui or not ui.Parent then
						pW.UIOffset, pA.UIOffset, pS.UIOffset, pD.UIOffset = Vector2.new(0, 75), Vector2.new(-250, 0), Vector2.new(0, -75), Vector2.new(250, 0)
					end
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
					if not isNPC then playerRemote:FireClient(owner) end
				else
					if not isNPC then playerRemote:FireClient(owner) end
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
						stunned = false
						tweenServ:Create(larmmotor, TweenInfo.new(0.25), {C0 = larmOrig}):Play()
						tweenServ:Create(llarmmotor, TweenInfo.new(0.25), {C0 = llarmOrig}):Play()
						task.delay(0.25, function() larm.Name, llarm.Name = larmName, llarmName end)
					end)
				end
				if not isNPC then playerRemote:FireClient(owner) end
			elseif action == "draining" and target then
				drain(player, action, target, value)
			elseif action == "stopdraining" then
				draining = false
				pcall(function() headbob:Disconnect() end)
				if victim and not stunned then
					torsomotor.C0 = torsoOrig * CFrame.Angles(math.rad(-4.011), 0, 0)
					larmmotor.C0 = larmOrig * CFrame.Angles(math.rad(75.287), math.rad(-1.662), math.rad(0.63))
					llarmmotor.C0 = llarmOrig * CFrame.Angles(math.rad(28.533), math.rad(-4.641), math.rad(49.79))
					rarmmotor.C0 = rarmOrig * CFrame.Angles(math.rad(74.886), math.rad(-14.725), math.rad(37.242))
					rlarmmotor.C0 = rlarmOrig * CFrame.Angles(math.rad(-1.948), math.rad(1.146), math.rad(-27.502))
					headmotor.C0 = headOrig
				elseif not victim and not stunned then
					rarmmotor.C0, rlarmmotor.C0, larmmotor.C0, llarmmotor.C0, torsomotor.C0, headmotor.C0 = rarmOrig, rlarmOrig, larmOrig, llarmOrig, torsoOrig, headOrig
					llarm.Name, larm.Name, rarm.Name, rlarm.Name = llarmName, larmName, rarmName, rlarmName
				end
				--- Abilities ---
			elseif action == "releasePrimary" and usingPrimary then
				endPrimary()
			elseif action == "primary" then
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
				armAnimating = true
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
							tweenServ:Create(v, TweenInfo.new(0.35), {Transparency = 0.997}):Play()
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
					--defaultPos(0.2)
					if (hrp.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude > 0 and not crouching then
						armAnimating = false
						isMoving()
						tweenServ:Create(headmotor, TweenInfo.new(0.2), {C0 = headOrig}):Play()
						tweenServ:Create(torsomotor, TweenInfo.new(0.2), {C0 = torsoOrig}):Play()
					else
						defaultPos(0.2)
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
				if onCD then return end
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
				local blackoutIndicator = Instance.new("BoolValue")
				blackoutIndicator.Name, blackoutIndicator.Value = "BlackoutActive", true
				blackoutIndicator.Parent = char
				warn(blackout)
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
							light.Brightness, light.Color, light.Range, light.Shadows = 0, Color3.fromRGB(255, 255, 255), 8, false
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
				wait(30)
				--wait(10) -- debug
				lightDelay = 5/#lights
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
				print("end")
				blackoutIndicator:Destroy()
				playerLights = {}
				lighting.Ambient = ambient
				lighting.OutdoorAmbient = odambient
				lights, brightness = {}, {}
			end
			function secondary(player, action, target, value)
			end
			function endPrimary(player, action, target, value)
				usingPrimary = false
			end
			function endSecondary(player, action, target, value)
			end
		end

		local function decoy()
			local disguiseFace;
			local displayName = ""
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
					local disguiseFace = false
					if target.Head:FindFirstChild("face") then
						disguiseFace = target.Head:FindFirstChildWhichIsA("Decal").Texture
						target.Head.face.Texture = "rbxassetid://1111587497"
					end
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
					wait(45)
					alert.Enabled = false
					decoytform:Play()
					if disguiseFace then
						target.Head.face.Texture = disguiseFace
					end
					transformAnim(target)
					for i,v in pairs(decoyParts) do
						v.Color = decoyColors[i]
					end
					task.delay(1, function() alert:Destroy() end)
				else
					if target.Humanoid.DisplayName ~= "" and target.Humanoid.DisplayName ~= target.Name then displayName = target.Humanoid.DisplayName else displayName = target.Name end
					local desc1, desc2 = game.Players:GetHumanoidDescriptionFromUserId(owner.UserId), game.Players:GetHumanoidDescriptionFromUserId(target:FindFirstChild("playerID").Value)
					for _,v in pairs(char:GetDescendants()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then v:Destroy() end end
					for _,v in pairs(target:GetDescendants()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then v:Destroy() end end
					char.Humanoid:ApplyDescription(desc2); target.Humanoid:ApplyDescription(desc1)

					animate = char:FindFirstChild("Animate")
					face = char.Head:FindFirstChild("face")
					if face then
						origFace = char.Head:FindFirstChild("face").Texture
					end
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
					hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
					hum.DisplayName = displayName

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
			local startSound, loopSound, punchSound, hitSound;
			local handcolor, handmat;
			function primary(player, action, target, value)
				if target then for _,v in pairs(workspace:GetDescendants()) do if v.Name == target and v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChild("uniquegrabid") and v.uniquegrabid.Value == value then target = v end end end
				if not usingPrimary then
					armAnimating = true
					startSound, loopSound, punchSound, hitSound = Instance.new("Sound"), Instance.new("Sound"), Instance.new("Sound"), Instance.new("Sound")
					startSound.SoundId, loopSound.SoundId, punchSound.SoundId, hitSound.SoundId = "rbxassetid://8796378067", "rbxassetid://8796376605", "rbxassetid://8796376990", "rbxassetid://8796375345"
					hitSound.Volume, loopSound.Looped = 1, true
					startSound.Parent, loopSound.Parent, punchSound.Parent, hitSound.Parent = rhand, rhand, rhand, rhand
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
					startSound:Play() loopSound:Play()
					rhand.Name = "flamepunch"
					rhand.Color = Color3.fromRGB(255, 180, 80)
					rhand.Material = Enum.Material.Neon
				else
					if not target then
						punchSound:Play()
						flamepunch()
					elseif target then
						hitSound:Play()
						tweenServ:Create(loopSound, TweenInfo.new(6), {Volume = 0}):Play()
						target.Archivable = true
						local targHum = target:FindFirstChildOfClass("Humanoid")
						if not targHum then return end
						local pstand = targHum.PlatformStand
						for _,v in pairs(workspace:GetDescendants()) do if v.Name == target and v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChild("uniquegrabid") and v.uniquegrabid.Value == value then target = v end end
						flamepunch(1, 0.75, true)
						wait(0.3)
						targHum.PlatformStand = true
						if not target.PrimaryPart then
							if target:FindFirstChild("HumanoidRootPart") then target.PrimaryPart = target.HumanoidRootPart
							elseif target:FindFirstChild("Torso") then target.PrimaryPart = target.Torso
							elseif target:FindFirstChild("LowerTorso") then target.PrimaryPart = target.LowerTorso
							elseif target:FindFirstChild("UpperTorso") then target.PrimaryPart = target.UpperTorso
							elseif target:FindFirstChildWhichIsA("BasePart") then target.PrimaryPart = target:FindFirstChildWhichIsA("BasePart")
							else print("literally no parts??") return
							end
						end
						local rot = (target.PrimaryPart.Position - hrp.Position).Unit * 90 --print(rot)

						if targHum.Health - 85 <= 0 then targHum.BreakJointsOnDeath = false end
						targHum.Health -= 85
						if targHum.Health <= 0 then
							wait()
							ragdoll(target, CFrame.new(0, 0, 0), 0, (((target.PrimaryPart.Position - hrp.Position).Unit * 150) * Vector3.new(1, 0, 1)) + Vector3.new(0, 150, 0), target.PrimaryPart)
						else
							target.PrimaryPart.CFrame = target.PrimaryPart.CFrame * CFrame.new(0, -2.5, 0) * CFrame.Angles(math.rad(rot.X), math.rad(rot.Y), math.rad(rot.Z))
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
							task.delay(2, function() targHum.PlatformStand = pstand end)
						end
						rhand.Color = handcolor
						rhand.Material = handmat
						rhand.Name = rhandName
						usingPrimary = false
						firebrick:Destroy()
						armAnimating = false
					end
				end
			end
		end

		local function infect()		
			function primary(player, action, target, value)
				if not victim or not victim:FindFirstChild("Humanoid") or victim.Humanoid.Health <= 0 then return end
				target = victim
				playerRemote:FireClient(owner, "drop")
				remote.OnServerEvent:Wait()
				target.Humanoid.WalkSpeed = 0
				target.Humanoid.JumpPower = 0
				if players:GetPlayerFromCharacter(target) then 
					thescript(players:GetPlayerFromCharacter(target), owner)
				else
					thescript(target, owner)
				end

			end
		end
		local function space()
			local banishedScripts = {}
			local victimParts, victimTransparency = {}, {}
			local equipSound, swoosh, hit, scream = Instance.new("Sound"), Instance.new("Sound"), Instance.new("Sound"), Instance.new("Sound")
			equipSound.SoundId, equipSound.TimePosition, equipSound.Volume = "rbxassetid://2783294896", 0.2, 0.5
			swoosh.SoundId, swoosh.TimePosition, swoosh.Volume = "rbxassetid://5058160717", 0.35, 0.5
			hit.SoundId, hit.TimePosition, hit.Volume = "rbxassetid://8284260932", 0, 0.5
			scream.SoundId, scream.TimePosition, scream.Volume = "rbxassetid://9066230755", 0.65, 0.5
			local screamFade = Instance.new("EqualizerSoundEffect")
			screamFade.HighGain, screamFade.LowGain, screamFade.MidGain = 0, 0, 0
			function primary(player, action, target, value)
				print(player, action, target, value)
				if value == "equip" then
					if not equipSound then
						equipSound = Instance.new("Sound")
						equipSound.SoundId, equipSound.TimePosition, equipSound.Volume = "rbxassetid://2783294896", 0.125, 0.5
					end
					equipSound.Parent = hrp
					equipSound:Play()
				elseif value == "swing" then
					if not swoosh then
						swoosh = Instance.new("Sound")
						swoosh.SoundId, swoosh.TimePosition, swoosh.Volume = "rbxassetid://5058160717", 0.35, 0.5
					end
					swoosh.Parent = hrp
					swoosh:Play()
				elseif value == "empty" then
					for _,v in pairs(banishedScripts) do if v:FindFirstChild("active") then
							v.active.Value = false
							local targhum = v.Parent:FindFirstChildWhichIsA("Humanoid")
							if not targhum then
								if v.Parent:IsA("PlayerGui") and v.Parent.Parent:IsA("Player") and v.Parent.Parent.Character and v.Parent.Parent.Character:FindFirstChildWhichIsA("Humanoid") then targhum = v.Parent.Parent.Character:FindFirstChildWhichIsA("Humanoid") end
							end
							if targhum and targhum:FindFirstChild("Voided") then targhum.Voided:Destroy() end
						end
					end
					for i,v in pairs(victimParts) do v.Transparency = victimTransparency[i] end
					banishedScripts, victimParts = {}, {}
				elseif value ~= "" then
					warn("start")
					for _,v in pairs(workspace:GetDescendants()) do if v.Name == target and v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChild("uniquegrabid") and v.uniquegrabid.Value == value then target = v end end
					warn("got target")
					--if not target then return end
					local victimPlr = players:GetPlayerFromCharacter(target)
					if target ~= char then
						warn(target.Name, victimPlr)
						if not hit then
							hit = Instance.new("Sound")
							hit.SoundId, hit.TimePosition, hit.Volume = "rbxassetid://8284260932", 0, 0.5
						end
						if not scream then
							scream = Instance.new("Sound")
							scream.SoundId, scream.TimePosition, scream.Volume = "rbxassetid://9066230755", 0.65, 0.5
						end
						hit.Parent, scream.Parent = hrp, target:FindFirstChildWhichIsA("BasePart")
						warn("After sounds")
						hit:Play() scream:Play()
						if not target.PrimaryPart then if target:FindFirstChild("HumanoidRootPart") then target.PrimaryPart = target.HumanoidRootPart elseif target:FindFirstChild("Torso") then target.PrimaryPart = target.Torso elseif target:FindFirstChild("LowerTorso") then target.PrimaryPart = target.LowerTorso else target.PrimaryPart = target:FindFirstChildWhichIsA("BasePart") end end
						target.PrimaryPart.CFrame = CFrame.new(target.PrimaryPart.Position, hrp.Position)
						target.PrimaryPart.CFrame = target.PrimaryPart.CFrame*CFrame.Angles(90, 0, 0)
						target.PrimaryPart.AssemblyLinearVelocity = (target.PrimaryPart.Position - hrp.Position).Unit * 50 + Vector3.new(0, 10, 0)
					end

					local indicator = Instance.new("BoolValue") indicator.Name, indicator.Parent, indicator.Value = "Voided", target:FindFirstChildWhichIsA("Humanoid"), true
					task.delay(0.1, function()
						warn("pre-banish")
						if target:FindFirstChild("banishVFX") then
							print("making active")
							if not target.banishVFX:FindFirstChild("active") then
								local activeVal = Instance.new("BoolValue") activeVal.Name, activeVal.Value, activeVal.Parent = "active", true, banishVFX
								activeVal.Parent = target:WaitForChild("banishVFX")
							end
							target.banishVFX.active = true
							table.insert(banishedScripts, target.banishVFX)
						elseif script:FindFirstChild("banishVFX") then
							print("adding script")
							local banishVFX = script.banishVFX:Clone()
							if victimPlr then banishVFX.Parent = victimPlr.PlayerGui else banishVFX.Parent = target end
							banishVFX.Disabled = false
							banishVFX:WaitForChild("active").Value = true
							table.insert(banishedScripts, banishVFX)
						elseif players:GetPlayerFromCharacter(target) then
							local banishVFX, banishParent;
							if victimPlr then banishParent = victimPlr.PlayerGui else banishParent = target end
							banishVFX = NLS([[script:WaitForChild("active")

local players = game:GetService("Players")
local lighting = game:GetService("Lighting")
local tweenServ = game:GetService("TweenService")
local runServ = game:GetService("RunService")
local debris = game:GetService("Debris")
local phys = game:GetService("PhysicsService")
local lights, lightColours = {}, {}
local parts, particles, sounds, partsTrans, particlesTrans = {}, {}, {}, {}, {}
local decals, decalTrans = {}, {}

local plr = players.LocalPlayer
local char = plr.Character
local banished = false

local banishSound = Instance.new("Sound")
banishSound.SoundId, banishSound.Volume, banishSound.Parent, banishSound.Looped = "rbxassetid://9157343533", 0, workspace, true
local cce, dof = Instance.new("ColorCorrectionEffect"), Instance.new("DepthOfFieldEffect")
dof.FarIntensity, dof.FocusDistance, dof.InFocusRadius, dof.NearIntensity = 0, 0, 0, 0
cce.Parent, dof.Parent = lighting, lighting
local cceGoal, dofGoal = {Brightness = 0.1, Contrast = 0.25, Saturation = -1, TintColor = Color3.fromRGB(234, 237, 255)}, {FarIntensity = 1, FocusDistance = 0, InFocusRadius = 25, NearIntensity = 1}
local cceEnd, dofEnd = {Brightness = 0, Contrast = 0, Saturation = 0, TintColor = Color3.fromRGB(255, 255, 255)}, {FarIntensity = 0, FocusDistance = 0, InFocusRadius = 0, NearIntensity = 0}
local cceTween, dofTween = tweenServ:Create(cce, TweenInfo.new(0.5), cceGoal), tweenServ:Create(dof, TweenInfo.new(0.5), dofGoal)

local function tempRemove(object)
	if object:IsA("BasePart") then
		--print(object.Name)
		table.insert(parts, object) table.insert(partsTrans, object.Transparency)
		local stasis = Instance.new("BodyPosition", object)
		stasis.Position, stasis.MaxForce, stasis.P = object.Position, Vector3.new(0, math.huge, 0), 5000
		stasis.Name = "riftstasis"

		phys:SetPartCollisionGroup(object, "RiftPlane")
		--object.Transparency = 1
		tweenServ:Create(object, TweenInfo.new(0.5), {Transparency = 1}):Play()
	elseif object:IsA("Decal") then
		table.insert(decals, object) table.insert(decalTrans, object.Transparency)
		--object.Transparency = 1
		tweenServ:Create(object, TweenInfo.new(0.5), {Transparency = 1}):Play()
	elseif object:IsA("ParticleEmitter") then
		--print(object.Name)
		table.insert(particles, object) table.insert(particlesTrans, object.Transparency)
		object.Transparency = NumberSequence.new(1)
	elseif object:IsA("Sound") then
		--print(object.Name)
		table.insert(sounds, object)
		local mute = Instance.new("EqualizerSoundEffect")
		mute.Name = "MuteSound"
		mute.HighGain, mute.LowGain, mute.MidGain, mute.Parent = 0, 0, 0, object
		tweenServ:Create(mute, TweenInfo.new(1), {HighGain = -80, LowGain = -35, MidGain = -80}):Play()
	end
end

local function restoreCharacter(hum)
	warn("RESTORE RESTORE RESTORE")
	local partsRem, particlesRem, soundsRem, decalsRem = {}, {}, {}, {}
	for i, v in pairs(hum.Parent:GetDescendants()) do
		if table.find(parts, v) then v.Transparency = partsTrans[i] table.insert(partsRem, v) 
		elseif table.find(particles, v) then
			v.Transparency = particlesTrans[i] table.insert(particles, v)
		elseif table.find(sounds, v) then
			if v:FindFirstChild("MuteSound") then 
				tweenServ:Create(v.MuteSound, TweenInfo.new(1), {HighGain = 0, MidGain = 0}):Play()
				tweenServ:Create(v.MuteSound, TweenInfo.new(0.35), {LowGain = 0}):Play()
				debris:AddItem(v.MuteSound, 1.5)
				table.insert(soundsRem, v)
			end
		elseif table.find(decals, v) then
			v.Transparency = decalTrans[i] table.insert(decalsRem, v)
		end
	end
	if #partsRem <= 0 and #particlesRem <= 0 and #soundsRem <= 0 and #decalsRem <= 0 then
		task.delay(0.3, function()
			for _,v in pairs(hum.Parent:GetDescendants()) do 
				if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "HumanoidRootPart" then v.Transparency = 0 end 
			end
		end)
	else 
		warn(#partsRem, #particlesRem, #soundsRem, #decalsRem)
	end
	for _,v in pairs(partsRem) do table.remove(partsTrans, table.find(parts, v)) table.remove(parts, table.find(parts, v)) end
	for _,v in pairs(particlesRem) do table.remove(particlesTrans, table.find(particles, v)) table.remove(particles, table.find(particles, v)) end
	for _,v in pairs(soundsRem) do table.remove(sounds, table.find(sounds, v)) end
	for _,v in pairs(decalsRem) do table.remove(decalTrans, table.find(decals, v)) table.remove(decals, table.find(decals, v)) end
end

local function restoreObjects()
	for _,v in pairs(sounds) do
		if v:FindFirstChild("MuteSound") and v.MuteSound:IsA("EqualizerSoundEffect") then
			tweenServ:Create(v.MuteSound, TweenInfo.new(1), {HighGain = 0, MidGain = 0}):Play()
			tweenServ:Create(v.MuteSound, TweenInfo.new(0.35), {LowGain = 0}):Play()
			debris:AddItem(v.MuteSound, 1.5)
		end
	end
	for i,v in pairs(parts) do
		v.Transparency = partsTrans[i]
		phys:SetPartCollisionGroup(v, "Default")
		if v:FindFirstChild("riftstasis") then
			v.riftstasis:Destroy()
		end
	end
	for i,v in pairs(particles) do v.Transparency = particlesTrans[i] end
	for i,v in pairs(decals) do v.Transparency = decalTrans[i] end
end

local function removeObj(object)
	if object:IsA("Humanoid") and not object:FindFirstChild("Voided") and object.Parent and object.Parent ~= char then 
		pcall(function() print(object.Parent.Name) end)
		for _,v in pairs(object.Parent:GetDescendants()) do
			tempRemove(v)
		end
	elseif object:IsA("BasePart") and object.Parent and object.Parent:IsA("Tool") and not object:FindFirstChild("Voided") then
		for _,v in pairs(object.Parent:GetDescendants()) do
			tempRemove(v)
		end
	elseif object:IsA("Humanoid") and object:FindFirstChild("Voided") and object.Parent then 
		restoreCharacter(object)
	end
end

local function vfxEnabled()
	for _,v in pairs(workspace:GetDescendants()) do removeObj(v) end
	--for _,v in pairs(workspace:GetDescendants()) do if v:IsA("Humanoid") and v:FindFirstChild("Voided") then restoreCharacter(v) end end
	banished = true
	--cce.Brightness = -5
	runServ.RenderStepped:Wait()
	cceTween:Pause() dofTween:Pause()
	cceTween, dofTween = tweenServ:Create(cce, TweenInfo.new(0.5), cceGoal), tweenServ:Create(dof, TweenInfo.new(0.5), dofGoal)
	tweenServ:Create(banishSound, TweenInfo.new(0.5), {Volume = 0.5}):Play()
	cceTween:Play() dofTween:Play()
	banishSound:Play()
end
local function vfxDisabled()
	banished = false
	restoreObjects()
	runServ.RenderStepped:Wait()
	cceTween:Pause() dofTween:Pause()
	cceTween, dofTween = tweenServ:Create(cce, TweenInfo.new(0.5), cceEnd), tweenServ:Create(dof, TweenInfo.new(0.5), dofEnd)
	cceTween:Play() dofTween:Play()
	banishSound:Pause()
end
workspace.DescendantAdded:Connect(function(object)
	if banished and not object:IsA("Humanoid") then
		removeObj(object)
	elseif banished and object.Name == "Voided" then
		print(object.Parent.Parent.Name)
		restoreObjects(object.Parent) 
	end
end)
local activeCheck;
if script:WaitForChild("active").Value == true then vfxEnabled() else vfxDisabled() end
activeCheck = script.active.Changed:Connect(function() if script.active.Value == true then vfxEnabled() else vfxDisabled() end end)
script.ChildAdded:Connect(function()
	if script:FindFirstChild("active") and #script:GetChildren() <= 0 then
		activeCheck:Disconnect()
		if script.active.Value == true then vfxEnabled() else vfxDisabled() end
		activeCheck = script.active.Changed:Connect(function() if script.active.Value == true then vfxEnabled() else vfxDisabled() end end)
	end
end)]], target)
							banishVFX.Name = "banishVFX"
							local activeVal = Instance.new("BoolValue") activeVal.Name, activeVal.Value, activeVal.Parent = "active", true, banishVFX
							activeVal.Parent = banishParent:WaitForChild("banishVFX")
							table.insert(banishedScripts, banishVFX)
						elseif not targPlr then
							local banishVFX = Instance.new("LocalScript")
							if victimPlr then banishVFX.Parent = victimPlr.PlayerGui else banishVFX.Parent = target end
							local activeVal = Instance.new("BoolValue") activeVal.Name, activeVal.Value, activeVal.Parent = "active", true, banishVFX
							banishVFX.Disabled = false
							banishVFX:WaitForChild("active").Value = true
							table.insert(banishedScripts, banishVFX)
						end
						warn("pos-banish")
						screamFade.Parent = scream
						tweenServ:Create(screamFade, TweenInfo.new(0.25), {HighGain = -80, LowGain = -20, MidGain = -80}):Play()
						for _,v in pairs(target:GetDescendants()) do
							if v:IsA("BasePart") or v:IsA("Decal") then table.insert(victimParts, v) table.insert(victimTransparency, v.Transparency) tweenServ:Create(v, TweenInfo.new(0.25), {Transparency = 1}):Play() end
						end
						task.delay(0.75, function() scream:Stop() scream.Parent = script end)
					end)
				end
			end
		end
		if not isNPC then 
			local abilityselect;
			abilityselect = owner.Chatted:Connect(function(msg)
				if string.lower(msg) == "> blackout" then blackout()
				elseif string.lower(msg) == "> cloak" then cloak()
				elseif string.lower(msg) == "> decoy" then decoy()
				elseif string.lower(msg) == "> wildfire" then wildfire()
				elseif string.lower(msg) == "> infect" then infect()
				elseif string.lower(msg) == "> space" then space()
				end
			end)
		end

		if script.Ability.Value == "Cloak" then
			cloak()
		elseif script.Ability.Value == "Decoy" then
			decoy()
		elseif script.Ability.Value == "Wildfire" then
			wildfire()
		elseif script.Ability.Value == "Blackout" then
			blackout()
		elseif script.Ability.Value == "Infect" then
			infect()
		elseif script.Ability.Value == "Space" then
			space()
			--wait(2)
			--primary(owner, "equip", "", "")
			--wait(2)
			--primary(owner, "swing", "", "")
			--wait(2)
			----primary(owner, "hit", char.Name, tostring(char:WaitForChild("uniquegrabid").Value))
			--primary(owner, "hit", "rat", tostring(workspace.rat:WaitForChild("uniquegrabid").Value))
		end
		ability:Destroy()
		print("To swap abilities, type > and then the ability name in chat.")
		print("The current abilities are:")
		print("> blackout")
		print("> cloak")
		print("> decoy")
		print("> wildfire")
		print("> infect")
		print("animbruh")

		local npcMovement, grabCD;
		npcMovement = coroutine.wrap(function()
			grabCD = false
			defaultPos(0.35)
			wait(1)
			local closestHum, closestHumDist = nil, math.huge
			print("start")
			while hum and hum.Parent and hum.Health > 0 do
				--print("loop")
				if not closestHum or closestHum.Parent or closestHum.Health < 0 then
					closestHumDist = math.huge
					for _,v in pairs(workspace:GetDescendants()) do
						if v ~= hum and v:IsA("Humanoid") and v.Health > 0 and not v.Parent:FindFirstChild("Vampire") and v.Parent:FindFirstChildWhichIsA("BasePart") and (v.Parent:FindFirstChildWhichIsA("BasePart").Position - hrp.Position).Magnitude < closestHumDist then
							closestHum, closestHumDist = v, (v.Parent:FindFirstChildWhichIsA("BasePart").Position - hrp.Position).Magnitude
						end
					end
				end
				if closestHum and closestHum.Parent and closestHum.Health > 0 then
					hum:MoveTo(closestHum.Parent:FindFirstChildWhichIsA("BasePart").Position + (hrp.Position - closestHum.Parent:FindFirstChildWhichIsA("BasePart").Position).Unit*2)
					if not grabCD and (closestHum.Parent:FindFirstChildWhichIsA("BasePart").Position - hrp.Position).Magnitude < 4 then
						grabCD = true
						swing()
						if closestHum.Health - 10 <= 0 then closestHum.BreakJointsOnDeath = false end
						closestHum:TakeDamage(10)
						if closestHum.Health <= 0 then ragdoll(closestHum.Parent) end
						wait(0.65)
						grabCD = false
					end
					--print(closestHum.Parent.Name)
				end

				wait(0.1)
			end
		end)
		if character ~= char then
			isNPC = true
			wait(1)
			npcMovement()
		end

	end)
	entirescript()
end


local started, maskpos, createMask = false, CFrame.new(0, 5, 0), nil
local lastEquipped = os.time()
function createMask()
	tool = Instance.new("Tool")
	tool.Name = "Vampire Mask"
	tool.Grip = CFrame.new(0, 0, 0, 1, 4.4189494730062506e-08, 1.4901161193847656e-08, -4.4189494730062506e-08, 1, -1.8679655600095657e-09, -1.4901161193847656e-08, 1.867964893875751e-09, 1)
	tool.GripForward = Vector3.new(-1.4901161193847656e-08, 1.8679655600095657e-09, -1)
	tool.GripUp = Vector3.new(4.4189494730062506e-08, 1, 1.867964893875751e-09)
	tool.GripRight = Vector3.new(1, -4.4189494730062506e-08, -1.4901161193847656e-08)

	handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(1, 1, 1)
	handle.Parent = tool
	local partbrick = Instance.new("Part")
	partbrick.Name, partbrick.Size, partbrick.Parent = "respawn", Vector3.new(1, 1, 1), tool
	partbrick.Anchored, partbrick.CanCollide, partbrick.Transparency = true, false, 1

	mesh = Instance.new("SpecialMesh")
	mesh.MeshId = "http://www.roblox.com/asset/?id=13192557"
	mesh.TextureId = "http://www.roblox.com/asset/?id=131268428"
	mesh.MeshType = Enum.MeshType.FileMesh
	mesh.Parent = handle
	mesh.VertexColor = Vector3.new(0, 0, 0)

	local particles = Instance.new("ParticleEmitter")
	particles.Name = "particles"
	particles.LightInfluence = 1
	particles.Lifetime = NumberRange.new(1, 1)
	particles.SpreadAngle = Vector2.new(35, 35)
	particles.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.6978527, 0), NumberSequenceKeypoint.new(1, 1)})
	particles.Color = ColorSequence.new(Color3.fromRGB(116, 2, 255), Color3.fromRGB(122, 0, 2))
	particles.VelocitySpread = 35
	particles.Speed = NumberRange.new(10, 10)
	particles.Size = NumberSequence.new(0.25)
	particles.RotSpeed = NumberRange.new(110, 110)
	particles.Rate = 0
	particles.EmissionDirection = Enum.NormalId.Front
	particles.Rotation = NumberRange.new(180, 180)
	particles.Parent = handle
	local particles2 = particles:Clone()
	particles2.Lifetime = NumberRange.new(0.25)
	particles2.Name = "particles"
	particles2.Lifetime = NumberRange.new(0.4)
	particles2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
	particles2.Color = ColorSequence.new(Color3.fromRGB(28, 0, 62))
	particles2.Speed = NumberRange.new(10, 10)
	particles2.Size = NumberSequence.new(1)
	particles2.EmissionDirection = Enum.NormalId.Bottom
	particles2.Parent = partbrick

	local use = Instance.new("Sound")
	use.Name = "use"
	use.SoundId = "rbxassetid://444667824"
	use.Parent = handle

	local ChorusSoundEffect = Instance.new("ChorusSoundEffect")
	ChorusSoundEffect.Mix = 0.6
	ChorusSoundEffect.Depth = 0.13
	ChorusSoundEffect.Rate = 6.1999998
	ChorusSoundEffect.Parent = use

	local whispers = Instance.new("Sound")
	whispers.Name = "Whispers"
	whispers.EmitterSize = 5
	whispers.RollOffMaxDistance = 10
	whispers.Volume = 0.05
	whispers.Looped = true
	whispers.MinDistance = 5
	whispers.MaxDistance = 10
	whispers.SoundId = "rbxassetid://7255353679"
	whispers.RollOffMinDistance = 5
	whispers.Parent = handle

	local sound = use
	whispers:Play()
	local pickupable = true
	if script:FindFirstChild("Holder") then
		script.Parent = script.Holder.Value
	else
		script.Parent = workspace
	end

	if owner and not started then
		started = true
		tool.Parent = owner.Backpack
	else 
		tool.Parent = script
		handle.CFrame = maskpos
		handle.Transparency = 1
		partbrick.CFrame = CFrame.new(handle.Position + Vector3.new(0, 1, 0))
		particles2:Emit(75)
		tweenServ:Create(handle, TweenInfo.new(0.25), {Transparency = 0}):Play()
	end
	tweenServ:Create(mesh, TweenInfo.new(0.25), {VertexColor = Vector3.new(1, 1, 1)}):Play()
	task.delay(2, function() partbrick.CFrame = CFrame.new(1000, 5900, -275) end)
	--debris:AddItem(partbrick, 2)

	tool.Activated:Connect(function()
		pcall(function()
			if tool.Parent:FindFirstChild("Vampire") or (not tool.Parent:FindFirstChild("UpperTorso") and not players:GetPlayerFromCharacter(tool.Parent)) then warn(tool.Parent.Name) return end
			pickupable = false
			local holder = tool.Parent
			sound:Play() particles:Emit(75)
			whispers.Volume = 0
			tool.Parent = script
			handle.CFrame = handle.CFrame * CFrame.new(handle.CFrame.LookVector*0.65)
			wait()
			handle.CanCollide = true
			handle.AssemblyLinearVelocity = handle.CFrame.LookVector*25
			wait(0.5)
			if players:GetPlayerFromCharacter(holder) then
				thescript(players:GetPlayerFromCharacter(holder))
			else
				thescript(holder)
			end
			wait(2)
			tweenServ:Create(whispers, TweenInfo.new(5), {Volume = 0.05}):Play()
			pickupable = true
			handle.Name = "Handle"
		end)
	end)
	tool.AncestryChanged:Connect(function()
		runServ.Heartbeat:Wait()
		if not tool:IsDescendantOf(game) then
			createMask()
		elseif tool.Parent == workspace then
			tool.Parent = script
		elseif tool.Parent and tool.Parent:FindFirstChild("Humanoid") then
			lastEquipped = os.time()
		end
	end)
	handle.AncestryChanged:Connect(function()
		if not handle:IsDescendantOf(tool) then tool:Destroy() end
	end)
	while tool.Parent do
		if not tool.Parent or not tool.Parent:IsDescendantOf(game) then wait(math.random(0, 500)/100) createMask() break end
		if tool.Parent == script and handle.Velocity.Magnitude <= 1 then
			maskpos = handle.CFrame
			wait(2)
		end
		if os.time() - lastEquipped > 60 then
			lastEquipped = os.time()
			tool.Parent = script
			mesh.VertexColor = Vector3.new(0, 0, 0)
			local randomHums, randomHum = {}, nil
			for _,v in pairs(workspace:GetDescendants()) do if v:IsA("Humanoid") and v.Parent and v.Parent:FindFirstChildWhichIsA("BasePart") then table.insert(randomHums, v) end end
			randomHum = randomHums[math.random(1, #randomHums)]
			maskpos = handle.CFrame
			handle.CFrame = CFrame.new(randomHum.Parent:FindFirstChildWhichIsA("BasePart").Position + Vector3.new(math.random(-1, 1), 0, math.random(-1, 1)).Unit * 20)
			handle.Transparency = 1
			mesh.VertexColor = Vector3.new(0, 0, 0)
			partbrick.CFrame = CFrame.new(handle.Position + Vector3.new(0, 1, 0))
			particles2:Emit(75)
			tweenServ:Create(handle, TweenInfo.new(0.25), {Transparency = 0}):Play()
			tweenServ:Create(mesh, TweenInfo.new(0.25), {VertexColor = Vector3.new(1, 1, 1)}):Play()
			task.delay(2, function()
				partbrick.CFrame = CFrame.new(1000, 5900, -275)
				if not players:GetPlayerFromCharacter(randomHum.Parent) and not randomHum.Parent:FindFirstChild("Vampire") and randomHum.Parent:FindFirstChild("UpperTorso") then 
					randomHum:MoveTo(handle.Position)
					handle.Touched:Wait()
					randomHum:EquipTool(tool)
					wait(0.5)
					tool:Activate()
				end
			end)
		end
		if not tool.Parent or not tool.Parent:IsDescendantOf(game) then wait(math.random(0, 500)/100) createMask() break end
		wait(0.1)
	end
end

local exists = false
for _,v in pairs(phys:GetCollisionGroups()) do if v.name == "RiftPlane" then exists = true end end
if not exists then phys:CreateCollisionGroup("RiftPlane") end
phys:CollisionGroupSetCollidable("Default", "RiftPlane", false)

createMask()
wait(0.1)
print(tool.Name)
