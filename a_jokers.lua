local mod = DJ_mod_obj
SMODS.Joker {
    key = 'dj_sss',
    loc_txt = {
        name = 'DJ {C:red}Soup {C:white}& {C:green}Salad',
        text = {
            "Gains stats during {C:attention}Small{} and {C:attention}Big Blinds{}",
            "Played Hand: {X:mult,C:white}-X#3#{} Mult, {X:chips,C:white}+X#4#{} Chips",
            "Discard: {X:chips,C:white}-X#5#{} Chips, {X:mult,C:white}+X#2#{} Mult",
            "Currently Stored: {X:mult,C:white}X#1#{} Mult, {X:chips,C:white}X#6#{} Chips",
            "{C:red}Unleashes power for only ONE hand in Boss Blinds! {C:inactive,s:0.8}(Resets after){}",
            "{C:inactive,s:0.8}DJ Soup and Salad's original idea with a twist!",
        }
    },
    config = { extra = { x_mult = 1, x_chips = 1, gain = 2, loss = 1 } },
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
            card.ability.extra.gain, 
            card.ability.extra.loss, 
            card.ability.extra.gain, 
            card.ability.extra.loss, 
            card.ability.extra.x_chips 
        } } 
    end,

    calculate = function(self, card, context)  
        if context.joker_main then  
            if G.GAME.blind and G.GAME.blind.boss and (card.ability.extra.x_mult > 1 or card.ability.extra.x_chips > 1) then
                local m = card.ability.extra.x_mult
                local c = card.ability.extra.x_chips
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.extra.x_mult = 1
                        card.ability.extra.x_chips = 1
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))

                return { 
                    x_mult = m,
                    x_chips = c,
                    message = "SOUP IS PEAK"
                }  
            end
        end
        if context.end_of_round and not context.blueprint and G.GAME.blind.boss then
            card.ability.extra.x_mult = 1
            card.ability.extra.x_chips = 1
        end
        local is_boss = G.GAME.blind and G.GAME.blind.boss
        
        if not is_boss and not context.blueprint then
            if context.before then  
                card.ability.extra.x_mult = math.max(1, card.ability.extra.x_mult - card.ability.extra.loss)
                card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.gain
                return {
                    message = "X" .. card.ability.extra.x_chips .. " Chips",
                    colour = G.C.CHIPS,
                    card = card
                }  
            end  
            if context.discard then  
                if context.other_card == context.full_hand[#context.full_hand] then
                    card.ability.extra.x_chips = math.max(1, card.ability.extra.x_chips - card.ability.extra.loss)
                    card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.gain
                    return {
                        message = "X" .. card.ability.extra.x_mult .. " Mult",
                        colour = G.C.MULT,
                        card = card
                    }
                end
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
    calculate = function(self, card, context)
         if context.joker_main then 
            return { x_mult = card.ability.extra.x_mult }
        end 
    end    
}

SMODS.Joker {
    key = 'average_cryptid', 
    atlas = 'K_atlas', 
    pos = { x = 0, y = 0 }, 
    soul_pos = { x = 1, y = 0 }, 
    rarity = "DJ_overpowered", 
    cost = 25, 
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
                        message = 'IM JOLLY',
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
        name = 'New Sprite',
        text = {
            "Gives {X:purple,C:white}^#1#{} Mult for every",
            "\"atlas\" mention in {C:attention}items/a_jokers.lua.{}",
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
        
        local content = NFS.read(mod_path .. "items/a_jokers.lua")
        if content then
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
            
            local content = NFS.read(mod_path .. "items/a_jokers.lua")
            if content then
                for _ in string.gmatch(content, "atlas") do 
                    count = count + 1 
                end
            end

            local total_pow = count * card.ability.extra.power_per_mention
            if total_pow > 0 then
                return {
                    message = "^" .. total_pow .. "!",
                    Emult_mod = total_pow,
                    colour = G.C.PURPLE
                }
            end
        end
    end
}
-- atlas
-- atlas
-- atlas
-- atlas
-- atlas
-- atlas
-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas-- atlas
-- balatro but 1% chance to install cryptid
SMODS.Joker {
    key = 'cry_need',
    loc_txt = {
        name = '\"Vanilla\" Styled joker',
        text = {
            "{C:green}#1# in #2#{} chance to {C:attention}\"install\" Cryptid{}",
            "when {C:attention}Blind{} is selected",
            "{C:inactive}(Self-destructs on success)",
            "{C:inactive,s:0.8}If you have 0 slots the chance will be saved until you do",
            "{C:inactive,s:0.8}Balatro but 1% chance to install cryptid:",
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
    add_to_deck = function(self)
        play_sound("DJ_glitch_sound")
        G.GAME.cry_upgrade_glitch_timer = 1.5
        if shake_screen then shake_screen(20, 30) end
    end,
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

            local owned_keys = {}
            for _, v in ipairs(G.jokers.cards) do
                if v.config.center.key then owned_keys[v.config.center.key] = true end
            end

            local rolled_win = pseudorandom('cry_need') < G.GAME.probabilities.normal / card.ability.extra.chance
            
            if rolled_win or card.ability.extra.stored_win or cryg_present then
                if (#G.jokers.cards - 1) < G.jokers.config.card_limit then
                    
                    local chosen_key = nil
                    if not owned_keys['j_DJ_cry'] then
                        chosen_key = 'j_DJ_cry'
                    else
                        local quest_pool = {}
                        for k, v in pairs(G.P_CENTERS) do
                            if v.set == 'Joker' and v.rarity == 'DJ_?' and not owned_keys[k] then
                                table.insert(quest_pool, k)
                            end
                        end
                        
                        if #quest_pool > 0 then
                            chosen_key = pseudorandom_element(quest_pool, pseudorandom('cry_spawn'))
                        else
                            chosen_key = 'j_joker'
                        end
                    end

                    local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_key, 'mod')
                    
                    if _card then 
                        _card:add_to_deck()
                        G.jokers:emplace(_card)
                        _card:start_materialize()
                        play_sound("DJ_glitch2_sound")
                        card:start_dissolve()
                        
                        G.GAME.cry_upgrade_glitch_timer = 2.0
                        if shake_screen then shake_screen(20, 30) end
                        
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
    add_to_deck = function(self, card)
        if G.jokers then    
            G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots 
        end
    end,
    remove_from_deck = function(self, card)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
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
    cost = 25,
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
            "{C:inactive,s:0.8}I HAVE TWO SIDES",
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
        name = "DJ Soup",
        text = { 
            "Create a {C:attention}Stream{}",
            "When boss blind is defeated",
            "{C:green}#1# in #2#{} chance to create {X:red,C:white}The Heart{} instead",
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS['c_DJ_new_song']
        info_queue[#info_queue+1] = G.P_CENTERS['c_DJ_the_heart']
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
                else
                    SMODS.add_card({ set = 'Tarot', key = 'c_DJ_new_song' })
                end
                return {
                    message = "NEW STREAM JUST DROPPED",
                    colour = G.C.BLUE
                }
            end
        end
        if context.setting_blind then
            G.GAME.mixin_dropped = false
        end
    end
}








-- oerac reference no way?
SMODS.Joker {
    key = 'kit',
    atlas = 'kit_atlas', 
    pos = {x = 0, y = 0},
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    display_size = { w = 95, h = 71 },
    discovered = true,
    config = { 
        extra = { 
            x_mult = 10, 
            e_mult = 2, 
            time_needed = 60 
        } 
    },
    loc_txt = {
        name = 'PLAY THE GAME ALREADY!',
        text = {
            "Gives {X:mult,C:white} X#1# {} Mult if more than",
            "{C:attention}#3# seconds{} total has been spent in blinds",
            "without playing a hand",
            "{C:inactive}(Gives {X:dark_edition,C:white} ^#2# {} instead if you have {C:attention}Lucky Cat{C:inactive})",
            "{C:green}Total time: #4#s / #3#s",
            "Currently: #5#",
        }
    },
    update = function(self, card, dt)
        if not card or not card.ability or not card.ability.extra then return end
        if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.DRAW_TO_HAND then
            local prev_time = G.GAME.cry_kit_total_time or 0
            local speed_mod = G.SETTINGS.GAMESPEED or 1
            G.GAME.cry_kit_total_time = prev_time + (dt / speed_mod)
            local threshold = card.ability.extra.time_needed or 60
            if prev_time < threshold and G.GAME.cry_kit_total_time >= threshold then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "STALLED", colour = G.C.DARK_EDITION})
            end
        end
    end,
    loc_vars = function(self, card, info_queue)
        local x_mult = 10
        local e_mult = 2
        local threshold = 60

        if card and card.ability and card.ability.extra then
            x_mult = card.ability.extra.x_mult or 10
            e_mult = card.ability.extra.e_mult or 2
            threshold = card.ability.extra.time_needed or 60
        end

        local time_val = math.floor(G.GAME.cry_kit_total_time or 0)
        local status_text = time_val >= threshold and "Active!" or "Inactive"
        
        return { vars = { 
            x_mult, 
            e_mult, 
            threshold, 
            math.min(time_val, threshold), 
            status_text 
        } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if (G.GAME.cry_kit_total_time or 0) < card.ability.extra.time_needed then
                G.GAME.cry_kit_total_time = 0
                return { message = 'Playing early!', colour = G.C.RED }
            end
        end
        if context.joker_main then
            if (G.GAME.cry_kit_total_time or 0) >= card.ability.extra.time_needed then
                local cat = nil
                if G.jokers and G.jokers.cards then
                    for _, j in ipairs(G.jokers.cards) do
                        if j.config.center.key == 'j_lucky_cat' then cat = j; break end
                    end
                end

                if cat then
                    card_eval_status_text(cat, 'extra', nil, nil, nil, {
                        Emult_mod = 1,
                        remove_default_message = true,
                        message = "MEOW!", 
                        colour = G.C.DARK_EDITION
                    })
                    return {
                        Emult_mod = card.ability.extra.e_mult,
                        colour = G.C.DARK_EDITION,
                        remove_default_message = true
                    }
                else
                    return {
                        message = 'X' .. card.ability.extra.x_mult .. '!',
                        Xmult_mod = card.ability.extra.x_mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    end
}












-- Global Helper: Find folder regardless of case
function get_mod_path(target)
    local items = love.filesystem.getDirectoryItems("Mods")
    if not items then return nil end
    local target_lower = target:lower()
    for _, v in ipairs(items) do
        if v:lower() == target_lower then
            return "Mods/" .. v
        end
    end
    return nil
end

-- The Recursive Purge function you found
local function purge_ignores(directory)
    if not love.filesystem.getInfo(directory) then return end
    
    local items = love.filesystem.getDirectoryItems(directory)
    for _, item in ipairs(items) do
        local path = directory .. '/' .. item
        local info = love.filesystem.getInfo(path)
        
        if info and info.type == 'directory' then
            purge_ignores(path) -- Go deeper
        elseif item:lower() == ".lovelyignore" then
            love.filesystem.remove(path) -- Delete it
        end
    end
end

SMODS.Joker {
    key = 'cryi',
    atlas = 'place_atlas',
    pos = {x = 0, y = 0},
    rarity = "DJ_misc",
    blueprint_compat = false,
    discovered = true,
    loc_txt = {
        name = "Malicious Installer",
        text = { "{C:red}#1#{}" }
    },
    loc_vars = function(self, info_queue, card)
        local cryptid_path = get_mod_path("cryptid")
        local status = cryptid_path and "When Blind is selected, will remove .lovelyignore files from cryptid and add them to DJ_mod\n(AKA disable dj mod and enable cryptid (VERY BUGGY!))" or "CRYPTID MISSING!"
        return { vars = { status } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local dj_path = get_mod_path("DJ_Mod")
            local cryptid_path = get_mod_path("cryptid")
            if dj_path then
                love.filesystem.write(dj_path .. "/.lovelyignore", " ")
            end
            if cryptid_path then
                purge_ignores(cryptid_path)
                
                error("\n--- MOD SWAP COMPLETE ---\nCryptid .lovelyignore's DECIMATED.\nDJ_Mod disabled.\nRESTART (Press R)")
            else
                print("Could not find Cryptid folder.")
            end
        end
    end
}
SMODS.Joker {
    key = 'purpleprint',
    atlas = 'ourple_atlas',
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = {},
    rarity = "DJ_misc",
    blueprint_compat = true,
    discovered = true,
    loc_txt = {
        name = "{C:purple}PurplePrint{}",
        text = { 
            "Retriggers Jokers to the", 
            "{C:attention}left{} and {C:attention}right{}",
            "{C:inactive}Status: #1#" 
        }
    },
    loc_vars = function(self, info_queue, card)
        local l_stat, r_stat = "None", "None"
        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    local left = G.jokers.cards[i-1]
                    local right = G.jokers.cards[i+1]
                    if left then l_stat = left.config.center.blueprint_compat and "Compatible" or "Incompatible" end
                    if right then r_stat = right.config.center.blueprint_compat and "Compatible" or "Incompatible" end
                end
            end
        end
        return { vars = { "L: " .. l_stat .. " / R: " .. r_stat } }
    end,
    draw = function(self, card, layer)
        if layer == 'front' then card.children.front:set_role_col(G.C.PURPLE) end
    end,
    calculate = function(self, card, context)  
    if context.retrigger_joker_check and not context.blueprint then  
        for i = 1, #G.jokers.cards do  
            if G.jokers.cards[i] == card then   
                if context.other_card == G.jokers.cards[i-1] or context.other_card == G.jokers.cards[i+1] then  
                    if context.other_card.config.center.blueprint_compat and not context.other_card.ability.ignore_copy then  
                        return {  
                            message = "Again!",  
                            repetitions = 1,  
                            card = card  
                        }  
                    end  
                end  
            end  
        end  
    end  
end
}
-- 2. THE REDPRINT
SMODS.Joker {
    key = 'redprint',
    atlas = 'red_atlas',
    pos = {x = 0, y = 0},
    config = {},
    rarity = 3,
    blueprint_compat = true,
    discovered = true,
    loc_txt = {
        name = "{C:red}RedPrint{}",
        text = { 
            "Copies the Joker to the {C:attention}left{}", 
            "{C:inactive}(Fuses with Blueprints){}",
            "{C:inactive}Status: #1#" 
        }
    },
    loc_vars = function(self, info_queue, card)
        local status = "None"
        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    local target = G.jokers.cards[i - 1]
                    if target then
                        status = target.config.center.blueprint_compat and "Compatible" or "Incompatible"
                    end
                end
            end
        end
        return { vars = { status } }
    end,
    draw = function(self, card, layer)
        if layer == 'front' then card.children.front:set_role_col(G.C.RED) end
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    local target = G.jokers.cards[i - 1]
                    if target and target.config.center.key == 'j_blueprint' and not (card.getting_sliced or target.getting_sliced) then
                        card.getting_sliced = true; target.getting_sliced = true
                        card:juice_up(); target:juice_up()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after', delay = 0.6,
                            func = function()
                                play_sound('DJ_purple_sound')
                                card:remove(); target:remove()
                                local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_DJ_purpleprint')
                                new_card:add_to_deck(); G.jokers:emplace(new_card)
                                return true
                            end
                        }))
                        return
                    end
                end
            end
        end
        if context.joker_main and not context.blueprint then
            if G.jokers and G.jokers.cards then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        local target = G.jokers.cards[i - 1]
                        if target and target.config.center.blueprint_compat and not target.ability.ignore_copy then
                            local res = SMODS.blueprint_effect(card, target, context)
                            if res then return res end
                        end
                    end
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'the_fortress',
    atlas = 'fort_atlas', 
    pos = {x = 0, y = 0},  
    rarity = 3,            
    cost = 8,
    blueprint_compat = true,
    discovered = true,
    loc_txt = {
        name = "The Fortress",
        text = { 
            "{X:mult,C:white} X#1# {} Mult if played",
            "hand is a {C:attention}Stronghold{}",
            "{C:green,s:0.8}Image taken from {C:chips}Cryptid!"
        }
    },
    config = { extra = 2.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if context.scoring_name == 'DJ_stronghold' then
                return {
                    message = 'X' .. card.ability.extra,
                    Xmult_mod = card.ability.extra
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'all_blueprints',
    loc_txt = {
        name = 'Oops, all blueprints!',
        text = {
            "Creates a {C:dark_edition}Negative{} {C:attention}Blueprint{}",
            "when {C:attention}hand is played{}",
            "{C:inactive,s:0.8}A comment inspired this joker"
        }
    },
    rarity = "DJ_overpowered",
    discovered = true,
    cost = 25,
    blueprint_compat = false,
    atlas = 'oopsb_atlas',
    pos = { x = 0, y = 0 },
    soul_pos = {x = 1, y = 0},

    calculate = function(self, card, context)
        if context.before and not context.blueprint then   
            local _card = SMODS.create_card({
                set = 'Joker',
                key = 'j_blueprint',
                area = G.jokers,
                edition = 'e_negative'
            })
            
            _card:add_to_deck()
            G.jokers:emplace(_card)
            _card:start_materialize()
        end
    end
}
SMODS.Joker {
    key = 'multi_jimbo',
    atlas = "jimp_atlas",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    config = { extra = { x_mod = 4 } },
    discovered = true,
    loc_txt = {
        name = "Jimbo {C:green}+{}",
        text = {
            "Gives {X:mult,C:white} X#1# {} Mult"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mod } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Emult_mod = 1,
                message = 'X' .. card.ability.extra.x_mod,
                x_mult = card.ability.extra.x_mod,
                remove_default_message = true,
                colour = G.C.MULT,

            }
        end
    end
}
SMODS.Joker {
    key = 'riceball',
    atlas = "rice_atlas",
    pos = {x = 0, y = 0},
    rarity = 2, 
    cost = 6,
    discovered = true,
    blueprint_compat = true,
    config = { extra = { x_mult = 1, gain = 3 } }, 
    loc_txt = {
        name = "RiceBall_129",
        text = {
            "Gains {X:mult,C:white} X#2# {} Mult if",
            "played hand is a {C:attention}Royal Flush{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)",
            "{C:red,s:1.3}READ THE CHAT!{}" 
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
    if context.before and not context.blueprint then
        local has_ace = false
        local has_ten = false
        
        if context.scoring_name == "Straight Flush" then
            for k, v in ipairs(context.scoring_hand) do
                if v:get_id() == 14 then has_ace = true end
                if v:get_id() == 10 then has_ten = true end
            end
        end

        if has_ace and has_ten then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.gain
            return {
                message = "Upgraded!",
                colour = G.C.RED,
                card = card
            }
        end
    end
    if context.joker_main and card.ability.extra.x_mult > 1 then
        return {
            x_mult = card.ability.extra.x_mult
        }
    end
end
}
SMODS.Joker {
    key = 'photochad',
    loc_txt = {
        name = 'PhotoChad',
        text = {
            "Retriggers all {C:attention}Face{} cards {C:attention}#3#{} times.",
            "All {C:attention}Face{} cards give {X:mult,C:white} X#1# {} Mult",
            "when scored. {C:inactive}(Increases both by {C:mult}#2#{C:inactive} at end of round)",
            "{C:inactive}>Looks inside",
            "{C:inactive}>PHOTOCHAD???"
        }
    },
    config = { extra = { x_mult = 2, repetitions = 1, gain = 1 } },
    rarity = 'DJ_overpowered',
    discovered = true,
    atlas = 'photo_atlas',
    pos = { x = 0, y = 0 }, 
    soul_pos = { x = 1, y = 0 },
    display_size = { w = 71, h = 80 },
    cost = 25,
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                (card and card.ability and card.ability.extra and card.ability.extra.x_mult) or self.config.extra.x_mult,
                (card and card.ability and card.ability.extra and card.ability.extra.gain) or self.config.extra.gain,
                (card and card.ability and card.ability.extra and card.ability.extra.repetitions) or self.config.extra.repetitions
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
        if context.repetition and context.cardarea == G.play then
            if context.other_card:is_face() then
                return {
                    message = 'Again!',
                    repetitions = card.ability.extra.repetitions,
                    card = card
                }
            end
        end
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.gain
            card.ability.extra.repetitions = card.ability.extra.repetitions + card.ability.extra.gain
            
            return {
                message = 'Upgrade!',
                colour = G.C.GREEN,
                card = card
            }
        end
    end
}
SMODS.Joker {
    key = 'spell_binder_3113',
    loc_txt = {
        name = 'Spell Binder 3113',
        text = {
            "Gains {C:chips}+#2#{} Chips for every",
            "{C:spectral}Spectral{} card used after this joker was bought",
            "{C:inactive}(Currently {C:chips}+#1#{} Chips)",
            "{C:inactive,s:0.8}Another balatro youtuber!"
        }
    },
    discovered = true,
    config = { extra = { chips = 0, chip_mod = 60 } },
    rarity = 2,
    cost = 6,
    atlas = 'spell_atlas',
    pos = { x = 0, y = 0 }, 
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                chip_mod = card.ability.extra.chips
            }
        end
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.ability.set == 'Spectral' then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Upgrade!'})
                        return true
                    end
                }))
            end
        end
    end
}
local funhouse_temp = { bet_val = "" }

G.FUNCS.cancel_funhouse_menu = function(e)
    G.FUNCS.exit_overlay_menu()
    G.SETTINGS.paused = false
    funhouse_temp.bet_val = "" 
end

G.FUNCS.confirm_funhouse_bet = function(e)
    local raw_input = funhouse_temp.bet_val or ""
    raw_input = raw_input:gsub("[oO]", "0")
    local input_val = tonumber(raw_input) 
    if not input_val then return end
    local current_dollars = to_number(G.GAME.dollars)
    if to_number(input_val) <= 0 or to_number(input_val) > current_dollars then 
        return 
    end
    for _, v in ipairs(G.jokers.cards) do
        if v.config.center.key == 'j_DJ_funhouse_host' then
            v.ability.extra.active_bet = input_val
            ease_dollars(-input_val)
            card_eval_status_text(v, 'extra', nil, nil, nil, {
                message = "BET: $"..input_val,
                colour = G.C.MONEY
            })
            break
        end
    end
    funhouse_temp.bet_val = "" 
    G.FUNCS.exit_overlay_menu()
    G.SETTINGS.paused = false
end

function create_funhouse_menu()
    local current_dollars = to_number(G.GAME.dollars)
    funhouse_temp.bet_val = "" 
    
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1 },
        nodes = {
            { n = G.UIT.R, config = { align = "cm", padding = 0.1 }, nodes = {
                { n = G.UIT.T, config = { text = "PLACE YOUR BET", scale = 0.6, colour = G.C.WHITE } }
            }},
            { n = G.UIT.R, config = { align = "cm", padding = 0.1 }, nodes = {
                -- Displaying the max amount safely
                { n = G.UIT.T, config = { text = "(Max: $"..tostring(current_dollars)..")", scale = 0.4, colour = G.C.GOLD } }
            }},
            { n = G.UIT.R, config = { align = "cm", padding = 0.2 }, nodes = {
            create_text_input({
                w = 4, h = 1,
                 max_length = 10,
                 prompt_text = "Enter Bet!",
                 ref_table = funhouse_temp,
                 ref_value = 'bet_val',
                 extended_cursor = true,
                  type = 'string',
                 character_filter = '0123456789'
             })
          }},
            { n = G.UIT.R, config = { align = "cm" }, nodes = {
                UIBox_button({ 
                    label = {"BET"}, 
                    button = 'confirm_funhouse_bet', 
                    colour = G.C.GREEN, 
                    minw = 2 
                }),
                UIBox_button({ 
                    label = {"CANCEL"}, 
                    button = 'cancel_funhouse_menu', 
                    colour = G.C.RED, 
                    minw = 2 
                })
            }}
        }
    }
end

G.FUNCS.focus_bet_input = function(e)
    if G.OVERLAY_MENU then
        local input = G.OVERLAY_MENU:get_UIE_by_ID('dj_bet_input')
        if input then 
        end
    end
end
SMODS.Joker {
    key = 'funhouse_host',
    atlas = "funhouse_atlas",
    pos = { x = 0, y = 0 },
    unique = true,
    config = { extra = { active_bet = 0, win_state = false, payout_triggered = false } },
    loc_txt = {
        name = "Funhouse Host",
        text = {
            "When {C:attention}Blind{} is selected,",
            "choose an amount of {C:money}${} to {C:money}Bet{}.",
            "Win in {C:attention}1 hand{} to double it,",
            "otherwise lose the amount."
        }
    },
    update = function(self, card)
        if G.jokers and card.area == G.jokers then
            local host_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == 'j_DJ_funhouse_host' then
                    host_count = host_count + 1
                    if host_count > 1 and G.jokers.cards[i] == card then
                        card:start_dissolve()
                    end
                end
            end
        end
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not self.getting_sliced then
            card.ability.extra.win_state = false
            card.ability.extra.payout_triggered = false
            card.ability.extra.active_bet = card.ability.extra.active_bet or 0
            local current_money = G.GAME.dollars or 0
            if to_number(current_money) > 0 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after', delay = 0.5,
                    func = function()
                        G.SETTINGS.paused = true
                        G.FUNCS.overlay_menu({ definition = create_funhouse_menu() })
                        return true
                    end
                }))
            end
        end
        if context.end_of_round and not context.repetition and not context.blueprint then
            if not card.ability.extra.payout_triggered then
                card.ability.extra.payout_triggered = true
                
                local handsUsed = G.GAME.current_round.hands_played
                if handsUsed == 1 then
                    card.ability.extra.win_state = true
                    local bet = tonumber(card.ability.extra.active_bet) or 0
                    if bet > 0 then
                        ease_dollars(bet * 2) 
                        card.ability.extra.active_bet = 0
                    end

                    return {
                        message = "WINNER! +$"..(bet*2),
                        colour = G.C.MONEY,
                        card = card
                    }
                else
                    card.ability.extra.win_state = false
                    card.ability.extra.active_bet = 0
                    return {
                        message = "BUST!",
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end
    end
}
SMODS.Joker {  
    key = 'tetrationa',  
    loc_txt = {  
        name = 'Tetrationa',  
        text = {  
            "Gains {X:dark_edition,C:white} ^^#2# {} height",  
            "per {C:spectral}Spectral{} card used",  
            "Tetrates {C:chips}Chips{} and {C:mult}Mult{} by this height",  
            "Creates a free {C:spectral}Mega Spectral{} pack each shop",  
            "{C:inactive}(Current Height: {X:dark_edition,C:white} ^^#1#{} {C:inactive})"  
        }  
    },  
    config = {   
        extra = {   
            height = 1.2,  
            gain = 0.03   
        }   
    },   
    rarity = 'DJ_surreal',  
    discovered = true,  
    atlas = 'tetr_atlas',  
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
    set_sprites = function(self, card, front)       
        if not card.custom_extra_sprite then       
            card.custom_extra_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[self.atlas], self.soul_pos.extra)       
            card.custom_extra_sprite.role.draw_major = card      
            card.custom_extra_sprite.custom_draw = true       
        end       
    end,  
    cost = 100,  
    blueprint_compat = false,  
      
    loc_vars = function(self, info_queue, card)  
        local extra = (card and card.ability and card.ability.extra) or self.config.extra  
        return { vars = {   
            string.format("%.2f", extra.height),  
            extra.gain   
        } }  
    end,
    set_debuff = function(self, card)
    return 'prevent_debuff'
    end,
  
    calculate = function(self, card, context)
        if card.debuff then card.debuff = false end
        if context.using_consumeable and not context.blueprint then 
            if context.consumeable.config.center.set == 'Spectral' then 
                card.ability.extra.height = card.ability.extra.height + card.ability.extra.gain 
                attention_text({ 
                    text = '^^' .. string.format("%.2f", card.ability.extra.height), 
                    scale = 1.2, hold = 0.8, major = card, 
                    backdrop_colour = G.C.SECONDARY_SET.Spectral, 
                    align = 'bm', offset = {x = 0, y = -0.2} 
                }) 
            end 
        end 
        if context.setting_blind and not context.blueprint then
            G.GAME.modifiers.spawn_tetration_pack = true
        end
        if context.joker_main then 
            local h = card.ability.extra.height 
            local chip_base = to_big(hand_chips or 1)
            local mult_base = to_big(mult or 1)
            if chip_base:gt(1.1) or mult_base:gt(1.1) then
                local h_exp = h - 1 
                local final_chips = chip_base:pow(chip_base:pow(h_exp)) 
                local final_mult = mult_base:pow(mult_base:pow(h_exp)) 
                local dynamic_pitch = math.min(1 + (h - 1.2), 2.5)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("DJ_tetr_sound", dynamic_pitch, 0.6)
                        card:juice_up(0.8, 0.5)
                        return true
                    end
                }))

                return { 
                    message = '^^' .. string.format("%.2f", h),
                    chip_mod = final_chips - chip_base, 
                    mult_mod = final_mult - mult_base, 
                    remove_default_message = true, 
                    colour = G.C.DARK_EDITION 
                } 
            end
        end 
    end
}
local tetration_shop_ref = Game.update_shop
function Game:update_shop(dt)
    tetration_shop_ref(self, dt)
    if G.GAME.modifiers.spawn_tetration_pack and G.shop_booster then
        local booster_card = SMODS.add_booster_to_shop('p_spectral_mega_1')
        if booster_card then
            booster_card.cost = 0
            booster_card.ability.extra_cost = 0
            booster_card.free = true
            booster_card:set_cost() 
            if booster_card.cost > 0 then
                booster_card.cost = 0
            end
            G.GAME.modifiers.spawn_tetration_pack = nil
        end
    end
end
SMODS.Joker {
    key = 'quadratic',
    atlas = "pyth_atlas",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    rarity = "DJ_surreal",
    discovered = true,
    cost = 100,
    blueprint_compat = false,
    loc_txt = {
        name = "Pythagorean Theorem",
        text = {
            "Forces {C:blue}Chips{} and {C:red}Mult{} to {C:attention}1{}",
            "and {C:chips}Chips{} {C:dark_edition}^{} {C:mult}Mult{} becomes the new {C:mult}Mult{}.",
            "{C:inactive}(Score operator is now {C:dark_edition}^{C:inactive})"
        }
    },
    set_debuff = function(self, card)
    return 'prevent_debuff'
    end,
    calculate = function(self, card, context)
        if card.debuff then card.debuff = false end
        if context.joker_main then
            local current_chips = hand_chips
            local current_mult = mult
            local val = current_chips ^ current_mult
            hand_chips = hand_chips + hand_chips
            hand_chips = hand_chips - hand_chips
            hand_chips = hand_chips - (hand_chips - 1)
            mult = mult + mult
            mult = mult - mult
            mult = mult - (mult - 1)
            return {
                x_mult = val,
                Emult_mod = 1,
                message = 'CHIPS ^ MULT',
                remove_default_message = true,
                colour = G.C.IMPORTANT
            }
        end
    end
}