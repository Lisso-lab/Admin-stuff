return {"antifling","afling","nofling"}, "Makes you harder to get flung", function()
    local char = get_char()

    if not char then return end

    local hum = char:FindFirstChildWhichIsA("Humanoid")

    if hum then hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false) end

    for _,v in pairs(char:GetChildren()) do
        if not v:IsA("BasePart") then continue end

        v.CustomPhysicalProperties = PhysicalProperties.new(9e99, 0.3, 0.5)
    end

    notify("Antifling enabled")
end
