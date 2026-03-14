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
                    G.GAME.used_vouchers.v_DJ_another = true
                    G.GAME.voucher_counts = (G.GAME.voucher_counts or 0) + 1
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
    config = { 
        dj_rarity = "DJ_?", 
        joker_slot_mod = -2, 
        negative_mult = 20, 
    },
    draw = function(card, layer)
        if card.children.center then
            card.children.center:draw_shader('negative', nil, nil, nil, card.children.center)
        else
            card:draw_shader('negative')
        end
    end,
    loc_txt = {
        name = "Black Hole Deck",
        text = {
            "Start run with a",
            "random {C:dark_edition}???{} rarity Joker",
            "{C:attention}-2{} Joker slots",
            "Negative Jokers are {C:attention}20x{} more likely",
            "{C:inactive,s=0.8}WORMWHOLE DECK COPY"
        }
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.jokers.config.card_limit = G.jokers.config.card_limit + (self.config.joker_slot_mod or -2)
                G.GAME.dj_negative_boost = self.config.negative_mult or 20
                local dj_jokers = {}
                for k, v in pairs(G.P_CENTERS) do
                    if v.set == 'Joker' and v.rarity == self.config.dj_rarity then
                        table.insert(dj_jokers, k)
                    end
                end
                if #dj_jokers > 0 then
                    local chosen_joker = dj_jokers[pseudorandom('bh_deck_start', 1, #dj_jokers)]
                    SMODS.add_card({
                        set = 'Joker',
                        key = chosen_joker,
                    })
                else
                    SMODS.add_card({
                        set = 'Joker',
                        key = 'j_DJ_cry',
                    })
                end
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
    config = { 
        dj_rarity = "DJ_overpowered", 
        joker_slot_mod = -1, 
        negative_mult = 10    
    },
    loc_txt = {
        name = "White Hole Deck",
        text = {
            "Start run with a",
            "random {C:dark_edition}Overpowered{} rarity Joker",
            "{C:attention}-1{} Joker slot",
            "Negative Jokers are {C:attention}10x{} more likely",
            "{C:inactive,s=0.8}WORMWHOLE DECK BUT WORSE (SPRITE TAKEN FROM CRYPTID)"
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