function mk_state(obj, state_name, f_enter, f_exec, f_exit)
    local s = {}
    s.enter = f_enter
    s.exec = f_exec
    s.exit = f_exit
    obj.fsm.states[state_name] = s
    return s
end

function set_state(obj, new_state_name)
    if obj.fsm.current ~= nil and obj.fsm.current == obj.fsm.states[new_state_name] then
        return
    end

    if obj.fsm.current ~= nil then
        obj.fsm.current.exit(obj)
    end

    obj.fsm.current = obj.fsm.states[new_state_name]
    obj.fsm.current.enter(obj)
end