function new_title()
    local title = {
        x = 0,
        y = 0,
        x_offset = 0,
        y_offset = 128,
        y_target = 0,
        dy = 5,
        bg = {
            x = 24,
            y = 48,
            size_x = 80,
            size_y = 28
        },
        images = {
            [1] = {sx = 31,  sy = 96,  sw = 4,  sh = 4,  dx = 20, dy = 44, dw = 8, dh = 8}, --flower
            [2] = {sx = 35,  sy = 96,  sw = 4,  sh = 4,  dx = 101, dy = 64, dw = 8, dh = 8}, --flower
            [3] = {sx = 31,  sy = 100, sw = 4,  sh = 4,  dx = 20, dy = 60, dw = 8, dh = 8}, --flower
            [4] = {sx = 35,  sy = 100, sw = 4,  sh = 4,  dx = 102, dy = 44, dw = 8, dh = 8}, --flower
            [5] = {sx = 104, sy = 64,  sw = 16, sh = 16, dx = 22, dy = 64, dw = 16, dh = 16}, --grass
            [6] = {sx = 0, sy = 96,  sw = 8, sh = 8, dx = 30, dy = 51, dw = 16, dh = 16, outline = 1, color = 2}, --悠
            [7] = {sx = 0, sy = 104, sw = 8, sh = 8, dx = 48, dy = 51, dw = 16, dh = 16, outline = 1, color = 2}, --闲
            [8] = {sx = 8, sy = 96,  sw = 8, sh = 8, dx = 66, dy = 51, dw = 16, dh = 16, outline = 1, color = 2}, --喵
            [9] = {sx = 8, sy = 104, sw = 8, sh = 8, dx = 84, dy = 51, dw = 16, dh = 16, outline = 1, color = 2}, --生
        },
        grass_images = {
            [1] = {sx = 16, sy = 96, sw = 8, sh = 5, dx = 38, dy = 73, dw = 8, dh = 5},
            [2] = {sx = 16, sy = 101, sw = 8, sh = 4, dx = 42, dy = 74, dw = 8, dh = 4},
            [3] = {sx = 16, sy = 104, sw = 8, sh = 3, dx = 50, dy = 75, dw = 8, dh = 3},
            [4] = {sx = 16, sy = 107, sw = 8, sh = 2, dx = 55, dy = 76, dw = 8, dh = 2},
            [5] = {sx = 24, sy = 96, sw = 7, sh = 9, dx = 62, dy = 69, dw = 7, dh = 9},
        },
        order = 0,
        open = title_open,
        update = title_update,
        close = title_close,
        draw = title_draw,
        hide = hide_title,
        getpos = function(t) return {x = t.x + t.x_offset, y = t.y + t.y_offset} end
    }
    add_ui_canvas(title)
    return title
end

function title_open(_title)
    _title.y_offset = 128
    _title.y_target = 0
    _title.dy = -5
end

function title_update(_title)
    if _title.dy < 0 then
        if _title.y_offset > _title.y_target then
            _title.y_offset = _title.y_offset + _title.dy
        end
    elseif _title.dy > 0 then
        if _title.y_offset < _title.y_target then
            _title.y_offset = _title.y_offset + _title.dy
        end
    end

    return true
end

function title_close(_title)

end

function hide_title(_title)
    _title.y_target = 128
    _title.dy = 5
end

function title_draw(_title)
    local title_pos = _title:getpos()

    -- draw bg
    local bg_x = title_pos.x + _title.bg.x
    local bg_y = title_pos.y + _title.bg.y

    rectfill(bg_x, bg_y, bg_x + _title.bg.size_x, bg_y + _title.bg.size_y,4)
    rect(bg_x - 1, bg_y - 1, bg_x + _title.bg.size_x + 1, bg_y + _title.bg.size_y + 1,9)

    -- palt(0, true)
    -- sspr(104, 64, 16, 16, title_pos.x + 22, title_pos.y + 64, 16, 16, true, false)
    -- palt()

    palt(0, true)
    palt(8, false)

    for img in all(_title.images) do
        local img_x = title_pos.x + img.dx
        local img_y = title_pos.y + img.dy
        if img.outline then
            outline_sspr(img.sx, img.sy, img.sw, img.sh, img_x, img_y, img.dw, img.dh, img.outline, img.color)
        end
        sspr(img.sx, img.sy, img.sw, img.sh, img_x, img_y, img.dw, img.dh)
    end


    -- draw grass
    for img in all(_title.grass_images) do
        local img_x = title_pos.x + img.dx
        local img_y = title_pos.y + img.dy
        sspr(img.sx, img.sy, img.sw, img.sh, img_x, img_y, img.dw, img.dh)
    end

    print("meow valley", title_pos.x + 48, title_pos.y + 68, 1)

    print("press 🅾️", title_pos.x + 50, title_pos.y + 90, 2)

    palt(0, false)
    palt(8, true)
    sspr(112, 8, 16, 8, title_pos.x + 92, title_pos.y + 70, 16, 8, true, false)
    palt()
end
