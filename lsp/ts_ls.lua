-- vim.lsp.config("ts_ls", {})
-- vim.lsp.enable("ts_ls")

local M = {}

M.setup = function(capabilities)
  require("lspconfig").ts_ls.setup({
    capabilities = capabilities,
  })
end

return M

