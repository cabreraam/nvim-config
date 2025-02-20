return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		--"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")
		--local dap_virtual_text = require("nvim-dap-virtual-text")

		dapui.setup({})
		--dap_virtual_text.setup({
		--	commented = true,
		--})

		dap_python.setup("python")

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		local opts = { noremap = true, silent = true }
		-- Toggle DAP UI
		vim.keymap.set("n", "<leader>du", function()
			dapui.toggle()
		end, opts)
	end,
}
