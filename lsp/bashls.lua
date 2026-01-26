local M = {}

M.setup = function(capabilities)
  require("lspconfig").bashls.setup({
    capabilities = capabilities,
  })
end

return M

