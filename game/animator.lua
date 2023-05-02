function animate(animator)
    if animator.state ~= animator.play then
        animator.state = animator.play
        animator.anim_index = 1
        animator.time = 0
    elseif #animator.animations[animator.state] > 1 then
        animator.time = animator.time + 1
        if animator.time >= animator.animations[animator.state].frame_rate then -- the current frame has been on screen for long enough
            animator.time = 0
            animator.anim_index = (animator.anim_index % #animator.animations[animator.state]) + 1 -- go to the next frame
            -- this loop animations
            if animator.anim_index == 1 and animator.animations[animator.state].next then -- at the moment the animation restarts
                animator.play = animator.animations[animator.state].next
                animator.state = animator.play
            end
        end
    end
    animator.sprite = animator.animations[animator.state][animator.anim_index]
end