-- the game class
function new_game()
    local game = {
        fsm = {states = {}},
        start = game_start,
        update = game_update,
        draw = game_draw
    }
    mk_state(game, "title", game_title_enter, game_title_exec, game_title_exit)
    mk_state(game, "play", game_play_enter, game_play_exec, game_play_exit)
    set_state(game, "title")
    return game
end

-- title state
function game_title_enter(_game)
end

function game_title_exec(_game)
    if btn(4) then
        set_state(_game, "play")
    end
end

function game_title_exit(_game)
    add_scene_obj(new_player(), 2)
    add_scene_obj(new_slime(), 2)
    add_scene_obj(new_npc(), 2)
end

-- play state
function game_play_enter(_game)

end

function game_play_exec(_game)
    update_scene_objs()
    cam.x = flr(myplayer.x - 64)
    cam.y = flr(myplayer.y - 64)
    if cam.y < 0 then
        cam.y = 0
    end
    if cam.x < 0 then
        cam.x = 0
    end
end

function game_play_exit(_game)
end

-- base 
function game_start(_game)
    local house = new_house()
    cam = {x = house.x - 64, y = house.y - 64}
end

function game_update(_game)
    _game.fsm.current.exec(_game)
    camera(cam.x, cam.y)
end

function game_draw(_game)
    map(0, 0, 0, 0, 128, 32)
    draw_scene_objs()
end

function game_draw_title(_game)
end
