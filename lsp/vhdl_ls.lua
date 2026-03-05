local M = {}

M.setup = function(capabilities)
	require("lspconfig").vhdl_ls.setup({
		capabilities = capabilities,
	})
end

return M
