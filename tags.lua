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
