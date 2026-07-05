---@type string, Essences
local addonName, Private = ...

if GetLocale() ~= "esMX" then
	return
end

local L = Private.L

L.Settings.ShowGlowLabel = "Mostrar indicador de Estallido de esencia"
L.Settings.EssenceBurstIndicatorLabel = "Indicador de Estallido de esencia"
L.Settings.EssenceBurstIndicatorTooltip = "Cómo mostrar los procs de Estallido de esencia disponibles."
L.Settings.EssenceBurstIndicatorLabels = {
	[Private.Enum.EssenceBurstIndicator.Glow] = "Brillo",
	[Private.Enum.EssenceBurstIndicator.Border] = "Color del borde",
}
L.Settings.EssenceBurstBorderColorLabel = "Color del borde de Estallido de esencia"
L.Settings.EssenceBurstBorderColorTooltip = "Color del borde usado cuando Estallido de esencia está disponible."
L.Settings.UseColorsLabel = "Usar colores"
L.Settings.ShowCantCastOpacityLabel = "Atenuar cuando no se puede lanzar"
L.Settings.ShowCantCastOpacityTooltip =
	"Reduce la opacidad cuando no tienes suficientes esencias para lanzar un consumidor."
L.Settings.ShowBackgroundLabel = "Mostrar fondo"
L.Settings.ShowRechargingLabel = "Mostrar recarga"
L.Settings.ShowRechargingTooltip = "Oscurece la esencia que se está recargando actualmente."
L.Settings.HideWhileSkyridingLabel = "Ocultar durante el Vuelo dracónico"
L.Settings.HideWhileSkyridingTooltip =
	"Oculta la barra de esencia solo cuando el Vuelo dracónico está disponible en tu montura actual."

L.Settings.BaseColorLabel = "Color base"
L.Settings.CapColorLabel = "Color al máximo"
L.Settings.CapColorTooltip = "Color usado cuando se está al máximo de esencias."
L.Settings.NearlyCapColorLabel = "Color casi al máximo"
L.Settings.NearlyCapColorTooltip = "Color usado cuando falta una esencia para el máximo."
L.Settings.RechargingDarknessLabel = "Oscuridad de recarga"
L.Settings.RechargingDarknessTooltip =
	"Oscurece el color actual de la barra para la esencia que se está recargando. 0 = sin cambios, 1 = negro."

L.Settings.OffsetXLabel = "Desplazamiento X"
L.Settings.OffsetYLabel = "Desplazamiento Y"
L.Settings.BarHeightLabel = "Altura de la barra"
L.Settings.GapLabel = "Separación"
L.Settings.BackgroundBrightnessLabel = "Brillo del fondo"
L.Settings.BackgroundBrightnessTooltip =
	"Escala el color de la barra para producir el color del fondo. 0 = negro, 1 = igual que la barra."
L.Settings.MinWidthLabel = "Anchura mínima"

L.Settings.PresetLabel = "Preajuste"
L.Settings.BarTextureLabel = "Textura de la barra"
L.Settings.BackgroundTextureLabel = "Textura del fondo"
