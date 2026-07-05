---@type string, Essences
local addonName, Private = ...

if GetLocale() ~= "itIT" then
	return
end

local L = Private.L

L.Settings.ShowGlowLabel = "Mostra indicatore di Esplosione di essenza"
L.Settings.EssenceBurstIndicatorLabel = "Indicatore di Esplosione di essenza"
L.Settings.EssenceBurstIndicatorTooltip = "Come mostrare i proc di Esplosione di essenza disponibili."
L.Settings.EssenceBurstIndicatorLabels = {
	[Private.Enum.EssenceBurstIndicator.Glow] = "Bagliore",
	[Private.Enum.EssenceBurstIndicator.Border] = "Colore del bordo",
}
L.Settings.EssenceBurstBorderColorLabel = "Colore del bordo di Esplosione di essenza"
L.Settings.EssenceBurstBorderColorTooltip = "Colore del bordo usato quando Esplosione di essenza è disponibile."
L.Settings.UseColorsLabel = "Usa colori"
L.Settings.ShowCantCastOpacityLabel = "Attenua quando non puoi lanciare"
L.Settings.ShowCantCastOpacityTooltip =
	"Riduce l'opacità quando non hai abbastanza essenze per lanciare un incantesimo consumatore."
L.Settings.ShowBackgroundLabel = "Mostra sfondo"
L.Settings.ShowRechargingLabel = "Mostra ricarica"
L.Settings.ShowRechargingTooltip = "Scurisce l'essenza attualmente in ricarica."
L.Settings.HideWhileSkyridingLabel = "Nascondi durante il Volo celeste"
L.Settings.HideWhileSkyridingTooltip =
	"Nasconde la barra delle essenze solo quando il Volo celeste è disponibile sulla tua cavalcatura attuale."

L.Settings.BaseColorLabel = "Colore di base"
L.Settings.CapColorLabel = "Colore al massimo"
L.Settings.CapColorTooltip = "Colore usato al massimo delle essenze."
L.Settings.NearlyCapColorLabel = "Colore quasi al massimo"
L.Settings.NearlyCapColorTooltip = "Colore usato con un'essenza sotto il massimo."
L.Settings.RechargingDarknessLabel = "Oscurità di ricarica"
L.Settings.RechargingDarknessTooltip =
	"Scurisce il colore attuale della barra per l'essenza in ricarica. 0 = invariato, 1 = nero."

L.Settings.OffsetXLabel = "Scostamento X"
L.Settings.OffsetYLabel = "Scostamento Y"
L.Settings.BarHeightLabel = "Altezza della barra"
L.Settings.GapLabel = "Spaziatura"
L.Settings.BackgroundBrightnessLabel = "Luminosità dello sfondo"
L.Settings.BackgroundBrightnessTooltip =
	"Scala il colore della barra per produrre il colore dello sfondo. 0 = nero, 1 = uguale alla barra."
L.Settings.MinWidthLabel = "Larghezza minima"

L.Settings.PresetLabel = "Preimpostazione"
L.Settings.BarTextureLabel = "Texture della barra"
L.Settings.BackgroundTextureLabel = "Texture dello sfondo"
