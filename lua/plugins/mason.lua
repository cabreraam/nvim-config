return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "texlab",
        "bashls",
        "ruff",
        "vhdl_ls",
        "cmake",
        "pyright",
        "neocmake",
        "jdtls",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = {
        "cppdbg",
        "java-debug-adapter",
      }, -- or "codelldb"
      automatic_installation = true,
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        latex = { "vale" },
      }
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
    opts = {
      automatic_installation = true,
      ensure_installed = { "cpplint" },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {
      ensure_installed = {},
      automatic_installation = true,
    },
  },

}
