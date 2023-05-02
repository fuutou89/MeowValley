-- the player class
function new_player()
    local player = {    
    x = 56,   -- x pos
    y = 64,   -- y pos
    spr_w = 2,    -- # of sprites wide
    spr_h = 2,    -- # of sprites high
    dx = 0,   -- delta x
    dy = 0,   -- delta y
    flip_x = false, -- obvious
    -- property for collision check
    w = 8,
    h = 6,
    ox = 4,
    oy = 10,
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
    draw = player_draw}
    return player
end

function player_start(mplayer)
    -- do nothing
    myplayer = mplayer
end

function player_update(mplayer)
    control_player(mplayer)
    animate(mplayer.animator)
    return true
end

function player_draw(mplayer)
    --transparency
    paltout ( 8)

    --shadow
    spr(64, mplayer.x + 2, mplayer.y + 14, 2, 1)

    spr(mplayer.animator.sprite, flr(mplayer.x), mplayer.y, mplayer.spr_w, mplayer.spr_h, mplayer.flip_x)

    -- draw collision debug
    is_solid("full",mplayer,0,0,{},true)
end

function paltout ( _bg )
    palt( 0, false)
    palt( _bg, true)
end