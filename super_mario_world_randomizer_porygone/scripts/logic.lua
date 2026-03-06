
function BowserCost()
	local currentTokens = Tracker:ProviderCountForCode("boss_tokens")
	local requiredTokens = Tracker:ProviderCountForCode("bosses_required")
	return (currentTokens >= requiredTokens)
end

function LevelVisited(level_id)
	local show_all_levels = Tracker:FindObjectForCode("show_all_levels")
	if show_all_levels.Active then
		return true
	end

	local level_visit = Tracker:FindObjectForCode("level_visit_" .. level_id)
	return level_visit.Active
end

function CanGet5DragonCoins(levelname, num)
    local yellow = 0
    local green = 0
    local gray = 0
    local i = tonumber(num)
    while i > 0 do
        local coin = Tracker:FindObjectForCode("@Dragon Coins/" .. levelname .. "/Dragon Coin #" .. i)
        if coin.AccessibilityLevel == AccessibilityLevel.SequenceBreak then yellow = yellow + 1 end
        if coin.AccessibilityLevel == AccessibilityLevel.Normal then green = green + 1 end
        if coin.AccessibilityLevel == AccessibilityLevel.Cleared then gray = gray + 1 end
        i = i - 1
    end
    local needed = 5 - gray
    if needed <= 0 then return AccessibilityLevel.Cleared end
    if green >= needed then return AccessibilityLevel.Normal end
    if green + yellow >= needed then return AccessibilityLevel.SequenceBreak end
    return AccessibilityLevel.None
end