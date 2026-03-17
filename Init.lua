---@type string, Essences
local addonName, Private = ...

Private.L = {}

Private.EventRegistry = CreateFromMixins(CallbackRegistryMixin)
Private.EventRegistry:OnLoad()
Private.EventRegistry:GenerateCallbackEvents({ Private.Enum.Events.SETTING_CHANGED })

Private.LoginFnQueue = {}

EventUtil.ContinueOnAddOnLoaded(addonName, function()
	-- only Evokers, see classID here: https://wago.tools/db2/ChrSpecialization
	if select(3, UnitClass("player")) ~= 13 then
		return
	end

	---@type EssencesSaved
	EssencesSaved = EssencesSaved or {}
	EssencesSaved.Settings = EssencesSaved.Settings or {}

	local defaults = Private.Settings.GetDefaultSettings()

	for key, value in pairs(defaults) do
		if EssencesSaved.Settings[key] == nil then
			EssencesSaved.Settings[key] = value
		end
	end

	for i = 1, #Private.LoginFnQueue do
		Private.LoginFnQueue[i]()
	end

	table.wipe(Private.LoginFnQueue)
end)
