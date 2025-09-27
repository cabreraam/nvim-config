local modules = {
	"config.lsp",
	"config.lazy",
	"config.keymaps",
}

-- this will call lazy, $XDG_CONFIG_HOME/.config/nvim/lua/config/lazy.lua
-- in the above file, it will call require("lazy")...
for _, mod in ipairs(modules) do
	local ok, err = pcall(require, mod)
	if not ok then
		error(("Error loading %s...\n\n%s"):format(mod, err))
	end
end
