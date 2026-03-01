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

SMODS.Sound { key = 'get_sound', path = 'get_sound.mp3' }    
SMODS.Sound { key = 'bruh_sound', path = 'bruh_sound.mp3' }
SMODS.Sound({ key = "speed_sound", path = "speed_sound.mp3"})

SMODS.current_mod.mod_icon = "Keese.png" -- idk why it wont work pls help

local mod_config = { 
    spawn_keese = false,  
    spawn_sss = false,  
    spawn_seb = false,
    spawn_balala = false,  
    spawn_first = false,
    spawn_walker = false,
    spawn_cry_need = false
}

for k, v in pairs(SMODS.current_mod.config) do 
    mod_config[k] = v 
end
SMODS.current_mod.config = mod_config 
  
SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, colour = G.C.BLACK },
        nodes = {
            { n = G.UIT.R, nodes = { { n = G.UIT.T, config = { text = "Toggle Start Items:", scale = 0.5, colour = G.C.WHITE } } } },
            
            -- Existing Toggles
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With Average Cryptid Joker", scale = 0.4, colour = G.C.PURPLE } },
                create_toggle({ label = '', ref_table = mod_config, ref_value = 'spawn_keese', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With DJ Soup & Salad Joker", scale = 0.4, colour = G.C.GREEN } },
                create_toggle({ label = '', ref_table = mod_config, ref_value = 'spawn_sss', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With Sebastion Pressure Joker", scale = 0.4, colour = G.C.RED } },
                create_toggle({ label = '', ref_table = mod_config, ref_value = 'spawn_seb', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With Balala the Fairies", scale = 0.4, colour = G.C.GREEN } },
                create_toggle({ label = '', ref_table = mod_config, ref_value = 'spawn_balala', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With My First Joker", scale = 0.4, colour = G.C.BLUE } },
                create_toggle({ label = '', ref_table = mod_config, ref_value = 'spawn_first', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With New Sprite Joker", scale = 0.4, colour = G.C.PURPLE } },
                create_toggle({ label = '', ref_table = mod_config, ref_value = 'spawn_walker', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "Spawn With PLEASE CRYPTID I NEED THIS!", scale = 0.4, colour = G.C.ORANGE } },
                create_toggle({ label = '', ref_table = mod_config, ref_value = 'spawn_cry_need', col = true, hide_label = true })
            }},
            { n = G.UIT.R, nodes = {
                { n = G.UIT.T, config = { text = "You are unable to spawn in with the secret joker", scale = 0.5, colour = G.C.GREEN } }
            }},
        }
    }
end

SMODS.Atlas{ key = "dj_atlas", path = "stolethisfromcryptid.png", px = 71, py = 95 } -- i actually did
SMODS.Atlas{ key = "seb_atlas", path = "seb.png", px = 71, py = 95 }
SMODS.Atlas{ key = "K_atlas", path = "stolethisfromcryptidsecond.png", px = 71, py = 95 } -- i actually did the second feturing dante from the devil may cry series
SMODS.Atlas { key = "balala_atlas",path = "balala.png", px = 71, py = 95 }
SMODS.Atlas { key = "first_atlas",path = "first.png", px = 71, py = 95 }
SMODS.Atlas { key = "walker_atlas", path = "walker.png", px = 71, py = 95 }
SMODS.Atlas { key = "cryf_atlas",path = "cryf.png",px = 71,py = 95}
SMODS.Atlas { key = "cry_atlas", path = "cry.png", px = 71, py = 95}


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
          "{C:green}and i'll give u mult :D{}",
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
            if card.ability.extra.in_shop then   -- i want it to play a sound but idk how maybe tommorow   
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
    atlas = 'K_atlas', pos = { x = 0, y = 0 }, soul_pos = { x = 1, y = 0 }, rarity = 4, cost = 20, unlocked = true, discovered = true, blueprint_compat = true, -- cryptid my goat
    loc_txt = { name = 'Average Cryptid Joker', text = { "{C:green}I LOVE {C:blue}JOLLY JOKERS{} I WILL GIVE U", "THE {X:purple,C:white}^999{} {C:red}MULT{} IF U HAVE ONE!", "{C:inactive,s=0.8}This is true right? (Uncompatible with \"Increase joker values\" jokers)" } },
    in_pool = function(self, args) return false end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_jolly = false
            for _, v in ipairs(G.jokers.cards) do if v.config.center.key == 'j_jolly' then has_jolly = true break end end
            if has_jolly then return { message = '^999!', Emult_mod = 999, colour = G.C.PURPLE } end -- cryptid frfr
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
    rarity = 4,
    atlas = 'first_atlas',
    pos = { x = 0, y = 0 },      
    soul_pos = { x = 1, y = 0 }, 
    cost = 10,
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
            local new_money = math.floor(old_money ^ card.ability.extra.exponent)
            
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
        name = 'PLEASE CRYPTID I NEED THIS!',
        text = {
            "{C:green}#1# in #2#{} chance to {C:attention}install Cryptid{}",
            "when {C:attention}Blind{} is selected",
            "{C:inactive}(Self-destructs on success)",
            "{C:inactive,s:0.8}Balatro but 1% chance to install cryptid:"
        }
    },
    config = { extra = { chance = 100, stored_win = false } }, 
    rarity = 2, 
    atlas = 'cryf_atlas',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } }, 
    cost = 1,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card) -- so basically if u get a win but no joker 
        -- slots im not evil so u get 100% UNTIL
        -- u get a joker slot
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.chance } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local rolled_win = pseudorandom('cry_need') < G.GAME.probabilities.normal / card.ability.extra.chance
            
            if rolled_win or card.ability.extra.stored_win then
                -- Do we have room?
                if #G.jokers.cards < G.jokers.config.card_limit then
                    local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_DJ_cry', 'mod')
                    if _card then 
                        _card:add_to_deck()
                        G.jokers:emplace(_card)
                        
                        card:remove() 
                        return {
                            message = "YOU'RE A LIER DJ!", -- he said he didnt change anything but 
                            -- "shop" said "soup"
                            colour = G.C.RED,
                            attention_text = true
                        }
                    end
                else
                    card.ability.extra.stored_win = true
                    return {
                        message = "Make slots you littl-",
                        colour = G.C.RED
                    }
                end
            else
                -- Regular failure
                return {
                    message = "YOU'RE TRUTHFUL DJ",
                    colour = G.C.GREEN
                }
            end
        end
    end
}


-- HELP HES TOO JOLLY, was going to use cryptids code but that didnt work out
SMODS.Joker {
    key = 'cry',
    atlas = 'cry_atlas',
    pos = { x = 0, y = 0 }, 
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 }, skip_draw = true }, 
    unlocked = true,
    discovered = true,
    rarity = 4, 
    cost = 20,
    blueprint_compat = true,
    config = { extra = { Emult = 1, Emult_mod = 1 } },
    loc_txt = {
        name = 'Exponentia?',
        text = {
            "Gains {X:dark_edition,C:white}^#2#{} Mult whenever a",
            "{C:attention}Jolly Joker{} is sold",
            "Creates a {C:attention}Jolly Joker{} when hand is played",
            "{C:inactive}(Currently {X:dark_edition,C:white}^#1#{C:inactive} Mult)",
            "{C:inactive,s:0.8}Bought him off ebay, he REALLY wants to escape for some reason" 
        }
    },

    in_pool = function(self, args) return false end,

    set_sprites = function(self, card, front)
        if card.children.floating_sprite then
            card.custom_floating_sprite = card.children.floating_sprite
            card.children.floating_sprite = nil
        end

        if card.custom_extra_floating_sprite then 
            card.custom_extra_floating_sprite:remove() 
        end
        
        card.custom_extra_floating_sprite = Sprite(
            card.T.x, card.T.y, card.T.w, card.T.h, 
            G.ASSET_ATLAS[self.atlas], 
            self.soul_pos.extra
        )
        card.custom_extra_floating_sprite.role.draw_major = card
        card.custom_extra_floating_sprite.states.hover.can = false
        card.custom_extra_floating_sprite.states.click.can = false
    end,

    custom_soul_anim = function(self, card, layer)
        local low_fps_t = math.floor(G.TIMERS.REAL * 12) / 12
        local seed = math.sin(low_fps_t * 1000)
        local rotate_mod = 0.15 * math.cos(low_fps_t * 43)
        local glitch_x = (seed > 0.9) and (seed - 0.9) * 2 or 0
        local glitch_y = (seed < -0.9) and (seed + 0.9) * 2 or 0

        if card.custom_extra_floating_sprite then
            card.custom_extra_floating_sprite.T.x = card.T.x
            card.custom_extra_floating_sprite.T.y = card.T.y
            card.custom_extra_floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, 0, 0)
        end

        if card.custom_floating_sprite then
            card.custom_floating_sprite.T.x = card.T.x
            card.custom_floating_sprite.T.y = card.T.y
            card.custom_floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, 0, rotate_mod, glitch_x, 0.1, glitch_y)
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { number_format(card.ability.extra.Emult), number_format(card.ability.extra.Emult_mod) } }
    end,
    
    calculate = function(self, card, context)
        -- Spawn Jolly Joker on played hand
        if context.before and not context.blueprint then
            if #G.jokers.cards < G.jokers.config.card_limit then
                local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jolly')
                _card:add_to_deck()
                G.jokers:emplace(_card)
                return { message = "I LOVE JOLLY JOKERS", colour = G.C.FILTER, card = card }
            else
                return { message = "Make slots you littl-", colour = G.C.RED, card = card }
            end
        end

        -- Gain ^Mult and 1/10 Suffering chance on Sell
        if context.selling_card and not context.blueprint then
            if context.card.config.center.key == 'j_jolly' then
                card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_mod
                
                if pseudorandom('dj_exponentia_suffering') < 0.1 then
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

        -- Score ^Mult
        if context.joker_main and (to_big(card.ability.extra.Emult) > to_big(1)) then
            return { message = "^" .. number_format(card.ability.extra.Emult), Emult_mod = card.ability.extra.Emult, colour = G.C.DARK_EDITION }
        end
    end
}
local game_start_ref = Game.start_run
function Game.start_run(self, args)
    game_start_ref(self, args)
    
    if G.GAME and G.GAME.round == 0 then
        G.E_MANAGER:add_event(Event({
            func = function()
                local dj_mod = SMODS.Mods["DJ_Mod"]
                if not (dj_mod and dj_mod.config) then return true end 
                
                local conf = dj_mod.config
                
                local function quick_spawn(key)
                    -- Check if already in inventory to prevent double-spawning
                    for _, v in pairs(G.jokers.cards) do
                        if v.config.center.key == key then return end
                    end

                    local card = create_card('Joker', G.jokers, nil, nil, nil, nil, key, 'mod')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end

                if conf.spawn_keese then quick_spawn('j_DJ_average_cryptid') end
                if conf.spawn_sss then quick_spawn('j_DJ_dj_sss') end
                if conf.spawn_seb then quick_spawn('j_DJ_seb_pressure') end
                if conf.spawn_balala then quick_spawn('j_DJ_balala_fairies') end
                if conf.spawn_first then quick_spawn('j_DJ_my_first_joker') end
                if conf.spawn_walker then quick_spawn('j_DJ_new_sprite') end
                if conf.spawn_cry_need then quick_spawn('j_DJ_cry_need') end

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