return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			-- Creates a beautiful debugger UI
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",

			-- Installs the debug adapters for you
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",

			-- Add your own debuggers here
			{ "mfussenegger/nvim-dap-python", event = "VeryLazy" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_setup = true,
				automatic_installation = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					-- 'delve',
					"debugpy",
				},
			})

			-- Basic debugging keymaps, feel free to change to your liking!
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Debug: Terminate" })
			vim.keymap.set("n", "<leader>dR", dap.terminate, { desc = "Debug: Restart" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Breakpoint" })

			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			vim.keymap.set("n", "<leader>dl", dapui.toggle, { desc = "Debug: See last session result." })

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- Install golang specific config
			-- require('dap-go').setup()
			-- local python_path = table.concat({ vim.fn.stdpath('data'),  'mason', 'packages', 'debugpy', 'venv', 'bin', 'python'}, '/'):gsub('//+', '/')
			local python_path =
				vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages", "debugpy", "venv", "bin", "python")
			require("dap-python").setup(python_path)
		end,
	},
	{
		"neolooong/whichpy.nvim",
		ft = "python",
		keys = {
			{
				"<leader>ci",
				"<cmd>WhichPy select<cr>",
				desc = "Start/Continue Debugger",
			},
		},
		dependencies = {
			-- optional for dap
			"mfussenegger/nvim-dap-python",
			-- optional for picker support
			-- "ibhagwan/fzf-lua",
			-- "nvim-telescope/telescope.nvim",
		},
		opts = {},
	},
}
