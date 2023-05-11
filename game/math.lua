function rnd2(a, b)
    return a + rnd(b - a)
end

function rnd3(x)
    return rnd(x * 2) - x
end

function ysort(arr)
    for i,arri in inext,arr do
        for j,arrj in inext, arr do
            if arri.center_y == nil then arri.center_y = 0 end
            if arrj.center_y == nil then arrj.center_y = 0 end
            if arri.center_y<arrj.center_y then
                arri,arr[i],arr[j]=arrj,arrj,arri
            end
        end
    end
end

function uisort(arr)
    for i,arri in inext,arr do
        for j,arrj in inext, arr do
            if arri.order == nil then arri.order = 0 end
            if arrj.order == nil then arrj.order = 0 end
            if arri.order<arrj.order then
                arri,arr[i],arr[j]=arrj,arrj,arri
            end
        end
    end
end