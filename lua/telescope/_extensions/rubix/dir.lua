local path_to_dir = function(path)
	if vim.fn.isdirectory(path) == 1 then
		return path
	end

	return vim.fs.dirname(path)
end

local bufdir = function(bufnr)
	local cwd = vim.fn.getcwd(vim.fn.bufwinnr(bufnr))

	-- if buffer is a terminal, return its cwd
	if vim.fn.getbufvar(bufnr, "&buftype") == "terminal" then
		return cwd
	end

	local name = vim.fn.bufname(bufnr)

	if string.sub(name, 1, 1) ~= "/" and string.sub(name, 1, 1) ~= "~" then
		-- make absolute
		name = cwd .. "/" .. name
	end

	return path_to_dir(vim.fs.normalize(name))
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
