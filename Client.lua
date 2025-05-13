local rp = game:GetService("ReplicatedStorage")
local cc = game:GetService("Lighting").ColorCorrection
local ts = game:GetService("TweenService")

local remote = rp.reaction

remote.OnClientEvent:Connect(function(effect)
	if effect == "cc" then
		
		cc.Enabled = true
		
		local goal= {}
		goal.Contrast = 1
		goal.Saturation = -1
		local info = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
		local tween = ts:Create(cc, info, goal)
		tween:Play()
		
		tween.Completed:Connect(function()
			task.wait(0.1)
			local goal= {}
			goal.Contrast = 0
			goal.Saturation = 0
			local info = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
			local tween = ts:Create(cc, info, goal)
			tween:Play()
		end)
		
		
	end


end)

