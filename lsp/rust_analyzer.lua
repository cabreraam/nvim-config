-- vim.lsp.config("rust_analyzer", {})
-- vim.lsp.enable("rust_analyzer")

local M = {}

M.setup = function(capabilities)
  require("lspconfig").rust_analyzer.setup({
    capabilities = capabilities,
  })
end

return M

