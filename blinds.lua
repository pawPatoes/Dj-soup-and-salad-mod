local mod = DJ_mod_obj
SMODS.Blind {
    key = 'no_mods',
    loc_txt = {
        name = "NO MODS",
        text = { 
            "All {C:attention}Modded Jokers{}", 
            "are {C:red}debuffed{}",
            "This gives {C:money}25$",
        }
    },
    atlas = "blind_atlas",
    pos = {x = 0, y = 0},
    weight = 5,
    dollars = 5,
    mult = 0.5,
    discovered = true,
    boss = {min = 1, max = 10},
    loc_vars = function(self)
        return { vars = { 25 } }
    end,
    boss_colour = HEX('ff3232'), 
    get_uibox_color = function(self)
        return HEX('ff3232')
    end,
    defeat = function(self)
        ease_dollars(20)
    end,
    set_blind = function(self)
        local has_modded = false
        if G.jokers and G.jokers.cards then
            for _, card in ipairs(G.jokers.cards) do
                if card.config.center.mod and card.config.center.key ~= 'j_DJ_chicot' then
                    has_modded = true
                    break
                end
            end
        end

        if has_modded then
            play_sound('DJ_buzzer_sound', 1, 1)
        else
            play_sound('DJ_buzzer1_sound', 1, 0.8)
        end
    end,

    recalc_debuff = function(self, card, from_blind)
        if card.ability.set == 'Joker' and card.config.center.mod then
            if card.config.center.key == 'j_DJ_chicot' then 
                return false 
            end
            return true
        end
    end
}