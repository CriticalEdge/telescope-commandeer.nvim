local finders = require("telescope.finders")
local Path = require('plenary.path')
local strings = require('plenary.strings')
local entry_display = require("telescope.pickers.entry_display")
local M = {}

M.command_finder = function(opts, commands)
  local display_type = opts.display_type
  local widths = {
    title = 0,
    display_path = 0,
  }

  -- I realize this is kinda useless now but I think I can make use of it
  for _, command in pairs(commands) do
    if display_type == 'full' then
      command.display_path = '[' .. command.path .. ']'
    else
      command.display_path = ''
    end
    local command_path_exists = Path:new(command.path):exists()
    if not command_path_exists then
      command.title = command.title .. " [deleted]"
    end
    for key, value in pairs(widths) do
      widths[key] = math.max(value, strings.strdisplaywidth(command[key] or ''))
    end
  end

  local window = entry_display.create {
    separator = " ",
    items = {
      { width = widths.title },
      { width = widths.workspace },
      { width = widths.display_path },
    }
  }

  local make_window = function(command)
    return window {
      { command.title },
      { command.workspace },
      { command.display_path },
    }
  end

  return finders.new_table {
    results = commands,
    entry_maker = function(command)
      command.value = command.path
      command.ordinal = command.title
      command.window = make_window
      return command
    end
  }

end

return M
