scene_objs = {
    [1] = {},
    [2] = {},
    [3] = {}
}

function update_scene_objs()
    for scene_obj_layer in all(scene_objs) do
        for scene_obj in all(scene_obj_layer) do
            if not scene_obj:update() then
                if scene_obj.destory ~= nil then
                    scene_obj:destory()
                end
                del(scene_obj_layer, scene_obj)
            end
        end
    end
end

function draw_scene_objs()
    for scene_obj_layer in all(scene_objs) do
        for scene_obj in all(scene_obj_layer) do
            scene_obj:draw()
        end
    end
end

function add_scene_obj(obj, layer)
    if obj.start ~= nil then
        obj:start()
    end
    add(scene_objs[layer], obj)
end