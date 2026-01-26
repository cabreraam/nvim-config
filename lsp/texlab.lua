-- vim.lsp.config("texlab", {})
-- vim.lsp.enable("texlab")

local M = {}

M.setup = function(capabilities)
  require("lspconfig").texlab.setup({
    capabilities = capabilities,
  })
end

return M

