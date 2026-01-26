-- vim.lsp.config("neocmake", {
-- 	filetypes = { "cmake" },
-- 	format = { enable = true },
-- 	single_file_support = true,
-- 	root_markers = { "CMakeLists.txt", "CMakePresets.json" },
-- 	cmd = { "neocmakelsp", "--stdio" },
-- })
-- 
-- vim.lsp.config("cmake", {})
-- 
-- vim.lsp.enable("neocmake")
-- vim.lsp.enable("cmake")
-- 
--

local M = {}

function M.setup(capabilities)
  local lspconfig = require("lspconfig")

  -- Setup neocmake LSP
  lspconfig.neocmake.setup({
    capabilities = capabilities,
    filetypes = { "cmake" },
    single_file_support = true,
    root_dir = lspconfig.util.root_pattern("CMakeLists.txt", "CMakePresets.json"),
    cmd = { "neocmakelsp", "--stdio" },
    settings = {
      format = { enable = true },
    },
  })

  -- Setup cmake LSP (optional, empty setup)
  lspconfig.cmake.setup({
    capabilities = capabilities,
  })
end

return M

