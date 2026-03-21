SMODS.Achievement {
    key = 'infinite_photochad',
    loc_txt = {
        name = 'Infinite Photochad, Infinite Happiness',
        description = {
            "Have both PhotoChad and",
            "Speculo in your possession",
            "at the same time."
        }
    },
    bypass_all_unlocked = true,
    atlas = 'ach_atlas',
    pos = { x = 1, y = 0 },
    hidden_pos = { x = 0, y = 0 },
    hidden_name = false, 
    hidden_text = false,
    
    unlock_condition = function(self, args)
        if G.jokers and G.jokers.cards then
            local has_photochad = false
            local has_speculo = false
            
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.key == 'j_DJ_photochad' then has_photochad = true end
                if j.config.center.key == 'j_DJ_speculo' then has_speculo = true end
            end
            if has_photochad and has_speculo then
                return true
            end
        end
        return false
    end
}
SMODS.Achievement {
    key = 'the_man_himself',
    loc_txt = {
        name = 'THE MAN HIMSELF',
        description = {
            "OBAIN THE MAN HIMSELF,",
            "THE LEGENDARY DJ SOUP AND SALAD."
        }
    },
    bypass_all_unlocked = true,
    atlas = 'ach_atlas',
    pos = { x = 1, y = 0 },
    hidden_pos = { x = 0, y = 0 },
    hidden_name = false, 
    hidden_text = false,
    unlock_condition = function(self, args)
        if G.jokers and G.jokers.cards then
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.key == 'j_DJ_dj_sss' then 
                    return true 
                end
            end
        end
        return false
    end
}
SMODS.Achievement {
    key = 'read_the_chat', 
    loc_txt = {
        name = 'READ THE CHAT!',
        description = {
            "READ THE CHAT!",
            "Obtain the riceball joker"
        }
    },
    bypass_all_unlocked = true,
    atlas = 'ach_atlas',
    pos = { x = 1, y = 0 },
    hidden_pos = { x = 0, y = 0 }, 
    hidden_name = false, 
    hidden_text = false,
    
    unlock_condition = function(self, args)
        if G.jokers and G.jokers.cards then
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.key == 'j_DJ_riceball' then 
                    return true 
                end
            end
        end
        return false
    end
}
SMODS.Achievement {
    key = 'fun', 
    loc_txt = {
        name = 'LETS HAVE A FUN HOUSE',
        description = {
            "Obtain the Funhouse Host joker"
        }
    },
    bypass_all_unlocked = true,
    atlas = 'ach_atlas',
    pos = { x = 1, y = 0 },
    hidden_pos = { x = 0, y = 0 }, 
    hidden_name = false, 
    hidden_text = false,
    
    unlock_condition = function(self, args)
        if G.jokers and G.jokers.cards then
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.key == 'j_DJ_funhouse_host' then 
                    return true 
                end
            end
        end
        return false
    end
}
SMODS.Achievement {
    key = '2763', 
    loc_txt = {
        name = '2763',
        description = {
            "2763"
        }
    },
    bypass_all_unlocked = true,
    atlas = 'ach_atlas',
    pos = { x = 1, y = 0 },
    hidden_pos = { x = 0, y = 0 }, 
    hidden_name = false, 
    hidden_text = false,
    
    unlock_condition = function(self, args)
        if G.jokers and G.jokers.cards then
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.key == 'j_DJ_2763_joker' then 
                    return true 
                end
            end
        end
        return false
    end
}
SMODS.Achievement {  
    key = 'nuh_uh',   
    loc_txt = {  
        name = 'NUH UH',  
        description = {  
            "Force Chicot to reject",  
            "The Plant boss blind."  
        }  
    },  
    bypass_all_unlocked = true,  
    atlas = 'ach_atlas',  
    pos = { x = 1, y = 0 },   
    hidden_pos = { x = 0, y = 0 },   
    hidden_name = false,   
    hidden_text = false,  
      
    unlock_condition = function(self, args)  
        if args.chicot then  
            return true  
        end  
        return false  
    end  
}
SMODS.Achievement {
    key = 'the_fun_begins',
    loc_txt = {
        name = 'The fun begins',
        description = { "Use The Heart card." }
    },
    atlas = 'ach_atlas',
    pos = { x = 1, y = 0 },
    unlock_condition = function(self, args)
    if args.type == 'dj_use_heart' then
        return true
    end
    return false
end
}
SMODS.Achievement {
    key = 'now_the_fun_begins',
    loc_txt = {
        name = 'NOW THE FUN BEGINS',
        description = { "Use The Eye card." }
    },
    atlas = 'ach_atlas',
    pos = { x = 1, y = 0 },
    unlock_condition = function(self, args)
    return args.type == 'dj_eye_used'
    end
}
local original_unlock_function = Game.update_check_for_unlock
function Game.update_check_for_unlock(self, args)
    if original_unlock_function then
        original_unlock_function(self, args)
    end
    local joker_achievements = {
        'infinite_photochad', 
        'the_man_himself', 
        'read_the_chat',
        'fun',
        '2763',
        'nuh_uh' 
    }

    for _, key in ipairs(joker_achievements) do
        local ach = SMODS.Achievements[key]
        if ach and not ach.earned then
            if ach:unlock_condition(args) then
                unlock_achievement('ach_DJ_' .. key)
                ach.earned = true
                G:save_settings()
            end
        end
    end
end