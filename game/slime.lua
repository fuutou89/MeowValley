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
        hit = slime_hit,
        -- finite state machine
        fsm = {states={}},
        wander_time = 0,
    }
    return slime
end

function slime_start(_slime)
    mk_state(_slime, "wander", slime_wander_enter, slime_wander_exec, slime_wander_exit)
    mk_state(_slime, "death", slime_death_enter, slime_death_exec, slime_death_exit)
    set_state(_slime, "wander")
end

function slime_update(_slime)
    --actor_wander(_slime, 0.25)
    _slime.fsm.current.exec(_slime)
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
    --draw_collider(_slime)
end

function slime_destory(_slime)
    add_scene_obj(new_slime(), 2)
end

function slime_on_collide_event(_slime, _collision_obj)
    return false
end

function slime_hit(_slime)
    set_state(_slime, "death")
end

-- slime wander state
function slime_wander_enter(_slime)
    _slime.animator.play = "walk"
end

function slime_wander_exec(_slime)
    if _slime.wander_time <= 0 then
        _slime.wander_time = rnd2(50, 100)
        local wander = rnd(10)
        if wander > 5 then
            _slime.dx = rnd2(0.25 * -1, 0.25)
            _slime.dy = rnd2(0.25 * -1, 0.25)
        else
            _slime.dx = 0
            _slime.dy = 0
        end
    end
    _slime.wander_time = _slime.wander_time - 1
    actor_move(_slime)
end

function slime_wander_exit(_slime)
end

-- slime death state
function slime_death_enter(_slime)
    sfx(34)
    _slime.dx = 0
    _slime.dy = 0
    _slime.animator.play = "death"
end

function slime_death_exec(_slime)
end

function slime_death_exit(_slime)
end

