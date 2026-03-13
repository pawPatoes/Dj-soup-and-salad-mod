SMODS.Seal {
    key = 'blueprinted',
    atlas = 'editions_atlas', -- Make sure this atlas exists!
    pos = {x = 0, y = 0},
    config = {},
    badge_colour = HEX("42a5f5"), -- Gives it a nice blue color in the UI

    -- THIS PART PREVENTS THE CRASH
    -- It ensures the card has a valid "seal" table when being copied
set_ability = function(self, card, initial)
        -- This ensures the seal doesn't just remain a raw string
        -- but behaves like a functional table if accessed by other mods
        if not card.ability.seal then card.ability.seal = {} end
    end,

    calculate = function(self, card, context)
        -- Triggers when the card itself is being scored
        if context.main_scoring and context.cardarea == G.play then
            -- Find where THIS card is in the played hand
            local my_pos = nil
            for i = 1, #G.play.cards do
                if G.play.cards[i] == card then 
                    my_pos = i 
                    break 
                end
            end

            -- Check the card immediately to the right
            if my_pos and G.play.cards[my_pos + 1] then
                local target = G.play.cards[my_pos + 1]
                local ret = { 
                    message = "Copied!",
                    colour = G.C.BLUE
                }

                -- Grab Chips
                local chips = (target.base and target.base.nominal or 0) + (target.ability.bonus or 0)
                if chips > 0 then ret.chips = chips end

                -- Grab Mult
                if target.ability.mult and target.ability.mult > 0 then
                    ret.mult = target.ability.mult
                end

                -- Grab XMult
                if target.ability.x_mult and target.ability.x_mult > 1 then
                    ret.x_mult = target.ability.x_mult
                end

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