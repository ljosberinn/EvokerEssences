---@type string, Essences
local addonName, Private = ...

if GetLocale() ~= "frFR" then
	return
end

local L = Private.L

L.Settings.ShowGlowLabel = "Afficher l'indicateur de Salve d'essence"
L.Settings.EssenceBurstIndicatorLabel = "Indicateur de Salve d'essence"
L.Settings.EssenceBurstIndicatorTooltip = "Comment afficher les procs de Salve d'essence disponibles."
L.Settings.EssenceBurstIndicatorLabels = {
	[Private.Enum.EssenceBurstIndicator.Glow] = "Lueur",
	[Private.Enum.EssenceBurstIndicator.Border] = "Couleur de bordure",
}
L.Settings.EssenceBurstBorderColorLabel = "Couleur de bordure de Salve d'essence"
L.Settings.EssenceBurstBorderColorTooltip = "Couleur de bordure utilisée lorsque Salve d'essence est disponible."
L.Settings.UseColorsLabel = "Utiliser les couleurs"
L.Settings.ShowCantCastOpacityLabel = "Atténuer si incantation impossible"
L.Settings.ShowCantCastOpacityTooltip =
	"Réduit l'opacité lorsque vous n'avez pas assez d'essences pour lancer un sort consommateur."
L.Settings.ShowBackgroundLabel = "Afficher l'arrière-plan"
L.Settings.ShowRechargingLabel = "Afficher la recharge"
L.Settings.ShowRechargingTooltip = "Assombrit l'essence en cours de recharge."
L.Settings.HideWhileSkyridingLabel = "Masquer pendant la Chevauchée céleste"
L.Settings.HideWhileSkyridingTooltip =
	"Masque la barre d'essence uniquement lorsque la Chevauchée céleste est disponible sur votre monture actuelle."

L.Settings.BaseColorLabel = "Couleur de base"
L.Settings.CapColorLabel = "Couleur au maximum"
L.Settings.CapColorTooltip = "Couleur utilisée au maximum d'essences."
L.Settings.NearlyCapColorLabel = "Couleur proche du maximum"
L.Settings.NearlyCapColorTooltip = "Couleur utilisée à une essence en dessous du maximum."
L.Settings.RechargingDarknessLabel = "Assombrissement de recharge"
L.Settings.RechargingDarknessTooltip =
	"Assombrit la couleur actuelle de la barre pour l'essence en cours de recharge. 0 = inchangé, 1 = noir."

L.Settings.OffsetXLabel = "Décalage X"
L.Settings.OffsetYLabel = "Décalage Y"
L.Settings.BarHeightLabel = "Hauteur de la barre"
L.Settings.GapLabel = "Espacement"
L.Settings.BackgroundBrightnessLabel = "Luminosité de l'arrière-plan"
L.Settings.BackgroundBrightnessTooltip =
	"Ajuste la couleur de la barre pour produire la couleur de l'arrière-plan. 0 = noir, 1 = identique à la barre."
L.Settings.MinWidthLabel = "Largeur minimale"

L.Settings.PresetLabel = "Préréglage"
L.Settings.BarTextureLabel = "Texture de la barre"
L.Settings.BackgroundTextureLabel = "Texture de l'arrière-plan"
