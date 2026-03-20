local mod = SMODS.current_mod


-- ima put this here to make sure people dont get him on accident, hes unstable as crap! 
-- (This is what you have to change to true)
exponentiaUnlocked = true
















SMODS.Joker {
    key = 'cryp',
    loc_txt = {
        name = 'Universum?',
        text = {
            "I will give you 1 of",
            "{X:dark_edition,C:white}My Tag{} for every {C:attention}Jolly Joker{} you have",
            "I will create a {C:attention}Jolly Joker{} every hand played",
            "{C:inactive,s=0.8}Random ahh house"
        }
    },
    rarity = "DJ_?",
    cost = 50,
    atlas = 'cryp_atlas',
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
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = SMODS.Tags['tag_DJ_upgrade']
    end,

    set_sprites = function(self, card, front)     
        if not card.custom_extra_sprite then     
            card.custom_extra_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[self.atlas], self.soul_pos.extra)     
            card.custom_extra_sprite.role.draw_major = card    
            card.custom_extra_sprite.custom_draw = true     
        end     
    end,

    blueprint_compat = true,
    discovered = true,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if #G.jokers.cards < G.jokers.config.card_limit then
                SMODS.add_card({
                    set = 'Joker',
                    key = 'j_jolly'
                })
            end
            local jolly_count = 0
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.key == 'j_jolly' then 
                    jolly_count = jolly_count + 1
                end
            end
            for i = 1, jolly_count do
                add_tag(Tag('tag_DJ_upgrade'))
            end
        end
    end,
}















SMODS.Joker {
    key = 'cryt',
    atlas = 'cryt_atlas',
    pos = {x = 0, y = 0},
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
    rarity = "DJ_?",
    cost = 50,
    blueprint_compat = false,
    discovered = true,
    config = { extra = { slot_mod = 2, current_bonus = 0 } },
    loc_txt = {
        name = "Tenebris?",
        text = {
            "He gives you {C:attention}+#1# Joker Slots{} and",
            "earns {C:money}$#1#{} at end of round for",
            "every {C:attention}Jolly Joker{} you have.",
            "He will create a {C:attention}Jolly Joker{} every hand.",
            "{C:inactive}(Currently {C:attention}+#2#{} {C:inactive}slots and {C:money}$#2#{} {C:inactive}payout)"
        }
    },
    loc_vars = function(self, info_queue, card)
        local jolly_count = 0
        if G.jokers and G.jokers.cards then
            for _, v in ipairs(G.jokers.cards) do
                if v.config.center.key == 'j_jolly' then jolly_count = jolly_count + 1 end
            end
        end
        local mod = (card.ability and card.ability.extra and card.ability.extra.slot_mod) or 2
        return { vars = { mod, (jolly_count * mod) } }
    end,
    update = function(self, card, dt)
        if G.jokers and G.jokers.cards and card.ability and card.ability.extra then
            local jolly_count = 0
            for _, v in ipairs(G.jokers.cards) do
                if v.config.center.key == 'j_jolly' and not v.states.drag.is_held and not v.removed then 
                    jolly_count = jolly_count + 1 
                end
            end

            local expected_bonus = jolly_count * (card.ability.extra.slot_mod or 2)
            
            if card.ability.extra.current_bonus ~= expected_bonus then
                local diff = expected_bonus - card.ability.extra.current_bonus
                G.jokers.config.card_limit = G.jokers.config.card_limit + diff
                card.ability.extra.current_bonus = expected_bonus
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        if card.ability and card.ability.extra then
            G.jokers.config.card_limit = G.jokers.config.card_limit - (card.ability.extra.current_bonus or 0)
            card.ability.extra.current_bonus = 0
        end
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local jolly = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jolly', nil)
                    jolly:set_edition({negative = true}, true)
                    jolly:add_to_deck()
                    G.jokers:emplace(jolly)
                    return true
                end
            }))
        end
    end,

    calc_dollar_bonus = function(self, card)
        local jolly_count = 0
        if G.jokers then
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.key == 'j_jolly' then jolly_count = jolly_count + 1 end
            end
        end
        return jolly_count * (card.ability.extra.slot_mod or 2)
    end
}


SMODS.Joker {
    key = 'cryit',
    loc_txt = {
        name = "Iterum?",
        text = {
            "Retriggers all scored cards {C:attention}1{} time",
            "for every {C:attention}Jolly Joker{} you have",
            "Gives {X:mult,C:white} X2 {} Mult for every scored card",
            "Creates a {C:attention}Jolly Joker{}",
            "at the start of every hand",
            "{C:inactive,s:0.8}Random ahh bank"
        }
    },
    rarity = "DJ_?",
    discovered = true,
    blueprint_compat = true,
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
    atlas = 'cryi_atlas',
    cost = 50,

    calculate = function(self, card, context)
        -- 1. Create Jolly Joker (context.before)
        if context.before and not context.blueprint then
            if #G.jokers.cards < G.jokers.config.card_limit then
                local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jolly')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
        end

        -- 2. X2 Mult per card (context.individual)
        if context.individual and context.cardarea == G.play then
            return {
                x_mult = 2,
                card = card
            }
        end

        -- 3. THE SMODS FIX: Retrigger Playing Cards
        -- According to your doc, SMODS looks for 'repetition' and 'cardarea == G.play'
        if context.repetition and context.cardarea == G.play then
            local jolly_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == 'j_jolly' then
                    jolly_count = jolly_count + 1
                end
            end

            if jolly_count > 0 then
                return {
                    message = 'Again!',
                    remove_default_message = true,
                    repetitions = jolly_count,
                    card = card,
                    X_chips = 1,
                }
            end
        end
    end
}





SMODS.Joker {
    key = 'speculo',
    atlas = 'crys_atlas',
    pos = {x = 0, y = 0},
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
    rarity = "DJ_?",
    cost = 50,
    blueprint_compat = false,
    discovered = true,
    loc_txt = {
        name = "Speculo?",
        text = {
            "Creates a {C:dark_edition}Negative{} {C:attention}Jolly Joker{} every hand.",
            "At end of round, creates a {C:dark_edition}Negative{} copy",
            "of a random Joker for every {C:attention}Jolly Joker{} you have. (Max of 30)",
            "{C:inactive}(Excludes Jolly Jokers and {X:dark_edition,C:white}???{C:inactive} rarity{C:inactive} Jokers)",
            "{C:inactive,s:0.8}Random ahh mirror"
        }
    },

    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.speculo_lock = false
        end
        if context.joker_main then
            local jolly = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jolly', nil)
            jolly:set_edition({negative = true}, true)
            jolly:add_to_deck()
            G.jokers:emplace(jolly)
        end
        if context.end_of_round and not context.repetition and not context.blueprint then
            if G.GAME.speculo_lock then return end
            G.GAME.speculo_lock = true

            local jolly_count = 0
            local other_jokers = {}
            
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.key == 'j_jolly' then
                    jolly_count = jolly_count + 1
                elseif j ~= card and j.config.center.rarity ~= "DJ_?" then
                    table.insert(other_jokers, j)
                end
            end

            local count_to_copy = math.min(jolly_count, 35)

            if count_to_copy > 0 and #other_jokers > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for i = 1, count_to_copy do
                            local target = other_jokers[math.random(#other_jokers)]
                            local copy = copy_card(target, nil, nil, nil, nil)
                            copy:set_edition({negative = true}, true)
                            copy:add_to_deck()
                            G.jokers:emplace(copy)
                        end
                        return true
                    end
                }))
            end
        end
    end
}


-- EMODS.please help me
SMODS.Joker { -- give me a reason
    key = 'joker_cola',
    atlas = 'cryc_atlas',
    pos = {x = 0, y = 0}, 
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
    rarity = "DJ_?",
    cost = 50,
    blueprint_compat = true,
    discovered = true,
    loc_txt = {
        name = "Joker Cola? {C:inactive}(Still tastes good!)",
        text = {
            "Creates a {X:dark_edition,C:white}Negative{} {C:attention}Jolly Joker{} every hand played.",
            "At end of round, create a {C:attention}random Tag{}",
            "for every {C:attention}Jolly Joker{} you have.",
            "{C:inactive}(Max 35 Tags)"
        }
    },

    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.cola_lock = false
        end
        if context.joker_main and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local jolly = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jolly', nil)
                    jolly:set_edition({negative = true}, true)
                    jolly:add_to_deck()
                    G.jokers:emplace(jolly)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        if context.end_of_round and not context.repetition and not context.blueprint then
            if G.GAME.cola_lock then return end
            G.GAME.cola_lock = true 

            local jolly_count = 0
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.key == 'j_jolly' then
                    jolly_count = jolly_count + 1
                end
            end

            local tags_to_give = math.min(jolly_count, 35)

            if tags_to_give > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for i = 1, tags_to_give do
                            local tag_key = get_next_tag_key('joker_cola')
                            add_tag(Tag(tag_key))
                        end
                        card:juice_up(0.5, 0.5)
                        return true
                    end
                }))
            end
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
             G.GAME.cry_upgrade_glitch_timer = 0.5
            return {    
                message = "^" .. number_format(total_pow),
                echips = total_pow,
                colour = G.C.CHIPS,
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
    cost = 1000000, -- now
    blueprint_compat = true, -- shut up
    unlocked = true, -- now
    discovered = true,
    config = { extra = { Emult = 1, Emult_mod = 1, is_broken = false } },
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
    add_to_deck = function(self, card)
    if exponentiaUnlocked == false then
        exponent_crash()
    end
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
        if context.before and not context.blueprint and not card.ability.extra.is_broken then
            if #G.jokers.cards < G.jokers.config.card_limit then
                local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jolly')
                _card:add_to_deck()
                G.jokers:emplace(_card)
                G.GAME.cry_upgrade_glitch_timer = 0.5
                return { message = "I HATE JOLLY JOKERS", colour = G.C.FILTER, card = card }
            else
                return { message = "MAKE SLOTS!", colour = G.C.RED, card = card }
            end
        end
        if context.selling_card and not context.blueprint then
            if context.card.config.center.key == 'j_jolly' and not card.ability.extra.is_broken then
                card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_mod
                
                if pseudorandom('dj_exponentia_suffering') < 0.1 then
                    card.ability.extra.Emult = math.max(1, card.ability.extra.Emult - 1)
                    G.GAME.cry_upgrade_glitch_timer = 1.5
                    return { message = "DO YOU ENJOY MY SUFFERING?", colour = G.C.DARK_EDITION, card = card }
                end

                G.GAME.cry_upgrade_glitch_timer = 1.0 
                return { message = "Upgrade! ^" .. number_format(card.ability.extra.Emult), colour = G.C.DARK_EDITION, card = card }
            end
        end -- im not going away
        if context.selling_self and not context.blueprint then
            play_sound('DJ_flash_sound')
            G.GAME.cry_upgrade_glitch_timer = 5.0 

            if not card.ability.extra.is_broken then
                local sell_payout = card.sell_cost or 0


                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.8,
                    func = function()
                        ease_dollars(-sell_payout)
                local replacement = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_DJ_cry_broken')
            replacement:add_to_deck()
            G.jokers:emplace(replacement)
                        
                        return true
                    end
                }))

                return {
                    message = "I'M NOT LEAVING.",
                    colour = G.C.RED,
                    card = card
                }
            end
        end
        if context.joker_main and card.config.center.key == 'j_DJ_cry' then
            if (to_big(card.ability.extra.Emult) > to_big(0)) then
                G.GAME.cry_upgrade_glitch_timer = 0.5
                return { 
                    message = "^" .. number_format(card.ability.extra.Emult), 
                    Emult_mod = card.ability.extra.Emult, 
                    colour = G.C.DARK_EDITION
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'cry_broken',
    atlas = 'cryb_atlas',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 }, skip_draw = true },
    rarity = "DJ_broke",
    cost = 0,
    discovered = false,
    blueprint_compat = true,
    eternal = true,
    loc_txt = {
        name = 'Exponentia??',
        text = {
            "{C:red,s:1.2}DESTROYED",
            "I HATE YOU",
            "{C:inactive,s:0.8}You brought this on yourself."
        }
    },

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
            card.custom_extra_floating_sprite.scale.x = card.children.center.scale.x
            card.custom_extra_floating_sprite.scale.y = card.children.center.scale.y
            card.custom_extra_floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, 0, 0)
        end

        if card.custom_guy_sprite then
            card.custom_guy_sprite.T.x, card.custom_guy_sprite.T.y = card.T.x, card.T.y
            card.custom_guy_sprite.scale.x = card.children.center.scale.x
            card.custom_guy_sprite.scale.y = card.children.center.scale.y
            card.custom_guy_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, 0, rotate_mod)
        end
    end,

    update = function(self, card)
        if card.debuff then
            card.debuff = false
            card:juice_up(0.1, 0.1)
        end
    end,

    add_to_deck = function(self, card)
        card:set_eternal(true)
    end,

    remove_from_deck = function(self, card, from_debuff)
        if from_debuff then return end 

        G.GAME.cry_upgrade_glitch_timer = 10
        play_sound("DJ_glitch3_sound", 1, 1)

        attention_text({
            text = 'DO YOU THINK YOU CAN GET RID OF ME?',
            scale = 0.8, hold = 15, align = 'cm',
            color = G.C.RED, backdrop_colour = {0, 0, 0, 1}
        })
        G.E_USE_IT = G.E_USE_IT or {}
        table.insert(G.E_USE_IT, function()
            local jailbreak = copy_card(card)
            jailbreak:add_to_deck()
            G.jokers:emplace(jailbreak)
            return true
        end)
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            G.GAME.cry_upgrade_glitch_timer = 2
            play_sound("DJ_glitch3_sound")
            play_sound("DJ_glitch2_sound")
            play_sound("DJ_glitch_sound")
            return { 
                message = "I HATE YOU", 
                Emult_mod = 0.2, 
                colour = G.C.DARK_EDITION
            }
        end
    end
}