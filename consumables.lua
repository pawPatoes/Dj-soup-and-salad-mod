local mod = DJ_mod_obj
SMODS.Consumable {  
    key = 'the_heart',  
    set = 'Spectral',  
    atlas = 'heart_atlas',  
    pos = { x = 0, y = 0 },
    discovered = true,
    soul_pos = {     
        x = 1,     
        y = 0,    
        draw = function(card, scale_mod, rotate_mod)    
            local beat_time = G.TIMERS.REAL * 2.5  
            local beat_phase = beat_time % 1  
              
            local heartbeat  
            if beat_phase < 0.15 then  
                heartbeat = 0.15 + 0.1 * math.sin(beat_phase * math.pi / 0.15)  
            elseif beat_phase < 0.3 then   
                heartbeat = 0.12 + 0.07 * math.sin((beat_phase - 0.15) * math.pi / 0.15)  
            else  
                heartbeat = 0.01 
            end  
              
            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil,     
                card.children.center, heartbeat, rotate_mod)  
        end    
    },    
    loc_txt = {  
        name = 'The Heart',  
        text = {  
            "Destroys all non-{C:attention}Eternal{} Jokers,",  
            "spawns a random {X:dark_edition,C:white}Overpowered{}",  
            "{C:attention}Joker{}"  
        }  
    },  
   
    can_use = function(self, card)  
        return true 
    end,  
      
    use = function(self, card, area, copier)    
        for i = #G.jokers.cards, 1, -1 do  
            local j = G.jokers.cards[i]  
            if not j.ability.eternal then   
                j:start_dissolve()   
            end  
        end  
  
        
        G.E_MANAGER:add_event(Event({  
            trigger = 'after',   
            delay = 0.4,   
            func = function()  
                local op_pool = {}  
                for k, v in pairs(G.P_CENTERS) do  
                    if v.set == 'Joker' and v.rarity == 'DJ_overpowered' then  
                        table.insert(op_pool, k)  
                    end  
                end  
                local chosen_key = #op_pool > 0 and op_pool[math.random(#op_pool)] or 'j_joker'  
                local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_key)  
                _card:add_to_deck()  
                G.jokers:emplace(_card)  
                _card:start_materialize()  
                return true  
            end  
        }))  
    end  
}
------------
-- TAROTS
-----------
SMODS.Consumable {
    key = 'new_song',
    set = 'Tarot', 
    atlas = 'khalid2_atlas',
    pos = { x = 0, y = 0 },
    discovered = true,
    loc_txt = {
        name = 'STREAM',
        text = { 
            "Create a random {C:attention}Joker{}",
            "from the {X:dark_version,C:white}DJ {}{X:dark_version,C:white}Mod{}",
        }
    },
    can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        local owned_djs = {}
        for _, j in ipairs(G.jokers.cards) do
            if j.config.center.key and string.find(j.config.center.key, 'j_DJ') then
                owned_djs[j.config.center.key] = true
            end
        end

        local rarity_roll = pseudorandom('late_night_rarity')
        local target_rarity = 1 
        if rarity_roll > 0.96 then 
            target_rarity = 4           
        elseif rarity_roll > 0.80 then 
            target_rarity = 3   
        elseif rarity_roll > 0.30 then 
            target_rarity = 2           
        else 
            target_rarity = 1           
        end

        local dj_pool = {}
        for k, v in pairs(G.P_CENTERS) do
            if v.set == 'Joker' and string.find(k, 'j_DJ') and not owned_djs[k] then
                if v.rarity == 1 or v.rarity == 2 or v.rarity == 3 or v.rarity == 4 then
                    if v.rarity == target_rarity then
                        table.insert(dj_pool, k)
                    end
                end
            end
        end
        if #dj_pool == 0 then
            for k, v in pairs(G.P_CENTERS) do
                if v.set == 'Joker' and string.find(k, 'j_DJ') and not owned_djs[k] then
                    if v.rarity == 1 or v.rarity == 2 or v.rarity == 3 or v.rarity == 4 then
                        table.insert(dj_pool, k)
                    end
                end
            end
        end

        if #dj_pool > 0 then
            local chosen_key = pseudorandom_element(dj_pool, pseudorandom('late_night_spawn'))
            SMODS.add_card({ set = 'Joker', key = chosen_key })
        else
            SMODS.add_card({ set = 'Joker', key = 'j_joker' }) 
        end
    end
}




SMODS.Tarot {
    key = 'blueprint_tarot',
    atlas = 'khalid2_atlas',
    pos = {x = 1, y = 0},
    config = { max_highlighted = 1 },
    discovered = true,
    
    can_use = function(self, card)
        if G.hand and #G.hand.highlighted == 1 then
            local target = G.hand.highlighted[1]
            return target and (not target.seal or target.seal ~= 'DJ_blueprinted')
        end
        return false
    end,

    use = function(self, card, area, copier)
        local target = G.hand.highlighted[1]
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if target then
                    target.seal = 'DJ_blueprinted'                  
                    if target.set_sprites then 
                        target:set_sprites(target.config.center) 
                    end              
                    play_sound('DJ_lightbulb_sound')         
                    target:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
    end,

    loc_vars = function(self, info_queue, card)
        if SMODS.Seals and SMODS.Seals['DJ_blueprinted'] then
            info_queue[#info_queue+1] = SMODS.Seals['DJ_blueprinted']
        end
        return { vars = { card.config.center.config.max_highlighted } }
    end,

    loc_txt = {
        name = '{C:attention}Brainstorming{} a {C:chips}Blueprint',
        text = {
            "Applies a {C:attention}Blueprinted Seal{}",
            "to {C:attention}#1#{} selected card",
        }
    }
}