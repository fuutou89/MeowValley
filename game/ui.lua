ui_canvas_list = {
}

function update_ui_canvas()
    for canvas in all(ui_canvas_list) do
        canvas.x = main_camera.x
        canvas.y = main_camera.y
        if not canvas:update() then
            if canvas.close ~= nil then
                canvas:close()
            end
            del(ui_canvas_list, canvas)
        end
    end
end

function draw_ui_canvas()
    uisort(ui_canvas_list)
    for canvas in all(ui_canvas_list) do
        canvas:draw()
    end
end

function add_ui_canvas(canvas)
    if canvas.open ~= nil then
        canvas:open()
    end
    add(ui_canvas_list, canvas)
end