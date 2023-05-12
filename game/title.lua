function new_title()
    local title = {
        x = 0,
        y = 0,
        x_offset = 0,
        y_offset = 128,
        bg = {
            x = 24,
            y = 32,
            size_x = 80,
            size_y = 28
        },
        order = 0,
        open = title_open,
        update = title_update,
        close = title_close,
        draw = title_draw
    }
    add_ui_canvas(title)
end

function title_open(_title)
end

function title_update(_title)
    if _title.y_offset > 0 then
        _title.y_offset = _title.y_offset - 5
    end
    return true
end

function title_close(_title)
end

function title_draw(_title)
    -- draw bg
    local bg_x = _title.x + _title.bg.x + _title.x_offset
    local bg_y = _title.y + _title.bg.y + _title.y_offset

    rectfill(bg_x, bg_y, bg_x + _title.bg.size_x, bg_y + _title.bg.size_y,4)
    rect(bg_x - 1, bg_y - 1, bg_x + _title.bg.size_x + 1, bg_y + _title.bg.size_y + 1,9)
    palt(0, true)

    local sp_start_x = _title.x + 32
    local sp_center_y = _title.y + _title.y_offset + 38

    outline_sspr(0, 96, 8, 8, sp_start_x, sp_center_y + 3, 16, 16, 1, 2)
    sspr(0, 96, 8, 8, sp_start_x, sp_center_y + 3, 16, 16)

    outline_sspr(0, 104, 8, 8, sp_start_x + 16 + 2, sp_center_y, 16, 16, 1, 2)
    sspr(0, 104, 8, 8, sp_start_x + 16 + 2, sp_center_y, 16, 16)

    outline_sspr(8, 96, 8, 8, sp_start_x + 32 + 2, sp_center_y + 3, 16, 16, 1, 2)
    sspr(8, 96, 8, 8, sp_start_x + 32 + 2, sp_center_y + 3, 16, 16)

    outline_sspr(8, 104, 8, 8, sp_start_x + 48 + 2, sp_center_y, 16, 16, 1, 2)
    sspr(8, 104, 8, 8, sp_start_x + 48 + 2, sp_center_y, 16, 16)

    --sspr(0, 104, 8, 8, _title.x + 40, _title.y + _title.y_offset + 40, 16, 16)
    --sspr(8, 96, 8, 8, _title.x + 50, _title.y + _title.y_offset + 30, 16, 16)
    --sspr(8, 104, 8, 8, _title.x + 60, _title.y + _title.y_offset + 40, 16, 16)
    --spr(192, _title.x + 56, _title.y + _title.y_offset + 40, 2, 2)
    palt()
end
