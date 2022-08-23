--!strict
return {"tp","teleport"}, "Teleports you to target", function(str: string)
    local char = get_char()

    local _char do
        local target = p_find_plrs(str)

        if target and type(target) == "table" then return end

        _char = target.Character

        if not _char then return end
    end

    tween(char.PrimaryPart, 
            TweenInfo.new(
                .2,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.InOut
            ),
            {CFrame = _char.PrimaryPart.CFrame * CFrame.new(0,2,2)}
        )

    notify("Teleported to: ", _char.Name)
end
