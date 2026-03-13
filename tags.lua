local mod = DJ_mod_obj
local original_level_up = level_up_hand
function level_up_hand(card, hand, instant, amount)
    original_level_up(card, hand, instant, amount)
    G.GAME.last_leveled_hand = hand
end


SMODS.Tag {
    key = 'upgrade',
    atlas = 'tags_atlas',
    pos = { x = 0, y = 0 },
    config = { levels = 100 },
    discovered = true,
    loc_txt = {
        name = 'Average Cryptid Tag',
        text = {
            "Gives {C:attention}+100{} levels to the",
            "{C:attention}last hand{} that was leveled up",
            "{C:inactive,S:0.8}(Currently: {C:attention}#1#{C:inactive})",
            "{C:green,S:0.8}Image taken from {C:chips,s:0.8}Cryptid{}",
        }
    },
    loc_vars = function(self, info_queue, tag)
        return { vars = { G.GAME.last_leveled_hand or "None" } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local target_hand = G.GAME.last_leveled_hand
            
            if target_hand then
    tag:yep("LES GO", G.C.PURPLE, function()
    local hand_ref = G.GAME.hands[target_hand]
    hand_ref.level = hand_ref.level + 100
    hand_ref.mult = hand_ref.mult + (100 * hand_ref.l_mult)
    hand_ref.chips = hand_ref.chips + (100 * hand_ref.l_chips)
    G.ROOM.shake = 2
    
    play_sound("DJ_glitch_sound")
    G.HUD:recalculate() 
    return true
    end)
    tag.triggered = true
    return true
    else
                print("DJ MOD: No hand leveled yet this run. Tag did nothing.")
            end
        end
    end
}
SMODS.Tag {
    key = 'dj_tag',
    atlas = 'tags_atlas',
    pos = { x = 1, y = 0 },
    config = { booster_key = 'p_DJ_dj_pack' },
    loc_txt = {
        name = "DJ Tag",
        text = {
            "Gives a free {C:attention}DJ Pack{}",
            "instantly"
        }
    },
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local function try_spawn()
                if G.pack_cards or G.DJ_PACK_LOCK then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.01,
                        func = function()
                            try_spawn()
                            return true
                        end
                    }))
                    return
                end

                local booster_key = tag.config.booster_key or 'p_DJ_dj_pack'
                local booster_center = G.P_CENTERS[booster_key]
                
                if booster_center then
                    -- 2. GRAB THE LOCK IMMEDIATELY
                    G.DJ_PACK_LOCK = true

                    tag:yep('+', G.C.SECONDARY_SET.Buffoon, function()
                        local booster_card = Card(G.play.T.x, G.play.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, booster_center, {bypass_discovery_center = true})
                        booster_card.cost = 0
                        
                        -- Instant appearance
                        booster_card.states.visible = true
                        booster_card:start_materialize(nil, true) 
                        G.play:emplace(booster_card)
                        
                        -- Open the pack
                        G.FUNCS.use_card({config = {ref_table = booster_card}})
                        
                        -- 3. RELEASE THE LOCK ONLY AFTER THE UI IS CREATED
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.1, -- Tiny window to ensure G.pack_cards is populated
                            func = function()
                                G.DJ_PACK_LOCK = nil
                                return true
                            end
                        }))
                        return true
                    end)
                    tag.triggered = true
                end
            end

            try_spawn()
            return true
        end
    end
}