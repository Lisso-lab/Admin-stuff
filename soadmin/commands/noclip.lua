--!strict
return {"nclip","noclip","collide"},"Disabled collision of Player", function()
    local run_service: RunService = game:GetService("RunService")

    if cmd_props.noclip then
        cmd_props.noclip:Disconnect()

        cmd_props.noclip = nil
	
	notify("Disabled noclip")
    else
        cmd_props.noclip = run_service["Stepped"]:Connect(function()
            local char = get_char()

            if char then
                for _,v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end)

	notify("Enabled noclip")
    end
end
