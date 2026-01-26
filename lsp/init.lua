local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- list all your LSP modules
local servers = {
  "bashls",
  "clangd",
  "cmake",
  "lua_ls",
  "ruff",
  "rust_analyzer",
  "texlab",
  "ts_ls",
  "verible",
  "vhdl_ls",
}

for _, name in ipairs(servers) do
  local ok, server = pcall(require, "config.lsp." .. name)
  if ok and server.setup then
    server.setup(capabilities)
  else
    vim.notify("Failed to load LSP config for " .. name, vim.log.levels.WARN)
  end
end

