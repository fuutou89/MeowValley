function _init()
    add_scene_obj(new_player(), 2)
    add_scene_obj(new_slime(), 2)
    add_scene_obj(new_npc(), 2)
    cam = {x = 0, y = 0}
end

function _update60()
    update_scene_objs()
    cam.x = flr(myplayer.x - 64)
    cam.y = flr(myplayer.y - 64)
    if cam.y < 0 then
        cam.y = 0
    end
    if cam.x < 0 then
        cam.x = 0
    end
    camera(cam.x, cam.y)
end

function _draw()
    -- pretty standard stuff here
    cls(12)
    map(0, 0, 0, 0, 128, 32)
    draw_scene_objs()
    pal()
end