local mod = DJ_mod_obj
SMODS.Back {
    name = "DJ Deck",
    key = "dj_deck",
    atlas = "deck_atlas",
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    loc_txt = {
        name = 'DJ Deck',
        text = { 
            "Spawns you in with a {C:attention}DJ Soup{} Joker,",
            "A {C:attention}New stream{} Consumable",
            "And a {C:attention}Another one{} voucher",
            "First {C:red}Boss Blind{} is guaranteed to be {C:red}NO MODS{}",
        }
    },
    apply = function(self)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 1, 
        func = function()
            if G.P_CENTERS.j_DJ_khalid then
                SMODS.add_card({ set = 'Joker', key = 'j_DJ_khalid' })
            end
            if G.P_CENTERS.c_DJ_new_song then
                SMODS.add_card({ set = 'Tarot', key = 'c_DJ_new_song' })
            end
            if G.P_CENTERS.v_DJ_another then
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.8,
        func = function()
            local card = Card(G.vouchers.T.x, G.vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS.v_DJ_another)
            card.set_cost = 0
            card.cost = 0
            card:redeem()
            card:remove()
            
            return true
        end
    }))
end
            if G.P_BLINDS.bl_DJ_no_mods then
                if G.GAME and G.GAME.round_resets and G.GAME.round_resets.blind_choices then
                    G.GAME.round_resets.blind_choices.Boss = 'bl_DJ_no_mods'
                end
            end
            
            return true
        end
    }))
end
}
SMODS.Back {
    name = "Black Hole Deck",
    key = "hole_deck",
    atlas = "deck_atlas", 
    pos = { x = 1, y = 0 },
    unlocked = false,
    check_unlock = function(self, args)
    local ach_key = 'ach_DJ_now_the_fun_begins'
    if args.type == 'dj_eye_used' then return true end
    if G.PROFILES[G.SETTINGS.profile].achievements[ach_key] then
        return true
    end
end,
    config = { 
        dj_rarity = "DJ_?", 
        joker_slot_mod = -1, 
        negative_mult = 10, 
    },
    loc_txt = {
        name = "Black Hole Deck",
        text = {
            "Start run with a",
            "random {C:dark_edition}???{} rarity Joker",
            "{C:attention}-1{} Joker slot",
            "Negative Jokers are {C:attention}10x{} more likely",
        },
        unlock = {
            "Unlock the {C:attention}\"NOW THE FUN BEGINS\"",
            "{C:dark_edition} Achievement"
        }
    },
    draw = function(card, layer)
        if card.children.center then
            card.children.center:draw_shader('negative', nil, nil, nil, card.children.center)
        else
            card:draw_shader('negative')
        end
    end,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.jokers.config.card_limit = G.jokers.config.card_limit + (self.config.joker_slot_mod or -1)
                G.GAME.dj_negative_boost = self.config.negative_mult or 10
                
                local dj_jokers = {}
                for k, v in pairs(G.P_CENTERS) do
                    if v.set == 'Joker' and v.rarity == self.config.dj_rarity then
                        if k ~= 'j_DJ_cry' or exponentiaUnlocked == true then
                            table.insert(dj_jokers, k)
                        end
                    end
                end
                local final_key = 'j_DJ_cryit'
                if #dj_jokers > 0 then
                    final_key = dj_jokers[pseudorandom('bh_deck_start', 1, #dj_jokers)]
                elseif exponentiaUnlocked == true then
                    final_key = 'j_DJ_cry'
                end
                if final_key == 'j_DJ_cry' and exponentiaUnlocked == false then
                    final_key = 'j_DJ_cryit' 
                end
                SMODS.add_card({
                    set = 'Joker',
                    key = final_key,
                })
                return true
            end
        }))
    end
}
SMODS.Back {
    name = "White Hole Deck",
    key = "w_hole_deck", 
    atlas = "deck_atlas",
    pos = { x = 2, y = 0 }, 
    unlocked = false,
    check_unlock = function(self, args)
    local ach_key = 'ach_DJ_the_fun_begins'
    if args.type == 'dj_heart_used' then return true end
    if G.PROFILES[G.SETTINGS.profile].achievements[ach_key] then
        return true
    end
end,
    config = { 
        dj_rarity = "DJ_overpowered", 
        joker_slot_mod = -2, 
        negative_mult = 20   
    },
    loc_txt = {
        name = "White Hole Deck",
        text = {
            "Start run with a",
            "random {C:dark_edition}Overpowered{} rarity Joker",
            "{C:attention}-2{} Joker slots",
            "Negative Jokers are {C:attention}20x{} more likely",
        },
        unlock = {
            "Unlock the {C:attention}\"The fun begins\"{}",
            "{C:dark_edition} Achievement"
        }
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.jokers.config.card_limit = G.jokers.config.card_limit + (self.config.joker_slot_mod or -1)
                G.GAME.dj_negative_boost = self.config.negative_mult or 10
                local dj_jokers = {}
                for k, v in pairs(G.P_CENTERS) do
                    if v.set == 'Joker' and v.rarity == self.config.dj_rarity then
                        table.insert(dj_jokers, k)
                    end
                end
                if #dj_jokers > 0 then
                    local chosen_joker = dj_jokers[pseudorandom('wh_start', 1, #dj_jokers)]
                    SMODS.add_card({
                        set = 'Joker',
                        key = chosen_joker, 
                    })
                end
                return true
            end
        }))
    end
}
SMODS.Back {
    name = "Rock Solid",
    key = "rock_solid",
    atlas = "deck_atlas",
    pos = { x = 3, y = 0 }, 
    config = { forced_stone = true },
    loc_txt = {
        name = "Rock Solid",
        text = {
            "All cards in your {C:attention}starting deck{}",
            "are {C:attention}Stone Cards{}",
            "{C:inactive,s=0.8}ROFFLE REFERENCE NO WAY"
        }
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
            for k, v in pairs(G.playing_cards) do
            v:set_ability(G.P_CENTERS.m_stone, nil, true)
            end
                return true
            end
        }))
    end
}