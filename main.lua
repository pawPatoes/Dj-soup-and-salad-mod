SMODS.Atlas({
    key = "modicon",
    path = "keese.png",
    px = 32,
    py = 32
})
function exponent_crash()
    local file_path = "Mods/DJ_Mod/items/exotic.lua"
    os.execute('start "" "' .. file_path .. '"')
    error("\n\n" ..
          "================================================\n" ..
          "THIS CRASH IS INTENTIONAL PLEASE READ THE TEXT BELOW!!!!\n" ..
          "ERROR: Tried to obtain locked joker \"j_DJ_cry\" (name = Exponentia?)\n" ..
          "================================================\n" ..
          "Cause for error: exponentiaUnlocked is set to false.\n" ..
          "The file has been opened for you.\n" ..
          "Locate 'exponentiaUnlocked = false'\n" ..
          "Change it to 'true'\n" ..
          "Save the file and Restart Balatro.\n" ..
          "EMODS.Dont\n" ..
          "Cry\n" ..
          "Cry\n" ..
          "Cry\n" ..
          "Cry\n" ..
          "Cry\n" ..
          "Cry\n" ..
          "Cry\n" ..
          "Cry\n" ..
          "are you still reading?\n" ..
          "================================================")
end
local card_init_ref = Card.set_ability
local native_copy = copy_card
function copy_card(other, new_card)
    if other and other.seal == 'DJ_blueprinted' then
        other.ability.seal = other.ability.seal or {}
    end
    return native_copy(other, new_card)
end
local mod = SMODS.current_mod
DJ_mod_obj = mod 
----------------------
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO THE ITEMS FOLDER AND A_JOKERS.lua!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO THE ITEMS FOLDER AND A_JOKERS.lua!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO THE ITEMS FOLDER AND A_JOKERS.lua!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO THE ITEMS FOLDER AND A_JOKERS.lua!
-- IF YOU'RE HERE TO ADD "ATLAS" FOR NEW SPRITE JOKER GO TO THE ITEMS FOLDER AND A_JOKERS.lua!
-- Thank you for reading this :3
SMODS.current_mod.optional_features = {  
    retrigger_joker = true  
}
mod.config_tab = dj_config_nodes
mod.default_config = {
    play_exotic_music = true
}
SMODS.DrawStep {  
    key = 'cry_soul_anim',  
    order = 60, 
    conditions = { vortex = false, facing = 'front' },  
    func = function(self, layer)  
        if (self.config.center.key == 'j_DJ_cry' or self.config.center.key == 'j_DJ_cry_broken') 
           and self.config.center.custom_soul_anim then  
            self.config.center:custom_soul_anim(self, layer)  
        end  
    end  
}
mod.mod_icon = "modicon"
SMODS.ScreenShader {
    key = 'cry_glitch',
    path = 'glitch.fs',
    process_config = function(self, config)
        if config and config.file then
            config.file = config.file:gsub('\r', '')
        end
    end,
    send_vars = function(self)
        return {
            timer = G.GAME.cry_upgrade_glitch_timer or 0
        }
    end,
    should_apply = function(self)
        return G.GAME.cry_upgrade_glitch_timer and G.GAME.cry_upgrade_glitch_timer > 0
    end
}
local game_upd_ref = Game.update
function Game:update(dt)
    game_upd_ref(self, dt)
    if G.GAME and G.GAME.cry_upgrade_glitch_timer and G.GAME.cry_upgrade_glitch_timer > 0 then
        G.GAME.cry_upgrade_glitch_timer = G.GAME.cry_upgrade_glitch_timer - dt
    end
end
local get_blind_amount_ref = get_blind_amount
function get_blind_amount(ante)
    local amount = get_blind_amount_ref(ante)
    if G.GAME and G.GAME.cry_body_multiplier then
        amount = amount * G.GAME.cry_body_multiplier
    end
    return amount
end
local game_update_ref = Game.update
local original_update = G.update
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
SMODS.Rarity {
    key = 'broke',
    loc_txt = {
        name = 'Sold?'
    },
    badge_colour = {1, 0, 1, 1},
    default_weight = 0,
}
G.C.SURREAL = {1, 0.5, 0, 1} 
SMODS.Rarity {
    key = 'surreal',
    loc_txt = { name = 'Surreal' },
    badge_colour = {1, 0.5, 0, 1},
    default_weight = 0,
}
-- SOUND
SMODS.Sound { key = 'get_sound', path = 'get_sound.mp3' }    
SMODS.Sound { key = 'bruh_sound', path = 'bruh_sound.mp3' }
SMODS.Sound { key = 'balala_sound', path = 'balala.ogg' }
SMODS.Sound { key = "static_sound", path = "static.ogg"}
SMODS.Sound { key = "life_sound", path = "life.mp3"}
SMODS.Sound {  
    key = 'sr_music',  
    path = 'sr.ogg',  
    select_music_track = function(self)   
        if G.jokers and G.jokers.cards then  
            for _, card in ipairs(G.jokers.cards) do   
                if card.config.center.key == 'j_DJ_sr' then    
                    return 8
                end  
            end  
        end  
        return nil  
    end
}
SMODS.Sound {key = "buzzer_sound",path = "buzzer.mp3"}
SMODS.Sound {key = "buzzer1_sound",path = "buzzer1.mp3"}
SMODS.Sound {key = "glitch_sound",path = "glitch.ogg"}
SMODS.Sound {key = "glitch2_sound",path = "glitch2.ogg"}
SMODS.Sound {key = "glitch3_sound",path = "glitch3.ogg"}
SMODS.Sound {key = "flash_sound",path = "flash.ogg"}
SMODS.Sound {key = "lightbulb_sound",path = "light.mp3"}
SMODS.Sound {key = "purple_sound",path = "purple.ogg"}
SMODS.Sound {key = "seek_sound",path = "seekj.ogg"}
SMODS.Sound {  
    key = 'music_ex',  
    path = 'music_exotic.ogg',  
    select_music_track = function(self)
        local dj_config = SMODS.Mods['DJ_Mod'] and SMODS.Mods['DJ_Mod'].config     
        if dj_config and not dj_config.play_exotic_music then 
            return nil 
        end
        if G.jokers and G.jokers.cards then  
            for _, card in ipairs(G.jokers.cards) do   
                if card.config.center.rarity == "DJ_?" then
                    return 10 
                end  
            end  
        end  
        return nil  
    end  
}
SMODS.Sound {key = "tetr_sound",path = "tetr.ogg"}
SMODS.load_mod_config(mod)
mod.config.reset_count = 0
mod.config.play_exotic_music = mod.config.play_exotic_music or false
local function dj_config_nodes()
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, colour = G.C.BLACK, r = 0.1 },
        nodes = {
            -- Row 1: The Checkbox Row
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.1 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = {
                            align = "cm",
                            padding = 0.05,
                            r = 0.1,
                            colour = mod.config.play_exotic_music and G.C.GREEN or G.C.UI.BACKGROUND_INACTIVE,
                            button = 'dj_toggle_music',
                            minw = 0.5,
                            minh = 0.5,
                            shadow = true
                        },
                nodes = {
                    {           
                        n = G.UIT.T,
                        config = {
                        text = " ",
                        scale = 0.5,
                        colour = G.C.WHITE
                        }
                    }
                }
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "cm", padding = 0.1 },
                        nodes = {
                            { n = G.UIT.T, config = { text = "Enable Exotic Music", scale = 0.4, colour = G.C.UI.TEXT_LIGHT } }
                        }
                    }
                }
            },
            -- Row 2: Description
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    { 
                        n = G.UIT.T, 
                        config = { 
                            text = "Plays exotic music when a ??? rarity joker is obtained", 
                            scale = 0.35, 
                            colour = G.C.UI.TEXT_LIGHT 
                        } 
                    }
                }
            },
            -- Row 3: Achievement Reset
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.2 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { 
                            align = "cm", padding = 0.1, r = 0.1, colour = G.C.RED, 
                            hover_colour = G.C.ORANGE, button = 'dj_reset_achievements', shadow = true
                        },
                        nodes = {
                            { n = G.UIT.T, config = { text = "RESET ACHIEVEMENTS (3 CLICKS)", scale = 0.4, colour = G.C.UI.TEXT_LIGHT } }
                        }
                    }
                }
            }
        }
    }
end

mod.config_tab = dj_config_nodes
G.FUNCS.dj_toggle_music = function(e)
    mod.config.play_exotic_music = not mod.config.play_exotic_music
    SMODS.save_mod_config(mod)
    e.config.colour = mod.config.play_exotic_music and G.C.GREEN or G.C.UI.BACKGROUND_INACTIVE
    if e.children and e.children[1] then
        local text_node = e.children[1]
        text_node.config.text = " "
        if text_node.set_text then text_node:set_text() end
    end
end
G.FUNCS.dj_reset_achievements = function(e)
    mod.config.reset_count = (mod.config.reset_count or 0) + 1
    
    if mod.config.reset_count >= 3 then
        mod.config.reset_count = 0 
        local count_wiped = 0
        local targets = {
            "infinite_photochad",
            "the_man_himself",
            "read_the_chat",
            "the_fun_begins",
            "now_the_fun_begins"
        }

        for _, key in ipairs(targets) do
            local full_key = "ach_DJ_" .. key
            local found = false
            if G.SETTINGS.ACHIEVEMENTS_EARNED and G.SETTINGS.ACHIEVEMENTS_EARNED[full_key] then
                G.SETTINGS.ACHIEVEMENTS_EARNED[full_key] = nil
                found = true
            end
            if SMODS.Achievements[key] then
                SMODS.Achievements[key].earned = false
                found = true
            end
            if G.ACHIEVEMENTS[full_key] then
                G.ACHIEVEMENTS[full_key].earned = false
                found = true
            end
            if found then count_wiped = count_wiped + 1 end
        end
        G:save_settings()   
        attention_text({
            text = (count_wiped > 0) and "DJ MOD RESET!" or "Nothing found!",
            scale = 0.6, 
            hold = 1.2,
            align = 'cm',
            colour = (count_wiped > 0) and G.C.WHITE or G.C.RED,
            major = G.ROOM.T.MAIN 
        })
    else
        print("Reset clicks: " .. mod.config.reset_count .. "/3")
    end
end

mod.config_tab = dj_config_nodes
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
SMODS.Atlas { key = "khaled_atlas", path = "kalidv.png", px = 59, py = 93}
SMODS.Atlas { key = "tags_atlas", path = "tags.png", px = 34, py = 34}
SMODS.Atlas { key = "cryb_atlas", path = "cryb.png", px = 71, py = 95}
SMODS.Atlas { key = "kit_atlas", path = "kit.png", px = 95, py = 71}
SMODS.Atlas { key = "editions_atlas",path = "editions.png",px = 71,py = 95 }
SMODS.Atlas { key = "packs_atlas",path = "packs.png",px = 57,py = 95 }
SMODS.Atlas { key = "cryp_atlas",path = "cryp.png",px = 71,py = 95 }
SMODS.Atlas { key = "place_atlas",path = "place.png",px = 71,py = 95 }
SMODS.Atlas { key = "red_atlas",path = "red.png",px = 71,py = 95 }
SMODS.Atlas { key = "ourple_atlas",path = "ourple.png",px = 71,py = 95 }
SMODS.Atlas { key = "fort_atlas",path = "fort.png",px = 71,py = 95 }
SMODS.Atlas { key = "cryt_atlas",path = "cryt.png",px = 71,py = 95 }
SMODS.Atlas { key = "cryi_atlas",path = "cryi.png",px = 71,py = 95 }
SMODS.Atlas { key = "crys_atlas",path = "crys.png",px = 71,py = 95 }
SMODS.Atlas { key = "cryc_atlas",path = "cryc.png",px = 71,py = 95 }
SMODS.Atlas { key = "pyth_atlas",path = "pyth.png",px = 71,py = 95 }
SMODS.Atlas { key = "jimp_atlas",path = "jimp.png",px = 71,py = 95 }
SMODS.Atlas { key = "rice_atlas",path = "rice.png",px = 71,py = 95 }
SMODS.Atlas { key = "glitch", path = "glitch.png",px = 1280, py = 720 }
SMODS.Atlas { key = "glitch1", path = "glitch1.png",px = 1280, py = 720 }
SMODS.Atlas { key = "seek", path = "seek.png",px = 1280, py = 720 }
SMODS.Atlas { key = "oopsb_atlas", path = "oopsb.png",px = 71, py = 95 }
SMODS.Atlas { key = "photo_atlas", path = "photo.png",px = 71, py = 80 }
SMODS.Atlas { key = 'ach_atlas', path = 'cry_ach.png',px = 64, py = 64 }
SMODS.Atlas { key = 'spell_atlas', path = 'spell.png',px = 71, py = 95 }
SMODS.Atlas { key = 'tetr_atlas', path = 'tetr.png',px = 71, py = 95 }
function SMODS.current_mod.post_process()
    if G.GAME and G.GAME.hands and G.GAME.hands['DJ_stronghold'] then
        G.GAME.hands['DJ_stronghold'].played = G.GAME.hands['DJ_stronghold'].played or 0
    end
end


local get_edition_ref = get_edition
function get_edition(_args)
    local edition = get_edition_ref(_args)
    if G.GAME.dj_negative_boost and not edition then
        if pseudorandom('dj_edition') < G.GAME.probabilities.normal * G.GAME.dj_negative_boost / 50 then
            return {negative = true}
        end
    end
    return edition
end



local items_path = mod.path .. "items/"
local item_files = NFS.getDirectoryItems(items_path)

for _, file in ipairs(item_files) do
    if file:match("%.lua$") then
        local file_content = NFS.read(items_path .. file)
        local func, err = loadstring(file_content, file)
        if func then
            pcall(func)
            print("DJ Mod: Loaded " .. file)
        else
            print("Error loading " .. file .. ": " .. tostring(err))
            error(err)
        end
    end
end
local game_start_ref = Game.start_run
function Game.start_run(self, args)
    game_start_ref(self, args)

    if G.GAME.round == 0 then
        local to_spawn = {
            { val = 'spawn_sr',       key = 'j_DJ_sr' },
            { val = 'spawn_cry',       key = 'j_DJ_cryi' },
            

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