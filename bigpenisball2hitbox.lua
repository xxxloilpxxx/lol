_G._hitboxext = true
if not _G.hitBoxSize then _G.hitBoxSize = 25 end
while _G._hitboxext do 
    task.wait()
    for _,v in pairs(workspace.__THINGS.__HITBOXES:GetChildren()) do
        v.Main.Size = Vector3.new(_G.hitBoxSize, _G.hitBoxSize, _G.hitBoxSize)
        v.Main.Color = Color3.fromRGB(255,0,0)
        v.Main.Transparency = _G.showHitbox and 0.75 or 1
    end
end
