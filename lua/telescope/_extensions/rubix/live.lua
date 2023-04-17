local builtin = require("telescope.builtin")
local dir = require("rubix/dir")

return function(opts)
	opts = opts or {}
	opts.cwd = dir.project()
	builtin.live_grep(opts)
end
