---@type string
local addonName = ...

---@class EssencesParentFrame : Frame

EventUtil.ContinueOnAddOnLoaded(addonName, function()
	-- only Evokers, see classID here: https://wago.tools/db2/ChrSpecialization
	if select(3, UnitClass("player")) ~= 13 then
		return
	end

	local isXeph = false

	do
		local name = UnitName("player")

		isXeph = name == "Xephyris" or name == "Syriphex"
	end

	local barHeight = isXeph and 12 or 8
	local padding = isXeph and 2 or 1
	local yOffset = isXeph and 4 or 2

	local enableGlow = isXeph
	local enableVariableColors = isXeph

	local LibCustomGlow = LibStub("LibCustomGlow-1.0")

	---@class EssencesParentFrame
	local frame = CreateFrame("Frame", "EssencesParentFrame", EssentialCooldownViewer)
	frame:ClearAllPoints()
	PixelUtil.SetPoint(frame, "BOTTOM", EssentialCooldownViewer, "TOP", 0, yOffset)

	frame.lastPower = 0
	frame.imminentDestructionStacks = 0
	frame.specId = 0
	frame.availableEssenceBursts = 0
	frame.lastImminentDestructionStart = 0

	local devaSpecId = 1467
	local presSpecId = 1468
	local augSpecId = 1473

	---@param spellId number
	---@return boolean
	function frame:IsSpender(spellId)
		return spellId == 356995 -- disintegrate
			or spellId == 357211 -- pyre
			or spellId == 364343 -- echo
			or spellId == 395160 -- eruption
	end

	---@param spellId number
	---@return boolean
	function frame:IsEssenceBurst(spellId)
		return spellId == 359618 -- deva essence burst
			or spellId == 361519 -- explain this
			or spellId == 369299 -- pres essence burst
			or spellId == 392268 -- aug essence burst
	end

	---@return number
	function frame:GetCurrentPower()
		return UnitPower("player", Enum.PowerType.Essence)
	end

	---@return number
	function frame:GetMaxPower()
		return UnitPowerMax("player", Enum.PowerType.Essence)
	end

	---@return number
	function frame:GetPartialPower()
		return UnitPartialPower("player", Enum.PowerType.Essence) / 1000.0
	end

	---@return number
	function frame:GetRechargeRate()
		local rate = GetPowerRegenForPowerType(Enum.PowerType.Essence)

		if not rate or rate == 0 then
			rate = 0.2
		end

		return rate
	end

	---@param id number
	---@return boolean
	function frame:IsDeepBreathLike(id)
		return id == 357210 -- deep breath
			or id == 433874 -- deep breath maneuverability
			or id == 403631 -- breath of eons
			or id == 442204 -- breath of eons maneuverability
	end

	---@return boolean
	function frame:KnowsImminentDestruction()
		return C_SpellBook.IsSpellKnown(370781, Enum.SpellBookSpellBank.Player) -- deva
			or C_SpellBook.IsSpellKnown(459537, Enum.SpellBookSpellBank.Player) -- aug
	end

	---@param show boolean
	function frame:ToggleGlow(show)
		if not enableGlow then
			return
		end

		if self._PixelGlow == nil then
			LibCustomGlow.PixelGlow_Start(
				self,
				nil,
				nil, -- N
				0.2, -- frequency
				nil, -- length
				nil, -- thickness
				1, -- xOffset
				1, -- yOffset
				false, -- border
				nil, -- key
				nil -- frameLevel
			)
		end

		if show then
			self._PixelGlow:Show()
		else
			self._PixelGlow:Hide()
		end
	end

	---@param currentPower number
	function frame:UpdateBarColors(currentPower)
		local maxPower = self:GetMaxPower()
		local spenderCost = self.specId == devaSpecId and 3 or 2

		if self.imminentDestructionStacks > 0 then
			spenderCost = spenderCost - 1
		end

		local r, g, b, a
		if currentPower == maxPower or not enableVariableColors then
			r, g, b, a = 0.93, 0.21, 0.35, 1
		elseif currentPower >= maxPower - 1 then
			r, g, b, a = 1, 0.5, 0, 1
		elseif currentPower < spenderCost then
			r, g, b, a = 0.2, 0.58, 0.5, self.availableEssenceBursts > 0 and 1 or 0.5
		else
			r, g, b, a = 0.2, 0.58, 0.5, 1
		end

		for i = 1, 6 do
			self:GetStatusBarAtIndex(i):SetStatusBarColor(r, g, b, a)
		end
	end

	---@param i number
	---@return StatusBar
	function frame:GetStatusBarAtIndex(i)
		local key = "EssenceBar" .. i

		if self[key] == nil then
			local statusBar = CreateFrame("StatusBar", "EssenceBar" .. i, self)
			statusBar:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8")
			statusBar:SetStatusBarColor(0.2, 0.58, 0.5)
			statusBar.Border = CreateFrame("Frame", "BACKGROUND", statusBar, "BackdropTemplate")
			statusBar.Border:SetAllPoints()
			statusBar.Border:SetBackdrop({
				edgeFile = "Interface\\Buttons\\WHITE8x8",
				edgeSize = 1,
			})
			statusBar.Border:SetBackdropBorderColor(0.1, 0.1, 0.1, 1)

			self[key] = statusBar

			return statusBar
		end

		return self[key]
	end

	function frame:Relayout()
		local maxPower = self:GetMaxPower()
		local widthToDistribute = math.max(EssentialCooldownViewer:GetWidth(), 300)
		local individualBarWidth = math.floor((widthToDistribute - padding * (maxPower - 1)) / maxPower + 0.5)

		if individualBarWidth < 0 then
			return
		end

		local currentPower = self:GetCurrentPower()

		for i = 1, 6 do
			local statusBar = self:GetStatusBarAtIndex(i)
			statusBar:ClearAllPoints()

			if i == 1 then
				PixelUtil.SetPoint(statusBar, "LEFT", self, "LEFT", 0, 0)
			else
				local previousStatusBar = self:GetStatusBarAtIndex(i - 1)
				PixelUtil.SetPoint(statusBar, "LEFT", previousStatusBar, "RIGHT", padding, 0)
			end

			statusBar:SetSize(individualBarWidth, barHeight)

			statusBar:SetShown(i <= maxPower)
			statusBar:SetMinMaxValues(0, 1)

			if i <= currentPower then
				statusBar:SetValue(1)
			else
				statusBar:SetValue(0)
			end
		end

		self:UpdateBarColors(currentPower)
	end

	PixelUtil.SetSize(frame, EssentialCooldownViewer:GetWidth(), barHeight - 2)

	EssentialCooldownViewer:HookScript("OnSizeChanged", function()
		local nextWidth = EssentialCooldownViewer:GetWidth()

		if nextWidth == frame:GetWidth() then
			return
		end

		PixelUtil.SetSize(frame, nextWidth, barHeight - 2)

		frame:Relayout()
	end)

	frame:Relayout()

	frame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
	frame:RegisterUnitEvent("UNIT_MAXPOWER", "player")
	frame:RegisterUnitEvent("SPELLS_CHANGED")
	frame:RegisterUnitEvent("PLAYER_DEAD")

	if enableVariableColors then
		frame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
	end

	if enableVariableColors or enableGlow then
		frame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_SHOW")
		frame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_HIDE")
	end

	function frame:CountActiveEssenceBursts()
		---@type Frame[]
		local children = { SpellActivationOverlayFrame:GetChildren() }

		local active = 0

		for i = 1, #children do
			local child = children[i]

			if child:IsShown() and self:IsEssenceBurst(child.spellID) then
				active = active + 1
			end
		end

		return active
	end

	---@param self StatusBar
	---@param elapsed number
	local function OnUpdate(self, elapsed)
		self:SetValue(math.min(1, self:GetValue() + elapsed * frame:GetRechargeRate()))
	end

	frame:SetScript(
		"OnEvent",
		---@param self EssencesParentFrame
		---@param event WowEvent
		function(self, event, ...)
			if event == "UNIT_POWER_FREQUENT" then
				local unit, powerType = ...

				if powerType ~= "ESSENCE" then
					return
				end

				local currentPower = self:GetCurrentPower()
				local maxPower = self:GetMaxPower()

				for i = 1, 6 do
					local statusBar = self:GetStatusBarAtIndex(i)

					if i == currentPower + 1 and i <= maxPower then
						statusBar:SetValue(self:GetPartialPower())
						statusBar:SetScript("OnUpdate", OnUpdate)
					elseif i <= currentPower then
						statusBar:SetScript("OnUpdate", nil)
						statusBar:SetValue(1)
					else
						statusBar:SetScript("OnUpdate", nil)
						statusBar:SetValue(0)
					end
				end

				self:UpdateBarColors(currentPower)
				self.lastPower = currentPower
			elseif event == "SPELLS_CHANGED" then
				self.specId = PlayerUtil.GetCurrentSpecID()

				if enableVariableColors and self.specId ~= presSpecId then
					frame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
				else
					frame:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
				end

				if (enableVariableColors and self.specId ~= presSpecId) or enableGlow then
					frame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_SHOW")
					frame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_HIDE")
				else
					frame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_SHOW")
					frame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_HIDE")

					self.availableEssenceBursts = 0
				end
			elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
				local spellId = select(3, ...)

				if self:IsDeepBreathLike(spellId) and self:KnowsImminentDestruction() then
					self.lastImminentDestructionStart = GetTime() + 1

					if self.specId == devaSpecId then
						local imminentDestructionDiff = GetTime() - self.lastImminentDestructionStart

						if imminentDestructionDiff > 30 then
							self.imminentDestructionStacks = 0
						end

						self.imminentDestructionStacks = math.min(self.imminentDestructionStacks + 4, 8)
					else
						self.imminentDestructionStacks = 6
					end
				elseif self:IsSpender(spellId) then
					if self.availableEssenceBursts == 0 and self.imminentDestructionStacks > 0 then
						local imminentDestructionDiff = GetTime() - self.lastImminentDestructionStart

						if imminentDestructionDiff > 30 then
							self.imminentDestructionStacks = 0
							return
						end

						self.imminentDestructionStacks = self.imminentDestructionStacks - 1
					else
					end
				end
			elseif event == "SPELL_ACTIVATION_OVERLAY_SHOW" then
				local spellId = ...

				if self:IsEssenceBurst(spellId) then
					local nextEssenceBurstCount = self:CountActiveEssenceBursts()

					self.availableEssenceBursts = nextEssenceBurstCount

					if nextEssenceBurstCount > 0 then
						self:ToggleGlow(true)
						self:UpdateBarColors(self:GetCurrentPower())
					end
				end
			elseif event == "SPELL_ACTIVATION_OVERLAY_HIDE" then
				local spellId = ...

				if spellId == nil then
					self.availableEssenceBursts = 0
					self:ToggleGlow(false)
				elseif self:IsEssenceBurst(spellId) then
					-- delay briefly as by the time this executes, the overlay is still animating out.
					-- 0.2s is fast enough that you won't notice the delay
					C_Timer.After(0.2, function()
						self.availableEssenceBursts = self:CountActiveEssenceBursts()

						if self.availableEssenceBursts == 0 then
							self:ToggleGlow(false)
						end
					end)
				end
			elseif event == "UNIT_MAXPOWER" then
				local unit, powerType = ...

				if powerType == "ESSENCE" then
					self:Relayout()
				end
			end
		end
	)
end)
