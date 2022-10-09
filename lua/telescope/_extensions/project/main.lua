-- telescope modules
-- local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
-- local themes = require "telescope.themes"

-- telescope-cmdline modules
local _actions = require("telescope._extensions.cmdline.actions")
local _finders = require("telescope._extensions.cmdline.finders")
-- local _git = require("telescope._extensions.cmdline.git")
local _utils = require("telescope._extensions.cmdline.utils")

local M = {}

-- Placeholders for future options
local order_by -- hopefully we get to do some custom sorting options

M.setup = function(user_config)

  if user_config.something then
    error("Be more specific!")
  end


end

M.commands = function(opts)
  pickers.new(opts, {
    propt_title = "CMDLine",
    results_title = "Commands",
    finder = _finders.command_finder(opts, _utils.get_commands(order_by)),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)

      local refresh_command_list = function()
        local picker = action_state.get_current_picker(prompt_bufnr)
        local finder = _finders.command_finder(opts, _utils.get_commands(order_by))
        picker:refresh(finder, { reset_prompt = true })
      end

      _actions.execute_command:enhance({ post = refresh_command_list })

      map('n', '<cr>', _actions.execute_command)

    end
  })
end

return M
