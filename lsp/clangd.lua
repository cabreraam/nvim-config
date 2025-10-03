local function get_cmake_binary_dir()
  -- find the preset file
  local preset_file = vim.fn.getcwd() .. "/CMakePresets.json"
  if vim.fn.filereadable(preset_file) == 0 then
    return nil
  end

  -- if readable, check if json
  local json = vim.fn.json_decode(vim.fn.readfile(preset_file))
  if not json or not json.configurePresets then
    return nil
  end

  -- pick active preset
  -- hardcoding active preset; will need to be changed if using different
  -- preset
  local active_preset = "relwithdebinfo"
  local binary_dir
  for _, preset in ipairs(json.configurePresets) do
    if preset.name == active_preset then
      -- expand relative paths relative to project root
      binary_dir = preset.binaryDir
    end
  end
  if not binary_dir then
    return nil
  end

  -- expand CMake macros
  local function expand_macros(path)
    local project_root = vim.fn.getcwd()
    path = path:gsub("%${sourceDir}", project_root)
    -- add more replacements here if needed
    return vim.fn.fnamemodify(path, ":p")
  end

  return expand_macros(binary_dir)
end

local binary_dir = get_cmake_binary_dir()

vim.lsp.config("clangd", {
  cmd = binary_dir and { "clangd", "--compile-commands-dir=" .. binary_dir } or { "clangd" },
})
vim.lsp.enable("clangd")
