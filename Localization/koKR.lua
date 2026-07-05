---@type string, Essences
local addonName, Private = ...

if GetLocale() ~= "koKR" then
	return
end

local L = Private.L

L.Settings.ShowGlowLabel = "정수 분출 표시기 보이기"
L.Settings.EssenceBurstIndicatorLabel = "정수 분출 표시기"
L.Settings.EssenceBurstIndicatorTooltip = "사용 가능한 정수 분출 효과를 표시하는 방식입니다."
L.Settings.EssenceBurstIndicatorLabels = {
	[Private.Enum.EssenceBurstIndicator.Glow] = "외곽 광채",
	[Private.Enum.EssenceBurstIndicator.Border] = "테두리 색상",
}
L.Settings.EssenceBurstBorderColorLabel = "정수 분출 테두리 색상"
L.Settings.EssenceBurstBorderColorTooltip = "정수 분출을 사용할 수 있을 때 사용하는 테두리 색상입니다."
L.Settings.UseColorsLabel = "색상 사용"
L.Settings.ShowCantCastOpacityLabel = "시전 불가 시 흐리게"
L.Settings.ShowCantCastOpacityTooltip = "소모 주문을 시전할 정수가 부족할 때 불투명도를 낮춥니다."
L.Settings.ShowBackgroundLabel = "배경 표시"
L.Settings.ShowRechargingLabel = "충전 표시"
L.Settings.ShowRechargingTooltip = "현재 충전 중인 정수를 어둡게 표시합니다."
L.Settings.HideWhileSkyridingLabel = "용 비행 중 숨기기"
L.Settings.HideWhileSkyridingTooltip = "현재 탈것에서 용 비행을 사용할 수 있을 때만 정수 막대를 숨깁니다."

L.Settings.BaseColorLabel = "기본 색상"
L.Settings.CapColorLabel = "최대 색상"
L.Settings.CapColorTooltip = "정수가 최대일 때 사용하는 색상입니다."
L.Settings.NearlyCapColorLabel = "최대 근접 색상"
L.Settings.NearlyCapColorTooltip = "최대보다 정수 하나 적을 때 사용하는 색상입니다."
L.Settings.RechargingDarknessLabel = "충전 어둡기"
L.Settings.RechargingDarknessTooltip = "현재 충전 중인 정수의 막대 색상을 어둡게 합니다. 0 = 변경 없음, 1 = 검정."

L.Settings.OffsetXLabel = "가로 위치"
L.Settings.OffsetYLabel = "세로 위치"
L.Settings.BarHeightLabel = "막대 높이"
L.Settings.GapLabel = "간격"
L.Settings.BackgroundBrightnessLabel = "배경 밝기"
L.Settings.BackgroundBrightnessTooltip = "막대 색상을 조절하여 배경 색상을 만듭니다. 0 = 검정, 1 = 막대와 동일."
L.Settings.MinWidthLabel = "최소 너비"

L.Settings.PresetLabel = "프리셋"
L.Settings.BarTextureLabel = "막대 텍스처"
L.Settings.BackgroundTextureLabel = "배경 텍스처"
