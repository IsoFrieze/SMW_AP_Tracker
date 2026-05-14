ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/tab_mapping.lua")

LEVEL_UNLOCKS = {}


CUR_INDEX = -1
SLOT_DATA = nil


function onClear(slot_data)   
    SLOT_DATA = slot_data
    CUR_INDEX = -1

    for _, v in pairs(ITEM_MAPPING) do
        if v[1] then
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    if obj.Active then
                        obj.CurrentStage = 0
                    --else
                    --    obj.Active = true
                    end
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                end
            end
        end
    end
    for _, v in pairs(SETTINGS_MAPPING) do
        if v[1] then
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                obj.AcquiredCount = 0
            end
        end
    end
    for _, v in pairs(BLOCK_CHECKS_MAPPING) do
        local obj = Tracker:FindObjectForCode(v)
        if obj then
            obj.Active = false
        end
    end
    for _, v in pairs(CARRYLESS_MAPPING) do
        local obj = Tracker:FindObjectForCode(v)
        if obj then
            obj.Active = false
        end
    end
    for _, v in pairs(EXTRA_LOGIC_MAPPING) do
        local obj = Tracker:FindObjectForCode(v)
        if obj then
            obj.Active = false
        end
    end
    for room_id, v in pairs(TAB_MAPPING) do
        if room_id then
            local obj = Tracker:FindObjectForCode("level_visit_" .. room_id)
            if obj then
                obj.AcquiredCount = 0
            end
        end
    end

    for _, location_array in pairs(LOCATION_MAPPING) do
        for _, location in pairs(location_array) do
            if location then
                local obj = Tracker:FindObjectForCode(location)
                if obj then
                    if location:sub(1, 1) == "@" then
                        obj.AvailableChestCount = obj.ChestCount
                    else
                        obj.Active = false
                    end
                end
            end
        end
    end

    PLAYER_ID = Archipelago.PlayerNumber or -1
    TEAM_NUMBER = Archipelago.TeamNumber or 0

    if SLOT_DATA == nil then
        return
    end

    if slot_data['dragon_coin_checks'] then
        local dragon_coins = Tracker:FindObjectForCode("dragon_coin_checks")
        dragon_coins.Active = (slot_data['dragon_coin_checks'] ~= 0)
    end
    if slot_data['moon_checks'] then
        local moons = Tracker:FindObjectForCode("moon_checks")
        moons.Active = (slot_data['moon_checks'] ~= 0)
    end
    if slot_data['hidden_1up_checks'] then
        local hidden_1ups = Tracker:FindObjectForCode("hidden_1up_checks")
        hidden_1ups.Active = (slot_data['hidden_1up_checks'] ~= 0)
    end
    if slot_data['star_block_checks'] then
        local bonus_blocks = Tracker:FindObjectForCode("bonus_block_checks")
        bonus_blocks.Active = (slot_data['star_block_checks'] ~= 0)
    end
    if slot_data['block_checks'] then
        for _, check in pairs(slot_data['block_checks']) do
            local map = BLOCK_CHECKS_MAPPING[check]
            if map then
                local obj = Tracker:FindObjectForCode(map)
                if obj then
                    obj.Active = true
                end
            end
        end
    end
    if slot_data['alternate_logic'] then
        for _, logic in pairs(slot_data['alternate_logic']) do
            local map = EXTRA_LOGIC_MAPPING[logic]
            if map then
                local obj = Tracker:FindObjectForCode(map)
                if obj then
                    obj.Active = true
                end
            end
        end
    end
    if slot_data['midway_point_checks'] then
        local midway_points = Tracker:FindObjectForCode("midway_point_checks")
        midway_points.Active = (slot_data['midway_point_checks'] ~= 0)
    end
    if slot_data['room_checks'] then
        local rooms = Tracker:FindObjectForCode("room_checks")
        rooms.Active = (slot_data['room_checks'] ~= 0)
    end
    Tracker:FindObjectForCode("yoshi_eggs_required").AcquiredCount = 0

    if Archipelago.PlayerNumber>-1 then
        EVENT_ID="smw_curlevelid_"..TEAM_NUMBER.."_"..PLAYER_ID
        print(string.format("SET NOTIFY %s",EVENT_ID))
        Archipelago:SetNotify({EVENT_ID})
        Archipelago:Get({EVENT_ID})

        EVENT_ID="smw_visitedlevels_"..TEAM_NUMBER.."_"..PLAYER_ID
        print(string.format("SET NOTIFY %s",EVENT_ID))
        Archipelago:SetNotify({EVENT_ID})
        Archipelago:Get({EVENT_ID})
    end

    --Default tab switching to on
    Tracker:FindObjectForCode("tab_switch").Active = 1
    Tracker:FindObjectForCode("show_all_levels").Active = 0
end

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then return end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    
    local v = ITEM_MAPPING[item_id]
    if not v then
        return
    end

    if not v[1] then
        return
    end

    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "progressiveskip" then
            obj.Active = true
            obj.CurrentStage = v[3]
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        end
    end
end

function onLocation(location_id, location_name)
    local location_array = LOCATION_MAPPING[location_id]
    if not location_array or not location_array[1] then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
        return
    end

    for _, location in pairs(location_array) do
        local obj = Tracker:FindObjectForCode(location)
        if obj then
            if location:sub(1,1) == "@" then
                obj.AvailableChestCount = obj.AvailableChestCount - 1 
            else
                obj.Active = true
            end
        else 
            print(string.format("onLocation: could not find object for code %s", location))
        end
    end
end

function onNotify(key, value, old_value)
    updateEvents(key, value)
end

function onNotifyLaunch(key, value)
    updateEvents(key, value)
end

function updateEvents(key, value)
    print(key)
    if value ~= nil then
        if string.find(key, "smw_curlevelid_") then
            print(string.format("updateEvents %x",value))
            local tabswitch = Tracker:FindObjectForCode("tab_switch")
            Tracker:FindObjectForCode("cur_level_id").CurrentStage = value
            if tabswitch.Active then
                if TAB_MAPPING[value] then
                    CURRENT_ROOM = TAB_MAPPING[value]
                    for str in string.gmatch(CURRENT_ROOM, "([^/]+)") do
                        print(string.format("Updating ID %x to Tab %s",value,str))
                        Tracker:UiHint("ActivateTab", str)
                    end
                    print(string.format("Updating ID %x to Tab %s",value,CURRENT_ROOM))
                else
                    --CURRENT_ROOM = TAB_MAPPING[0x00]
                    print(string.format("Failed to find ID %x",value))
                    --Tracker:UiHint("ActivateTab", CURRENT_ROOM)
                end
            end
        elseif string.find(key, "smw_visitedlevels_") then
            --print(string.format("updateEvents %x",value))
            for _, level_id in ipairs(value) do
                level_visit = Tracker:FindObjectForCode("level_visit_" .. level_id)
                if level_visit ~= nil and not level_visit.Active then
                    level_visit.Active = 1
                    print("Setting level_visit_" .. level_id)
                    
                    -- reveal required eggs only when Yoshi's House is visited
                    -- doesn't actually work because a 'level_visit' tag for yoshi's house isn't even recorded
                    if level_id == 260 then
                        local eggs = Tracker:FindObjectForCode("yoshi_eggs_required")
                        eggs.AcquiredCount = SLOT_DATA['required_egg_count']
                    end
                    
                    -- reveal carryless exit only when that level is entered
                    -- still spoilers, until you actually see the keyhole/red orb
                    if SLOT_DATA['carryless_exits'] then
                        local translevel = level_id
                        if translevel > 36 then translevel = translevel - 256 + 36 end
                        for _, cexit in pairs(SLOT_DATA['carryless_exits']) do
                            if cexit == translevel then
                                local map = CARRYLESS_MAPPING[cexit]
                                if map then
                                    local obj = Tracker:FindObjectForCode(map)
                                    if obj then
                                        -- obj.Active = true
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)


