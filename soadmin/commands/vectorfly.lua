--!strict
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

return {"vfly","vectorfly"},"Flying with use of vectors", function(speed)
    if cmd_props.vectorfly and not cmd_props.vectorfly[1].Connected then
        cmd_props.vectorfly = nil
    end

    if cmd_props.vectorfly then
        for i=1,#cmd_props.vectorfly do
            cmd_props.vectorfly[i]:Disconnect()
        end

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

        local part do
            local char = get_char()

            local hum = char:FindFirstChildWhichIsA("Humanoid")

            part = Instance.new("Part")

            part.Anchored = true
            part.Position = char.PrimaryPart.Position
        end

        local function main()
            local speed = cmd_props.vectorfly.speed
            local x_vec,look_vec,y_vec = cam.CFrame.XVector*speed,cam.CFrame.LookVector*speed,cam.CFrame.YVector/2
            local char = get_char()

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

        print(speed)
    
        if tonumber(speed) then
            cmd_props.vectorfly.speed = tonumber(speed)
        else
            cmd_props.vectorfly.speed = 1
        end

        cmd_props.vectorfly = {}

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
