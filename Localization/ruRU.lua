---@type string, Essences
local addonName, Private = ...

if GetLocale() ~= "ruRU" then
	return
end

local L = Private.L

L.Settings.ShowGlowLabel = "Показывать индикатор Выброса Сущности"
L.Settings.EssenceBurstIndicatorLabel = "Индикатор Выброса Сущности"
L.Settings.EssenceBurstIndicatorTooltip = "Как отображать доступные срабатывания Выброса Сущности."
L.Settings.EssenceBurstIndicatorLabels = {
	[Private.Enum.EssenceBurstIndicator.Glow] = "Свечение",
	[Private.Enum.EssenceBurstIndicator.Border] = "Цвет рамки",
}
L.Settings.EssenceBurstBorderColorLabel = "Цвет рамки Выброса Сущности"
L.Settings.EssenceBurstBorderColorTooltip = "Цвет рамки, используемый когда доступен Выброс Сущности."
L.Settings.UseColorsLabel = "Использовать цвета"
L.Settings.ShowCantCastOpacityLabel = "Затемнять, когда нельзя применить"
L.Settings.ShowCantCastOpacityTooltip =
	"Снижает непрозрачность, когда не хватает сущностей для применения расходующего заклинания."
L.Settings.ShowBackgroundLabel = "Показывать фон"
L.Settings.ShowRechargingLabel = "Показывать восстановление"
L.Settings.ShowRechargingTooltip = "Затемняет сущность, которая сейчас восстанавливается."
L.Settings.HideWhileSkyridingLabel = "Скрывать во время Полёта верхом"
L.Settings.HideWhileSkyridingTooltip =
	"Скрывает шкалу сущностей только когда на текущем средстве передвижения доступен Полёт верхом."

L.Settings.BaseColorLabel = "Основной цвет"
L.Settings.CapColorLabel = "Цвет при максимуме"
L.Settings.CapColorTooltip = "Цвет, используемый при максимальном количестве сущностей."
L.Settings.NearlyCapColorLabel = "Цвет почти при максимуме"
L.Settings.NearlyCapColorTooltip = "Цвет, используемый, когда до максимума не хватает одной сущности."
L.Settings.RechargingDarknessLabel = "Затемнение при восстановлении"
L.Settings.RechargingDarknessTooltip =
	"Затемняет текущий цвет шкалы для восстанавливающейся сущности. 0 = без изменений, 1 = чёрный."

L.Settings.OffsetXLabel = "Смещение по X"
L.Settings.OffsetYLabel = "Смещение по Y"
L.Settings.BarHeightLabel = "Высота шкалы"
L.Settings.GapLabel = "Промежуток"
L.Settings.BackgroundBrightnessLabel = "Яркость фона"
L.Settings.BackgroundBrightnessTooltip =
	"Масштабирует цвет шкалы для получения цвета фона. 0 = чёрный, 1 = как у шкалы."
L.Settings.MinWidthLabel = "Минимальная ширина"

L.Settings.PresetLabel = "Шаблон"
L.Settings.BarTextureLabel = "Текстура шкалы"
L.Settings.BackgroundTextureLabel = "Текстура фона"
