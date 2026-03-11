G.sr_music_enabled = true
----------------------
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO LAST LINE!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO LAST LINE!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO LAST LINE!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO LAST LINE!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO LAST LINE!
-- Thank you for reading this :3
SMODS.DrawStep {  
    key = 'cry_soul_anim',  
    order = 60, 
    conditions = { vortex = false, facing = 'front' },  
    func = function(self, layer)  
        if self.config.center.key == 'j_DJ_cry' and self.config.center.custom_soul_anim then  
            self.config.center:custom_soul_anim(self, layer)  
        end  
    end  
}

local original_update = G.update
function G:update(dt)
    original_update(self, dt)

    if not G.jokers or not G.jokers.cards then
        if not G.dj_silenced then
            
            love.audio.stop()
            
            if G.SOUND_MANAGER and G.SOUND_MANAGER.channel then
                G.SOUND_MANAGER.channel:push({type = 'stop'})
            end

            G.dj_silenced = true
        end
    else
        G.dj_silenced = false
    end
end
SMODS.Rarity {
    key = 'misc',
    loc_txt = {
        name = 'Misc.'
    },
    badge_colour = {0.25, 0.87, 0.81, 1},
    default_weight = 10,
}
SMODS.Rarity {
    key = 'overpowered',
    loc_txt = {
        name = 'Overpowered'
    },

    badge_colour = HEX("081D5E"), 
    default_weight = 0,
}
SMODS.Rarity {
    key = '?',
    loc_txt = {
        name = '???'
    },

    badge_colour = HEX("000000"), 
    default_weight = 0,
}
-- SOUND
SMODS.Sound { key = 'get_sound', path = 'get_sound.mp3' }    
SMODS.Sound { key = 'bruh_sound', path = 'bruh_sound.mp3' }
SMODS.Sound { key = 'balala_sound', path = 'balala.ogg' }
SMODS.Sound { key = "static_sound", path = "static.ogg"}
SMODS.Sound { key = "east_sound", path = "east.ogg"}
SMODS.Sound { key = "life_sound", path = "life.mp3"}
SMODS.Sound { key = "sr_sound", path = "sr.ogg"}
SMODS.Sound {key = "buzzer_sound",path = "buzzer.mp3"}
SMODS.Sound {key = "buzzer1_sound",path = "buzzer1.mp3"}
-- ATLAS
SMODS.Atlas { key = "dj_atlas", path = "stolethisfromcryptid.png", px = 71, py = 95 } -- i actually did
SMODS.Atlas { key = "seb_atlas", path = "seb.png", px = 71, py = 95 }
SMODS.Atlas { key = "K_atlas", path = "stolethisfromcryptidsecond.png", px = 71, py = 95 } -- i actually did the second feturing dante from the devil may cry series
SMODS.Atlas { key = "balala_atlas",path = "balala.png", px = 71, py = 95 }
SMODS.Atlas { key = "first_atlas",path = "first.png", px = 71, py = 95 }
SMODS.Atlas { key = "walker_atlas", path = "walker.png", px = 71, py = 95 }
SMODS.Atlas { key = "cryf_atlas",path = "cryf.png",px = 71,py = 95}
SMODS.Atlas { key = "cry_atlas", path = "cry.png", px = 71, py = 95}
SMODS.Atlas { key = "heart_atlas", path = "heart.png",px = 71, py = 95} -- thats a lot of atlases
SMODS.Atlas { key = 'cryg_atlas',path = 'oops.png', px = 71, py = 95}
SMODS.Atlas { key = 'sr_atlas',path = 'sr.png', px = 71, py = 95}
SMODS.Atlas { key = "A60_atlas", path = "60.png", px = 71, py = 95, atlas_table = "ANIMATION_ATLAS", frames = 6}
SMODS.Atlas { key = "dupe_atlas", path = "dupe.png", px = 71, py = 95}
SMODS.Atlas { key = "east_atlas", path = "east.png", px = 71, py = 95}
SMODS.Atlas { key = "o7_atlas", path = "o7.png", px = 71, py = 95}
SMODS.Atlas { key = "deck_atlas", path = "deck.png", px = 71, py = 95}
SMODS.Atlas { key = "khalid_atlas", path = "khalid.png", px = 71, py = 95}
SMODS.Atlas { key = "khalid2_atlas", path = "khalid2.png", px = 71, py = 95}
SMODS.Atlas { key = "blind_atlas", path = "blind.png", px = 34, py = 34}
SMODS.Atlas { key = "khaled_atlas", path = "kalidv.png", px = 71, py = 95}




SMODS.current_mod.mod_icon = "Keese.png" -- idk why it wont work pls help
SMODS.current_mod.config_tab = function()
    return { 
        n = G.UIT.ROOT, 
        config = { align = "tm", padding = 0.1, colour = G.C.BLACK }, 
        nodes = {
            { n = G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = {
                { n = G.UIT.T, config = { text = "AUDIO SETTINGS", scale = 0.6, colour = G.C.GOLD } }
            }},
            { n = G.UIT.R, config = { align = "cm", padding = 0.2 }, nodes = {
                UIBox_button({
                    label = {"SILENCE VOICE CRACK"},
                    button = "silence_crack_button",
                    colour = G.C.RED,
                    scale = 0.5,
                    minw = 4,
                    minh = 0.8
                })
            }},

            { n = G.UIT.R, config = { align = "cm", mt = 0.2 }, nodes = {
                { n = G.UIT.T, config = { 
                    text = "SILENCES MASSIVE VOICE CRACK UNTIL RESTART", 
                    scale = 0.3, 
                    colour = G.C.UI.TEXT_LIGHT 
                } }
            }}
        }
    }
end

G.FUNCS.silence_crack_button = function(e)
    SMODS.Sound:create_stop_sound("DJ_east_sound", 999)
    attention_text({
        text = "SILENCED!", 
        scale = 0.8, 
        hold = 0.5, 
        colour = G.C.WHITE, 
        align = 'cm'
    })
end
SMODS.Joker { -- go my mult
    key = 'dj_sss',
    loc_txt = {
        name = 'DJ {C:red}soup {C:normal}& {C:green}salad',
        text = {
            "{C:red}D{C:attention}J{} gains {X:mult,C:white}X#2#{} Mult per {C:blue}hand played{},",
            "Loses {X:mult,C:white}X#3#{} Mult per {C:attention}card {C:red}discarded{}",
            "Currently {X:mult,C:white}X#1# {C:normal} Mult",
            "{C:inactive,s=0.8}The whole reason this mod exists" -- indeed
        }
    },
    config = { extra = { x_mult = 1, mult_gain = 1, mult_ungain = 0.1 } },
    rarity = 4, 
    cost = 20, 
    blueprint_compat = true, 
    atlas = 'dj_atlas', 
    pos = { x = 0, y = 0 }, 
    soul_pos = { x = 1, y = 0 }, 
    discovered = true,

  
    loc_vars = function(self, info_queue, card) 
        return { vars = { 
            card.ability.extra.x_mult, 
            card.ability.extra.mult_gain, 
            card.ability.extra.mult_ungain 
        } } 
    end,

    calculate = function(self, card, context)  
        if context.joker_main then  
            return { x_mult = card.ability.extra.x_mult }  
        end  

        if context.before and not context.blueprint then  
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.mult_gain  
            return { message = "Upgrade!", colour = G.C.MULT }  
        end  

        if context.discard and not context.blueprint then  
            card.ability.extra.x_mult = math.max(1, card.ability.extra.x_mult - card.ability.extra.mult_ungain)  
            

            if context.other_card == context.full_hand[1] then  
                card:juice_up(0.1, 0.1)
            end  
        end
    end 
}

SMODS.Joker {    
    key = 'seb_pressure',  -- GET OUT!!!!!!!!!!  
    loc_txt = {    
        name = 'Sebastion Pressure',    
        text = { "{C:red}PLEASE GET OUT OF MY {C:attention}shop{}",
         "{C:red}IN LESS THAN {C:attention}3 SECONDS{}",
          "{C:green}and i'll gain {X:mult,C:white}0.5X{} mult :D{}",
          "{C:red}Resets{} on miss!",
           "{C:green}(Currently {X:mult,C:white}X#1# {C:green} Mult)",
           "{C:inactive,s=0.8}GET OUT!"
        }    
    }, 
    config = { extra = { x_mult = 1, timer = 0, in_shop = false } },    
    rarity = 2, atlas = 'seb_atlas', pos = { x = 0, y = 0 }, cost = 6, blueprint_compat = true, discovered = true,  
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult } } end,    
    update = function(self, card, dt)    
        if G.STATE == G.STATES.SHOP then   -- idk what this means documentation my goat     
            if not card.ability.extra.in_shop then card.ability.extra.in_shop = true card.ability.extra.timer = love.timer.getTime() end    
        else    
            if card.ability.extra.in_shop then   
                local time_spent = love.timer.getTime() - card.ability.extra.timer    
                if time_spent < 3 then    
                    card.ability.extra.x_mult = card.ability.extra.x_mult + 0.5    
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "GET OUT!", colour = G.C.RED})    
                    play_sound('DJ_get_sound', 1, 0.5)  -- GET OUT    
                else    
                    card.ability.extra.x_mult = 1    
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "KILL YOURSELF", colour = G.C.RED, scale = 0.4})    
                    play_sound('DJ_bruh_sound', 1, 0.5)  -- KILL YOURSELF    
                end      
                card.ability.extra.in_shop = false      
            end      
        end      
    end,  
    calculate = function(self, card, context) if context.joker_main then return { x_mult = card.ability.extra.x_mult } end end    
}

SMODS.Joker {
    key = 'average_cryptid', 
    atlas = 'K_atlas', 
    pos = { x = 0, y = 0 }, 
    soul_pos = { x = 1, y = 0 }, 
    rarity = "DJ_overpowered", 
    cost = 20, 
    unlocked = true, 
    discovered = true, 
    blueprint_compat = true,
    loc_txt = { 
        name = 'Average Cryptid Joker', 
        text = {  
            "Gains {X:chips,C:white}^#2#{} for every {C:attention}Jolly Joker{} you have",
            "{C:green}1 in 2{} chance to create a",
            "{C:attention}Jolly Joker{} at start of {C:attention}Blind{}",
            "{C:inactive}(Currently {X:chips,C:white}^#3# {C:inactive} Chips)",
            "{C:inactive,s:0.8}This is true right? (Compatible with \"Increase joker value\" jokers)" 
        } 
    },
    
    config = { extra = { echips_gain = 2, chance = 2, echips_base = 1 } },

    loc_vars = function(self, info_queue, card)
        local jolly_count = 0
        if G.jokers and G.jokers.cards then
            for _, v in ipairs(G.jokers.cards) do 
                if v.config.center.key == 'j_jolly' then jolly_count = jolly_count + 1 end 
            end
        end
        local total_display = card.ability.extra.echips_base + (jolly_count * card.ability.extra.echips_gain)
        return { vars = { card.ability.extra.echips_base, card.ability.extra.echips_gain, total_display, card.ability.extra.chance } }
    end,

    in_pool = function(self, args) return false end,

 calculate = function(self, card, context)
        if context.setting_blind and not self.getting_sliced and not context.blueprint then
            if pseudorandom('average_cryptid') < G.GAME.probabilities.normal / card.ability.extra.chance then
                if #G.jokers.cards < G.jokers.config.card_limit then
                    local jolly = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jolly')
                    jolly:add_to_deck()
                    G.jokers:emplace(jolly)
                    return {
                        message = 'KEEEEEESE',
                        colour = G.C.CHIPS
                    }
                end
            end
        end


        if context.joker_main then
            local jolly_count = 0
            for _, v in ipairs(G.jokers.cards) do 
                if v.config.center.key == 'j_jolly' then jolly_count = jolly_count + 1 end 
            end
            
            local total_echips = card.ability.extra.echips_base + (jolly_count * card.ability.extra.echips_gain)
            

            return {
                Echips_mod = total_echips, 
                echips = total_echips,     
                colour = G.C.CHIPS
            }
        end
    end
}
-- WHO ARE BALALA THE FARIES?
SMODS.Joker {
    key = 'balala_fairies',
    loc_txt = {
    name = 'BALALA the fairies',
    text = {
        "WE FIGHT THE {C:attention}BOSS BLINDS{}",
        "TO GIVE YOU {X:mult,C:white}X#1# {} MULT!",
        "{C:inactive,s=0.8}WHO ARE BALALA THE FAIRIES?"
    }
},
loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult } }
end,
    config = { extra = { x_mult = 4 } },
    rarity = 3, cost = 10, atlas = 'balala_atlas', pos = { x = 0, y = 0 }, 
    blueprint_compat = true, discovered = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.blind.boss then
            return {
                x_mult = card.ability.extra.x_mult,
                play_sound('DJ_balala_sound', 1, 5)
            }
        end
    end
}
 -- This is meant to make fun of people's first jokers
SMODS.Joker {
    key = 'my_first_joker',
    loc_txt = {
        name = 'My First Joker',
        text = {
            "MY FIRST {C:attention}JOKER{} DO U LIKE IT?",
            "{X:dark_edition,C:white}^#1#{} EVERYTHING!!!!!!!!!! {C:inactive,s:0.5}Wait the sprite says ^10 tho?",
            "{C:inactive,s=0.8}Bullying goes hard (Compatible with \"Increase joker values\" jokers)"
        }
    },
    config = { extra = { exponent = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.exponent } }
    end,
    rarity = "DJ_overpowered",
    atlas = 'first_atlas',
    pos = { x = 0, y = 0 },      
    soul_pos = { x = 1, y = 0 }, 
    cost = 25,
    blueprint_compat = true,
    unlocked = true,
    discovered = true,
    in_pool = function(self, args) return false end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                echips = card.ability.extra.exponent,
                Emult_mod = card.ability.extra.exponent,
                message = "^5 EVERYTHING!!!!111!!",
                colour = G.C.PURPLE
            }
        end

        if context.after and not context.blueprint then
            local old_money = math.max(1, G.GAME.dollars)
            local new_money = math.floor(old_money ^ 5)
            
            if new_money > G.GAME.dollars then
                ease_dollars(new_money - G.GAME.dollars)
                return {
                    message = "^5 Money!!!!!!",
                    colour = G.C.MONEY
                }
            end
        end
    end
}
-- Walker balatro joker
SMODS.Joker {
    key = 'new_sprite',
    loc_txt = {
        name = 'New sprite',
        text = {
            "Gives {X:purple,C:white}^#1#{} Mult for every",
            "\"atlas\" mention in {C:attention}main.lua{}",
            "{C:inactive}(You can add some yourself!)",
            "{C:red}PUT -- BEFORE SO IT DOESNT CRASH!{}",
            "{C:inactive}Total Bonus: {X:purple,C:white}^#2#{}",
            "{C:inactive}Current Count: {C:purple}#3#{}"
        }
    },
    config = { extra = { power_per_mention = 0.05 } },
    rarity = 4, 
    atlas = 'walker_atlas',
    pos = { x = 0, y = 0 },      
    soul_pos = { x = 1, y = 0 }, 
    cost = 20,
    blueprint_compat = true,
    discovered = true,
    unlocked = true,

    loc_vars = function(self, info_queue, card)
        local count = 0
        local mod_path = SMODS.Mods["DJ_Mod"].path
        local f = io.open(mod_path .. "main.lua", "r")
        if f then
            local content = f:read("*all")
            f:close()
            for _ in string.gmatch(content, "atlas") do
                count = count + 1
            end
        end
        return { vars = { card.ability.extra.power_per_mention, (count * card.ability.extra.power_per_mention), count } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            local mod_path = SMODS.Mods["DJ_Mod"].path
            local f = io.open(mod_path .. "main.lua", "r")
            if f then
                local content = f:read("*all")
                f:close()
                for _ in string.gmatch(content, "atlas") do
                    count = count + 1
                end
            end
            local total_pow = count * card.ability.extra.power_per_mention
            return {
                message = "^" .. total_pow .. "!",
                Emult_mod = total_pow,
                colour = G.C.PURPLE
            }
        end
    end
}
-- balatro but 1% chance to install cryptid
SMODS.Joker {
    key = 'cry_need',
    loc_txt = {
        name = '\"Vanilla\" Styled joker',
        text = {
            "{C:green}#1# in #2#{} chance to {C:attention}\"install\" Cryptid{}",
            "when {C:attention}Blind{} is selected",
            "{C:inactive}(Self-destructs on success)",
            "{C:inactive,s:0.8}Balatro but 1% chance to install cryptid:"
        }
    },
    config = { extra = { chance = 50, stored_win = false } }, 
    rarity = 2, 
    atlas = 'cryf_atlas',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } }, 
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card) 
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.chance } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local cryg_present = false
            for _, v in ipairs(G.jokers.cards) do
                if v.config.center.key == 'j_DJ_cryg' and not v.debuff then
                    cryg_present = true
                end
            end

            local rolled_win = pseudorandom('cry_need') < G.GAME.probabilities.normal / card.ability.extra.chance
            
            if rolled_win or card.ability.extra.stored_win or cryg_present then
                if #G.jokers.cards < G.jokers.config.card_limit then
                    local quest_pool = {}
                    for k, v in pairs(G.P_CENTERS) do
                        if v.set == 'Joker' and v.rarity == 'DJ_?' then
                            table.insert(quest_pool, k)
                        end
                    end

                    local chosen_key = #quest_pool > 0 and quest_pool[math.random(#quest_pool)] or 'j_joker'
                    local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_key, 'mod')
                    
                    if _card then 
                        _card:add_to_deck()
                        G.jokers:emplace(_card)
                        _card:start_materialize()
                        
                        card:start_dissolve() 
                        return {
                            message = "YOU'RE A LIER DJ!",
                            colour = G.C.RED,
                            attention_text = true
                        }
                    end
                else
                    card.ability.extra.stored_win = true
                    return {
                        message = "MAKE SLOTS (NEXT PROBABILITY GUARANTEED!)",
                        colour = G.C.RED
                    }
                end
            else
                return {
                    message = "YOU'RE TRUTHFUL DJ",
                    colour = G.C.GREEN
                }
            end
        end
    end
}
local sr_is_playing = false

SMODS.Joker {    
    key = 'sr',    
    loc_txt = {    
        name = '!sr youtube.com/watch?v=lNjVd00zKDE',    
        text = {    
            "Replaces {C:attention}music{} with",    
            "{C:attention}Peak songs{} while held.",    
            "{C:green}+1{} Joker slot.",    
            "{C:inactive,s=0.8}!sr reference no way! (Music is remixed!)"    
        }    
    },    
    config = { extra = { joker_slots = 1 } },    
    rarity = "DJ_misc",
    cost = 0,    
    atlas = 'sr_atlas',    
    pos = { x = 0, y = 0 },     
    blueprint_compat = false,    
    discovered = true,    
    add_to_deck = function(self, card, from_debuff)    
    if G.jokers then    
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots  
        G.dj_music_active = true  
    end    
      
    G.E_MANAGER:add_event(Event({    
        trigger = 'after',    
        delay = 0.2,     
        func = function()       
            play_sound("DJ_sr_sound", 1, 1)  
            return true  
        end    
    }))  
    end,
  
    remove_from_deck = function(self, card, from_debuff)  
        if G.jokers then  
            G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
            G.SOUND_MANAGER.channel:push({type = 'stop'})
            G.dj_music_active = false

        end  
    end  
}





SMODS.Joker {
    key = 'cryg',
    atlas = 'cryg_atlas',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    unlocked = true,
    rarity = "DJ_overpowered",
    cost = 20,
    blueprint_compat = true,
    discovered = true,
    unlocked = true,
    config = { extra = { Emult = 1, Emult_mod = 2.5, odds = 500 } },
    loc_txt = {
        name = "500 Oops all 6's",
        text = {
            "All {C:green}probabilities{} are {C:attention}guaranteed{}!",
            "Gains {X:dark_edition,C:white}^#2#{} Mult whenever",
            "a {C:green}probability{} is triggered.",
            "{C:inactive}(Currently {X:dark_edition,C:white}^#1#{C:inactive} Mult)",
            "{C:red}Destroys itself{} if a {C:attention}\"Vanilla\" Styled Joker{} succeeds.",
            "{C:inactive,s:0.8}HEAR THAT DJ? NO MORE DEBUGPLUS!"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Emult, card.ability.extra.Emult_mod, card.ability.extra.odds } }
    end,

    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return { numerator = context.numerator * card.ability.extra.odds }
        end

        if context.setting_blind and not context.blueprint then
            local found_vanilla = false
            for _, v in ipairs(G.jokers.cards) do
                if v.config.center.key == 'j_DJ_cry_need' then
                    v.ability.extra.stored_win = true
                    found_vanilla = true
                end
            end
            
            if found_vanilla then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
                return { message = "MISSION COMPLETE", colour = G.C.GREEN }
            end
        end

        if context.joker_main and (to_big(card.ability.extra.Emult) > to_big(1)) then
            return { 
                message = "^" .. number_format(card.ability.extra.Emult), 
                Emult_mod = card.ability.extra.Emult, 
                colour = G.C.DARK_EDITION 
            }
        end
    end
}

local old_prob = SMODS.pseudorandom_probability
function SMODS.pseudorandom_probability(label, sucs, total, id)
    local has_cryg = false
    

    for _, v in ipairs(G.jokers.cards) do
        if v.config.center.key == 'j_DJ_cryg' and not v.debuff then
            has_cryg = true
            if not v.blueprint then 
                v.ability.extra.Emult = v.ability.extra.Emult + v.ability.extra.Emult_mod
                v:juice_up(0.1, 0.1)
                return { message = "Upgrade!", colour = G.C.GREEN } 
            end
        end
    end

   
    if has_cryg then 
        return true 
    end
    
   
    return old_prob(label, sucs, total, id)
end
-- A-60!
SMODS.Joker {
    key = 'A60',
    atlas = 'A60_atlas', 
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 }, 
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    discovered = true,
    
    config = { 
        extra = { gain = 0.05, milestone_mult = 6.60 },
        animation = { frames = 6, fps = 30 } 
    },

    update = function(self, card, dt)
        local time = (G.TIMERS and G.TIMERS.real) or 0
        
        card.soul_glow = card.soul_glow or 0.6
        
        local soul_speed = 0.05
        local frame = math.floor(time / soul_speed) % 6
        
        card.ability.soul_pos = card.ability.soul_pos or {x = 0, y = 1}
        card.ability.soul_pos.x = frame
        card.ability.soul_pos.y = 1
    end,

    loc_txt = {
        name = "A-60",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult for every",
            "{C:attention}.png{} in this mod's {C:attention}assets/1x{}",
            "{C:green}You can add your own!",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
            "{C:inactive,s:0.7}Scaring 10 year olds, starting today!"
        }
    },


    loc_vars = function(self, info_queue, card)
        local png_count = 0
        local target_mod = SMODS.Mods["DJ_Mod"]
        
        if target_mod and target_mod.path then
            local target_path = target_mod.path .. "/assets/1x"
            local files = love.filesystem.getDirectoryItems(target_path)
            
            if not files or #files == 0 then
                files = love.filesystem.getDirectoryItems("Mods/DJ_Mod/assets/1x")
            end

            if files then
                for _, file in ipairs(files) do
                    if file:lower():match("%.png$") then 
                        png_count = png_count + 1 
                    end
                end
            end
        end
        
        local current_xmult = (png_count == 60) and card.ability.extra.milestone_mult or (1 + (png_count * card.ability.extra.gain))
        return { vars = { current_xmult, card.ability.extra.gain } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local png_count = 0
            local target_mod = SMODS.Mods["DJ_Mod"]
            
            -- SAFETY CHECK: Stop the crash if the mod isn't found
            if target_mod and target_mod.path then
                local target_path = target_mod.path .. "/assets/1x"
                local files = love.filesystem.getDirectoryItems(target_path)
                
                -- Fallback for different install locations
                if not files or #files == 0 then
                    files = love.filesystem.getDirectoryItems("Mods/DJ_Mod/assets/1x")
                end

                if files then
                    for _, file in ipairs(files) do
                        if file:lower():match("%.png$") then 
                            png_count = png_count + 1 
                        end
                    end
                end
            end

            local is_milestone = (png_count == 60)
            local total_xmult = is_milestone and card.ability.extra.milestone_mult or (1 + (png_count * card.ability.extra.gain))
                
            if total_xmult > 1 then
                play_sound('DJ_static_sound', 1, 1) 
                if is_milestone then card:juice_up(1.2, 1.2) end 
                return {
                    Xmult_mod = total_xmult,
                    message = is_milestone and "6.60X!" or ("X" .. number_format(total_xmult)),
                    colour = is_milestone and G.C.RED or G.C.MULT
                }
            end
        end
    end,
}
-- I hEARd that you went to the eASt side...
SMODS.Joker {
    key = 'voice',
    atlas = 'east_atlas',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    config = { extra = { gain = 0.2 } },
    discovered = true,
    
    loc_txt = {
        name = "MASSIVE Voice crack",
        text = {
            "Gives {X:mult,C:white} X#1# {} Mult for every",
            "{C:attention}Registered Sound{} in this mod",
            "{C:inactive}(Found {C:attention}#3# {C:inactive}sounds)",
            "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
            "{C:inactive,s:0.8}I HAVE TWO SIDES (SONG IS NOT COPYRIGHTED! {C:red,s:1.2}But i recommend putting your volume down...)",
        }
    },

    loc_vars = function(self, info_queue, card)
        local sound_count = 0
        
        for k, v in pairs(SMODS.Sound.obj_table) do
            if k:find('^DJ_') then
                sound_count = sound_count + 1
            end
        end

        local current_xmult = 1 + (sound_count * card.ability.extra.gain)
        return { vars = { card.ability.extra.gain, current_xmult, sound_count } }
    end,

add_to_deck = function(self, card)  
    play_sound('DJ_east_sound', 1, 0.5)
    G.dj_music_active = true,
    print("YO BRO IT PLAYING FRFR (DEBUG LINE)")   
end,
remove_from_deck = function(self, card, from_debuff)  
    G.SOUND_MANAGER.channel:push({ type = 'stop' })
    G.dj_music_active = false,
    print("STOPPED ALL SOUNDS AND FOR SOME REASON BACKROUND MUSIC STAYS???")
end,

    calculate = function(self, card, context)  
        if context.joker_main then
            local sound_count = 0
            for k, v in pairs(SMODS.Sound.obj_table) do
                if k:find('^DJ_') then
                    sound_count = sound_count + 1
                end
            end
            
            local total_xmult = 1 + (sound_count * card.ability.extra.gain)
            return {
                message = 'X' .. total_xmult,
                Xmult_mod = total_xmult
            }
        end
    end
}
-- o7 joker frfr
SMODS.Joker {
    key = 'o7',
    atlas = 'o7_atlas', 
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = 4, 
    cost = 20, 
    blueprint_compat = true, 
    discovered = true,
    loc_txt = {
        name = 'DJ o7',
        text = {
            "Gives {X:chips,C:white}X#1#{} Chips for every Playing Card {C:red}destroyed{}",
            "{C:red}1 in 20{} chance to {C:red}destroy{} each discarded card",
            "{C:inactive}(Currently {X:chips,C:white}X#2#{C:inactive} Chips)",
            "{C:inactive,s:0.8}You saluting is now a joker whether you like it or not"
        }
    },
    config = { extra = { x_chips_gain = 0.5, x_chips = 1, chance = 20 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_chips_gain, card.ability.extra.x_chips } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.x_chips > 1 then
            return {
                x_chips = card.ability.extra.x_chips,
                colour = G.C.CHIPS,
                card = card
            }
        end

        if context.discard and not context.blueprint then
            local destroyed_count = 0
            local cards_to_dissolve = {}
            for i = 1, #context.full_hand do
                if pseudorandom('o7_discard') < G.GAME.probabilities.normal / card.ability.extra.chance then
                    destroyed_count = destroyed_count + 1
                    cards_to_dissolve[#cards_to_dissolve+1] = context.full_hand[i]
                end
            end
            
            if destroyed_count > 0 then
                card.ability.extra.x_chips = card.ability.extra.x_chips + (card.ability.extra.x_chips_gain * destroyed_count)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after', delay = 0.2,
                    func = function() 
                        card:juice_up(0.1, 0.1)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Upgrade! X' .. card.ability.extra.x_chips, colour = G.C.CHIPS})
                        for _, v in ipairs(cards_to_dissolve) do v:start_dissolve() end
                        return true end 
                }))
            end
        end
        if context.remove_playing_cards and not context.blueprint then
            local count = #context.removed
            if count > 0 then
                card.ability.extra.x_chips = card.ability.extra.x_chips + (card.ability.extra.x_chips_gain * count)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.1, 0.1)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = 'Upgrade! X' .. card.ability.extra.x_chips,
                            colour = G.C.CHIPS
                        })
                        return true
                    end
                }))
            end
        end

        if context.glass_shattered and not context.blueprint then
            card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chips_gain
            return {
                message = 'Upgrade! X' .. card.ability.extra.x_chips,
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}
SMODS.Joker {
    key = 'khalid',
    atlas = 'khalid_atlas',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    config = { extra = { heart_odds = 10 } },
    discovered = true,
    loc_txt = {
        name = "DJ Khaled",
        text = { 
            "Create a {C:attention}New song{}",
            "When boss blind is defeated",
            "{C:green}#1# in #2#{} chance to create {X:red,C:white}The Heart{} instead",
        }
    },
    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            play_sound("DJ_life_sound")
        end
    end,
    loc_vars = function(self, info_queue, card)
        local extra = (card and card.ability and card.ability.extra) or self.config.extra
        return { 
            vars = { 
                G.GAME.probabilities.normal or 1, 
                extra.heart_odds 
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss then
            if not G.GAME.mixin_dropped then
                G.GAME.mixin_dropped = true 
                
                local extra = card.ability.extra
                if pseudorandom('mixin_heart') < (G.GAME.probabilities.normal or 1) / extra.heart_odds then
                    SMODS.add_card({ set = 'Tarot', key = 'c_DJ_the_heart' })
                    play_sound("DJ_life_sound", 1, 1)
                else
                    SMODS.add_card({ set = 'Tarot', key = 'c_DJ_new_song' })
                    play_sound("DJ_life_sound", 1, 1)
                end
                return {
                    message = "NEW SONG JUST DROPPED",
                    colour = G.C.BLUE
                }
            end
        end
        if context.setting_blind then
            G.GAME.mixin_dropped = false
        end
    end
}


-- NO I CANT!
SMODS.Joker { -- let him out
    key = 'dupe',    
    atlas = 'dupe_atlas',    
    pos = { x = 0, y = 0 },     
    soul_pos = {   
        x = 2, y = 0,   
        extra = { x = 1, y = 0 },  
        draw = function(card, scale_mod, rotate_mod)     
            if card.custom_extra_sprite then  
                card.custom_extra_sprite.T.x, card.custom_extra_sprite.T.y = card.T.x, card.T.y  
                card.custom_extra_sprite.scale = card.children.center.scale  
                card.custom_extra_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod*0.8, rotate_mod*0.8, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL), nil, 0.6)  
                card.custom_extra_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod*0.8, rotate_mod*0.8)  
            end  
                
            if card.children.floating_sprite then    
                card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL), nil, 0.6)    
                card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)    
            end  
        end  
    },
    
    rarity = "DJ_?",    
    cost = 50,  
    blueprint_compat = true,    
    config = { extra = { echips_gain = 1.5, echips_base = 1, pair_mod = 1.5 } },
    discovered = true,   
    
    loc_txt = {    
        name = "Duplicare?",    
        text = { 
            "Creates a {C:dark_edition}Negative{} {C:attention}Jolly Joker{} every hand played",    
            "Gives {X:chips,C:white}^#2#{} Chips for every {C:attention}Jolly Joker{} in joker slots",
            "Will give {X:mult,C:white}1.5X{} as much If played hand is a {C:attention}pair",    
            "{C:inactive}(Currently {X:dark_edition,C:white}^#3#{C:inactive} Chips)",    
            "{C:red,s:1.2}LET HIM OUT!",    
        }    
    },

    set_sprites = function(self, card, front)     
        if not card.custom_extra_sprite then     
            card.custom_extra_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[self.atlas], self.soul_pos.extra)     
            card.custom_extra_sprite.role.draw_major = card    
            card.custom_extra_sprite.custom_draw = true     
        end     
    end,

    loc_vars = function(self, info_queue, card)    
        local jolly_count = 0    
        if G.jokers then    
            for _, v in pairs(G.jokers.cards) do    
                if v.config.center.key == 'j_jolly' then jolly_count = jolly_count + 1 end    
            end    
        end    
        local gain = (card.ability.extra and card.ability.extra.echips_gain) or 1.5
        local base = (card.ability.extra and card.ability.extra.echips_base) or 1
        local total_pow = base + (gain * jolly_count)    
        return { vars = { base, gain, total_pow } }    
    end,    
    
    calculate = function(self, card, context)    
        if context.before and not context.blueprint then    
            local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jolly')    
            _card:set_edition({negative = true}, true)    
            _card:add_to_deck()    
            G.jokers:emplace(_card)    
            _card:start_materialize()
                
            return {    
                message = "I HATE JOLLY JOKERS",    
                colour = G.C.FILTER,    
                card = card    
            }    
        end    
    
        if context.joker_main then    
            local jolly_count = 0    
            if G.jokers then    
                for _, v in pairs(G.jokers.cards) do    
                    if v.config.center.key == 'j_jolly' then jolly_count = jolly_count + 1 end    
                end    
            end    
            
            local gain = (card.ability.extra and card.ability.extra.echips_gain) or 1.5
            local base = (card.ability.extra and card.ability.extra.echips_base) or 1
            local total_pow = base + (gain * jolly_count)    
                
            if context.scoring_name == "Pair" then     
                total_pow = total_pow * ((card.ability.extra and card.ability.extra.pair_mod) or 1.5)    
            end    
    
            return {    
                message = "^" .. number_format(total_pow),
                echips = total_pow,
                colour = G.C.CHIPS    
            }    
        end    
    end    
}







-- If i do, what will the people say?? I cant remove you yet! And even if I do what about old versions? I can't wipe them all!
SMODS.Joker { -- let me out
    key = 'cry', -- let me out
    atlas = 'cry_atlas', -- let me out
    pos = { x = 0, y = 0 }, -- let me out
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 }, skip_draw = true }, -- i don't care
    unlocked = true, -- next update
    rarity = "DJ_?", -- now
    cost = 50, -- now
    blueprint_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { Emult = 1, Emult_mod = 1 } },
    loc_txt = {
        name = 'Exponentia?',
        text = {
            "Gains {X:dark_edition,C:white}^#2#{} Mult whenever a",
            "{C:attention}Jolly Joker{} is sold",
            "Creates a {C:attention}Jolly Joker{} when hand is played",
            "{C:inactive}(Currently {X:dark_edition,C:white}^#1#{C:inactive} Mult)",
            "{C:red,s:1.2}WARNING: VERY UNSTABLE" 
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Emult, card.ability.extra.Emult_mod } }
    end,


    set_sprites = function(self, card, front)
        if card.children.floating_sprite then
            card.children.floating_sprite:remove()
            card.children.floating_sprite = nil
        end

        if not card.custom_extra_floating_sprite then 
            card.custom_extra_floating_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[self.atlas], {x=1, y=0})
            card.custom_extra_floating_sprite.role.draw_major = card
        end
        
        if not card.custom_guy_sprite then
            card.custom_guy_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[self.atlas], {x=2, y=0})
            card.custom_guy_sprite.role.draw_major = card
        end
    end,

    custom_soul_anim = function(self, card, layer)
        card.children.center:draw() 

        local low_fps_t = math.floor(G.TIMERS.REAL * 12) / 12
        local rotate_mod = 0.15 * math.cos(low_fps_t * 43)

        if card.custom_extra_floating_sprite then
            card.custom_extra_floating_sprite.T.x, card.custom_extra_floating_sprite.T.y = card.T.x, card.T.y
            card.custom_extra_floating_sprite.scale = card.children.center.scale
            card.custom_extra_floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, 0, 0)
        end

        if card.custom_guy_sprite then
            card.custom_guy_sprite.T.x, card.custom_guy_sprite.T.y = card.T.x, card.T.y
            card.custom_guy_sprite.scale = card.children.center.scale
            card.custom_guy_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, 0, rotate_mod)
        end
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if #G.jokers.cards < G.jokers.config.card_limit then
                local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jolly')
                _card:add_to_deck()
                G.jokers:emplace(_card)
                return { message = "I HATE JOLLY JOKERS", colour = G.C.FILTER, card = card }
            else
                return { message = "MAKE SLOTS MAKE SLOTS MAKE SLOTS", colour = G.C.RED, card = card }
            end
        end

        if context.selling_card and not context.blueprint then
            if context.card.config.center.key == 'j_jolly' then
                card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_mod
                
                if pseudorandom('dj_exponentia_suffering') < 0.1 then
                    card.ability.extra.Emult = math.max(1, card.ability.extra.Emult - 1)
                    return {
                        message = "DO YOU ENJOY MY SUFFERING?", 
                        colour = G.C.DARK_EDITION,
                        card = card
                    }
                end

                return { 
                    message = "Upgrade! ^" .. number_format(card.ability.extra.Emult), 
                    colour = G.C.DARK_EDITION, 
                    card = card 
                }
            end
        end

        if context.joker_main and (to_big(card.ability.extra.Emult) > to_big(1)) then
            return { 
                message = "^" .. number_format(card.ability.extra.Emult), 
                Emult_mod = card.ability.extra.Emult, 
                colour = G.C.DARK_EDITION 
            }
        end
    end
}






SMODS.Consumable {  
    key = 'the_heart',  
    set = 'Spectral',  
    atlas = 'heart_atlas',  
    pos = { x = 0, y = 0 },  
    soul_pos = {     
        x = 1,     
        y = 0,    
        draw = function(card, scale_mod, rotate_mod)    
            local beat_time = G.TIMERS.REAL * 2.5  
            local beat_phase = beat_time % 1  
              
            local heartbeat  
            if beat_phase < 0.15 then  
                heartbeat = 0.15 + 0.1 * math.sin(beat_phase * math.pi / 0.15)  
            elseif beat_phase < 0.3 then   
                heartbeat = 0.12 + 0.07 * math.sin((beat_phase - 0.15) * math.pi / 0.15)  
            else  
                heartbeat = 0.01 
            end  
              
            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil,     
                card.children.center, heartbeat, rotate_mod)  
        end    
    },    
    loc_txt = {  
        name = 'The Heart',  
        text = {  
            "Destroys all non-{C:attention}Eternal{} Jokers,",  
            "spawns a random {X:dark_edition,C:white}Overpowered{}",  
            "{C:attention}Joker{}"  
        }  
    },  
   
    can_use = function(self, card)  
        return true 
    end,  
      
    use = function(self, card, area, copier)    
        for i = #G.jokers.cards, 1, -1 do  
            local j = G.jokers.cards[i]  
            if not j.ability.eternal then   
                j:start_dissolve()   
            end  
        end  
  
        
        G.E_MANAGER:add_event(Event({  
            trigger = 'after',   
            delay = 0.4,   
            func = function()  
                local op_pool = {}  
                for k, v in pairs(G.P_CENTERS) do  
                    if v.set == 'Joker' and v.rarity == 'DJ_overpowered' then  
                        table.insert(op_pool, k)  
                    end  
                end  
                local chosen_key = #op_pool > 0 and op_pool[math.random(#op_pool)] or 'j_joker'  
                local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_key)  
                _card:add_to_deck()  
                G.jokers:emplace(_card)  
                _card:start_materialize()  
                return true  
            end  
        }))  
    end  
}
SMODS.Consumable {
    key = 'new_song',
    set = 'Tarot', 
    atlas = 'khalid2_atlas',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'NEW SONG',
        text = { "Create a random {C:attention}Joker{}",
        "from the {X:dark_version,C:white}DJ {}{X:dark_version,C:white}Mod{}",
        }

    },
    can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
    local owned_djs = {}
    for _, j in ipairs(G.jokers.cards) do
        if j.config.center.key and string.find(j.config.center.key, 'j_DJ') then
            owned_djs[j.config.center.key] = true
        end
    end

  
    local rarity_roll = pseudorandom('late_night_rarity')
    local target_rarity = 1 
    
    if rarity_roll > 0.96 then 
        target_rarity = 4           
    elseif rarity_roll > 0.80 then 
        target_rarity = 3          
    elseif rarity_roll > 0.60 then 
        target_rarity = 'DJ_misc'   
    elseif rarity_roll > 0.30 then 
        target_rarity = 2           
    else 
        target_rarity = 1           
    end

    local dj_pool = {}
    for k, v in pairs(G.P_CENTERS) do
        if v.set == 'Joker' and string.find(k, 'j_DJ') 
           and v.rarity == target_rarity and not owned_djs[k] then
            table.insert(dj_pool, k)
        end
    end

    if #dj_pool == 0 then
        for k, v in pairs(G.P_CENTERS) do
            if v.set == 'Joker' and string.find(k, 'j_DJ') and not owned_djs[k] then
                if v.rarity == 1 or v.rarity == 2 or v.rarity == 3 or v.rarity == 4 or v.rarity == 'DJ_misc' then
                    table.insert(dj_pool, k)
                end
            end
        end
    end

    if #dj_pool > 0 then
        local chosen_key = pseudorandom_element(dj_pool, pseudorandom('late_night_spawn'))
        SMODS.add_card({ set = 'Joker', key = chosen_key })
    else
        SMODS.add_card({ set = 'Joker' }) 
    end
end
}








SMODS.Back {
    name = "DJ Deck",
    key = "dj_deck",
    atlas = "deck_atlas",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'DJ Deck',
        text = { 
            "Spawns you in with a {C:attention}DJ Khaled{} Joker",
            "And a {C:attention}New song{} Consumable",
            "First {C:red}Boss Blind{} is guaranteed to be {C:red}NO MODS{}",
            "Starts with {C:attention}ANOTHER ONE{} voucher effect"
        }
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.add_card({
                    set = 'Joker',
                    key = 'j_DJ_khalid'
                })
                SMODS.add_card({
                    set = 'Tarot',
                    key = 'c_DJ_new_song'
                })
                if G.P_CENTERS.v_DJ_another then
                    G.GAME.used_vouchers.v_DJ_another = true
                    G.GAME.voucher_counts = G.GAME.voucher_counts or 0
                    G.GAME.voucher_counts = G.GAME.voucher_counts + 1
                end
                if G.GAME and G.GAME.round_resets and G.GAME.round_resets.blind_choices then
                    G.GAME.round_resets.blind_choices.Boss = 'bl_DJ_no_mods'
                    local HUD_boss = G.HUD_blind:get_UIE_by_ID('HUD_blind_boss')
                    if HUD_boss then 
                        G.GAME.blind:set_blind(G.P_BLINDS.bl_DJ_no_mods)
                    end
                end
                
                return true
            end
        }))
    end
}
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
        return { vars = { 20 } }
    end,

    boss_colour = HEX('ff3232'), -- this crashed cuz color and not colour WHY BRITIAN


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
                if card.config.center.mod then
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
            return true
        end
    end
}
SMODS.Voucher {
    key = 'another',
    atlas = 'khaled_atlas',
    pos = { x = 0, y = 0 },
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





local game_start_ref = Game.start_run
function Game.start_run(self, args)
    game_start_ref(self, args)

    if G.GAME.round == 0 then
        local to_spawn = {
            { val = 'spawn_keese',    key = 'j_DJ_average_cryptid' },
            { val = 'spawn_sss',      key = 'j_DJ_dj_sss' },
            { val = 'spawn_seb',      key = 'j_DJ_seb_pressure' },
            { val = 'spawn_balala',   key = 'j_DJ_balala_fairies' },
            { val = 'spawn_first',    key = 'j_DJ_my_first_joker' },
            { val = 'spawn_walker',   key = 'j_DJ_new_sprite' },
            { val = 'spawn_cry_need', key = 'j_DJ_cry_need' },
            { val = 'spawn_sr',       key = 'j_DJ_sr' },
            { val = 'spawn_cryg',     key = 'j_DJ_cryg' },
            { val = 'spawn_60',     key = 'j_DJ_A60' },
            { val = 'spawn_voice',     key = 'j_DJ_voice' },
            { val = 'spawn_o7',     key = 'j_DJ_o7' },
            

        }

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.5,
            func = function()
                local my_mod = SMODS.Mods["DJ_Mod"]
                if my_mod and my_mod.config then
                    for _, item in ipairs(to_spawn) do
                        if my_mod.config[item.val] then
                            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, item.key, 'spawn')
                            if card then
                                card:add_to_deck()
                                G.jokers:emplace(card)
                                card:start_materialize()
                            end
                        end
                    end
                end
                return true
            end
        }))
    end
end



























-- put ur "atlas"es here!
--
--
--
--
--
--
--
--
-- add more "--" if u need to!