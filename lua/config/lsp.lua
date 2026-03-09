-- Get the path to your nvim config's lsp directory
-- stdpath("config") returns ~/.config/nvim
local lsp_dir = vim.fn.stdpath("config") .. "/lsp"

-- glob returns a list of all .lua files in that directory
-- false = don't search subdirectories
-- true = return as a list rather than a single string
for _, file in ipairs(vim.fn.glob(lsp_dir .. "/*.lua", false, true)) do
	-- fnamemodify transforms a file path:
	-- ":t" gets just the filename (e.g. "basedpyright.lua")
	-- ":r" strips the extension (e.g. "basedpyright")
	local name = vim.fn.fnamemodify(file, ":t:r")

	vim.lsp.enable(name)
end
