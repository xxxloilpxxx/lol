local globals = getrenv()._G.globals
local enums = getrenv()._G.enums
local utils = getrenv()._G.utils

local fpv_sol_recoil = globals.fpv_sol_recoil
local fpv_sol_spread = globals.fpv_sol_spread

setmetatable(fpv_sol_spread, {
    __index = function(self, key)
        if key == 'spread' then
            return 0
        end
        return rawget(self, key)
    end,
    __newindex = function(self, key, value)
        if key == 'spread' then spread = value; return end
        rawset(self, key, value)
    end
})

setmetatable(fpv_sol_recoil, {
    __index = function(self, key)
        if key == 'attitude_delta' then
            return Vector3.zero
        end
        return rawget(self, key)
    end,
    __newindex = function(self, key, value)
        if key == 'attitude_delta' then attitude_delta = value; return end
        rawset(self, key, value)
    end
})

rawset(fpv_sol_spread, 'spread', nil)
rawset(fpv_sol_recoil, 'attitude_delta', nil)

if isourclosure then
    local OldEvalUdho = utils.math_util.eval_udho
    local function eval_udho(...)
        if debug.info(2, 's'):find('recoil_anim') then
            return 0, 0
        end
        return OldEvalUdho(...)
    end
    utils.math_util.eval_udho = eval_udho

    for _, fn in next, getgc() do
        if type(fn) == 'function' then
            if islclosure(fn) and (not isourclosure(fn)) then
                local upvalues = getupvalues(fn)
                for _, upv in next, upvalues do
                    if upv == OldEvalUdho then
                        setupvalue(fn, _, eval_udho)
                    end
                end
            end
        end
    end
end
