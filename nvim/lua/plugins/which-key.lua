return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		spec = {
			{ "<leader>b", group = "Buffer" },
			{ "<leader>c", group = "Code" },
			{ "<leader>f", group = "Find/File" },
			{ "<leader>g", group = "Git" },
			{ "<leader>s", group = "Search" },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>u", group = "UI" },
			{ "<leader>w", group = "Window" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>dt", group = "Debug Focus on" },
			{ "<leader>p", group = "Pick" },
			{ "<leader>x", group = "List" },
		},
	},
}
