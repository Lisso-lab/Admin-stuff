return {"vflyspeed","vfs","vectorflyspeed"}, "Changes speed of vector fly", function(speed)
    if cmd_props.vectorfly then
        if tonumber(speed) then
            cmd_props.vectorfly.speed = tonumber(speed)
        else
            cmd_props.vectorfly.speed = 1
        end
    end
end
