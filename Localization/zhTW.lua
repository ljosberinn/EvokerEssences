---@type string, Essences
local addonName, Private = ...

if GetLocale() ~= "zhTW" then
	return
end

local L = Private.L

L.Settings.ShowGlowLabel = "顯示精華爆發指示器"
L.Settings.EssenceBurstIndicatorLabel = "精華爆發指示器"
L.Settings.EssenceBurstIndicatorTooltip = "如何顯示可用的精華爆發觸發。"
L.Settings.EssenceBurstIndicatorLabels = {
	[Private.Enum.EssenceBurstIndicator.Glow] = "發光",
	[Private.Enum.EssenceBurstIndicator.Border] = "邊框顏色",
}
L.Settings.EssenceBurstBorderColorLabel = "精華爆發邊框顏色"
L.Settings.EssenceBurstBorderColorTooltip = "精華爆發可用時使用的邊框顏色。"
L.Settings.UseColorsLabel = "使用顏色"
L.Settings.ShowCantCastOpacityLabel = "無法施放時變暗"
L.Settings.ShowCantCastOpacityTooltip = "當精華不足以施放消耗類法術時降低不透明度。"
L.Settings.ShowBackgroundLabel = "顯示背景"
L.Settings.ShowRechargingLabel = "顯示充能"
L.Settings.ShowRechargingTooltip = "使正在充能的精華變暗。"
L.Settings.HideWhileSkyridingLabel = "翱翔時隱藏"
L.Settings.HideWhileSkyridingTooltip = "僅當目前坐騎可使用翱翔時隱藏精華條。"

L.Settings.BaseColorLabel = "基礎顏色"
L.Settings.CapColorLabel = "滿值顏色"
L.Settings.CapColorTooltip = "精華達到最大值時使用的顏色。"
L.Settings.NearlyCapColorLabel = "接近滿值顏色"
L.Settings.NearlyCapColorTooltip = "比最大值少一個精華時使用的顏色。"
L.Settings.RechargingDarknessLabel = "充能變暗程度"
L.Settings.RechargingDarknessTooltip = "使正在充能的精華的目前條顏色變暗。0 = 不變，1 = 黑色。"

L.Settings.OffsetXLabel = "水平偏移"
L.Settings.OffsetYLabel = "垂直偏移"
L.Settings.BarHeightLabel = "條高度"
L.Settings.GapLabel = "間距"
L.Settings.BackgroundBrightnessLabel = "背景亮度"
L.Settings.BackgroundBrightnessTooltip = "縮放條顏色以產生背景顏色。0 = 黑色，1 = 與條相同。"
L.Settings.MinWidthLabel = "最小寬度"

L.Settings.PresetLabel = "預設"
L.Settings.BarTextureLabel = "條材質"
L.Settings.BackgroundTextureLabel = "背景材質"
