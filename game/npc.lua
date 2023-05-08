function new_npc()
    local npc = {
        x = 280,
        y = 90,
        center_x = 32,
        center_y = 32,
        spr_w = 2,
        spr_h = 2,
        dx = 0,
        dy = 0,
        flip_x = false,
        -- property for collision check
        w = 8,
        h = 6,
        ox = 4,
        oy = 10,    
        -- property for scene collision check
        collider = {
            width = 16,
            height = 16
        },    
        -- animator
        animator = {
            animations = {
                idle = {frame_rate = 15, unpack(split"38,40")},
                walk = {frame_rate = 15, unpack(split"42,44,46")}
            },
            play = "idle",
            sprite = 0
        },
        -- scene obj base function
        start = npc_start,
        update = npc_update,
        draw = npc_draw,
        on_collide_event = npc_on_collide_event,
        -- finite state machine
        fsm = {states={}},
        idle_time = 0,
        wander_time = 0,
        talk_time = 0
    }
    return npc
end

function npc_start(_npc)
    mk_state(_npc, "idle", npc_idle_enter, npc_idle_exec, npc_idle_exit)
    mk_state(_npc, "wander", npc_wander_enter, npc_wander_exec, npc_wander_exit)
    mk_state(_npc, "charm", npc_charm_enter, npc_charm_exec, npc_charm_exit)
    set_state(_npc, "idle")
end

-- npc charm state 
function npc_charm_enter(_npc)
    _npc.animator.play = "idle"
    _npc.dx = 0
    _npc.dy = 0
    new_emoticon(_npc.x + 6, _npc.y - 8, 70, 50, 3)
end

function npc_charm_exec(_npc)
    npc_face_to_player(_npc)
    if _npc.talk_time > 0 then 
        _npc.talk_time = _npc.talk_time - 1
        return
    end
    local collide_player = solid_obj(_npc, _npc.dx, _npc.dy)
    if not collide_player then
        set_state(_npc, "idle")
    end

    if myplayer.animator.sprite == 14 then
        new_emoticon(_npc.x + 6, _npc.y - 8, flr(rnd2(68,70)), 50, 3)
        _npc.talk_time = 50
    end
end

function npc_charm_exit(_npc)
    new_emoticon(_npc.x + 6, _npc.y - 8, 71, 50, 3)
end

-- npc idle state
function npc_idle_enter(_npc)
    _npc.animator.play = "idle"
    _npc.dx = 0
    _npc.dy = 0
    _npc.idle_time = rnd2(50, 100)
end

function npc_idle_exec(_npc)
    npc_face_to_player(_npc)
    _npc.idle_time = _npc.idle_time - 1
    if _npc.idle_time <= 0 then
        -- roll dice the determin idle or wander
        local wander = rnd(10)
        if wander > 5 then
            set_state(_npc, "wander")
        else
            _npc.idle_time = rnd2(50, 100)
        end
    end

    npc_valide_charm(_npc)
end

function npc_idle_exit(_npc)
end

-- npc wander state
function npc_wander_enter(_npc)
    _npc.dx = rnd2(0.25 * -1, 0.25)
    _npc.dy = rnd2(0.25 * -1, 0.25)
    _npc.wander_time = rnd2(50, 100)
end

function npc_wander_exec(_npc)
    if _npc.dx ~= 0 or _npc.dy ~= 0 then
        _npc.animator.play = "walk"
    else
        _npc.animator.play = "idle"
    end
    actor_move(_npc)
    _npc.wander_time = _npc.wander_time - 1
    if _npc.wander_time <= 0 then
        set_state(_npc, "idle")
    end

    npc_valide_charm(_npc)
end

function npc_wander_exit(_npc)
end

function npc_update(_npc)
    _npc.fsm.current.exec(_npc)
    actor_update_center(_npc, 8, 16)
    animate(_npc.animator)
    return true
end

function npc_draw(_npc)
    --transparency
    paltout ( 8)

    --shadow
    spr(64, _npc.x + 2, _npc.y + 14, 2, 1)

    spr(_npc.animator.sprite, _npc.x, _npc.y, _npc.spr_w, _npc.spr_h, _npc.flip_x)

    -- draw collision debug
    --is_solid("full",_npc,0,0,{},true)

    --circ(_npc.center_x, _npc.center_y, 1)
    
    -- draw collider
    draw_collider(_npc)
end

function npc_on_collide_event(_npc, _collision_obj)
    if _collision_obj.tag == "player" then
        return true
    end
    return false
end

function npc_valide_charm(_npc)
    local collide = solid_obj(_npc, _npc.dx, _npc.dy)
    if collide then
        set_state(_npc, "charm")
    end
end

function npc_face_to_player(_npc)
    -- face to player
    if myplayer.x < _npc.x then _npc.flip_x = true
    else _npc.flip_x = false end
end