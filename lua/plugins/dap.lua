return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")
		local dap_virtual_text = require("nvim-dap-virtual-text")

		dapui.setup({})
		dap_virtual_text.setup({
			commented = true,
		})

		dap_python.setup("python")

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		dap.configurations.cpp = {
			{
				name = "Run executable (GDB)",
				type = "cppdbg",
				request = "launch",
				stopAtEntry = true,
				-- This requires special handling of 'run_last', see
				-- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
				cwd = vim.fn.getcwd(),
				program = function()
					local path = vim.fn.input({
						prompt = "Path to executable: ",
						default = vim.fn.getcwd() .. "/",
						completion = "file",
					})

					return (path and path ~= "") and path or dap.ABORT
				end,
			},
			{
				name = "Run executable with arguments (GDB)",
				type = "cppdbg",
				request = "launch",
				-- This requires special handling of 'run_last', see
				-- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
				program = function()
					local path = vim.fn.input({
						prompt = "Path to executable: ",
						default = vim.fn.getcwd() .. "/",
						completion = "file",
					})

					return (path and path ~= "") and path or dap.ABORT
				end,
				args = function()
					local args_str = vim.fn.input({
						prompt = "Arguments: ",
					})
					return vim.split(args_str, " +")
				end,
			},
			{
				name = "Attach to process (GDB)",
				type = "gdb",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
		}
	end,
}
