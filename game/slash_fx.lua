function new_slash_fx(_x, _y, _vx, _vy, _flip, layer)
    local slash_fx = {
        x = _x,
        y = _y,
        vx = _vx,
        vy = _vy,
        flip = _flip,
        -- animator
        animator = {
            animations = {
                flash = {frame_rate = 3, next = "flash_end", unpack(split"80,66,67")},
                flash_end = {frame_rate = 15, unpack(split"67")}
            },
            play = "flash",
            sprite = 66
        },
        update = slash_fx_update,
        draw = slash_fx_draw
    }
    if _flip then
        slash_fx.vx = slash_fx.vx * -1
    end
    add_scene_obj(slash_fx, layer)
end

function slash_fx_update(p)
    p.x = p.x + p.vx
    p.y = p.y + p.vy
    animate(p.animator)
    return p.animator.state == "flash"
end

function slash_fx_draw(p)
    spr(p.animator.sprite, p.x, p.y, 1, 1, p.flip)
end