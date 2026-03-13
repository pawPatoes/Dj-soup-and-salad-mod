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