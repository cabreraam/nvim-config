# Anthony's Neovim Config

## Dependencies
- Need treesitter-cli
  ```
  sudo npm install -g tree-sitter-cli
  ```
  or locally via
  ```
  npm install tree-sitter-cli
  ```
  but note that you'll have to find where it was locally installed and then add
  this to your path

## Known Issues and their Workarounds 
For the `cmake-language-server` plugin, there's a versioning issue that can be resolved with:
```
/path/to/mason/packages/nvim/mason/packages/cmake-language-server/venv/bin/pip install "pygls<2.0"
```
