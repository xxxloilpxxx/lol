--FRONTLINES hitbox extender | mopsHub Sources

if getgenv().__connection then getgenv().__connection:Disconnect() end

_G.Hitbox_Extender_Settings = _G.Hitbox_Extender_Settings or {
    Enabled = true,

    Size = 5, --Size of the hitbox
    Transparency = 0.5, --Transparency of the hitbox

    TeamCheck = true, --ignore team hitboxes
    TargetHitbox = "Head", --All, Head, Torso
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local globals = getrenv()._G.globals

local soldier_hitbox_id_hash = getrenv()._G.globals.soldier_hitbox_id_hash
local soldier_hitbox_hash = getrenv()._G.globals.soldier_hitbox_hash
local tpv_sol_joint_t = getrenv()._G.tpv_sol_joint_t

local Hitbox_IDs = {
    ["Head"] = 6,
    ["Torso"] = 1,
}

local Hitbox_Sizes = {
    ["ROOT_M"] = Vector3.new(1, 1, 2),
    ["HEAD_M"] = Vector3.new(2, 1.2, 1.2),
}

local function getSolidierId(plr)
    assert(plr, "Missing <Player> plr")
    for i, v in pairs(globals.cli_names) do
        if plr and plr.Name == v then
            return i
        end
    end
end

local function getTeam(plr)
    assert(plr, "Missing <Player> plr")
    local id = getSolidierId(plr)
    if not id then
        return
    end
    return globals.cli_teams[id]
end

getgenv().__connection = RunService.RenderStepped:Connect(function()
    if _G.Hitbox_Extender_Settings.Enabled then
        for _,v in pairs(Players:GetPlayers()) do
            local soldierId = getSolidierId(v)

            --team check
            if _G.Hitbox_Extender_Settings.TeamCheck and getTeam(Player) ~= getTeam(v) then
                --get hitbox of player
                for hitbox, id in pairs(soldier_hitbox_hash) do
                    if id == soldierId then
                        if _G.Hitbox_Extender_Settings.TargetHitbox == "All" then
                            pcall(function()
                                local _size = _G.Hitbox_Extender_Settings.Size
                                hitbox.Size = Vector3.new(_size,_size,_size)
                                hitbox.Transparency = _G.Hitbox_Extender_Settings.Transparency
                            end)
                        else
                            local joint_id = Hitbox_IDs[_G.Hitbox_Extender_Settings.TargetHitbox]
                            assert(joint_id, "Invalid <string> TargetHitbox")
                            for joint,__id in pairs(tpv_sol_joint_t) do
                                if __id == joint_id and soldier_hitbox_id_hash[hitbox] == joint_id then
                                    pcall(function()
                                        local _size = _G.Hitbox_Extender_Settings.Size
                                        hitbox.Size = Vector3.new(_size,_size,_size)
                                        hitbox.Transparency = _G.Hitbox_Extender_Settings.Transparency
                                    end)
                                else
                                    if not (soldier_hitbox_id_hash[hitbox] == joint_id) then
                                        hitbox.Transparency = 1
                                        hitbox.Size = Hitbox_Sizes[joint] or Vector3.new(1,1,1)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        for hitbox, id in pairs(soldier_hitbox_hash) do
            for joint, __id in pairs(tpv_sol_joint_t) do
                if Hitbox_Sizes[joint] then
                    hitbox.Transparency = 1
                    hitbox.Size = Hitbox_Sizes[joint]
                end
            end
        end
    end
end)
