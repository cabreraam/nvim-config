-- set tabs to 2 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- remapping keys
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit color
vim.opt.termguicolors = true

-- turn on line numbers
vim.cmd("set number")

--require("config.lazy")
require("config")

vim.cmd.colorscheme("catppuccin")
-- Setting bg colors for gitsigns.nvim
vim.api.nvim_set_hl(0, "GitSignsAddPreview", { bg = "#3b9054" })
vim.api.nvim_set_hl(0, "GitSignsAddInline", { bg = "#3b9054" })
vim.api.nvim_set_hl(0, "GitSignsDeletePreview", { bg = "#a04448" })
vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { bg = "#a04448" })

vim.g.nvim_tree_respect_buf_cwd = 1
