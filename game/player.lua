-- the player class
function new_player()
    local player = {    
    x = 56,   -- x pos
    y = 64,   -- y pos
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
    on_collide_event = player_on_collide_event}
    return player
end

function player_start(_player)
    -- do nothing
    myplayer = _player
end

function player_update(_player)
    control_player(_player)
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
