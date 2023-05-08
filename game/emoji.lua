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
    emoji.y = emoji.y - 0.5
    emoji.a = emoji.a + 0.075
    emoji.x = emoji.x + sin(emoji.a) * 1
    return emoji.time > 0
end

function emoji_draw(emoji)
    print(emoji.char, emoji.x, emoji.y, emoji.color)
end

function new_emoticon(_x, _y, _sprite, _time, _layer)
    local emoticon = {
        x = _x, 
        y = _y,
        sprite = _sprite, 
        time = _time, 
        update = emoticon_update,
        draw = emoticon_draw
    }
    add_scene_obj(emoticon, _layer)
end

function emoticon_update(_emoticon)
    _emoticon.time = _emoticon.time - 1
    return _emoticon.time > 0
end

function emoticon_draw(_emoticon)
    palt(0, true)
    palt(8, false)
    spr(96, _emoticon.x, _emoticon.y, 2, 2)
    spr(_emoticon.sprite, _emoticon.x + 4, _emoticon.y + 3, 1, 1)
end