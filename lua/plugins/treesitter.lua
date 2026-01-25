return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.config")

    configs.setup({
      auto_install = true,
      -- ensure_installed = {
      --   "c",
      --   "cmake",
      --   "cpp",
      --   "diff",
      --   "dot",
      --   "firrtl",
      --   "fortran",
      --   "git_config",
      --   "git_rebase",
      --   "gitattributes",
      --   "gitcommit",
      --   "gitignore",
      --   "json",
      --   "latex",
      --   "llvm",
      --   "lua",
      --   "mlir",
      --   "ninja",
      --   "tablegen",
      --   "verilog",
      --   "vhdl",
      --   "vim",
      --   "vimdoc",
      --   "yaml",
      --   "query",
      --   "elixir",
      --   "heex",
      --   "javascript",
      --   "html"
      -- },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
