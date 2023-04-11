local builtin = require("telescope.builtin")
local dir = require("telescope._extensions.rubix.dir")

return function(opts)
	opts = opts or {}
	opts.cwd = dir.project()
	builtin.grep_string(opts)
end
