return {
	cmd = { "verible-verilog-ls", "--rules_config_search" },
	filetypes = { "systemverilog", "verilog" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local git_root = vim.fs.find(".git", { path = fname, upward = true })[1]
		if git_root then
			on_dir(vim.fn.fnamemodify(git_root, ":h"))
		else
			on_dir(vim.fn.getcwd())
		end
	end,
}
