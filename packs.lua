SMODS.Booster {
    key = 'dj_pack',
    kind = 'Buffoon',
    atlas = 'packs_atlas',
    pos = { x = 0, y = 0 },
    config = { extra = 2, choose = 1 }, 
    display_size = { w = 57, h = 95 },
    cost = 4,
    weight = 1,
    dye = G.C.PURPLE,
    background_colour = G.C.PURPLE,
    discovered = true,
    loc_txt = {
        name = 'DJ Pack',
        group_name = 'DJ Pack',
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{} random {C:attention}DJ Mod{} Jokers"
        }
    },
    create_card = function(self, card, i)
    local rarity_roll = pseudorandom('dj_pack_rarity'..G.GAME.round_resets.ante..i)
    local target_rarity = 1 
    if rarity_roll > 0.96 then target_rarity = 4           
    elseif rarity_roll > 0.80 then target_rarity = 3   
    elseif rarity_roll > 0.30 then target_rarity = 2                    
    else target_rarity = 1 end
    local dj_pool = {}
    local used_keys = {}
    if G.pack_cards and G.pack_cards.cards then
        for _, v in ipairs(G.pack_cards.cards) do
            used_keys[v.config.center.key] = true
        end
    end
    for k, v in pairs(G.P_CENTERS) do
        if v.set == 'Joker' and v.rarity == target_rarity and string.find(k, 'j_DJ') then
            if not used_keys[k] then 
                table.insert(dj_pool, k) 
            end
        end
    end
    if #dj_pool == 0 then
        for r = 1, 4 do
            for k, v in pairs(G.P_CENTERS) do
                if v.set == 'Joker' and v.rarity == r and string.find(k, 'j_DJ') then
                    if not used_keys[k] then table.insert(dj_pool, k) end
                end
            end
            if #dj_pool > 0 then break end
        end
    end
    local chosen_key = (#dj_pool == 0) and 'j_joker' or pseudorandom_element(dj_pool, pseudorandom('dj_pack_spawn'..i))
    return SMODS.create_card({
        set = "Joker",
        area = G.pack_cards,
        key = chosen_key,
        skip_materialize = true 
    })
end
}

SMODS.Booster {
    key = 'dj_pack2',
    kind = 'Buffoon',
    atlas = 'packs_atlas',
    pos = { x = 1, y = 0 },
    config = { extra = 4, choose = 2 }, 
    dye = G.C.PURPLE,
    background_colour = G.C.PURPLE,
    display_size = { w = 57, h = 95 },
    cost = 8,
    weight = 1,
    discovered = true,
    loc_txt = {
        name = 'MEGA!!! DJ Pack',
        group_name = 'MEGA!!! DJ Pack',
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{} random {C:attention}DJ Mod{} Jokers"
        }
    },
    create_card = function(self, card, i)
    local rarity_roll = pseudorandom('dj_pack_rarity'..G.GAME.round_resets.ante..i)
    local target_rarity = 1 
    if rarity_roll > 0.96 then target_rarity = 4           
    elseif rarity_roll > 0.80 then target_rarity = 3   
    elseif rarity_roll > 0.30 then target_rarity = 2                    
    else target_rarity = 1 end

    local dj_pool = {}
    local used_keys = {}
    if G.pack_cards and G.pack_cards.cards then
        for _, v in ipairs(G.pack_cards.cards) do
            used_keys[v.config.center.key] = true
        end
    end
    for k, v in pairs(G.P_CENTERS) do
        if v.set == 'Joker' and v.rarity == target_rarity and string.find(k, 'j_DJ') then
            if not used_keys[k] then 
                table.insert(dj_pool, k) 
            end
        end
    end
    if #dj_pool == 0 then
        for r = 1, 4 do
            for k, v in pairs(G.P_CENTERS) do
                if v.set == 'Joker' and v.rarity == r and string.find(k, 'j_DJ') then
                    if not used_keys[k] then table.insert(dj_pool, k) end
                end
            end
            if #dj_pool > 0 then break end
        end
    end
    local chosen_key = (#dj_pool == 0) and 'j_joker' or pseudorandom_element(dj_pool, pseudorandom('dj_pack_spawn'..i))
    return SMODS.create_card({
        set = "Joker",
        area = G.pack_cards,
        key = chosen_key,
        skip_materialize = true 
    })
end
}