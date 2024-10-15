local builtin = require("telescope.builtin")

return function(opts)
	opts = opts or {}
	opts.find_command = { "rg", "--files", "--hidden" }
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	local ret = ""
	local fname = vim.uri_to_fname(vim.uri_from_bufnr(0))
	if next(clients) ~= nil then
		for _, client in ipairs(clients) do
			if client.name ~= "copilot" then
				if client.root_dir ~= nil then
					local root_dir = client.root_dir or ""
					local start = string.find(fname, root_dir, 1, true)
					if start and start == 1 and string.len(root_dir) > string.len(ret) then
						ret = root_dir
					end
				end
			end
		end
	end
	opts.cwd = ret
	builtin.find_files(opts)
end
