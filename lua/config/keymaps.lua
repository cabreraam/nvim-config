-- telescope
local builtin = require("telescope.builtin")
local gitsigns = require("gitsigns")

local wk = require("which-key")
wk.add({
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
	{ "<leader>fg", builtin.live_grep, desc = "Live Grep", mode = "n" },
	{ "<leader>n", ":NvimTreeToggle<CR>", desc = "Toggle nvim tree", mode = "n" },
	{ "<leader>gf", vim.lsp.buf.format, desc = "format code", mode = { "n" } },
	{ "<leader>K", vim.lsp.buf.hover, desc = "Hover description", mode = { "n" } },
	{ "<leader>gf", vim.lsp.buf.format, desc = "format code", mode = { "n" } },
	{ "<leader>gd", vim.lsp.buf.definition, desc = "Go to defintion", mode = { "n", "v" } },
	{ "<leader>gr", builtin.lsp_references, desc = "See references", mode = { "n", "v" } },
	{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" } },
	{ "<leader>of", vim.diagnostic.open_float, desc = "Float window for diagnostic", mode = { "n", "v" } },
	{ "<leader>at", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial Outline", mode = { "n" } },
	{
		"<leader>hb",
		function()
			gitsigns.blame_line({ full = true })
		end,
		desc = "Gitsigns blame",
		mode = { "n" },
	},
	{ "<leader>hp", gitsigns.preview_hunk, desc = "Gitsigns preview hunk", mode = { "n" } },
})
