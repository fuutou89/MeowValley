function new_emoji(_x, _y, _char, _time, _color, _layer)
    local emoji = {
        x = _x,
        y = _y,
        a = 0,
        char = _char,
        color = _color,
        time = _time,
        update = emoji_update,
        draw = emoji_draw
    }
    add_scene_obj(emoji, _layer)
end

function emoji_update(emoji)
    emoji.time = emoji.time - 1
    emoji.y = emoji.y - 1
    emoji.a = emoji.a + 0.075
    emoji.x = emoji.x + sin(emoji.a) * 1
    return emoji.time > 0
end

function emoji_draw(emoji)
    print(emoji.char, emoji.x, emoji.y, emoji.color)
end