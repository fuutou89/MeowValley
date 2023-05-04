-- the slime class
function new_slime()
    local slime = {
        x = 64,
        y = 64,
        center_x = 32,
        center_y = 32,
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
        -- property for scene collision check
        collider = {
            width = 16,
            height = 8
        },   
        -- animator
        animator = {
            animations = {
                walk = {frame_rate = 12, unpack(split"32,34,32,36")},
                death = {frame_rate = 6, unpack(split"48,48,50,52,52,52,52,52,0")}
            },
            play = "walk",
            sprite = 0
        },
        -- scene obj base function 
        start = slime_start,
        update = slime_update,
        draw = slime_draw,
        destory = slime_destory,
        on_collide_event = slime_on_collide_event,
        hit = slime_hit
    }
    return slime
end

function slime_start(_slime)
end

function slime_update(_slime)
    --actor_wander(_slime, 0.25)
    actor_update_center(_slime, 8, 4)
    animate(_slime.animator)
    return _slime.animator.sprite ~= 0
end

function slime_draw(_slime)
    --transparency
    paltout ( 8)
    --shadow
    spr(64, _slime.x + 2, _slime.y + 6, 2, 1)
    spr(_slime.animator.sprite, flr(_slime.x), _slime.y, _slime.spr_w, _slime.spr_h, _slime.flip_x)
    --is_solid("full",_slime,0,0,{},true)
    --circ(_slime.center_x, _slime.center_y, 1)
    draw_collider(_slime)
end

function slime_destory(_slime)
    add_scene_obj(new_slime(), 2)
end

function slime_on_collide_event(_slime, _collision_obj)
    return false
end

function slime_hit(_slime)
    _slime.dx = 0
    _slime.dy = 0
    _slime.next_wander_time = 999
    _slime.animator.play = "death"
end
