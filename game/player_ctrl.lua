function control_player(_player)
   if _player.animator.state == "crouch" then return end

   if btn(⬅️) then
      _player.flip_x = true
      _player.dx = -1
   elseif btn(➡️) then
      _player.flip_x = false
      _player.dx = 1
   else
      _player.dx = 0
   end
    
   if btn(⬆️) then
      _player.dy = -1
   elseif btn(⬇️) then
      _player.dy = 1
   else
      _player.dy = 0
   end

   if not is_solid("full", _player, _player.dx, 0, {0}) then
      _player.x = _player.x + _player.dx
   end

   if not is_solid("full", _player, 0, _player.dy, {0}) then
      _player.y = _player.y + _player.dy
   end

   local v = sqrt(_player.dx^2 + _player.dy^2)
   if v > 0 then
      local k = 0.01 / v
      local smoke_x = _player.x + 8
      new_smoke(smoke_x, _player.y + 16, 
      _player.dx*k + rnd3(0.3), 
      _player.dy*k + rnd3(0.3), 1, 1)
   end

   if _player.animator.state == "idle" then
      if btnp(5) then
         player_attack(_player)
      elseif btnp(4) then
         player_crouch(_player)
      elseif _player.dx ~= 0 or _player.dy ~= 0 then
         _player.animator.play = "walk"
      end
   elseif _player.animator.state == "walk" then
      if _player.dx == 0 and _player.dy == 0 then
         _player.animator.play = "idle"
      end
   end
end

function player_attack(_player)
   _player.animator.play = "attack"
   local slash_x = _player.x
   if not _player.flip_x then slash_x = slash_x + 8 end
   new_slash(slash_x, _player.y + 8, 2, 0, _player.flip_x, 3)
end

function player_crouch(_player)
   _player.animator.play = "crouch"
   new_emoji(_player.x + 8, _player.y + 10,"🐱", 20,128 + 14, 3)
end