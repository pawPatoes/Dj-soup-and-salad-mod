SMODS.Atlas({
    key = "modicon",
    path = "keese.png",
    px = 32,
    py = 32
})
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
if next(SMODS.find_mod("cryptid")) then
    error("CRYPTID BREAKS DJ MOD!!! DISABLE CRYPTID OR THIS MOD")
end
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
local game_update_ref = Game.update
function Game:update(dt)
    game_update_ref(self, dt)
    if G.GAME and G.GAME.cry_upgrade_glitch_timer and G.GAME.cry_upgrade_glitch_timer > 0 then
        G.GAME.cry_upgrade_glitch_timer = G.GAME.cry_upgrade_glitch_timer - dt
    end
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
    default_weight = 10,
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
                if card:is_rarity("DJ_misc") then    
                    return 9
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
SMODS.Sound {  
    key = 'music_op',  
    path = 'music_op.ogg',  
    select_music_track = function(self)   
        if G.jokers and G.jokers.cards then  
            for _, card in ipairs(G.jokers.cards) do   
                if card:is_rarity("DJ_overpowered") then    
                    return 10  
                end  
            end  
        end  
        return nil  
    end  
}

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