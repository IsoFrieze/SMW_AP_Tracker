
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
    if needed <= 0 then return AccessibilityLevel.Inspect end
    if green >= needed then return AccessibilityLevel.Normal end
    if green + yellow >= needed then return AccessibilityLevel.SequenceBreak end
    return AccessibilityLevel.None
end

function Not(code)
    local val = Tracker:FindObjectForCode(code)
    if val.Active then return 0 end
    return 1
end


function CanCarry()
    return Tracker:FindObjectForCode("carry").Active
end

function CanRun()
    return Tracker:FindObjectForCode("progressive_run").CurrentStage >= 1
end

function CanWallRun()
    return Tracker:FindObjectForCode("progressive_run").CurrentStage >= 2
end

function CanSwim()
    return Tracker:FindObjectForCode("progressive_swim").CurrentStage >= 1
end

function CanClimb()
    return Tracker:FindObjectForCode("climb").Active
end

function CanSpinJump()
    return Tracker:FindObjectForCode("spin_jump").Active
end

function HasMushroom()
    return Tracker:FindObjectForCode("progressive_powerup").CurrentStage >= 1
end

function HasFireFlower()
    return Tracker:FindObjectForCode("progressive_powerup").CurrentStage >= 2
end

function HasFeather()
    return Tracker:FindObjectForCode("progressive_powerup").CurrentStage >= 3
end

function HasSuperStar(level)
    return Tracker:FindObjectForCode("star").AcquiredCount >= tonumber(level)
end

function HasPBalloon()
    return Tracker:FindObjectForCode("p_balloon").Active
end

function HasPSwitch()
    return Tracker:FindObjectForCode("p_switch").Active
end

function HasYSP()
    return Tracker:FindObjectForCode("ysp").Active
end

function HasGSP()
    return Tracker:FindObjectForCode("gsp").Active
end

function HasRSP()
    return Tracker:FindObjectForCode("rsp").Active
end

function HasBSP()
    return Tracker:FindObjectForCode("bsp").Active
end

function HasMidway()
    return Tracker:FindObjectForCode("midway").Active
end

function HasItemBox()
    return Tracker:FindObjectForCode("itembox").Active
end

function HasExtraDefense()
    return Tracker:FindObjectForCode("extra_defense").Active
end

function CanBreakTurnBlocks()
    return HasMushroom() and CanSpinJump()
end

function CanCapeFly()
    return HasFeather() and CanRun()
end

function CanGetGreenYoshi()
    return
        Tracker:FindObjectForCode("inventory_yoshi_logic").Active or
        Tracker:FindObjectForCode("level_visit_3").Active or -- tsa
        Tracker:FindObjectForCode("level_visit_262").Active or -- yi2
        Tracker:FindObjectForCode("level_visit_259").Active or -- yi3
        Tracker:FindObjectForCode("level_visit_21").Active or -- dp1
        Tracker:FindObjectForCode("level_visit_6").Active or -- dp4
        Tracker:FindObjectForCode("level_visit_266").Active or -- vd3
        Tracker:FindObjectForCode("level_visit_1").Active or -- vs2
        (Tracker:FindObjectForCode("level_visit_13").Active and CanCarry()) or -- bb2
        (Tracker:FindObjectForCode("level_visit_16").Active and HasRSP()) or -- cm
        Tracker:FindObjectForCode("level_visit_286").Active or -- foi1
        Tracker:FindObjectForCode("level_visit_291").Active or -- foi3
        Tracker:FindObjectForCode("level_visit_34").Active or -- ci1
        Tracker:FindObjectForCode("level_visit_36").Active or -- ci2
        (Tracker:FindObjectForCode("level_visit_271").Active and CanClimb()) or -- vob4
        Tracker:FindObjectForCode("level_visit_296").Active or -- sz5
        -- Tracker:FindObjectForCode("level_visit_294").Active or -- sz7
        (Tracker:FindObjectForCode("level_visit_293").Active and HasPSwitch() and CanCarry()) -- sz8
end

function CanGetRedYoshi()
    return
        Tracker:FindObjectForCode("inventory_yoshi_logic").Active or
        (Tracker:FindObjectForCode("level_visit_308").Active and CanBreakTurnBlocks()) or -- sw1
        Tracker:FindObjectForCode("level_visit_309").Active -- sw4
end

function CanGetYellowYoshi()
    return
        Tracker:FindObjectForCode("inventory_yoshi_logic").Active or
        Tracker:FindObjectForCode("level_visit_306").Active or -- sw3
        (Tracker:FindObjectForCode("level_visit_310").Active and (CanCapeFly() or HasPSwitch())) -- sw5
end

function CanGetBlueYoshi()
    return
        Tracker:FindObjectForCode("inventory_yoshi_logic").Active or
        Tracker:FindObjectForCode("level_visit_304").Active or -- sw2
        ((CanGetGreenYoshi() or CanGetRedYoshi() or CanGetYellowYoshi()) and (
            Tracker:FindObjectForCode("level_visit_15").Active or -- cba
            Tracker:FindObjectForCode("level_visit_277").Active or -- vob2
            Tracker:FindObjectForCode("level_visit_300").Active -- sz3
        ))
end

function CanGetAnyYoshi()
    return CanGetGreenYoshi() or CanGetRedYoshi() or CanGetYellowYoshi() or CanGetBlueYoshi()
end

function CanYoshiCarry()
    return 
        Tracker:FindObjectForCode("yoshitongue").Active and
        (CanGetGreenYoshi() or CanGetYellowYoshi() or CanGetBlueYoshi())
end

function CanCarryOrYoshiTongue()
    return CanCarry() or CanYoshiCarry()
end

function CanYoshiFly()
    return CanYoshiCarry() and CanGetBlueYoshi()
end

function CanFly()
    return CanCapeFly() or CanYoshiFly()
end

function CanCapeSpinFly()
    return CanCapeFly() and CanSpinJump()
end

function HasYoshi()
    return Tracker:FindObjectForCode("yoshi").Active and CanGetAnyYoshi()
end

function CanBeatMediumLevel()
    local can = false
    if Tracker:FindObjectForCode("game_logic_difficulty").CurrentStage == 0 then
        can = HasMushroom() and (HasItemBox() or HasMidway())
    elseif Tracker:FindObjectForCode("game_logic_difficulty").CurrentStage == 1 then
        can = HasMushroom()
    else
        can = true
    end
    if can then return AccessibilityLevel.Normal end
    return AccessibilityLevel.SequenceBreak
end

function CanBeatHardLevel()
    local can = false
    if Tracker:FindObjectForCode("game_logic_difficulty").CurrentStage == 0 then
        can = HasFireFlower() and (HasItemBox() or HasMidway() or HasExtraDefense())
    elseif Tracker:FindObjectForCode("game_logic_difficulty").CurrentStage == 1 then
        can = HasMushroom() and (HasItemBox() or HasMidway())
    else
        can = true
    end
    if can then return AccessibilityLevel.Normal end
    return AccessibilityLevel.SequenceBreak
end

function EnemiesShuffled()
    return Tracker:FindObjectForCode("enemy_shuffle").Active
end

function EnemiesNotShuffled()
    return not EnemiesShuffled()
end