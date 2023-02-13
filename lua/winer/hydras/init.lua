local utils = require("winer.utils")

local M = {}

--- Activates a given or choosen Hydra defined in "winer.hydras"
---@param _hydra string|nil the file name of the hydra
M.activate_hydra = function(_hydra)
    local module = "winer.hydras." .. _hydra
    local stat, hydra = pcall(require, module)
    if stat then
        hydra:activate() -- FIX: somehow it's nil
    else
        vim.notify("[winer]: Hydra: '" .. _hydra .. "' could not be loaded", vim.log.levels.ERROR)
    end
end

return M
