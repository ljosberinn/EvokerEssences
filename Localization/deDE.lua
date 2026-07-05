---@type string, Essences
local addonName, Private = ...

if GetLocale() ~= "deDE" then
	return
end

local L = Private.L

L.Settings.ShowGlowLabel = "Essenzexplosionhervorhebung anzeigen"
L.Settings.EssenceBurstIndicatorLabel = "Essenzexplosion"
L.Settings.EssenceBurstIndicatorTooltip = "Wie verfügbare Essenzexplosion-Procs angezeigt werden."
L.Settings.EssenceBurstIndicatorLabels = {
	[Private.Enum.EssenceBurstIndicator.Glow] = "Leuchten",
	[Private.Enum.EssenceBurstIndicator.Border] = "Randfarbe",
}
L.Settings.EssenceBurstBorderColorLabel = "Essenzexplosionsrandfarbe"
L.Settings.EssenceBurstBorderColorTooltip = "Randfarbe, die verwendet wird, wenn Essenzexplosion verfügbar ist."
L.Settings.UseColorsLabel = "Farben verwenden"
L.Settings.ShowCantCastOpacityLabel = "Abdunkeln, wenn Wirken nicht möglich"
L.Settings.ShowCantCastOpacityTooltip =
"Verringert die Deckkraft, wenn nicht genügend Essenzen zum Wirken eines Verbrauchers vorhanden sind."
L.Settings.ShowBackgroundLabel = "Hintergrund anzeigen"
L.Settings.ShowRechargingLabel = "Aufladen anzeigen"
L.Settings.ShowRechargingTooltip = "Dunkelt die Essenz ab, die gerade aufgeladen wird."
L.Settings.HideWhileSkyridingLabel = "Beim Drachenreiten ausblenden"
L.Settings.HideWhileSkyridingTooltip =
"Blendet die Essenzleiste nur aus, wenn Drachenreiten auf dem aktuellen Reittier verfügbar ist."

L.Settings.BaseColorLabel = "Grundfarbe"
L.Settings.CapColorLabel = "Maximalfarbe"
L.Settings.CapColorTooltip = "Farbe, die bei maximaler Essenzanzahl verwendet wird."
L.Settings.NearlyCapColorLabel = "Fast-Maximalfarbe"
L.Settings.NearlyCapColorTooltip = "Farbe, die bei einer Essenz unter dem Maximum verwendet wird."
L.Settings.RechargingDarknessLabel = "Aufladedunkelheit"
L.Settings.RechargingDarknessTooltip =
"Dunkelt die aktuelle Leistenfarbe für die gerade aufladende Essenz ab. 0 = unverändert, 1 = schwarz."

L.Settings.OffsetXLabel = "Versatz X"
L.Settings.OffsetYLabel = "Versatz Y"
L.Settings.BarHeightLabel = "Leistenhöhe"
L.Settings.GapLabel = "Abstand"
L.Settings.BackgroundBrightnessLabel = "Hintergrundhelligkeit"
L.Settings.BackgroundBrightnessTooltip =
"Skaliert die Leistenfarbe zur Erzeugung der Hintergrundfarbe. 0 = schwarz, 1 = wie die Leiste."
L.Settings.MinWidthLabel = "Mindestbreite"

L.Settings.PresetLabel = "Vorlage"
L.Settings.BarTextureLabel = "Leistentextur"
L.Settings.BackgroundTextureLabel = "Hintergrundtextur"
