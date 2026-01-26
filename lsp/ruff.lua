-- vim.lsp.config("ruff", {
-- 	--	on_attach = on_attach,
-- })
-- vim.lsp.enable("ruff")

local M = {}

M.setup = function(capabilities)
  require("lspconfig").ruff.setup({
    capabilities = capabilities,
  })
end

return M

