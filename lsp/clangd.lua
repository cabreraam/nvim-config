-- ~/.config/nvim/lsp/clangd.lua

--- Search for CMakePresets.json at the given root and one level deep.
--- Returns the path to the file, or nil.
local function find_cmake_presets(project_root)
	if vim.fn.filereadable(project_root .. "/CMakePresets.json") == 1 then
		return project_root .. "/CMakePresets.json"
	end

	local subdirs = vim.fn.glob(project_root .. "/*/CMakePresets.json", false, true)
	if #subdirs > 0 then
		return subdirs[1]
	end

	return nil
end

--- Read the active cmake preset from a project-local override file,
--- falling back to a default.
local function get_active_preset(project_root)
	local override_file = project_root .. "/.nvim-cmake-preset"
	if vim.fn.filereadable(override_file) == 1 then
		local lines = vim.fn.readfile(override_file)
		if lines and lines[1] then
			return vim.fn.trim(lines[1])
		end
	end
	return "relwithdebinfo"
end

--- Given a project root, find the CMake binary dir by reading CMakePresets.json.
--- Returns the expanded binary dir path, or nil.
local function get_cmake_binary_dir(project_root)
	local preset_file = find_cmake_presets(project_root)
	if not preset_file then
		return nil
	end

	local preset_dir = vim.fn.fnamemodify(preset_file, ":h")

	local ok, json = pcall(function()
		return vim.fn.json_decode(vim.fn.readfile(preset_file))
	end)
	if not ok or not json or not json.configurePresets then
		return nil
	end

	local presets_by_name = {}
	for _, preset in ipairs(json.configurePresets) do
		presets_by_name[preset.name] = preset
	end

	local function resolve_binary_dir(preset_name, visited)
		visited = visited or {}
		if visited[preset_name] then
			return nil
		end
		visited[preset_name] = true

		local preset = presets_by_name[preset_name]
		if not preset then
			return nil
		end

		if preset.binaryDir then
			return preset.binaryDir
		end

		if preset.inherits then
			return resolve_binary_dir(preset.inherits, visited)
		end

		return nil
	end

	local active_preset = get_active_preset(project_root)
	local binary_dir = resolve_binary_dir(active_preset)
	if not binary_dir then
		return nil
	end

	binary_dir = binary_dir:gsub("%${sourceDir}", preset_dir)
	binary_dir = binary_dir:gsub("%${workspaceFolder}", project_root)
	binary_dir = binary_dir:gsub("%${presetName}", active_preset)
	return vim.fn.fnamemodify(binary_dir, ":p")
end

--- Build the clangd cmd given a resolved project root.
local function build_cmd(root_dir)
	local binary_dir = get_cmake_binary_dir(root_dir)
	if binary_dir then
		return { "clangd", "--compile-commands-dir=" .. binary_dir }
	end

	local candidates = {
		root_dir .. "/build",
		root_dir .. "/build/debug",
		root_dir .. "/build/release",
		root_dir .. "/build/relwithdebinfo",
		root_dir .. "/out",
	}
	for _, candidate in ipairs(candidates) do
		if vim.fn.filereadable(candidate .. "/compile_commands.json") == 1 then
			return { "clangd", "--compile-commands-dir=" .. candidate }
		end
	end

	return { "clangd" }
end

return {
	cmd = function(dispatchers, config)
		local root_dir = config.root_dir or vim.fn.getcwd()
		local cmd = build_cmd(root_dir)
		return vim.lsp.rpc.start(cmd, dispatchers)
	end,
	filetypes = { "c", "cpp", "objc", "objcpp", "inc", "cu" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root = vim.fs.find(
			{ "CMakePresets.json", ".git", "compile_commands.json" },
			{ upward = true, path = vim.fn.fnamemodify(fname, ":h") }
		)[1]
		if root then
			on_dir(vim.fn.fnamemodify(root, ":h"))
		end
	end,
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>gd",
			"<cmd>lua vim.lsp.buf.definition()<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
