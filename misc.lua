SMODS.PokerHand {
    key = 'stronghold',
    chips = 200,
    mult = 15,
    l_chips = 40,
    l_mult = 4,
    visible = false,
    
    loc_txt = {
        name = 'Stronghold',
        description = {
            "5 {C:attention}Stone Cards{}"
        }
    },
    
    example = {
        { 'S_A', true, enhancement = 'm_stone' },
        { 'S_A', true, enhancement = 'm_stone' },
        { 'S_A', true, enhancement = 'm_stone' },
        { 'S_A', true, enhancement = 'm_stone' },
        { 'S_A', true, enhancement = 'm_stone' }
    },

    evaluate = function(parts, hand)
        if #hand ~= 5 then return {} end
        
        local stone_cards = {}
        for i = 1, #hand do
            if hand[i].config.center == G.P_CENTERS.m_stone then
                table.insert(stone_cards, hand[i])
            end
        end
        
        if #stone_cards == 5 then
            return { stone_cards }
        else
            return {} 
        end
    end
}