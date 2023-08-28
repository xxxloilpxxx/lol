_G.SpeedMultiplier = 2 -- (0 = off)

for _,v in pairs(getgc(true)) do
    if(type(v) == "table") then
        if(rawget(v, "walkAdjustment")) then
            v.walkAdjustment = _G.SpeedMultiplier or 2
        end
    end
end
