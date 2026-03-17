---@type string, Essences
local addonName, Private = ...

table.insert(Private.LoginFnQueue, function()
	local LibEditMode = LibStub("LibEditMode")
	local LibSharedMedia = LibStub("LibSharedMedia-3.0")

	local devaSpecId = 1467
	local presSpecId = 1468

	---@type EssencesParentFrame
	local frame = CreateFrame("Frame", "EssencesParentFrame", EssentialCooldownViewer)
	frame:ClearAllPoints()
	PixelUtil.SetPoint(
		frame,
		"BOTTOM",
		EssentialCooldownViewer,
		"TOP",
		EssencesSaved.Settings.OffsetX,
		EssencesSaved.Settings.OffsetY
	)

	frame.imminentDestructionStacks = 0
	frame.specId = 0
	frame.availableEssenceBursts = 0
	frame.lastImminentDestructionStart = 0

	---@param hex string
	---@return { r: number, g: number, b: number, a: number|nil }
	local function HexStringToTable(hex)
		local r, g, b, a = CreateColorFromHexString(hex):GetRGBA()

		return {
			r = r,
			g = g,
			b = b,
			a = a or 1,
		}
	end

	frame.colorBase = HexStringToTable(EssencesSaved.Settings.BaseColor)
	frame.colorCap = HexStringToTable(EssencesSaved.Settings.CapColor)
	frame.colorNearlyCap = HexStringToTable(EssencesSaved.Settings.NearlyCapColor)

	function frame:IsSpender(spellId)
		return spellId == 356995 -- disintegrate
			or spellId == 357211 -- pyre
			or spellId == 364343 -- echo
			or spellId == 395160 -- eruption
	end

	function frame:IsEssenceBurst(spellId)
		return spellId == 359618 -- deva essence burst
			or spellId == 361519 -- explain this
			or spellId == 369299 -- pres essence burst
			or spellId == 392268 -- aug essence burst
	end

	function frame:GetCurrentPower()
		return UnitPower("player", Enum.PowerType.Essence)
	end

	function frame:GetMaxPower()
		return UnitPowerMax("player", Enum.PowerType.Essence)
	end

	function frame:GetPartialPower()
		return UnitPartialPower("player", Enum.PowerType.Essence) / 1000.0
	end

	function frame:GetRechargeRate()
		local basePowerRegen = GetPowerRegenForPowerType(Enum.PowerType.Essence)

		if not basePowerRegen or basePowerRegen == 0 then
			basePowerRegen = 0.2
		end

		return basePowerRegen
	end

	function frame:IsDeepBreathLike(id)
		return id == 357210 -- deep breath
			or id == 433874 -- deep breath maneuverability
			or id == 403631 -- breath of eons
			or id == 442204 -- breath of eons maneuverability
	end

	function frame:KnowsImminentDestruction()
		return C_SpellBook.IsSpellKnown(370781, Enum.SpellBookSpellBank.Player) -- deva
			or C_SpellBook.IsSpellKnown(459537, Enum.SpellBookSpellBank.Player) -- aug
	end

	function frame:ToggleGlow(show)
		if not EssencesSaved.Settings.ShowGlow then
			return
		end

		if show then
			if self._PixelGlow == nil then
				local LibCustomGlow = LibStub("LibCustomGlow-1.0")

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

			self._PixelGlow:Show()
		elseif self._PixelGlow ~= nil then
			self._PixelGlow:Hide()
		end
	end

	function frame:UpdateBarColors(currentPower)
		local maxPower = self:GetMaxPower()
		local spenderCost = self.specId == devaSpecId and 3 or 2

		if self.imminentDestructionStacks > 0 then
			local imminentDestructionDiff = GetTime() - self.lastImminentDestructionStart

			if imminentDestructionDiff > 30 then
				self.imminentDestructionStacks = 0
			else
				spenderCost = spenderCost - 1
			end
		end

		local r, g, b, a = self.colorBase.r, self.colorBase.g, self.colorBase.b, self.colorBase.a

		if EssencesSaved.Settings.UseColors then
			if currentPower == maxPower then
				r, g, b, a = self.colorCap.r, self.colorCap.g, self.colorCap.b, self.colorCap.a
			elseif currentPower >= maxPower - 1 then
				r, g, b, a = self.colorNearlyCap.r, self.colorNearlyCap.g, self.colorNearlyCap.b, self.colorNearlyCap.a
			elseif currentPower < spenderCost then
				a = self.availableEssenceBursts > 0 and 1 or 0.5
			end
		end

		for i = 1, 6 do
			local statusBar = self:GetStatusBarAtIndex(i)
			statusBar:SetStatusBarColor(r, g, b, a)

			statusBar.Background:SetShown(EssencesSaved.Settings.ShowBackground)

			if EssencesSaved.Settings.ShowBackground then
				local bright = EssencesSaved.Settings.BackgroundBrightness
				statusBar.Background:SetVertexColor(r * bright, g * bright, b * bright, a)
			end
		end
	end

	function frame:GetStatusBarAtIndex(i)
		local key = "EssenceBar" .. i

		if self[key] == nil then
			---@type EssencesStatusBar
			local statusBar = CreateFrame("StatusBar", key, self)
			statusBar:SetStatusBarTexture(EssencesSaved.Settings.BarTexture)
			local r, g, b, a = self.colorBase.r, self.colorBase.g, self.colorBase.b, self.colorBase.a
			statusBar:SetStatusBarColor(r, g, b, a)

			statusBar.Border = CreateFrame("Frame", "Border", statusBar, "BackdropTemplate")
			statusBar.Border:SetAllPoints()
			statusBar.Border:SetBackdrop({
				edgeFile = "Interface\\Buttons\\WHITE8x8",
				edgeSize = 1,
			})
			statusBar.Border:SetBackdropBorderColor(0.1, 0.1, 0.1, 1)

			statusBar.Background = statusBar:CreateTexture("Background", "BACKGROUND")
			statusBar.Background:SetAllPoints()
			statusBar.Background:SetTexture(EssencesSaved.Settings.BackgroundTexture)
			statusBar.Background:SetVertexColor(
				r * EssencesSaved.Settings.BackgroundBrightness,
				g * EssencesSaved.Settings.BackgroundBrightness,
				b * EssencesSaved.Settings.BackgroundBrightness,
				1
			)
			statusBar.Background:SetShown(EssencesSaved.Settings.ShowBackground)

			self[key] = statusBar

			return statusBar
		end

		return self[key]
	end

	function frame:Relayout()
		local cdvWidth = EssentialCooldownViewer:GetWidth()

		if cdvWidth <= 2 then
			return
		end

		PixelUtil.SetSize(frame, cdvWidth, EssencesSaved.Settings.BarHeight - 2)
		frame:ClearAllPoints()
		PixelUtil.SetPoint(
			frame,
			"BOTTOM",
			EssentialCooldownViewer,
			"TOP",
			EssencesSaved.Settings.OffsetX,
			EssencesSaved.Settings.OffsetY
		)

		local widthToDistribute = math.floor(math.max(cdvWidth + 0.5, EssencesSaved.Settings.MinWidth))
		local maxPower = self:GetMaxPower()
		local totalBarSpace = widthToDistribute - (maxPower - 1) * EssencesSaved.Settings.Gap
		local individualBarWidth = math.floor(totalBarSpace / maxPower)
		local extraPixels = totalBarSpace % maxPower
		local currentPower = self:GetCurrentPower()

		for i = 1, 6 do
			local statusBar = self:GetStatusBarAtIndex(i)

			if i > maxPower then
				statusBar:Hide()
			else
				statusBar:ClearAllPoints()

				if i == 1 then
					PixelUtil.SetPoint(statusBar, "LEFT", self, "LEFT", 0, 0)
				else
					local previousStatusBar = self:GetStatusBarAtIndex(i - 1)
					PixelUtil.SetPoint(statusBar, "LEFT", previousStatusBar, "RIGHT", EssencesSaved.Settings.Gap, 0)
				end

				local width = individualBarWidth + (i <= extraPixels and 1 or 0)
				statusBar:SetSize(width, EssencesSaved.Settings.BarHeight)
				statusBar:SetMinMaxValues(0, 1)
				statusBar:SetValue(i <= currentPower and 1 or 0)
				statusBar:Show()
			end
		end

		self:UpdateBarColors(currentPower)
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

	local function SyncEventRegistration()
		if (EssencesSaved.Settings.UseColors and frame.specId ~= presSpecId) or EssencesSaved.Settings.ShowGlow then
			frame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_SHOW")
			frame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_HIDE")
		else
			frame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_SHOW")
			frame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_HIDE")
			frame.availableEssenceBursts = 0
		end

		if EssencesSaved.Settings.UseColors and frame.specId ~= presSpecId then
			frame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
		else
			frame:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		end
	end

	Private.EventRegistry:RegisterCallback(Private.Enum.Events.SETTING_CHANGED, function(self, key, value)
		if key == Private.Settings.Keys.ShowGlow or key == Private.Settings.Keys.UseColors then
			SyncEventRegistration()
			frame:UpdateBarColors(frame:GetCurrentPower())
		elseif key == Private.Settings.Keys.BaseColor then
			frame.colorBase = HexStringToTable(value)
			frame:UpdateBarColors(frame:GetCurrentPower())
		elseif key == Private.Settings.Keys.CapColor then
			frame.colorCap = HexStringToTable(value)
			frame:UpdateBarColors(frame:GetCurrentPower())
		elseif key == Private.Settings.Keys.NearlyCapColor then
			frame.colorNearlyCap = HexStringToTable(value)
			frame:UpdateBarColors(frame:GetCurrentPower())
		elseif key == Private.Settings.Keys.ShowBackground or key == Private.Settings.Keys.BackgroundBrightness then
			frame:UpdateBarColors(frame:GetCurrentPower())
		elseif
			key == Private.Settings.Keys.OffsetX
			or key == Private.Settings.Keys.OffsetY
			or key == Private.Settings.Keys.BarHeight
			or key == Private.Settings.Keys.Gap
			or key == Private.Settings.Keys.MinWidth
		then
			frame:Relayout()
		elseif key == Private.Settings.Keys.BarTexture then
			for i = 1, 6 do
				frame:GetStatusBarAtIndex(i):SetStatusBarTexture(value)
			end
		elseif key == Private.Settings.Keys.BackgroundTexture then
			for i = 1, 6 do
				frame:GetStatusBarAtIndex(i).Background:SetTexture(value)
			end
		elseif key == Private.Settings.Keys.Preset then
			local presetValues = Private.Settings.GetPresetValues(value)

			for fieldName, fieldValue in pairs(presetValues) do
				EssencesSaved.Settings[fieldName] = fieldValue
				Private.EventRegistry:TriggerEvent(
					Private.Enum.Events.SETTING_CHANGED,
					Private.Settings.Keys[fieldName],
					fieldValue
				)
			end

			LibEditMode:RefreshFrameSettings(frame)
		end
	end, frame)

	---@param self StatusBar
	---@param elapsed number
	local function OnUpdate(self, elapsed)
		self:SetValue(math.min(1, self:GetValue() + elapsed * frame:GetRechargeRate()))
	end

	function frame:OnEvent(event, ...)
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
		elseif event == "SPELLS_CHANGED" then
			self.specId = PlayerUtil.GetCurrentSpecID()
			SyncEventRegistration()
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
				end
			end
		elseif event == "SPELL_ACTIVATION_OVERLAY_SHOW" then
			local spellId = ...

			if not self:IsEssenceBurst(spellId) then
				return
			end

			local nextEssenceBurstCount = self:CountActiveEssenceBursts()

			if nextEssenceBurstCount > 0 and self.availableEssenceBursts ~= nextEssenceBurstCount then
				self.availableEssenceBursts = nextEssenceBurstCount
				self:ToggleGlow(true)
				self:UpdateBarColors(self:GetCurrentPower())
			end
		elseif event == "SPELL_ACTIVATION_OVERLAY_HIDE" then
			local spellId = ...

			-- this should only fire when resetting all spell overlay glows but fires at random times regardless
			if spellId == nil then
				local nextEssenceBurstCount = self:CountActiveEssenceBursts()

				if self.availableEssenceBursts ~= nextEssenceBurstCount then
					self.availableEssenceBursts = nextEssenceBurstCount
					self:ToggleGlow(nextEssenceBurstCount > 0)
					self:UpdateBarColors(self:GetCurrentPower())
				end
			elseif self:IsEssenceBurst(spellId) then
				-- delay briefly as by the time this executes, the overlay is still animating out.
				-- 0.2s is fast enough that you won't notice the delay
				C_Timer.After(0.2, function()
					local nextEssenceBurstCount = self:CountActiveEssenceBursts()

					if self.availableEssenceBursts == nextEssenceBurstCount then
						return
					end

					self.availableEssenceBursts = nextEssenceBurstCount
					self:ToggleGlow(nextEssenceBurstCount > 0)
					self:UpdateBarColors(self:GetCurrentPower())
				end)
			end
		elseif event == "FIRST_FRAME_RENDERED" then
			EssentialCooldownViewer:HookScript("OnSizeChanged", function()
				local nextWidth = EssentialCooldownViewer:GetWidth()

				if nextWidth == frame:GetWidth() then
					return
				end

				PixelUtil.SetSize(frame, nextWidth, EssencesSaved.Settings.BarHeight - 2)
				frame:Relayout()
			end)

			self:Relayout()
		elseif event == "UNIT_MAXPOWER" then
			local unit, powerType = ...

			if powerType == "ESSENCE" then
				self:Relayout()
			end
		end
	end

	frame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
	frame:RegisterUnitEvent("UNIT_MAXPOWER", "player")
	frame:RegisterEvent("SPELLS_CHANGED")
	frame:RegisterEvent("FIRST_FRAME_RENDERED")
	frame:SetScript("OnEvent", frame.OnEvent)

	do
		local function CreateSetting(key, defaults)
			if key == Private.Settings.Keys.Preset then
				local function Generator(_, rootDescription)
					for id, label in pairs(Private.L.Settings.PresetLabels) do
						local function IsEnabled()
							return false -- write-only; no persisted "current preset"
						end

						local function SetProxy()
							Private.EventRegistry:TriggerEvent(
								Private.Enum.Events.SETTING_CHANGED,
								Private.Settings.Keys.Preset,
								id
							)
						end

						rootDescription:CreateRadio(label, IsEnabled, SetProxy)
					end
				end

				---@type LibEditModeDropdown
				return {
					name = Private.L.Settings.PresetLabel,
					kind = Enum.EditModeSettingDisplayType.Dropdown,
					default = Private.Enum.Preset.Xephyris,
					desc = Private.L.Settings.PresetTooltip,
					generator = Generator,
					set = function() end,
				}
			end

			if key == Private.Settings.Keys.ShowGlow then
				local function Get(_)
					return EssencesSaved.Settings.ShowGlow
				end

				local function Set(_, value)
					if EssencesSaved.Settings.ShowGlow ~= value then
						EssencesSaved.Settings.ShowGlow = value
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, value)
					end
				end

				---@type LibEditModeCheckbox
				return {
					name = Private.L.Settings.ShowGlowLabel,
					kind = Enum.EditModeSettingDisplayType.Checkbox,
					default = defaults.ShowGlow,
					desc = Private.L.Settings.ShowGlowTooltip,
					get = Get,
					set = Set,
				}
			end

			if key == Private.Settings.Keys.UseColors then
				local function Get(_)
					return EssencesSaved.Settings.UseColors
				end

				local function Set(_, value)
					if EssencesSaved.Settings.UseColors ~= value then
						EssencesSaved.Settings.UseColors = value
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, value)
					end
				end

				---@type LibEditModeCheckbox
				return {
					name = Private.L.Settings.UseColorsLabel,
					kind = Enum.EditModeSettingDisplayType.Checkbox,
					default = defaults.UseColors,
					desc = Private.L.Settings.UseColorsTooltip,
					get = Get,
					set = Set,
				}
			end

			if key == Private.Settings.Keys.ShowBackground then
				local function Get(_)
					return EssencesSaved.Settings.ShowBackground
				end

				local function Set(_, value)
					if EssencesSaved.Settings.ShowBackground ~= value then
						EssencesSaved.Settings.ShowBackground = value
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, value)
					end
				end

				---@type LibEditModeCheckbox
				return {
					name = Private.L.Settings.ShowBackgroundLabel,
					kind = Enum.EditModeSettingDisplayType.Checkbox,
					default = defaults.ShowBackground,
					desc = Private.L.Settings.ShowBackgroundTooltip,
					get = Get,
					set = Set,
				}
			end

			if key == Private.Settings.Keys.BaseColor then
				local function Get(_)
					return CreateColorFromHexString(EssencesSaved.Settings.BaseColor)
				end

				local function Set(_, value)
					local hex = value:GenerateHexColor()

					if EssencesSaved.Settings.BaseColor ~= hex then
						EssencesSaved.Settings.BaseColor = hex
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, hex)
					end
				end

				---@type LibEditModeColorPicker
				return {
					name = Private.L.Settings.BaseColorLabel,
					kind = LibEditMode.SettingType.ColorPicker,
					default = CreateColorFromHexString(defaults.BaseColor),
					desc = Private.L.Settings.BaseColorTooltip,
					get = Get,
					set = Set,
				}
			end

			if key == Private.Settings.Keys.CapColor then
				local function Get(_)
					return CreateColorFromHexString(EssencesSaved.Settings.CapColor)
				end

				local function Set(_, value)
					local hex = value:GenerateHexColor()

					if EssencesSaved.Settings.CapColor ~= hex then
						EssencesSaved.Settings.CapColor = hex
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, hex)
					end
				end

				---@type LibEditModeColorPicker
				return {
					name = Private.L.Settings.CapColorLabel,
					kind = LibEditMode.SettingType.ColorPicker,
					default = CreateColorFromHexString(defaults.CapColor),
					desc = Private.L.Settings.CapColorTooltip,
					get = Get,
					set = Set,
				}
			end

			if key == Private.Settings.Keys.NearlyCapColor then
				local function Get(_)
					return CreateColorFromHexString(EssencesSaved.Settings.NearlyCapColor)
				end

				local function Set(_, value)
					local hex = value:GenerateHexColor()

					if EssencesSaved.Settings.NearlyCapColor ~= hex then
						EssencesSaved.Settings.NearlyCapColor = hex
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, hex)
					end
				end

				---@type LibEditModeColorPicker
				return {
					name = Private.L.Settings.NearlyCapColorLabel,
					kind = LibEditMode.SettingType.ColorPicker,
					default = CreateColorFromHexString(defaults.NearlyCapColor),
					desc = Private.L.Settings.NearlyCapColorTooltip,
					get = Get,
					set = Set,
				}
			end

			if key == Private.Settings.Keys.OffsetX then
				local sliderSettings = Private.Settings.GetSliderSettingsForKey(key)

				local function Get(_)
					return EssencesSaved.Settings.OffsetX
				end

				local function Set(_, value)
					if EssencesSaved.Settings.OffsetX ~= value then
						EssencesSaved.Settings.OffsetX = value
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, value)
					end
				end

				---@type LibEditModeSlider
				return {
					name = Private.L.Settings.OffsetXLabel,
					kind = Enum.EditModeSettingDisplayType.Slider,
					default = defaults.OffsetX,
					desc = Private.L.Settings.OffsetXTooltip,
					get = Get,
					set = Set,
					minValue = sliderSettings.min,
					maxValue = sliderSettings.max,
					valueStep = sliderSettings.step,
				}
			end

			if key == Private.Settings.Keys.OffsetY then
				local sliderSettings = Private.Settings.GetSliderSettingsForKey(key)

				local function Get(_)
					return EssencesSaved.Settings.OffsetY
				end

				local function Set(_, value)
					if EssencesSaved.Settings.OffsetY ~= value then
						EssencesSaved.Settings.OffsetY = value
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, value)
					end
				end

				---@type LibEditModeSlider
				return {
					name = Private.L.Settings.OffsetYLabel,
					kind = Enum.EditModeSettingDisplayType.Slider,
					default = defaults.OffsetY,
					desc = Private.L.Settings.OffsetYTooltip,
					get = Get,
					set = Set,
					minValue = sliderSettings.min,
					maxValue = sliderSettings.max,
					valueStep = sliderSettings.step,
				}
			end

			if key == Private.Settings.Keys.BarHeight then
				local sliderSettings = Private.Settings.GetSliderSettingsForKey(key)

				local function Get(_)
					return EssencesSaved.Settings.BarHeight
				end

				local function Set(_, value)
					if EssencesSaved.Settings.BarHeight ~= value then
						EssencesSaved.Settings.BarHeight = value
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, value)
					end
				end

				---@type LibEditModeSlider
				return {
					name = Private.L.Settings.BarHeightLabel,
					kind = Enum.EditModeSettingDisplayType.Slider,
					default = defaults.BarHeight,
					desc = Private.L.Settings.BarHeightTooltip,
					get = Get,
					set = Set,
					minValue = sliderSettings.min,
					maxValue = sliderSettings.max,
					valueStep = sliderSettings.step,
				}
			end

			if key == Private.Settings.Keys.Gap then
				local sliderSettings = Private.Settings.GetSliderSettingsForKey(key)

				local function Get(_)
					return EssencesSaved.Settings.Gap
				end

				local function Set(_, value)
					if EssencesSaved.Settings.Gap ~= value then
						EssencesSaved.Settings.Gap = value
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, value)
					end
				end

				---@type LibEditModeSlider
				return {
					name = Private.L.Settings.GapLabel,
					kind = Enum.EditModeSettingDisplayType.Slider,
					default = defaults.Gap,
					desc = Private.L.Settings.GapTooltip,
					get = Get,
					set = Set,
					minValue = sliderSettings.min,
					maxValue = sliderSettings.max,
					valueStep = sliderSettings.step,
				}
			end

			if key == Private.Settings.Keys.BackgroundBrightness then
				local sliderSettings = Private.Settings.GetSliderSettingsForKey(key)

				local function Get(_)
					return EssencesSaved.Settings.BackgroundBrightness
				end

				local function Set(_, value)
					if EssencesSaved.Settings.BackgroundBrightness ~= value then
						EssencesSaved.Settings.BackgroundBrightness = value
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, value)
					end
				end

				---@type LibEditModeSlider
				return {
					name = Private.L.Settings.BackgroundBrightnessLabel,
					kind = Enum.EditModeSettingDisplayType.Slider,
					default = defaults.BackgroundBrightness,
					desc = Private.L.Settings.BackgroundBrightnessTooltip,
					get = Get,
					set = Set,
					minValue = sliderSettings.min,
					maxValue = sliderSettings.max,
					valueStep = sliderSettings.step,
				}
			end

			if key == Private.Settings.Keys.MinWidth then
				local sliderSettings = Private.Settings.GetSliderSettingsForKey(key)

				local function Get(_)
					return EssencesSaved.Settings.MinWidth
				end

				local function Set(_, value)
					if EssencesSaved.Settings.MinWidth ~= value then
						EssencesSaved.Settings.MinWidth = value
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, value)
					end
				end

				---@type LibEditModeSlider
				return {
					name = Private.L.Settings.MinWidthLabel,
					kind = Enum.EditModeSettingDisplayType.Slider,
					default = defaults.MinWidth,
					desc = Private.L.Settings.MinWidthTooltip,
					get = Get,
					set = Set,
					minValue = sliderSettings.min,
					maxValue = sliderSettings.max,
					valueStep = sliderSettings.step,
				}
			end

			if key == Private.Settings.Keys.BarTexture then
				local function Generator(_, rootDescription)
					for name, path in pairs(LibSharedMedia:HashTable(LibSharedMedia.MediaType.STATUSBAR)) do
						local function IsEnabled()
							return EssencesSaved.Settings.BarTexture == path
						end

						local function SetProxy()
							if EssencesSaved.Settings.BarTexture ~= path then
								EssencesSaved.Settings.BarTexture = path
								Private.EventRegistry:TriggerEvent(
									Private.Enum.Events.SETTING_CHANGED,
									Private.Settings.Keys.BarTexture,
									path
								)
							end
						end

						rootDescription:CreateRadio(name, IsEnabled, SetProxy)
					end
				end

				local function Set(_, value)
					if EssencesSaved.Settings.BarTexture ~= value then
						EssencesSaved.Settings.BarTexture = value
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, value)
					end
				end

				---@type LibEditModeDropdown
				return {
					name = Private.L.Settings.BarTextureLabel,
					kind = Enum.EditModeSettingDisplayType.Dropdown,
					default = defaults.BarTexture,
					desc = Private.L.Settings.BarTextureTooltip,
					generator = Generator,
					set = Set,
				}
			end

			if key == Private.Settings.Keys.BackgroundTexture then
				local function Generator(_, rootDescription)
					for name, path in pairs(LibSharedMedia:HashTable(LibSharedMedia.MediaType.BACKGROUND)) do
						local function IsEnabled()
							return EssencesSaved.Settings.BackgroundTexture == path
						end

						local function SetProxy()
							if EssencesSaved.Settings.BackgroundTexture ~= path then
								EssencesSaved.Settings.BackgroundTexture = path
								Private.EventRegistry:TriggerEvent(
									Private.Enum.Events.SETTING_CHANGED,
									Private.Settings.Keys.BackgroundTexture,
									path
								)
							end
						end

						rootDescription:CreateRadio(name, IsEnabled, SetProxy)
					end
				end

				local function Set(_, value)
					if EssencesSaved.Settings.BackgroundTexture ~= value then
						EssencesSaved.Settings.BackgroundTexture = value
						Private.EventRegistry:TriggerEvent(Private.Enum.Events.SETTING_CHANGED, key, value)
					end
				end

				---@type LibEditModeDropdown
				return {
					name = Private.L.Settings.BackgroundTextureLabel,
					kind = Enum.EditModeSettingDisplayType.Dropdown,
					default = defaults.BackgroundTexture,
					desc = Private.L.Settings.BackgroundTextureTooltip,
					generator = Generator,
					set = Set,
				}
			end

			error(string.format("CreateSetting: no widget defined for key '%s'", key or "nil"))
		end

		LibEditMode:AddFrame(
			frame,
			function() end, -- position dragging not used; offsets are managed via settings sliders
			{ point = "CENTER", x = 0, y = 0 },
			addonName
		)

		local sel = LibEditMode.frameSelections[frame]
		-- sel:SetScript("OnMouseDown", nil)
		sel:SetScript("OnDragStart", nil)
		sel:SetScript("OnDragStop", nil)

		local displayOrder = Private.Settings.GetDisplayOrder()
		local defaults = Private.Settings.GetDefaultSettings()
		local settings = {}

		for i = 1, #displayOrder do
			table.insert(settings, CreateSetting(displayOrder[i], defaults))
		end

		LibEditMode:AddFrameSettings(frame, settings)
	end

	SyncEventRegistration()
end)
