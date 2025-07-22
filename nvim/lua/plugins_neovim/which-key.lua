return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		spec = {
			{ "<leader>b", group = "[B]uffer" },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>f", group = "[F]ind/[F]ile" },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>u", group = "[U]I" },
			{ "<leader>w", group = "[W]indow" },
		},
	},
}
