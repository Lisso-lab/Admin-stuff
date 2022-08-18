--!strict
return {"vfly","vectorfly"},"Flying with use of vectors", function(speed)
    local user_input_service: UserInputService = game:GetService("UserInputService")
    local run_service: RunService = game:GetService("RunService")

    local cam: Camera = workspace.CurrentCamera

    local keys_using = {
        ["W"] = false,
        ["A"] = false,
        ["S"] = false,
        ["D"] = false,
        ["Q"] = false,
        ["E"] = false
    }

    if cmd_props.vectorfly and not cmd_props.vectorfly[1].Connected then
        cmd_props.vectorfly.part:Destroy()

        cmd_props.vectorfly = nil
    end

    if cmd_props.vectorfly then
        cmd_props.vectorfly.part:Destroy()

        for i=1,#cmd_props.vectorfly do
            cmd_props.vectorfly[i]:Disconnect()
        end

        cmd_props.vectorfly.part:Destroy()

        notify("Disabled vector fly")
    else
        local function input_began(key,a)
            if a then return end

            key = string.split(tostring(key.keyCode),".")
            key = key[#key]

            if keys_using[key] == false then
                keys_using[key] = true
            end
        end

        local function input_ended(key,a)
            if a then return end

            key = string.split(tostring(key.keyCode),".")
            key = key[#key]

            if keys_using[key] == true then
                keys_using[key] = false
            end
        end

        local function main(delta_time)
            local speed: number = cmd_props.vectorfly.speed * (delta_time / (1/60))

            local x_vec: Vector3   = cam.CFrame.XVector*speed
            local look_vec: Vector3= cam.CFrame.LookVector*speed
            local y_vec: Vector3   = cam.CFrame.YVector/2

            local part: BasePart = cmd_props.vectorfly.part
            local char: Model = get_char()

            if not char then return end

            if keys_using["W"] and not keys_using["S"] then
                part.Position += look_vec
            end
            if keys_using["A"] and not keys_using["D"] then
                part.Position -= x_vec
            end
            if keys_using["S"] and not keys_using["W"] then
                part.Position -= look_vec
            end
            if keys_using["D"] and not keys_using["A"] then
                part.Position += x_vec
            end
            if keys_using["Q"] and not keys_using["E"] then
                part.Position -= y_vec
            end
            if keys_using["E"] and not keys_using["Q"] then
                part.Position += y_vec
            end

            char:MoveTo(part.Position)
        end

        cmd_props.vectorfly = {}

        cmd_props.vectorfly.part = Instance.new("Part")

        cmd_props.vectorfly.part.Anchored = true

        do local char = get_char()
            cmd_props.vectorfly.part.Position = char.PrimaryPart.Position
        end
    
        if tonumber(speed) then
            cmd_props.vectorfly.speed = tonumber(speed)
        else
            cmd_props.vectorfly.speed = 1
        end

        local connections = {
            run_service["Heartbeat"]:Connect(main),
            user_input_service.InputBegan:Connect(input_began),
            user_input_service.InputEnded:Connect(input_ended)
        }

        for i=1,#connections do
            do_connection(connections[i])

            cmd_props.vectorfly[#cmd_props.vectorfly+1] = connections[i]
        end

        notify("Enabled vector fly")
    end
end
