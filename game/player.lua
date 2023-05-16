-- the player class
function new_player()
    local player = {    
    x = 304,   -- x pos
    y = 112,   -- y pos
    center_x = 32,
    center_y = 32,
    spr_w = 2,    -- # of sprites wide
    spr_h = 2,    -- # of sprites high
    dx = 0,   -- delta x
    dy = 0,   -- delta y
    flip_x = false, -- obvious
    tag = "player",
    -- property for map collision check
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
            sleep = {frame_rate = 15, unpack(split"12,14")},
            idle = {frame_rate = 15, unpack(split"0,2")},
            walk = {frame_rate = 8, unpack(split"10,4,6")},
            attack = {frame_rate = 7, next = "idle", unpack(split"8,10,12")},
            crouch = {frame_rate = 15, next = "idle", unpack(split"12,14")}
        },
        play = "idle",
        sprite = 0
    },
    -- scene obj base function
    start = player_start,
    update = player_update,
    draw = player_draw,
    on_collide_event = player_on_collide_event,
    -- finite state machine
    fsm = {states={}}
    }
    return player
end

function player_start(_player)
    myplayer = _player
    mk_state(_player, "sleep", player_sleep_enter, player_sleep_exec, player_sleep_exit)
    mk_state(_player, "idle", player_idle_enter, player_idle_exec, player_idle_exit)
    mk_state(_player, "walk", player_walk_enter, player_walk_exec, player_walk_exit)
    mk_state(_player, "attack", player_attack_enter, player_attack_exec, player_attack_exit)
    mk_state(_player, "crouch", player_crouch_enter, player_crouch_exec, player_crouch_exit)
    set_state(_player, "sleep")
end

function player_update(_player)
    --control_player(_player)
    _player.fsm.current.exec(_player)
    actor_update_center(_player, 8, 16)
    animate(_player.animator)
    return true
end

function player_draw(_player)
    --transparency
    paltout ( 8)

    --shadow
    spr(64, _player.x + 2, _player.y + 14, 2, 1)

    spr(_player.animator.sprite, flr(_player.x), _player.y, _player.spr_w, _player.spr_h, _player.flip_x)

    -- draw collision debug
    --is_solid("full",_player,0,0,{},true)

    --circ(_player.center_x, _player.center_y, 1)

    -- draw collider
    draw_collider(_player)
end

function player_on_collide_event(_player, _collision_obj)
    return false
end

-- player sleep state
function player_sleep_enter(_player)
    _player.animator.play = "sleep"
end

function player_sleep_exec(_player)
end

function player_sleep_exit(_player)
end

-- player idle state
function player_idle_enter(_player)
    _player.animator.play = "idle"
end

function player_idle_exec(_player)
   if player_move(_player) then
    set_state(_player, "walk")
   elseif btnp(5) then
    set_state(_player, "attack")
   elseif btnp(4) then
    set_state(_player, "crouch")
   end
end

function player_idle_exit(_player)
end

-- player walk state
function player_walk_enter(_player)
    _player.animator.play = "walk"
end

function player_walk_exec(_player)
    if not player_move(_player) then
     set_state(_player, "idle")
    end
end

function player_walk_exit(_player)
end

-- player attack state
function player_attack_enter(_player)
    _player.animator.play = "attack"
    local slash_x = _player.x
    if not _player.flip_x then slash_x = slash_x + 8 end
    new_slash(slash_x, _player.y + 8, 2, 0, _player.flip_x, 3)
end

function player_attack_exec(_player)
    if _player.animator.state == "idle" then
        set_state(_player, "idle")
    end
end

function player_attack_exit(_player)
end

-- player crouch state
function player_crouch_enter(_player)
    _player.animator.play = "crouch"
    new_emoji(_player.x + 8, _player.y + 10,"🐱", 20,128 + 14, 3)
end

function player_crouch_exec(_player)
    if _player.animator.state == "idle" then
        set_state(_player, "idle")
    end
end

function player_crouch_exit(_player)
end

function player_move(_player)
    if btn(⬅️) then
        _player.dx = -1
     elseif btn(➡️) then
        _player.dx = 1
     else
        _player.dx = 0
     end
      
     if btn(⬆️) then
        _player.dy = -1
     elseif btn(⬇️) then
        _player.dy = 1
     else
        _player.dy = 0
     end

     actor_move(_player)
  
     local v = sqrt(_player.dx^2 + _player.dy^2)
     if v > 0 then
        local k = 0.01 / v
        local smoke_x = _player.x + 8
        new_smoke(smoke_x, _player.y + 16, 
        _player.dx*k + rnd3(0.3), 
        _player.dy*k + rnd3(0.3), 1, 1)
     end

     return v > 0
end