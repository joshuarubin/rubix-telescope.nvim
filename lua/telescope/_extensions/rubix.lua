local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
  error('This plugin requires nvim-telescope/telescope.nvim')
end

return telescope.register_extension {
  exports = {
    history     = require("telescope._extensions.rubix.history"),
    find_files  = require("telescope._extensions.rubix.files"),
    grep_string = require("telescope._extensions.rubix.grep"),
    live_grep   = require("telescope._extensions.rubix.live"),
  }
}
