function _init()
    init_player()
    cam = {x = 0, y = 0}
end

function _update60()
    move_player()
    anim_player()
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
    draw_player()
    pal()
end