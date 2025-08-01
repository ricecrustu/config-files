return {
	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		version = false,
		config = function()
			require("mini.icons").setup()

			require("mini.move").setup()

			require("mini.files").setup({
				windows = {
					preview = true,
				},
			})
			vim.keymap.set("n", "<leader>te", function()
				MiniFiles.open()
			end, { desc = "Open Mini Files", silent = true })
			vim.keymap.set("n", "<leader>fe", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
				MiniFiles.reveal_cwd()
			end, { desc = "Reveal current buffer in cwd", silent = true })
			vim.keymap.set("n", "<leader>fE", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
			end, { desc = "Reveal current buffer in explorer", silent = true })
			-- Set focused directory as current working directory
			local set_cwd = function()
				local path = (MiniFiles.get_fs_entry() or {}).path
				if path == nil then
					return vim.notify("Cursor is not on valid entry")
				end
				vim.fn.chdir(vim.fs.dirname(path))
			end

			-- Yank in register full path of entry under cursor
			local yank_path = function()
				local path = (MiniFiles.get_fs_entry() or {}).path
				if path == nil then
					return vim.notify("Cursor is not on valid entry")
				end
				vim.fn.setreg(vim.v.register, path)
			end

			-- Open path with system default handler (useful for non-text files)
			local ui_open = function()
				vim.ui.open(MiniFiles.get_fs_entry().path)
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local b = args.data.buf_id
					vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
					vim.keymap.set("n", "gX", ui_open, { buffer = b, desc = "OS open" })
					vim.keymap.set("n", "gy", yank_path, { buffer = b, desc = "Yank path" })
				end,
			})

			require("mini.sessions").setup()
			vim.keymap.set("n", "<leader>csw", function()
				local cwd = vim.fn.getcwd()
				local last_folder = cwd:match("([^/]+)$")
				MiniSessions.write(last_folder)
			end, { desc = "Write Mini Sessions" })
			vim.keymap.set("n", "<leader>csf", function()
				vim.cmd("wa")
				MiniSessions.select()
			end, { desc = "Find Mini Sessions" })
			vim.keymap.set("n", "<leader>css", function()
				vim.cmd("wa")
				MiniSessions.write()
				MiniSessions.select()
			end, { desc = "Switch Mini Sessions" })

			require("mini.comment").setup({
				options = {
					custom_commentstring = function()
						return require("ts_context_commentstring.internal").calculate_commentstring()
							or vim.bo.commentstring
					end,
				},
			})

			require("mini.pairs").setup({
				modes = { insert = true, command = true, terminal = false },
				-- skip autopair when next character is one of these
				skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
				-- skip autopair when the cursor is inside these treesitter nodes
				skip_ts = { "string" },
				-- skip autopair when next character is closing pair
				-- and there are more closing pairs than opening pairs
				skip_unbalanced = true,
				-- better deal with markdown code blocks
				markdown = true,
			})

			require("mini.surround").setup({
				mappings = {
					add = "gsa", -- Add surrounding in Normal and Visual modes
					delete = "gsd", -- Delete surrounding
					find = "gsf", -- Find surrounding (to the right)
					find_left = "gsF", -- Find surrounding (to the left)
					highlight = "gsh", -- Highlight surrounding
					replace = "gsr", -- Replace surrounding
					update_n_lines = "gsn", -- Update `n_lines`
				},
			})

			local ai = require("mini.ai")
			require("mini.ai").setup({
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					-- g = LazyVim.mini.ai_buffer, -- buffer
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			})

			-- customize mini.statusline content
			-- local active_content = require("utils.status_helper").active_content
			-- require("mini.statusline").setup({ content = { active = active_content } })
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		-- lazy = true,
		event = "VeryLazy",
		opts = {
			enable_autocmd = false,
		},
	},
}
