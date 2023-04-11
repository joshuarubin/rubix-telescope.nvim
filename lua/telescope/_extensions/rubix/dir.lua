local path_to_dir = function(path)
	if vim.fn.isdirectory(path) == 1 then
		return path
	end

	return vim.fs.dirname(path)
end

local bufdir = function(bufnr)
	-- if buffer is a terminal, return its cwd
	if vim.fn.getbufvar(bufnr, "&buftype") == "terminal" then
		return vim.fn.getcwd(vim.fn.bufwinnr(bufnr))
	end

	return path_to_dir(vim.fn.bufname(bufnr))
end

local path_to_project_dir = function(path, allow_empty)
	allow_empty = allow_empty or false
	local search_directory = path_to_dir(path)

	-- -- Search project file.
	local root_files = {
		".project",
		"compile_commands.json",
		"configure",
		"gtags",
		"package.json",
		"tags",
		".git",
	}

	for _, root_file in ipairs(root_files) do
		local paths = vim.fs.find(root_file, {
			path = search_directory,
			upward = true,
		})
		for _, ret in ipairs(paths) do
			return vim.fs.dirname(ret)
		end
	end

	if not allow_empty then
		return search_directory
	end

	return ""
end

local dir = {}

dir.buffer = function()
	return bufdir(vim.fn.bufnr("%"))
end

dir.project = function()
	return path_to_project_dir(dir.buffer())
end

return dir
