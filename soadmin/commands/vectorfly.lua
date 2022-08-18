--!strict
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local user_input_service: UserInputService = game:GetService("UserInputService")
local run_service: RunService = game:GetService("RunService")

local cam: Camera = workspace.CurrentCamera

local keys_using = {
    ["W"] = false,
    ["A"] = false,
    ["S"] = false,
    ["D"] = false
}

return {"vfly","vectorfly"},"Flying with use of vectors", function()
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

        if hum then hum.PlatformStand = true end

        part = Instance.new("Part")

        part.Anchored = true
        part.Position = char.PrimaryPart.Position
    end

    local function main()
        local x_vec,look_vec,ori = cam.CFrame.XVector,cam.CFrame.LookVector,cam.CFrame.Rotation
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

        char:MoveTo(part.Position)
    end

    do_connection(run_service["Heartbeat"]:Connect(main))

    do_connection(user_input_service.InputBegan:Connect(input_began))
    do_connection(user_input_service.InputEnded:Connect(input_ended))

    notify("Enabled vector fly")
end
