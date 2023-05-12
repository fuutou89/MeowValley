-- draw sprite outline using
-- the following variables:
-- s=sprite #
-- x=sprite's x-position
-- y=sprite's y-position

-- t=type of outline (binary)
--   this is a single number
--   from 0-511 thus:
--   256 128 064 █ █ █
--   032 016 008 █ █ █
--   004 002 001 █ █ █

-- c=color of outline
-- h=sprite size across, def 1
-- v=sprite size down  , def 1
-- (both variables of h + v
--  are optional)

function outline(s,x,y,t,c,h,v)if(t==0)return
    local b=256for i=1,15do pal(i,c)end h=h or 1v=v or 1for i=-1,1do for j=-1,1do if(band(t,b)>0)spr(s,x+j,y+i,h,v)
    b\=2end end pal()end

function outline_sspr(sx,sy,sw,sh,dx,dy,dw,dh,t,c)if(t==0)return
    local b=256for i=1,15do pal(i,c)end for i=-1,1do for j=-1,1do if(band(t,b)>0)sspr(sx,sy,sw,sh,dx+j,dy+i,dw,dh)
    b\=2end end pal()end    