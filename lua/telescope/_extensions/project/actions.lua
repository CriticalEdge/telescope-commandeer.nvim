-- local builtin = require("telescope.builtin")
-- local actions = require("telescope.actions")
-- local actions_state = require("telescope.actions.state")
local transform_mod = require('telescope.actions.mt').transform_mod

local M = {}

M.execute_command = function()
  return nil
end

return transform_mod(M)
