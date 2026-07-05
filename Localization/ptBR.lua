---@type string, Essences
local addonName, Private = ...

if GetLocale() ~= "ptBR" then
	return
end

local L = Private.L

L.Settings.ShowGlowLabel = "Mostrar indicador de Explosão de Essência"
L.Settings.EssenceBurstIndicatorLabel = "Indicador de Explosão de Essência"
L.Settings.EssenceBurstIndicatorTooltip = "Como mostrar os procs de Explosão de Essência disponíveis."
L.Settings.EssenceBurstIndicatorLabels = {
	[Private.Enum.EssenceBurstIndicator.Glow] = "Brilho",
	[Private.Enum.EssenceBurstIndicator.Border] = "Cor da borda",
}
L.Settings.EssenceBurstBorderColorLabel = "Cor da borda de Explosão de Essência"
L.Settings.EssenceBurstBorderColorTooltip = "Cor da borda usada quando Explosão de Essência está disponível."
L.Settings.UseColorsLabel = "Usar cores"
L.Settings.ShowCantCastOpacityLabel = "Esmaecer quando não puder conjurar"
L.Settings.ShowCantCastOpacityTooltip =
	"Reduz a opacidade quando você não tem essências suficientes para conjurar uma magia consumidora."
L.Settings.ShowBackgroundLabel = "Mostrar fundo"
L.Settings.ShowRechargingLabel = "Mostrar recarga"
L.Settings.ShowRechargingTooltip = "Escurece a essência que está sendo recarregada no momento."
L.Settings.HideWhileSkyridingLabel = "Ocultar durante o Voo Dracônico"
L.Settings.HideWhileSkyridingTooltip =
	"Oculta a barra de essência apenas quando o Voo Dracônico está disponível na sua montaria atual."

L.Settings.BaseColorLabel = "Cor base"
L.Settings.CapColorLabel = "Cor no máximo"
L.Settings.CapColorTooltip = "Cor usada quando se está no máximo de essências."
L.Settings.NearlyCapColorLabel = "Cor quase no máximo"
L.Settings.NearlyCapColorTooltip = "Cor usada quando falta uma essência para o máximo."
L.Settings.RechargingDarknessLabel = "Escuridão de recarga"
L.Settings.RechargingDarknessTooltip =
	"Escurece a cor atual da barra para a essência que está sendo recarregada. 0 = inalterado, 1 = preto."

L.Settings.OffsetXLabel = "Deslocamento X"
L.Settings.OffsetYLabel = "Deslocamento Y"
L.Settings.BarHeightLabel = "Altura da barra"
L.Settings.GapLabel = "Espaçamento"
L.Settings.BackgroundBrightnessLabel = "Brilho do fundo"
L.Settings.BackgroundBrightnessTooltip =
	"Ajusta a cor da barra para produzir a cor do fundo. 0 = preto, 1 = igual à barra."
L.Settings.MinWidthLabel = "Largura mínima"

L.Settings.PresetLabel = "Predefinição"
L.Settings.BarTextureLabel = "Textura da barra"
L.Settings.BackgroundTextureLabel = "Textura do fundo"
