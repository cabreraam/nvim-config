vim.lsp.config("verible", {
  filetypes = { "systemverilog", "verilog" },
  cmd = { "verible-verilog-ls", "--rules_config_search" }, --, "--file_list_path", "./verible.filelist" },
  root_dir = function(fname)
    return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
  end,
  autostart = true,
})
vim.lsp.enable("vhdl_ls")
