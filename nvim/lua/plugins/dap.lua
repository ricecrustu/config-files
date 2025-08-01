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

			-- "Weissle/persistent-breakpoints.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

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

			-- Debug signs
			local sign = vim.fn.sign_define

			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapBreakpointRejected", { text = "●", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
			sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "debugPC", numhl = "" })

			-- Basic debugging keymaps, feel free to change to your liking!
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Debug: Terminate" })
			vim.keymap.set("n", "<leader>dr", dap.run, { desc = "Debug: Run" })
			vim.keymap.set("n", "<leader>dR", dap.terminate, { desc = "Debug: Restart" })

			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			vim.keymap.set("n", "<leader>dl", dapui.toggle, { desc = "Debug: See last session result" })

			-- Breakpoint keymaps
			vim.keymap.set("n", "<leader>db", function()
				require("persistent-breakpoints.api").toggle_breakpoint()
			end, { desc = "Debug: Toggle Breakpoint", silent = true })

			vim.keymap.set("n", "<leader>dB", function()
				require("persistent-breakpoints.api").set_conditional_breakpoint()
			end, { desc = "Debug: Set conditional Breakpoint", silent = true })

			vim.keymap.set("n", "<leader>dL", dap.list_breakpoints, { desc = "Debug: List Breakpoint" })
			-- vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			-- vim.keymap.set("n", "<leader>dB", function()
			-- 	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			-- end, { desc = "Debug: Set Breakpoint" })

			vim.keymap.set({ "n", "v" }, "<leader>dw", dapui.elements.watches.add, { desc = "Debug: Add to watch" })

			-- dap ui view options
			local widgets = require("dap.ui.widgets")
			vim.keymap.set({ "n", "v" }, "<leader>dh", widgets.hover, { desc = "Debug: Show hover" })
			vim.keymap.set({ "n", "v" }, "<leader>dp", widgets.preview, { desc = "Debug: Show preview" })
			vim.keymap.set("n", "<Leader>df", function()
				widgets.centered_float(widgets.frames)
				-- widgets.sidebar(widgets.frames)
				-- widgets.cursor_float(widgets.frames)
			end, { desc = "Debug: View the current frame" })
			vim.keymap.set("n", "<Leader>ds", function()
				widgets.centered_float(widgets.scopes)
			end, { desc = "Debug: View the current scope" })

			---jump to the window of specified dapui element
			---@param element string filetype of the element
			local function jump_to_element(element)
				local visible_wins = vim.api.nvim_tabpage_list_wins(0)

				for _, win in ipairs(visible_wins) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].filetype == element then
						vim.api.nvim_set_current_win(win)
						return
					end
				end

				vim.notify(("element '%s' not found"):format(element), vim.log.levels.WARN)
			end

			vim.keymap.set("n", "<leader>dtv", function()
				jump_to_element("dapui_scopes")
			end, { desc = "Debug: Foucus on scopes window" })
			vim.keymap.set("n", "<leader>dtw", function()
				jump_to_element("dapui_watches")
			end, { desc = "Debug: Foucus on watches window" })
			vim.keymap.set("n", "<leader>dtb", function()
				jump_to_element("dapui_breakpoints")
			end, { desc = "Debug: Foucus on breakpoints window" })
			vim.keymap.set("n", "<leader>dts", function()
				jump_to_element("dapui_stacks")
			end, { desc = "Debug: Foucus on stacks window" })
			vim.keymap.set("n", "<leader>dtc", function()
				jump_to_element("dapui_console")
			end, { desc = "Debug: Foucus on console window" })
			vim.keymap.set("n", "<leader>dtr", function()
				jump_to_element("dap_repl")
			end, { desc = "Debug: Foucus on repl window" })

			-- Auto open and cloase dupui on events
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

			-- Auto trigger completion in dap REPL
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "dap-repl",
				callback = function()
					require("dap.ext.autocompl").attach()
				end,
			})

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
	{
		"Weissle/persistent-breakpoints.nvim",
		event = "VeryLazy",
		opts = { load_breakpoints_event = "BufReadPost", always_reload = true },
	},
}
