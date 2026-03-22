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
    boss = {min = 1, max = 1000},
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
SMODS.Blind {  
    key = 'sell_jokers',  
    loc_txt = {  
        name = 'SELL YOUR JOKERS!',  
        text = {   
            "Score {C:attention}LESS{} than the",   
            "required amount to win.",  
            "{C:red,s:0.8}Exceeding the goal = The run is over!{}"  
        }  
    },  
    atlas = 'blind1_atlas',  
    pos = {x = 0, y = 0},   
    dollars = 10,  
    mult = 0.5,  
    boss = {  
        min = 8,  
        showdown = true  
    },  
    boss_colour = HEX('2d004d'),  
    ignore_showdown_check = true,  
    in_pool = function(self)  
        return G.GAME.round_resets.ante % 8 == 0 and G.GAME.round_resets.ante >= 8  
    end,  
    weight = 10000,  
  
    set_blind = function(self, reset)  
        if not reset then  
            G.E_MANAGER:add_event(Event({  
                func = function()  
                    attention_text({  
                        text = 'STAY SMALL!',  
                        scale = 1.3,   
                        hold = 3,  
                        major = G.play,  
                        backdrop_colour = G.C.BLACK,  
                        align = 'cm',  
                        offset = {x = 0, y = -1}  
                    })  
                    return true  
                end  
            }))  
        end  
    end  
}
local game_update_ref = Game.update
function Game.update(self, dt)
    game_update_ref(self, dt)
    
    if G.STAGE == G.STAGES.RUN and G.STATE == G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.GAME_OVER then
        local blind = G.GAME.blind
        if blind and blind.config.blind.key == 'bl_DJ_sell_jokers' and not blind.disabled then
            local current_chips = to_number(G.GAME.chips)
            local target_chips = to_number(blind.chips)
            local progress = current_chips / target_chips
            if current_chips >= target_chips then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        attention_text({
                            text = 'TOO BIG!',
                            scale = 1.3, 
                            hold = 3,
                            major = G.play,
                            backdrop_colour = G.C.RED,
                            align = 'cm',
                        })
                        return true
                    end
                }))
                G.GAME.chips = 0
                G.GAME.current_round.hands_left = 0
                G.STATE = G.STATES.GAME_OVER
                G.STATE_COMPLETE = false
            end
        end
    end
end
local evaluate_play_ref = G.FUNCS.evaluate_play
G.FUNCS.evaluate_play = function(e)
    local blind = G.GAME.blind
    local is_dj = blind and blind.config.blind.key == 'bl_DJ_sell_jokers' and not blind.disabled
    
    if is_dj then
        local current_chips = to_number(G.GAME.chips)
        local target_chips = to_number(blind.chips)
        if G.GAME.current_round.hands_left <= 0 and current_chips < target_chips then
            blind:disable() 
            local real_chips = G.GAME.chips
            G.GAME.chips = blind.chips
            
            evaluate_play_ref(e)
            
            G.GAME.chips = real_chips
            
            attention_text({
                text = 'UNDER THE LIMIT!',
                scale = 1.2, 
                hold = 2,
                backdrop_colour = G.C.BLUE,
                align = 'cm',
            })
            return
        end
    end
    
    evaluate_play_ref(e)
end