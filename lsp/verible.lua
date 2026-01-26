local M = {}

function M.setup(capabilities)
  local lspconfig = require("lspconfig")

  lspconfig.verible.setup({
    capabilities = capabilities,
    filetypes = { "systemverilog", "verilog" },
    cmd = { "verible-verilog-ls", "--rules_config_search" }, 
    root_dir = function(fname)
      local git_root = vim.fs.find(".git", { path = fname, upward = true })[1]
      return git_root and vim.fs.dirname(git_root) or vim.fn.getcwd()
    end,
    autostart = true,
  })
end

return M

