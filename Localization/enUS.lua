---@type string, Essences
local addonName, Private = ...

local L = Private.L
L.Settings = {}
L.EditMode = {}

L.Settings.ShowGlowLabel = "Show Glow"
L.Settings.ShowGlowTooltip = nil
L.Settings.UseColorsLabel = "Use Colors"
L.Settings.UseColorsTooltip = nil
L.Settings.ShowBackgroundLabel = "Show Background"
L.Settings.ShowBackgroundTooltip = nil

L.Settings.BaseColorLabel = "Base Color"
L.Settings.BaseColorTooltip = nil
L.Settings.CapColorLabel = "Cap Color"
L.Settings.CapColorTooltip = "Color used when at maximum essences."
L.Settings.NearlyCapColorLabel = "Nearly Cap Color"
L.Settings.NearlyCapColorTooltip = "Color used when one essence below the maximum."

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
	[Private.Enum.Preset.Vollmerino] = "Vollmerino",
}
L.Settings.BarTextureLabel = "Bar Texture"
L.Settings.BarTextureTooltip = nil
L.Settings.BorderTextureLabel = "Border Texture"
L.Settings.BorderTextureTooltip = nil
L.Settings.BackgroundTextureLabel = "Background Texture"
L.Settings.BackgroundTextureTooltip = nil
