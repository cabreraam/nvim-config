local M = {
	"chipsalliance/verible",
}
M.config = function()
	require("lspconfig").verible.setup({
		filetypes = { "systemverilog", "verilog" },
		cmd = { "verible-verilog-ls", "--rules_config_search" }, --, "--file_list_path", "./verible.filelist" },
		root_dir = function(fname)
			return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
		end,
		autostart = true,
	})
end

return M
