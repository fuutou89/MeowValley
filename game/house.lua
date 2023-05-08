function new_house()
    local house = {
        x = 260,
        y = 70,
        update = house_update,
        draw = house_draw,
    }
    add_scene_obj(house, 1)
end

function house_update(_house)
    return true
end

function house_draw(_house)
    palt( 0, true)
    -- door
    spr(139, _house.x + 20, _house.y + 9, 2, 2)
    -- windows
    spr(184, _house.x - 8, _house.y + 9, 1, 1)
    spr(184, _house.x + 7, _house.y + 9, 1, 1)
    -- flowers
    spr(185, _house.x - 10, _house.y + 16, 1, 1)
    spr(185, _house.x + 5, _house.y + 16, 1, 1)
end