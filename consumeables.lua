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
        check_for_unlock({type = 'dj_use_heart', card = card})
        G.E_MANAGER:add_event(Event({
        func = function()
            local deck_key = 'b_DJ_w_hole_deck'
            if G.P_CENTERS[deck_key] and not G.P_CENTERS[deck_key].unlocked then
                G.P_CENTERS[deck_key].unlocked = true
                unlock_card(G.P_CENTERS[deck_key]) 
                G:save_settings()
            end
            return true
        end
        }))
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
G.EYE_GLITCH_TYPE = nil

SMODS.DrawStep {
    key = 'eye_glitch_visual',
    order = 2000, 
    func = function(self)
        if G.EYE_GLITCH_TYPE and G.ASSET_ATLAS[G.EYE_GLITCH_TYPE] then
            local atlas = G.ASSET_ATLAS[G.EYE_GLITCH_TYPE]
            if not atlas or not atlas.image then return end

            love.graphics.push('all')
            love.graphics.origin()
            love.graphics.setColor(1, 1, 1, 1) 
            
            -- --- SETTINGS ---
            local speed = 20  -- How many "jumps" per second
            local intensity = 0.05 -- Max jump distance (5% of screen)
            local overscale = 1.15 -- Make image 15% bigger to hide borders
            
            -- 1. SNAP LOGIC
            -- Using math.floor makes the value "step" instead of "slide"
            local snap_t = math.floor(G.TIMERS.REAL * speed)
            
            -- Use the snapped time to generate a constant offset for the entire frame
            -- Use a pseudo-random seed based on the snap_t
            local offset_x = (math.sin(snap_t * 12.9898) * 43758.5453 % 1 - 0.5) * (love.graphics.getWidth() * intensity)
            local offset_y = (math.sin(snap_t * 78.233) * 43758.5453 % 1 - 0.5) * (love.graphics.getHeight() * intensity)
            
            -- 2. CENTER & OVERSCALE
            -- Calculate base scale to fill screen, then multiply by overscale
            local screen_w = love.graphics.getWidth()
            local screen_h = love.graphics.getHeight()
            local base_scale_x = screen_w / atlas.image:getWidth()
            local base_scale_y = screen_h / atlas.image:getHeight()
            
            local final_scale_x = base_scale_x * overscale
            local final_scale_y = base_scale_y * overscale
            
            -- Calculate centering offset so the oversized image covers the edges
            local center_x = (screen_w - (atlas.image:getWidth() * final_scale_x)) / 2
            local center_y = (screen_h - (atlas.image:getHeight() * final_scale_y)) / 2

            -- 3. DRAW
            -- Add the center_x/y to the jump offset_x/y
            love.graphics.draw(atlas.image, center_x + offset_x, center_y + offset_y, 0, 
                final_scale_x, final_scale_y)
                
            love.graphics.pop()
        end
    end
}
SMODS.Consumable {
    key = 'eye',
    set = 'Spectral',
    discovered = true,
    hidden = false,
    atlas = 'khalid2_atlas',
    pos = { x = 4, y = 0 },
    soul_pos = { 
        x = 4, y = 1,
        extra = { x = 4, y = 2 },
        draw = function(card, scale_mod, rotate_mod)
            local teleport_rate = 0.08 
            local time_step = math.floor(G.TIMERS.REAL / teleport_rate)
            math.randomseed(time_step)
            local mdx = (math.random() - 0.5) * 0.05 
            local mdy = (math.random() - 0.5) * 0.05     
            if math.random() > 0.1 then
                if card.children and card.children.floating_sprite then
                    card.children.floating_sprite:set_sprite_pos({x = 4, y = 1})
                    card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, 
                        card.children.center, scale_mod, rotate_mod, mdx, mdy)
                end
            end
            for i = 1, 10 do
                local cdx = (math.random() - 0.5) * 3.2
                local cdy = (math.random() - 0.5) * 3.2
                if math.abs(cdx) < 0.6 then cdx = cdx * 2.0 end 
                if math.abs(cdy) < 0.6 then cdy = cdy * 2.0 end  
                local crot = (math.random() - 0.5) * 20      
                if math.random() > 0.25 then
                    if card.children and card.children.floating_sprite then
                        card.children.floating_sprite:set_sprite_pos({x = 4, y = 2})
                        card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, 
                            card.children.center, scale_mod, rotate_mod + crot, cdx, cdy)
                    end
                end
            end
            card.children.floating_sprite:set_sprite_pos({x = 4, y = 1})
            math.randomseed(os.time())
        end
    },
    loc_txt = {
        name = 'The Eye',
        text = {
            "Restart the run at {C:attention}Ante 1{}",
            "{C:red}Lose all{} Jokers, Consumables, and Gold",
            "Permanently Increase {C:attention}Blind sizes{} by a LOT",
            "Manifest a random {C:attention}Surreal{} Joker",
            "{C:attention}Surreal{} jokers {C:red}cannot{} be {C:red}debuffed",
            "{C:red}(JUMPSCARE WARNING!)",
            "{C:inactive,s:0.8}IS THAT A MAYHEM REFERENCE"
        }
    },
    in_pool = function(self, args)
        return pseudorandom('the_eye_pool') < 0.5
    end,
    cost = 20,
    can_use = function(self, card) return true end,
    use = function(self, card, area, copier)
        check_for_unlock({type = 'dj_eye_used'})
    G.E_MANAGER:add_event(Event({
        func = function()
            local deck_key = 'b_DJ_hole_deck'
            if G.P_CENTERS[deck_key] and not G.P_CENTERS[deck_key].unlocked then
                G.P_CENTERS[deck_key].unlocked = true
                unlock_card(G.P_CENTERS[deck_key])
                G:save_settings()
            end
            return true
        end
    }))
        G.eye_prev_speed = G.SETTINGS.GAMESPEED
        G.eye_prev_vol = G.SETTINGS.SOUND.music_volume   
        G.GAME.cry_body_multiplier = (G.GAME.cry_body_multiplier or 1) * 350
        G.GAME.ante = 1
        G.GAME.round_resets.ante = 1
        G.GAME.dollars = 4
        for i = #G.jokers.cards, 1, -1 do G.jokers.cards[i]:remove() end
        for i = #G.consumeables.cards, 1, -1 do G.consumeables.cards[i]:remove() end
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.SETTINGS.GAMESPEED = 1
                G.SETTINGS.SOUND.music_volume = 0
                G.EYE_GLITCH_TYPE = "DJ_seek" 
                play_sound("DJ_seek_sound", 1, 1.5)
                
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 1.3, 
            func = function()
                G.EYE_GLITCH_TYPE = nil 
                G.SETTINGS.GAMESPEED = G.eye_prev_speed or 1
                G.SETTINGS.SOUND.music_volume = G.eye_prev_vol or 100
                for k, v in pairs(G.GAME.hands) do
                    v.level = 1
                    v.played = 0
                    v.mult = v.s_mult or 10
                    v.chips = v.s_chips or 10
                end
                local sur_pool = {}
                for k, v in pairs(G.P_CENTERS) do
                    if v.set == 'Joker' and v.rarity == 'DJ_surreal' then 
                        table.insert(sur_pool, k) 
                    end
                end    
                
                local chosen_key = #sur_pool > 0 
                    and sur_pool[math.random(#sur_pool)] 
                    or 'j_joker'
                    
                local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_key, 'eye_spawn')
                _card:add_to_deck()
                G.jokers:emplace(_card)
                _card:start_materialize()        
                
                if shake_screen then shake_screen(30, 45) end
                G.HUD:recalculate()
                
                return true
            end
        }))
    end
}
SMODS.Consumable {    
    key = 'spawnuni',    
    set = 'Spectral',    
    atlas = 'place_atlas',    
    discovered = true,  
    pos = { x = 0, y = 0 },    
    weight = 1,    
    cost = 10,  
    in_pool = function(self, args)  
        return G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante and G.GAME.round_resets.ante >= 8  
    end,  
    set_badges = function(self, card, badges)    
            badges[#badges + 1] = {n=G.UIT.R, config={align = "cm"}, nodes={  
                {n=G.UIT.R, config={align = "cm", colour = {0.2, 0.05, 0.35, 1}, r = 0.1, minw = 2, minh = 0.50, emboss = 0.05, padding = 0.03}, nodes={  
                    {n=G.UIT.B, config={h=0.1,w=0.03}},  
                    {n=G.UIT.T, config={text = " Endless Exclusive ", colour = G.C.WHITE, scale = 0.33, shadow = true}},  
                    {n=G.UIT.B, config={h=0.1,w=0.03}}  
                }}  
            }}  
    end,  
    loc_txt = {    
        name = "The Collapse of the Universe",    
        text = {    
            "Creates a {C:dark_edition}Universal Collapse{}",    
            "{C:inactive}(Must have room)"    
        }    
    },    
    loc_vars = function(self, info_queue, card)    
        info_queue[#info_queue+1] = G.P_CENTERS.j_DJ_universal_collapse    
        return {}    
    end,    
    can_use = function(self, card)    
        return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers    
    end,    
    use = function(self, card, area, copier)    
        G.E_MANAGER:add_event(Event({    
            trigger = 'after',    
            delay = 0.4,    
            func = function()    
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_DJ_universal_collapse')    
                card:add_to_deck()    
                G.jokers:emplace(card)    
                return true    
            end    
        }))    
    end    
}
-----------
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
        local max_h = (card and card.config and card.config.center and card.config.center.config and card.config.center.config.max_highlighted) or self.config.max_highlighted
        
        return { vars = { max_h } }
    end,

    loc_txt = {
        name = '{C:attention}Brainstorming{} a {C:chips}Blueprint',
        text = {
            "Applies a {C:attention}Blueprinted Seal{}",
            "to {C:attention}#1#{} selected card",
        }
    }
}
----------
-- PLANET
---------
SMODS.Consumable {
    key = 'stronghold_planet',
    set = 'Planet',
    name = "Eye Of Ender",
    config = { hand_type = 'DJ_stronghold' },
    pos = { x = 2, y = 0 },
    soul_pos = {x = 3, y = 0},
    atlas = 'khalid2_atlas', 
    loc_txt = {
        name = "Eye Of Ender",
        text = {
            "{S:0.8}(lvl.#1#{S:0.8}){} Upgrades",
            "{C:attention}Stronghold{}",
            "{C:mult}+#2#{} Mult and",
            "{C:chips}+#3#{} Chips"
        }
    },
    loc_vars = function(self, info_queue, card) 
        local hand_key = 'DJ_stronghold'
        local level, mult, chips = 1, 15, 40 
        if G.GAME and G.GAME.hands and G.GAME.hands[hand_key] then
            level = G.GAME.hands[hand_key].level
            mult = G.GAME.hands[hand_key].l_mult
            chips = G.GAME.hands[hand_key].l_chips
        end

        return { vars = { level, mult, chips } }
    end,
    use = function(self, card, area, copier)
        level_up_hand(card, 'DJ_stronghold', nil, 1)
    end
}