local has_telescope, telescope = pcall(require, 'telescope')
local main = require('telescope._extensions.commandeer.main')
local utils = require('telescope._extensions.commandeer.utils')

if not has_telescope then
  error('This plugin requires nvim-telescope/telescope.nvim')
end

utils.init_files()

return telescope.register_extension {
  setup = main.setup,
  exports = { commandeer = main.commandeer }
}
