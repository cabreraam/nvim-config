local on_attach = function(client, bufnr)
	-- Auto formatting when saving file
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({
				async = false,
				filter = function(client)
					return client.name == "ruff"
				end,
			})
		end,
	})
end
vim.lsp.config("ruff", {
	on_attach = on_attach,
})
vim.lsp.enable("ruff")
