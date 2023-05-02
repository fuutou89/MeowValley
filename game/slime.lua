-- the slime class
function new_slime()
    local slime = {
        x = 64,
        y = 64,
        spr_w = 2,
        spr_h = 1,
        dx = 0,
        dy = 0,
        flip_x = false,
        next_wander_time = 0,
        -- property for collision check
        w = 8,
        h = 4,
        ox = 3,
        oy = 3,
        -- animator
        animator = {
            animations = {
                walk = {frame_rate = 12, unpack(split"32,34,32,36")}
            },
            play = "walk",
            sprite = 0
        },
        -- scene obj base function 
        start = slime_start,
        update = slime_update,
        draw = slime_draw,
        destory = slime_destory
    }
    return slime
end

function slime_start(_slime)
end

function slime_update(_slime)
    slime_wander(_slime)
    animate(_slime.animator)
    return true
end

function slime_wander(_slime)
    if _slime.next_wander_time < 0 then
        _slime.next_wander_time = 100
        local wander = rnd(10)
        if wander > 5 then
            _slime.dx = rnd2(-0.25, 0.25)
            _slime.dy = rnd2(-0.25, 0.25)
        else
            _slime.dx = 0
            _slime.dy = 0
        end
    end

    _slime.next_wander_time = _slime.next_wander_time - 1

    if _slime.dx < 0 then _slime.flip_x = true 
    else _slime.flip_x = false end
    if not is_solid("full", _slime, _slime.dx, 0, {0}) then
        _slime.x = _slime.x + _slime.dx
     end
  
     if not is_solid("full", _slime, 0, _slime.dy, {0}) then
        _slime.y = _slime.y + _slime.dy
     end
end

function slime_draw(_slime)
    --transparency
    paltout ( 8)
    spr(_slime.animator.sprite, flr(_slime.x), _slime.y, _slime.spr_w, _slime.spr_h, _slime.flip_x)
    is_solid("full",_slime,0,0,{},true)
end

function slime_destory(_slime)
end

