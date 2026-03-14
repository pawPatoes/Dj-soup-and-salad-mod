local mod = DJ_mod_obj
local original_level_up = level_up_hand


SMODS.Tag {
    key = 'upgrade',
    atlas = 'tags_atlas',
    pos = { x = 0, y = 0 },
    config = { levels = 5 },
    discovered = true,
    loc_txt = {
        name = "Universum's Tag",
        text = {
            "Gives {C:attention}+#1#{} levels",
            "to the {C:attention}last played{} poker hand",
            "{C:inactive,s=0.8}(Last hand: {C:attention}#2#{C:inactive})",
            "{C:green,s=0.8}Image taken from {C:chips,s:0.8}Cryptid{}"
        }
    },
    loc_vars = function(self, info_queue, tag)
        local last_hand = G.GAME.last_hand_played or "None"
        return { vars = { tag.config.levels, last_hand } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local target_hand = G.GAME.last_hand_played        
            if target_hand and G.GAME.hands[target_hand] then
                tag:yep("+5 Levels", G.C.PURPLE, function()
                    level_up_hand(tag, target_hand, nil, tag.config.levels)
                    G.ROOM.shake = 2
                    return true
                end)
                tag.triggered = true
                return true
            else
                return false 
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
                    G.DJ_PACK_LOCK = true
                    tag:yep('+', G.C.SECONDARY_SET.Buffoon, function()
                        local booster_card = Card(G.play.T.x, G.play.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, booster_center, {bypass_discovery_center = true})
                        booster_card.cost = 0
                        booster_card.states.visible = true
                        booster_card:start_materialize(nil, true) 
                        G.play:emplace(booster_card)
                        G.FUNCS.use_card({config = {ref_table = booster_card}})
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.1,
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