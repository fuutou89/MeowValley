-- the player class
player = {
    x = 56,   -- x pos
    y = 64,   -- y pos
    bspr = 32, -- base sprite
    w = 2,    -- # of sprites wide
    h = 2,    -- # of sprites high
    dx = 0,   -- delta x
    dy = 0,   -- delta y
    flip_x = false, -- obvious
    tmr = 0,   -- timer for animation
    ani_frame = 0
}
   
-- player constructor
function player:new(o)
    self.__index = self
    return setmetatable(o or {}, self)
end

function init_player()
    myplayer = player:new()
end

function anim_player()
    if abs(myplayer.dx) ~= 0 or abs(myplayer.dy) ~= 0 then
        play_player_walk()
    else
        play_player_idle()
    end
end

function draw_player()
    --transparency
    paltout ( 8)

    --shadow
    spr(64, myplayer.x + 2, myplayer.y + 14, 2, 1)

    spr(myplayer.bspr, flr(myplayer.x), myplayer.y, myplayer.w, myplayer.h, myplayer.flip_x)
end

local idle_bspr = 0
local walk_bspr = 8

function play_player_idle()
    play_player_ani(myplayer, idle_bspr)
end

function play_player_walk()
    play_player_ani(myplayer, walk_bspr)
end

function play_player_ani(player, base_sprite)
    player.tmr = player.tmr + 1
    if player.tmr == 10 then
        player.tmr = 0
        player.ani_frame = player.ani_frame + 1
    end
    if player.ani_frame == 4 then
        player.ani_frame = 0
        player.bspr = base_sprite
    else
        player.bspr = base_sprite + 2 * player.ani_frame
    end
end

function paltout ( _bg )
    palt( 0, false)
    palt( _bg, true)
end