return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			notify = false,
			noice = true,
			mini = {
				enabled = true,
				indentscope_color = "",
			},
			blimk_cmp = {
				style = "bordered",
			},
			mason = true,
			markview = true,
			snacks = {
				enabled = true,
				indent_scope_color = "",
			},
			lsp_trouble = true,
			which_key = true,
		},
	},
	config = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
