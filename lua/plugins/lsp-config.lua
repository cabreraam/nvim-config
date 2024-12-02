return {
  {
    "williamboman/mason.nvim",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "texlab" }
    }
  },
  {
    "neovim/nvim-lspconfig",
    --opts = {
    --}
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths here.
                "${3rd}/luv/library"   -- removed warning about not nowing fs_stat!!!
                -- c.f. https://github.com/folke/lazy.nvim/discussions/1349#discussioncomment-9122673
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })
      lspconfig.clangd.setup({})
      lspconfig.pyright.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.texlab.setup({})
      lspconfig.vale_ls.setup({})
      -- vim.keymap.set('n', 'K', vim.lsp.buf.hover)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  },
  --{
  --  "mfussenegger/nvim-lint",
  --  config = function()
  --    local lint = require("lint")
  --    lint.linters_by_ft = {
  --      latex = {'vale',}
  --    }
  --  end

  --},
  --{
  --  "rshkarin/mason-nvim-lint",
  --  opts = {
  --    automatic_installation = true,
  --  }
  --}

}
