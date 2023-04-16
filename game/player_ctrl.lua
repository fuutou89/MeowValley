function move_player()
    if btn(⬅️) then
        myplayer.flip_x = true
        myplayer.dx = -1
     elseif btn(➡️) then
        myplayer.flip_x = false
        myplayer.dx = 1
     else
        myplayer.dx = 0
     end
    
     if btn(⬆️) then
        myplayer.dy = -1
     elseif btn(⬇️) then
        myplayer.dy = 1
     else
        myplayer.dy = 0
     end

     if not move_hit(myplayer.x + myplayer.dx + 1, myplayer.y + 12, 14, 1) then
        myplayer.x = myplayer.x + myplayer.dx
     end

     if not move_hit(myplayer.x + 1, myplayer.y + myplayer.dy + 12, 5, 5) then
        myplayer.y = myplayer.y + myplayer.dy
     end
end

function move_hit(x, y, w, h)
    local collide = false
    
    for i=x, x+w, w do
        if fmget(i / 8, y/ 8) or fmget(i / 8, (y + h) / 8) then
            collide = true
        end
    end

    return collide
end

function fmget(x, y)
    return not fget(mget(x, y), 0)
end