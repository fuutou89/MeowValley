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
        ysort(scene_obj_layer)
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

function solid_obj(obj, dx, dy)
    for scene_obj_layer in all(scene_objs) do
        for scene_obj in all(scene_obj_layer) do
            if obj ~= scene_obj and obj.collider ~= nil and scene_obj.collider ~= nil then
                local a_min_x = obj.x
                local a_min_y = obj.y
                local a_max_x = obj.x + obj.collider.width
                local a_max_y = obj.y + obj.collider.height

                local b_min_x = scene_obj.x
                local b_min_y = scene_obj.y
                local b_max_x = scene_obj.x + scene_obj.collider.width
                local b_max_y = scene_obj.y + scene_obj.collider.height

                local intersect = a_min_x <= b_max_x and
                a_max_x >= b_min_x and
                a_min_y <= b_max_y and 
                a_max_y >= b_min_y

                if intersect then
                    local collide_a = obj:on_collide_event(scene_obj)
                    local collide_b = scene_obj:on_collide_event(obj)
                    return collide_a or collide_b
                end
            end
        end
    end
    return false
end

function paltout ( _bg )
    palt( 0, false)
    palt( _bg, true)
end

function actor_wander(_actor, _speed)
    if _actor.next_wander_time <= 0 then
        _actor.next_wander_time = 100
        local wander = rnd(10)
        if wander > 5 then
            _actor.dx = rnd2(_speed * -1, _speed)
            _actor.dy = rnd2(_speed * -1, _speed)
        else
            _actor.dx = 0
            _actor.dy = 0
        end

        if _actor.dx < 0 then _actor.flip_x = true 
        else _actor.flip_x = false end
    end

    _actor.next_wander_time = _actor.next_wander_time - 1

    actor_move(_actor)
end

function actor_move(_actor)
    if _actor.dx > 0 then _actor.flip_x = false
    elseif _actor.dx < 0 then
        _actor.flip_x = true
    end
    
    if not is_solid("full", _actor, _actor.dx, 0, {0}) then
        _actor.x = _actor.x + _actor.dx
     end
  
     if not is_solid("full", _actor, 0, _actor.dy, {0}) then
        _actor.y = _actor.y + _actor.dy
     end
end

function actor_update_center(_actor, _offsetx, _offsety)
    _actor.center_x = _actor.x + _offsetx
    _actor.center_y = _actor.y + _offsety
end

function draw_collider(_obj)
    rect(_obj.x, _obj.y, _obj.x + _obj.collider.width, _obj.y + _obj.collider.height, 9)
end