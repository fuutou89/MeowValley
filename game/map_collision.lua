function is_solid(opt,f,ox,oy,flags,debug)
    local collist={}
    ox = ox or 0
    oy = oy or 0
    flags=flags or {0}
    if(type(flags) ~= "table") then flags={flags} end
    local ix=f.x+f.ox+ox
    local iy=f.y+f.oy+oy
    for x=ix,ix+f.w+7,8 do
        for y=iy,iy+f.h+7,8 do
            if opt==nil
            or opt=="full"
            or opt=="left" and x==ix
            or opt=="right" and x>=ix+f.w
            or opt=="up" and y==iy
            or opt=="down" and y>=iy+f.h
            or opt=="rdown" and y>=iy+f.h and x>=ix+f.w
            or opt=="ldown" and x==ix and y>=iy+f.h
            or opt=="rup" and y==iy and x>=ix+f.w
            or opt=="lup" and y==iy and x==ix
            then
                add(collist, {x=min(x,ix+f.w), y=min(y,iy+f.h)})
            end
        end
    end
    if(debug) then print(#collist) end
    for c in all(collist) do
        if(debug) then pset(c.x,c.y,8) end
        for v in all(flags) do
            if(fget(mget(c.x/8,c.y/8),v)) then return true end
        end
    end
    return false
end