---@type string, Essences
local _, Private = ...

---@class EssencesEnums
Private.Enum = {}

---@enum EssencesEvents
Private.Enum.Events = {
	SETTING_CHANGED = "SETTING_CHANGED",
}

---@enum Preset
Private.Enum.Preset = {
	Xephyris = 1,
	Vollmer = 2,
}

---@enum EssenceBurstIndicator
Private.Enum.EssenceBurstIndicator = {
	Glow = 1,
	Border = 2,
}
