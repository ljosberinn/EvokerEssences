---@type string, Essences
local _, Private = ...

---@class EssencesSettings
Private.Settings = {}

Private.Settings.Keys = {
	ShowGlow = "SHOW_GLOW",
	UseColors = "USE_COLORS",
	BaseColor = "BASE_COLOR",
	CapColor = "CAP_COLOR",
	NearlyCapColor = "NEARLY_CAP_COLOR",
	ShowBackground = "SHOW_BACKGROUND",
	OffsetX = "OFFSET_X",
	OffsetY = "OFFSET_Y",
	BarHeight = "BAR_HEIGHT",
	Gap = "GAP",
	BackgroundBrightness = "BACKGROUND_BRIGHTNESS",
	MinWidth = "MIN_WIDTH",
	BarTexture = "BAR_TEXTURE",
	BorderTexture = "BORDER_TEXTURE",
	BackgroundTexture = "BACKGROUND_TEXTURE",
	Preset = "PRESET", -- write-only trigger, not persisted as its own key
}

---@param preset number
---@return EssencesSavedSettings
function Private.Settings.GetPresetValues(preset)
	local isXeph = preset == Private.Enum.Preset.Xeph

	return {
		ShowGlow = isXeph,
		UseColors = isXeph,
		BaseColor = CreateColor(0.2, 0.58, 0.5):GenerateHexColor(),
		CapColor = CreateColor(0.93, 0.21, 0.35):GenerateHexColor(),
		NearlyCapColor = CreateColor(1, 0.5, 0.2):GenerateHexColor(),
		ShowBackground = true,
		OffsetX = 0,
		OffsetY = isXeph and 3 or 2,
		BarHeight = isXeph and 12 or 8,
		Gap = isXeph and 2 or 0,
		BackgroundBrightness = 0.4,
		MinWidth = 200,
		BarTexture = "Interface\\Buttons\\WHITE8X8",
		BorderTexture = "Interface\\Buttons\\WHITE8x8",
		BackgroundTexture = "Interface\\Buttons\\WHITE8X8",
	}
end

---@return EssencesSavedSettings
function Private.Settings.GetDefaultSettings()
	return Private.Settings.GetPresetValues(Private.Enum.Preset.Xeph)
end

---@param key string
---@return SliderSettings
function Private.Settings.GetSliderSettingsForKey(key)
	if key == Private.Settings.Keys.OffsetX or key == Private.Settings.Keys.OffsetY then
		return {
			min = -1000,
			max = 1000,
			step = 1,
		}
	end

	if key == Private.Settings.Keys.BarHeight then
		return {
			min = 1,
			max = 40,
			step = 1,
		}
	end

	if key == Private.Settings.Keys.Gap then
		return {
			min = -20,
			max = 20,
			step = 1,
		}
	end

	if key == Private.Settings.Keys.BackgroundBrightness then
		return {
			min = 0,
			max = 1,
			step = 0.01,
		}
	end

	if key == Private.Settings.Keys.MinWidth then
		return {
			min = 30,
			max = 1000,
			step = 1,
		}
	end

	error(string.format("GetSliderSettingsForKey: no slider settings defined for key '%s'", key or "nil"))
end

function Private.Settings.GetDisplayOrder()
	return {
		Private.Settings.Keys.Preset,
		Private.Settings.Keys.ShowGlow,
		Private.Settings.Keys.UseColors,
		Private.Settings.Keys.BaseColor,
		Private.Settings.Keys.CapColor,
		Private.Settings.Keys.NearlyCapColor,
		Private.Settings.Keys.ShowBackground,
		Private.Settings.Keys.BackgroundBrightness,
		Private.Settings.Keys.OffsetX,
		Private.Settings.Keys.OffsetY,
		Private.Settings.Keys.BarHeight,
		Private.Settings.Keys.Gap,
		Private.Settings.Keys.MinWidth,
		Private.Settings.Keys.BarTexture,
		Private.Settings.Keys.BorderTexture,
		Private.Settings.Keys.BackgroundTexture,
	}
end
