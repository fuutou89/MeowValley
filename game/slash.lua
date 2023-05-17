function new_slash(_x, _y, _dx, _dy, _flip, layer)
    local slash_fx = {
        x = _x,
        y = _y,
        dx = _dx,
        dy = _dy,
        flip = _flip,
        w = 8,
        h = 8,
        -- property for scene collision check
        collider = {
            width = 8,
            height = 8
        },       
        -- animator
        animator = {
            animations = {
                flash = {frame_rate = 3, next = "flash_end", unpack(split"80,66,67")},
                flash_end = {frame_rate = 15, unpack(split"67")}
            },
            play = "flash",
            sprite = 66
        },
        update = slash_update,
        draw = slash_draw,
        on_collide_event = slash_on_collide_event
    }
    if _flip then
        slash_fx.dx = slash_fx.dx * -1
    end
    add_scene_obj(slash_fx, layer)
end

function slash_update(p)
    p.x = p.x + p.dx
    p.y = p.y + p.dy
    animate(p.animator)
    solid_obj(p, p.dx, p.dy)
    return p.animator.state == "flash"
end

function slash_draw(p)
    palt( 0, true)
    spr(p.animator.sprite, p.x, p.y, 1, 1, p.flip)
    --draw_collider(p)
end

function slash_on_collide_event(p, _collision_obj)
    if _collision_obj.hit ~= nil then
        _collision_obj:hit()
        return true
    end
    return false
end