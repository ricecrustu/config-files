return {
	"OXY2DEV/markview.nvim",
	lazy = false,

	-- For `nvim-treesitter` users.
	priority = 49,

	-- For blink.cmp's completion
	-- source
	-- dependencies = {
	--     "saghen/blink.cmp"
	-- },
	--
	config = function()
		local presets = require("markview.presets")
		require("markview").setup({
			---@type markview.config.markdown
			markdown = {
				enable = true,

				code_blocks = {
					enable = true,

					style = "block",

					border_hl = "MarkviewCode",
					info_hl = "MarkviewCodeInfo",

					min_width = 45,
					pad_amount = 2,
					pad_char = " ",
					sign = false,
				},

				headings = {
					heading_1 = {
						style = "label",
						hl = "MarkviewPalette1Fg",
					},
					heading_2 = {
						style = "label",
						hl = "MarkviewPalette2Fg",
					},
					heading_3 = {
						style = "label",
						hl = "MarkviewPalette3Fg",
					},
					heading_4 = {
						style = "label",
						hl = "MarkviewPalette4Fg",
					},
					heading_5 = {
						style = "label",
						hl = "MarkviewPalette5Fg",
					},
					heading_6 = {
						style = "label",
						hl = "MarkviewPalette6Fg",
					},
					shift_width = 0,
				},

				horizontal_rules = presets.horizontal_rules.dashed,

				list_items = {
					enable = true,
					wrap = true,

					shift_width = 2,

					marker_minus = {
						add_padding = true,
						conceal_on_checkboxes = true,

						text = "",
						hl = "MarkviewListItemMinus",
					},

					marker_plus = {
						add_padding = true,
						conceal_on_checkboxes = true,

						text = "◈",
						hl = "MarkviewListItemPlus",
					},

					marker_star = {
						add_padding = true,
						conceal_on_checkboxes = true,

						text = "◇",
						hl = "MarkviewListItemStar",
					},

					marker_dot = {
						add_padding = true,
						conceal_on_checkboxes = true,
					},

					marker_parenthesis = {
						add_padding = true,
						conceal_on_checkboxes = true,
					},
				},

				metadata_minus = {
					enable = true,

					hl = "MarkviewCode",
					border_hl = "MarkviewCodeFg",

					border_top = "▄",
					border_bottom = "▀",
				},

				metadata_plus = {
					enable = true,

					hl = "MarkviewCode",
					border_hl = "MarkviewCodeFg",

					border_top = "▄",
					border_bottom = "▀",
				},

				tables = {
					enable = true,
					strict = false,

					col_min_width = 10,
					block_decorator = true,
					use_virt_lines = false,
				},
			},
			preview = {
				modes = { "i", "n", "no", "c" },
				hybrid_modes = { "i" },
			},
		})
	end,
}
