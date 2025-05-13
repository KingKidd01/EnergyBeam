

local vfxFold = script.VFX	


local rp = game:GetService("ReplicatedStorage")
local ts = game:GetService("TweenService")
local rs = game:GetService("RunService")

local dummy = workspace:WaitForChild("Dummy")


while wait(2) do
local charge = vfxFold.Charge.charge:Clone()
local dummyPart = vfxFold.Fire.dummyPart:Clone()
local explosion = vfxFold.Fire.Explosion:Clone()

remote = rp.reaction

charge.Parent = dummy


explosion.Parent = dummy
dummyPart.Parent = dummy


local cc = game:GetService("Lighting").ColorCorrection

local function ccChange()
	cc.Enabled = true

	local goal= {}
	goal.Contrast = 1
	goal.Saturation = -1
	local info = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
	local tween = ts:Create(cc, info, goal)
	tween:Play()

	tween.Completed:Connect(function()
		dummy.Position = dummy.Position + Vector3.new(-1.5,0,0)		
		task.wait(0.1)
		local goal= {}
		goal.Contrast = 0
		goal.Saturation = 0
		local info = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
		local tween = ts:Create(cc, info, goal)
		tween:Play()
	end)
end
	
for i,v in pairs(charge:GetChildren()) do
	if v:IsA("ParticleEmitter") then
		v.Enabled = true
		v:Emit(10)
	end
end
	
wait(2)

--emit dummyPart vfx
for i,v in pairs(dummyPart:GetChildren()) do
	if v:IsA("ParticleEmitter") then
		v.Enabled = true
		v:Emit(10)
	end
end

--disable charge vfx
for i,v in pairs(charge:GetChildren()) do
	if v.Enabled then
		v:Clear()
		v.Enabled = false
	end
end

explosion.Position = dummyPart.Position

for i,v in pairs(dummyPart:GetChildren()) do
	if v:IsA("Beam") then
		v.Attachment0 = dummyPart
		v.Attachment1 = explosion
	end
end




local goal= {}
goal.Position = explosion.Position + Vector3.new(60,0,0)
local info = TweenInfo.new(0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)
local tween = ts:Create(explosion, info, goal)
tween:Play()

ccChange()
--remote:FireAllClients("cc")


dummyPart.Position = charge.Position

tween.Completed:Connect(function()
	for i,v in pairs(explosion:GetChildren()) do
		if v:IsA("ParticleEmitter") and v.Name ~= "Lightning1" and v.Name ~= "Wave"then
			v:Emit(10)
			v.Enabled = true
		end
	end	
end)


wait(5)

for i,v in pairs(dummyPart:GetChildren()) do
	if v:IsA("Beam") then
		local goal= {}
		goal.Width0 = 0
		goal.Width1 = 0
		local info = TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
		local tween = ts:Create(v, info, goal)
		tween:Play()
	end
end

for i,v in pairs(dummy:GetDescendants()) do
	if v:IsA("ParticleEmitter") then
		v.Enabled = false
		v:Destroy()
	end
end
end	