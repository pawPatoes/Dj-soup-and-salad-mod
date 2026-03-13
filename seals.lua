SMODS.Seal {
    key = 'blueprinted',
    atlas = 'editions_atlas',
    pos = {x = 0, y = 0},
    config = {},

    calculate = function(self, card, context)
        -- Triggers when the card itself is being scored
        if context.main_scoring and context.cardarea == G.play then
            -- 1. Find where THIS card is in the played hand
            local my_pos = nil
            for i = 1, #G.play.cards do
                if G.play.cards[i] == card then 
                    my_pos = i 
                    break 
                end
            end

            -- 2. Check the card immediately to the right (my_pos + 1)
            if my_pos and G.play.cards[my_pos + 1] then
                local target = G.play.cards[my_pos + 1]
                local ret = { card = card }

                -- 3. Grab Chips (Nominal + Bonus enhancement)
                local chips = (target.base and target.base.nominal or 0) + (target.ability.bonus or 0)
                if chips > 0 then ret.chips = chips end

                -- 4. Grab Mult (Mult enhancement / Lucky card)
                if target.ability.mult and target.ability.mult > 0 then
                    ret.mult = target.ability.mult
                end

                -- 5. Grab XMult (Glass / Polychrome)
                if target.ability.x_mult and target.ability.x_mult > 1 then
                    ret.x_mult = target.ability.x_mult
                end

                -- Return the copied values if we found any
                if ret.chips or ret.mult or ret.x_mult then
                    return ret
                end
            end
        end
    end,

    loc_txt = {
        label = 'Blueprinted Seal',
        name = 'Blueprinted',
        text = {
            "Copies {C:chips}Chips{} and {C:mult}Mult{}",
            "of the {C:attention}Card{} to its right"
        }
    },
}