return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	enabled = false,
	-- ft = { 'markdown', 'quarto' },
	-- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		heading = {
			position = "inline",
			sign = false,
			width = "block",
			min_width = 0,
			icons = { "󰼏 ", "󰎨 ", "󰼑 ", "󰎲 ", "󰼓 ", "󰎴 ", "󰼕 ", "󰎺 " },
			border = true,
			above = "",
			below = "",
		},
		checkbox = {
			checked = {
				scope_highlight = "@markup.strikethrough",
			},
		},
		code = {
			sign = false,
			language_border = " ",
			language_left = "",
			language_right = "",
			width = "block",
			min_width = 80,
			left_pad = 2,
			language_pad = 2,
		},
		bullet = {
			icons = { " ", " ", "◆", "◇" },
		},
	},
}
