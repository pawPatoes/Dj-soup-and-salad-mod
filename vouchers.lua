local mod = DJ_mod_obj
SMODS.Voucher {
    key = 'another',
    atlas = 'khaled_atlas',
    pos = { x = 0, y = 0 },
    display_size = { w = 59, h = 93 },
    cost = 10,
    unlocked = true,
    discovered = true,
    loc_txt = {
        name = "ANOTHER ONE",
        text = {
            "When you {C:attention}buy{} a Joker,",
            "{C:green}25%{} chance to create a",
            "{C:dark_edition}Negative{} copy of it"
        }
    }
}

SMODS.Voucher {
    key = 'wethebest',
    atlas = 'khaled_atlas',
    pos = { x = 1, y = 0 },
    requires = {'v_DJ_another'},
    display_size = { w = 59, h = 93 },
    cost = 10,
    unlocked = true,
    discovered = true,
    loc_txt = {
        name = "WE THE BEST",
        text = {
            "When you {C:attention}buy{} any card,",
            "{C:green}50%{} chance to create a",
            "{C:dark_edition}Negative{} copy of it"
        }
    }
}
local buy_ref = G.FUNCS.buy_from_shop
G.FUNCS.buy_from_shop = function(e)
    buy_ref(e)
    local card = e.config.ref_table
    
    if G.GAME.used_vouchers.v_DJ_wethebest then
        local target_area = (card.ability.set == 'Joker') and G.jokers or G.consumeables
        if #target_area.cards < target_area.config.card_limit + (G.GAME.joker_buffer or 0) then
            if pseudorandom('wethebest') < 0.50 then
                create_negative_khaled_copy(card)
            end
        end
    elseif G.GAME.used_vouchers.v_DJ_another and card.ability.set == 'Joker' then
        if #G.jokers.cards < G.jokers.config.card_limit + (G.GAME.joker_buffer or 0) then
            if pseudorandom('anotherone') < 0.25 then
                create_negative_khaled_copy(card)
            end
        end
    end
end

function create_negative_khaled_copy(original_card)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            local _card = copy_card(original_card, nil, nil, nil, true)
            _card:set_edition({negative = true}, true)
            _card:add_to_deck()
            if _card.ability.set == 'Joker' then 
                G.jokers:emplace(_card) 
            else 
                G.consumeables:emplace(_card) 
            end
            
            play_sound('DJ_life_sound', 1.2, 0.7)
            attention_text({text = "ANOTHER ONE!", scale = 1, hold = 1, colour = G.C.GOLD, align = 'cm', major = G.play})
            return true
        end
    }))
end