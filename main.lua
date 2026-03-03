G.sr_music_enabled = true
----------------------
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO LAST LINE!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO LAST LINE!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO LAST LINE!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO LAST LINE!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO LAST LINE!
----------------------




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





SMODS.current_mod.mod_icon = "Keese.png" -- idk why it wont work pls help

local mod_config = { 
    spawn_keese = false,  
    spawn_sss = false,  
    spawn_seb = false,
    spawn_balala = false,  
    spawn_first = false,
    spawn_walker = false,
    spawn_cry_need = false,
    spawn_sr = true,
    spawn_cryg = false
}

SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, colour = G.C.BLACK },
        nodes = {
            { n = G.UIT.R, nodes = { { n = G.UIT.T, config = { text = "Toggle Start Items:", scale = 0.5, colour = G.C.WHITE } } } },
            
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With Average Cryptid Joker", scale = 0.4, colour = G.C.PURPLE } },
                create_toggle({ label = '', ref_table = SMODS.Mods["DJ_Mod"].config, ref_value = 'spawn_keese', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With DJ Soup & Salad Joker", scale = 0.4, colour = G.C.GREEN } },
                create_toggle({ label = '', ref_table = SMODS.Mods["DJ_Mod"].config, ref_value = 'spawn_sss', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With Sebastion Pressure Joker", scale = 0.4, colour = G.C.RED } },
                create_toggle({ label = '', ref_table = SMODS.Mods["DJ_Mod"].config, ref_value = 'spawn_seb', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With Balala the Fairies", scale = 0.4, colour = G.C.GREEN } },
                create_toggle({ label = '', ref_table = SMODS.Mods["DJ_Mod"].config, ref_value = 'spawn_balala', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With My First Joker", scale = 0.4, colour = G.C.BLUE } },
                create_toggle({ label = '', ref_table = SMODS.Mods["DJ_Mod"].config, ref_value = 'spawn_first', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With New Sprite Joker", scale = 0.4, colour = G.C.PURPLE } },
                create_toggle({ label = '', ref_table = SMODS.Mods["DJ_Mod"].config, ref_value = 'spawn_walker', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With \"vanilla\" styled joker", scale = 0.4, colour = G.C.ORANGE } },
                create_toggle({ label = '', ref_table = SMODS.Mods["DJ_Mod"].config, ref_value = 'spawn_cry_need', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With !sr Joker", scale = 0.4, colour = G.C.ORANGE } },
                create_toggle({ label = '', ref_table = SMODS.Mods["DJ_Mod"].config, ref_value = 'spawn_sr', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With 500 Oops all 6's", scale = 0.4, colour = G.C.GREEN } },
                create_toggle({ label = '', ref_table = SMODS.Mods["DJ_Mod"].config, ref_value = 'spawn_cryg', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "You are unable to spawn in with the secret jokers", scale = 0.5, colour = G.C.GREEN } }
            }},
        }
    }
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
                return { message = "Downgraded!", colour = G.C.RED }  
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
    key = 'average_cryptid', -- absolute peak
    atlas = 'K_atlas', pos = { x = 0, y = 0 }, soul_pos = { x = 1, y = 0 }, rarity = "DJ_overpowered", cost = 20, unlocked = true, discovered = true, blueprint_compat = true, -- cryptid my goat
    loc_txt = { name = 'Average Cryptid Joker', text = { "{C:green}I LOVE {C:blue}JOLLY JOKERS{} I WILL GIVE U", "{X:purple,C:white}^15{} {C:red}MULT{} IF U HAVE ONE!", "{C:inactive,s=0.8}This is true right? (Uncompatible with \"Increase joker values\" jokers)" } },
    in_pool = function(self, args) return false end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_jolly = false
            for _, v in ipairs(G.jokers.cards) do if v.config.center.key == 'j_jolly' then has_jolly = true break end end
            if has_jolly then return { message = '^15!', Emult_mod = 15, colour = G.C.PURPLE } end -- cryptid frfr
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
            "{X:dark_edition,C:white}^#1#{} EVERYTHING!!!!!!!!!!",
            "{C:inactive,s=0.8}Bullying goes hard (Compatible with \"Increase joker values\" jokers)"
        }
    },
    config = { extra = { exponent = 10 } },
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
                Echips_mod = card.ability.extra.exponent,
                Emult_mod = card.ability.extra.exponent,
                message = "^10 EVERYTHING!!!!111!!",
                colour = G.C.PURPLE
            }
        end

        if context.after and not context.blueprint then
            local old_money = math.max(1, G.GAME.dollars)
            local new_money = math.floor(old_money ^ 5)
            
            if new_money > G.GAME.dollars then
                ease_dollars(new_money - G.GAME.dollars)
                return {
                    message = "^10 Money!!11!!!!",
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
            -- Logic: Check if cryg is in the deck
            local cryg_present = false
            for _, v in ipairs(G.jokers.cards) do
                if v.config.center.key == 'j_DJ_cryg' and not v.debuff then
                    cryg_present = true
                end
            end

            -- Roll for success OR check if cryg/stored_win guarantees it
            local rolled_win = pseudorandom('cry_need') < G.GAME.probabilities.normal / card.ability.extra.chance
            
            if rolled_win or card.ability.extra.stored_win or cryg_present then
                if #G.jokers.cards < G.jokers.config.card_limit then
                    local quest_pool = {}
                    for k, v in pairs(G.P_CENTERS) do
                        -- Only grabs the secret ? rarity jokers
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
                        
                        -- If cryg caused this, it handles its own destruction in its own calculate function
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
    rarity = 1,     
    cost = 0,    
    atlas = 'sr_atlas',    
    pos = { x = 0, y = 0 },     
    blueprint_compat = false,    
    discovered = true,    
    
    add_to_deck = function(self, card, from_debuff)  
        if G.jokers then  
            G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots  
        end  
          
        G.E_MANAGER:add_event(Event({  
            trigger = 'after',  
            delay = 0.2,   
            func = function()  
                -- Stop any existing music first  
                if card.sr_music_source then  
                    card.sr_music_source:stop()  
                end  
                  
                -- Use NFS to read the file data properly  
                local sound_path = SMODS.Mods["DJ_Mod"].path .. "assets/sounds/sr.ogg"  
                local file_data = NFS.read('data', sound_path)  
                if file_data then  
                    local source = love.audio.newSource(love.sound.newDecoder(file_data), "stream")  
                    source:setVolume(0.6)  
                    source:setLooping(true)  
                    source:play()  
                    card.sr_music_source = source  
                end  
                return true  
            end  
        }))  
    end,  
  
    remove_from_deck = function(self, card, from_debuff)  
        if G.jokers then  
            G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots  
        end  
          
        if card.sr_music_source then  
            card.sr_music_source:stop()  
            card.sr_music_source = nil  
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
    config = { extra = { Emult = 1, Emult_mod = 1, odds = 500 } },
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
            end
        end
    end

   
    if has_cryg then 
        return true 
    end
    
   
    return old_prob(label, sucs, total, id)
end

-- If i do, what will the people say?? I cant remove you yet! And even if I do what about old versions? I can't wipe em all!
SMODS.Joker { -- let me out
    key = 'cry', -- let me out
    atlas = 'cry_atlas', -- let me out
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 }, skip_draw = true },
    unlocked = true,
    rarity = "DJ_?",
    cost = 50,
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

    in_pool = function(self, args) return false end,

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
                return { message = "I LOVE JOLLY JOKERS", colour = G.C.FILTER, card = card }
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
            -- Create realistic heartbeat pattern (lub-dub with pause)  
            local beat_time = G.TIMERS.REAL * 2.5  
            local beat_phase = beat_time % 1  
              
            local heartbeat  
            if beat_phase < 0.15 then  
                -- First beat (lub)  
                heartbeat = 0.15 + 0.1 * math.sin(beat_phase * math.pi / 0.15)  
            elseif beat_phase < 0.3 then  
                -- Second beat (dub) - slightly smaller  
                heartbeat = 0.12 + 0.07 * math.sin((beat_phase - 0.15) * math.pi / 0.15)  
            else  
                -- Pause between beats  
                heartbeat = 0.01 
            end  
              
            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil,     
                card.children.center, heartbeat, rotate_mod)  
        end    
    },    
    hidden = true, -- Makes it a Soul-tier find  
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
        -- Destroy all non-eternal jokers  
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
            { val = 'spawn_cryg',     key = 'j_DJ_cryg' }
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