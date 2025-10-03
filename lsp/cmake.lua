vim.lsp.config("neocmake", {
	filetypes = { "cmake" },
	format = { enable = true },
	single_file_support = true,
	root_markers = { "CMakeLists.txt", "CMakePresets.json" },
	cmd = { "neocmakelsp", "--stdio" },
})

vim.lsp.config("cmake", {})

vim.lsp.enable("neocmake")
vim.lsp.enable("cmake")
