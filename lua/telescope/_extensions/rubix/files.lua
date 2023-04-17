local builtin = require("telescope.builtin")
local dir = require("rubix/dir")

return function(opts)
	opts = opts or {}
	opts.find_command = { "rg", "--files", "--hidden" }
	opts.cwd = dir.project()
	builtin.find_files(opts)
end
