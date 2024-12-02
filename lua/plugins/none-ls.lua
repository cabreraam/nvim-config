return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	opts = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.completion.spell,
				require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
				require("none-ls.diagnostics.cpplint"), -- requires none-ls-extras.nvim
				require("none-ls.formatting.mdslw"), -- requires none-ls-extras.nvim
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
