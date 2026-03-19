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
          
        -- Initialize pack session tracking  
        if not SMODS.OPENED_BOOSTER.session_used_keys then  
            SMODS.OPENED_BOOSTER.session_used_keys = {}  
        end  
          
        local dj_pool = {}  
        local used_keys = {}  
          
        -- Copy player-owned jokers to used_keys  
        if G.jokers and G.jokers.cards then  
            for _, v in ipairs(G.jokers.cards) do  
                used_keys[v.config.center.key] = true  
            end  
        end  
          
        -- Copy pack session jokers to used_keys  
        for k, v in pairs(SMODS.OPENED_BOOSTER.session_used_keys) do  
            used_keys[k] = v  
        end  
          
        -- Build pool of available DJ jokers at target rarity  
        for k, v in pairs(G.P_CENTERS) do  
            if v.set == 'Joker' and v.rarity == target_rarity and string.find(k, 'j_DJ') then  
                if not used_keys[k] then   
                    table.insert(dj_pool, k)   
                end  
            end  
        end  
          
        -- Fallback: try all rarities if target rarity pool is empty  
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
          
        -- Track this joker for the current pack session  
        SMODS.OPENED_BOOSTER.session_used_keys[chosen_key] = true  
          
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
          
        -- Initialize pack session tracking  
        if not SMODS.OPENED_BOOSTER.session_used_keys then  
            SMODS.OPENED_BOOSTER.session_used_keys = {}  
        end  
          
        local dj_pool = {}  
        local used_keys = {}  
          
        -- Copy player-owned jokers to used_keys  
        if G.jokers and G.jokers.cards then  
            for _, v in ipairs(G.jokers.cards) do  
                used_keys[v.config.center.key] = true  
            end  
        end  
          
        -- Copy pack session jokers to used_keys  
        for k, v in pairs(SMODS.OPENED_BOOSTER.session_used_keys) do  
            used_keys[k] = v  
        end  
          
        -- Build pool of available DJ jokers at target rarity  
        for k, v in pairs(G.P_CENTERS) do  
            if v.set == 'Joker' and v.rarity == target_rarity and string.find(k, 'j_DJ') then  
                if not used_keys[k] then   
                    table.insert(dj_pool, k)   
                end  
            end  
        end  
          
        -- Fallback: try all rarities if target rarity pool is empty  
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
          
        -- Track this joker for the current pack session  
        SMODS.OPENED_BOOSTER.session_used_keys[chosen_key] = true  
          
        return SMODS.create_card({  
            set = "Joker",  
            area = G.pack_cards,  
            key = chosen_key,  
            skip_materialize = true   
        })  
    end  
}