---@meta

---@class Essences
---@field Enum EssencesEnums
---@field Settings EssencesSettings
---@field EventRegistry CallbackRegistryMixin
---@field L table<string, table<string, string|nil>>
---@field LoginFnQueue function[]

---@class EssencesEnums
---@field Events table<string, string>
---@field Preset table<string, number>
---@field EssenceBurstIndicator table<string, number>

---@class EssencesColor
---@field r number
---@field g number
---@field b number
---@field a number

---@class EssencesStatusBar : StatusBar
---@field elapsed number
---@field Border Frame|BackdropTemplate
---@field Background Texture

---@class EssencesParentFrame : Frame
---@field _PixelGlow Frame?
---@field imminentDestructionStacks number
---@field specId number
---@field availableEssenceBursts number
---@field lastImminentDestructionStart number
---@field colorBase EssencesColor
---@field colorCap EssencesColor
---@field colorNearlyCap EssencesColor
---@field colorEssenceBurstBorder EssencesColor
---@field IsSpender fun(self: EssencesParentFrame, spellId: number): boolean
---@field IsEssenceBurst fun(self: EssencesParentFrame, spellId: number): boolean
---@field GetCurrentPower fun(self: EssencesParentFrame): number
---@field GetMaxPower fun(self: EssencesParentFrame): number
---@field GetPartialPower fun(self: EssencesParentFrame): number
---@field GetRechargeRate fun(self: EssencesParentFrame): number
---@field IsDeepBreathLike fun(self: EssencesParentFrame, id: number): boolean
---@field KnowsImminentDestruction fun(self: EssencesParentFrame): boolean
---@field ToggleGlow fun(self: EssencesParentFrame, show: boolean)
---@field UpdateBarColors fun(self: EssencesParentFrame, currentPower: number)
---@field ShouldHideForSkyriding fun(self: EssencesParentFrame): boolean
---@field UpdateVisibility fun(self: EssencesParentFrame)
---@field QueueVisibilityRefresh fun(self: EssencesParentFrame)
---@field visibilityRefreshTicker FunctionContainer?
---@field GetStatusBarAtIndex fun(self: EssencesParentFrame, i: number): EssencesStatusBar
---@field Relayout fun(self: EssencesParentFrame)
---@field CountActiveEssenceBursts fun(self: EssencesParentFrame): number
---@field OnEvent fun(self: EssencesParentFrame, event: WowEvent, ...)
---@field GetRechargeRate fun(self: EssencesParentFrame): number

---@class EssencesSaved
---@field Settings EssencesSavedSettings

---@class EssencesSavedSettings
---@field ShowGlow boolean
---@field EssenceBurstIndicator number
---@field EssenceBurstBorderColor string
---@field UseColors boolean
---@field ShowCantCastOpacity boolean
---@field ShowRecharging boolean
---@field HideWhileSkyriding boolean
---@field BaseColor string
---@field CapColor string
---@field NearlyCapColor string
---@field RechargingDarkness number
---@field ShowBackground boolean
---@field OffsetX number
---@field OffsetY number
---@field BarHeight number
---@field Gap number
---@field BackgroundBrightness number
---@field MinWidth number
---@field BarTexture string
---@field BackgroundTexture string

---@class EssencesSettings
---@field Keys table<string, string>
---@field GetDefaultSettings fun(): EssencesSavedSettings
---@field GetPresetValues fun(preset: number): EssencesSavedSettings
---@field GetSliderSettingsForKey fun(key: string): SliderSettings
---@field GetDisplayOrder fun(): string[]

---@class SliderSettings
---@field min number
---@field max number
---@field step number

---@class LibEditModeSetting
---@field name string
---@field kind string
---@field desc string?
---@field default number|string|boolean|table
---@field disabled boolean?

---@class LibEditModeGetterSetter
---@field set fun(layoutName: string, value: number|string|boolean|table, fromReset: boolean)
---@field get fun(layoutName: string): number|string|boolean|table

---@class LibEditModeCheckbox : LibEditModeSetting, LibEditModeGetterSetter

---@class LibEditModeDropdownBase : LibEditModeSetting
---@field generator fun(owner, rootDescription, data)
---@field height number?
---@field multiple boolean?

---@class LibEditModeDropdownGenerator : LibEditModeDropdownBase
---@field generator fun(owner, rootDescription, data)

---@class LibEditModeDropdownSet : LibEditModeDropdownBase
---@field set fun(layoutName: string, value: number|string|boolean|table, fromReset: boolean)

---@alias LibEditModeDropdown LibEditModeDropdownGenerator | LibEditModeDropdownSet

---@class LibEditModeSlider : LibEditModeSetting, LibEditModeGetterSetter
---@field minValue number?
---@field maxValue number?
---@field valueStep number?
---@field formatter (fun(value: number): string)|nil

---@class LibEditModeColorPicker : LibEditModeSetting, LibEditModeGetterSetter
---@field hasOpacity boolean?
