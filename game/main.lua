function _init()
    my_game = new_game()
    my_game:start()
end

function _update60()
    my_game:update()
end

function _draw()
    -- pretty standard stuff here
    cls(12)
    my_game:draw()
    pal() --resets all palettes to system defaults
end