function control_player(target)
   if target.animator.state == "crouch" then return end

   if btn(⬅️) then
      target.flip_x = true
      target.dx = -1
   elseif btn(➡️) then
      target.flip_x = false
      target.dx = 1
   else
      target.dx = 0
   end
    
   if btn(⬆️) then
      target.dy = -1
   elseif btn(⬇️) then
      target.dy = 1
   else
      target.dy = 0
   end

   if not is_solid("full", target, target.dx, 0, {0}) then
      target.x = target.x + target.dx
   end

   if not is_solid("full", target, 0, target.dy, {0}) then
      target.y = target.y + target.dy
   end

   local v = sqrt(target.dx^2 + target.dy^2)
   if v > 0 then
      local k = 0.01 / v
      local smoke_x = target.x + 8
      new_smoke(smoke_x, target.y + 16, 
      target.dx*k + rnd3(0.3), 
      target.dy*k + rnd3(0.3), 1, 1)
   end

   if target.animator.state == "idle" then
      if btnp(5) then
         player_attack(target)
      elseif btnp(4) then
         player_crouch(target)
      elseif target.dx ~= 0 or target.dy ~= 0 then
         target.animator.play = "walk"
      end
   elseif target.animator.state == "walk" then
      if target.dx == 0 and target.dy == 0 then
         target.animator.play = "idle"
      end
   end
end

function player_attack(target)
   target.animator.play = "attack"
   local slash_x = target.x
   if not target.flip_x then slash_x = slash_x + 8 end
   new_slash_fx(slash_x, target.y + 8, 1, 0, target.flip_x, 3)
end

function player_crouch(target)
   target.animator.play = "crouch"
   new_emoji(target.x + 8, target.y + 10,"🐱", 20,128 + 14, 3)
end