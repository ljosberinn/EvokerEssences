---@type string, Essences
local addonName, Private = ...

local L = Private.L
L.Settings = {}
L.EditMode = {}

L.Settings.ShowGlowLabel = "Show Essence Burst Indicator"
L.Settings.ShowGlowTooltip = nil
L.Settings.EssenceBurstIndicatorLabel = "Essence Burst Indicator"
L.Settings.EssenceBurstIndicatorTooltip = "How to show available Essence Burst procs."
L.Settings.EssenceBurstIndicatorLabels = {
	[Private.Enum.EssenceBurstIndicator.Glow] = "Glow",
	[Private.Enum.EssenceBurstIndicator.Border] = "Border Color",
}
L.Settings.EssenceBurstBorderColorLabel = "Essence Burst Border Color"
L.Settings.EssenceBurstBorderColorTooltip = "Border color used when Essence Burst is available."
L.Settings.UseColorsLabel = "Use Colors"
L.Settings.UseColorsTooltip = nil
L.Settings.ShowCantCastOpacityLabel = "Dim When Unable To Cast"
L.Settings.ShowCantCastOpacityTooltip = "Lower opacity when you do not have enough essences to cast a spender."
L.Settings.ShowBackgroundLabel = "Show Background"
L.Settings.ShowBackgroundTooltip = nil
L.Settings.ShowRechargingLabel = "Show Recharging"
L.Settings.ShowRechargingTooltip = "Darken the essence currently recharging."
L.Settings.HideWhileSkyridingLabel = "Hide While Skyriding"
L.Settings.HideWhileSkyridingTooltip = "Hide the essence bar only while Skyriding is available on your current mount."

L.Settings.BaseColorLabel = "Base Color"
L.Settings.BaseColorTooltip = nil
L.Settings.CapColorLabel = "Cap Color"
L.Settings.CapColorTooltip = "Color used when at maximum essences."
L.Settings.NearlyCapColorLabel = "Nearly Cap Color"
L.Settings.NearlyCapColorTooltip = "Color used when one essence below the maximum."
L.Settings.RechargingDarknessLabel = "Recharging Darkness"
L.Settings.RechargingDarknessTooltip = "Darkens the current bar color for the essence currently recharging. 0 = unchanged, 1 = black."

L.Settings.OffsetXLabel = "Offset X"
L.Settings.OffsetXTooltip = nil
L.Settings.OffsetYLabel = "Offset Y"
L.Settings.OffsetYTooltip = nil
L.Settings.BarHeightLabel = "Bar Height"
L.Settings.BarHeightTooltip = nil
L.Settings.GapLabel = "Gap"
L.Settings.GapTooltip = nil
L.Settings.BackgroundBrightnessLabel = "Background Brightness"
L.Settings.BackgroundBrightnessTooltip =
	"Scales the bar color to produce the background color. 0 = black, 1 = same as bar."
L.Settings.MinWidthLabel = "Min Width"
L.Settings.MinWidthTooltip = nil

L.Settings.PresetLabel = "Preset"
L.Settings.PresetTooltip = nil
L.Settings.PresetLabels = {
	[Private.Enum.Preset.Xephyris] = "Xephyris",
	[Private.Enum.Preset.Vollmer] = "Vollmer",
}
L.Settings.BarTextureLabel = "Bar Texture"
L.Settings.BarTextureTooltip = nil
L.Settings.BackgroundTextureLabel = "Background Texture"
L.Settings.BackgroundTextureTooltip = nil
