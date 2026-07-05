---@type string, Essences
local addonName, Private = ...

if GetLocale() ~= "zhCN" then
	return
end

local L = Private.L

L.Settings.ShowGlowLabel = "显示精华爆发指示器"
L.Settings.EssenceBurstIndicatorLabel = "精华爆发指示器"
L.Settings.EssenceBurstIndicatorTooltip = "如何显示可用的精华爆发触发。"
L.Settings.EssenceBurstIndicatorLabels = {
	[Private.Enum.EssenceBurstIndicator.Glow] = "发光",
	[Private.Enum.EssenceBurstIndicator.Border] = "边框颜色",
}
L.Settings.EssenceBurstBorderColorLabel = "精华爆发边框颜色"
L.Settings.EssenceBurstBorderColorTooltip = "精华爆发可用时使用的边框颜色。"
L.Settings.UseColorsLabel = "使用颜色"
L.Settings.ShowCantCastOpacityLabel = "无法施放时变暗"
L.Settings.ShowCantCastOpacityTooltip = "当精华不足以施放消耗类技能时降低不透明度。"
L.Settings.ShowBackgroundLabel = "显示背景"
L.Settings.ShowRechargingLabel = "显示充能"
L.Settings.ShowRechargingTooltip = "使正在充能的精华变暗。"
L.Settings.HideWhileSkyridingLabel = "驭空飞行时隐藏"
L.Settings.HideWhileSkyridingTooltip = "仅当当前坐骑可使用驭空飞行时隐藏精华条。"

L.Settings.BaseColorLabel = "基础颜色"
L.Settings.CapColorLabel = "满值颜色"
L.Settings.CapColorTooltip = "精华达到最大值时使用的颜色。"
L.Settings.NearlyCapColorLabel = "接近满值颜色"
L.Settings.NearlyCapColorTooltip = "比最大值少一个精华时使用的颜色。"
L.Settings.RechargingDarknessLabel = "充能变暗程度"
L.Settings.RechargingDarknessTooltip = "使正在充能的精华的当前条颜色变暗。0 = 不变，1 = 黑色。"

L.Settings.OffsetXLabel = "横向偏移"
L.Settings.OffsetYLabel = "纵向偏移"
L.Settings.BarHeightLabel = "条高度"
L.Settings.GapLabel = "间距"
L.Settings.BackgroundBrightnessLabel = "背景亮度"
L.Settings.BackgroundBrightnessTooltip = "缩放条颜色以生成背景颜色。0 = 黑色，1 = 与条相同。"
L.Settings.MinWidthLabel = "最小宽度"

L.Settings.PresetLabel = "预设"
L.Settings.BarTextureLabel = "条材质"
L.Settings.BackgroundTextureLabel = "背景材质"
