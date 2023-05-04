function new_smoke(_x, _y, _vx, _vy, _w, layer)
    local smoke = {
        x = _x,
        y = _y,
        center_x = 0,
        center_y = 0,
        vx = _vx,
        vy = _vy,
        w = rnd2(_w, _w * 1.5),
        -- scene obj base 
        update = smoke_update,
        draw = smoke_draw
    }
    add_scene_obj(smoke, layer)
end

function smoke_update(p)
    p.x = p.x + p.vx
    p.y = p.y + p.vy
    p.w = p.w - 0.1
    p.vx = p.vx * 0.95    
    p.vy = p.vy * 0.95    
    return p.w > 0
end

function smoke_draw(p)
    rectfill(p.x-p.w,p.y-p.w, p.x+p.w,p.y+p.w, 7) 
end