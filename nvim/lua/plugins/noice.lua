return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	opts = {
		views = {
			hover = {
				view = "popup",
				relative = "cursor",
				zindex = 45,
				enter = false,
				anchor = "auto",
				size = {
					width = "auto",
					height = "auto",
					max_height = 20,
					max_width = 120,
				},
				border = {
					style = "rounded",
					padding = { 0, 2 },
				},
				position = { row = 2, col = 0 },
				win_options = {
					winhighlight = { Normal = "NoiceCmdlinePopup", FloatBorder = "MoreMsg" },
					wrap = true,
					linebreak = true,
				},
			},
		},
		lsp = {
			hover = {
				silent = true,
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			-- bottom_search = true, -- use a classic bottom cmdline for search
			-- command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			-- inc_rename = false, -- enables an input dialog for inc-rename.nvim
			-- lsp_doc_border = true, -- add a border to hover docs and signature help
		},
	},
}
