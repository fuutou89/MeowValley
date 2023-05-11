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
    add_scene_obj(new_player(), 2)
    add_scene_obj(new_slime(), 2)
    add_scene_obj(new_npc(), 2)
    new_title()
end

function game_title_exec(_game)
    if btn(4) then
        set_state(_game, "play")
    end
end

function game_title_exit(_game)

end

-- play state
function game_play_enter(_game)

end

function game_play_exec(_game)
    main_camera.x = flr(myplayer.x - 64)
    main_camera.y = flr(myplayer.y - 64)
    if main_camera.y < 0 then
        main_camera.y = 0
    end
    if main_camera.x < 0 then
        main_camera.x = 0
    end
end

function game_play_exit(_game)
end

-- base 
function game_start(_game)
    local house = new_house()
    main_camera = {x = house.x - 64, y = house.y - 64}
end

function game_update(_game)
    _game.fsm.current.exec(_game)
    update_scene_objs()
    update_ui_canvas()
    camera(main_camera.x, main_camera.y)
end

function game_draw(_game)
    map(0, 0, 0, 0, 128, 32)
    draw_scene_objs()
    draw_ui_canvas()
end