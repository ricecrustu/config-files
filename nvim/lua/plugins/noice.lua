return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = function()
		require("noice").setup({
			-- add any options here
			views = {
				popup = {},
				hover = {
					border = {
						style = "rounded",
					},
				},
			},
			popupmenu = {
				win_options = {
					winhighlight = {
						Normal = "NoicePopupmenu", -- change to NormalFloat to make it look like other floats
						FloatBorder = "NoicePopupmenuBorder", -- border highlight
						CursorLine = "NoicePopupmenuSelected", -- used for highlighting the selected item
						PmenuMatch = "NoicePopupmenuMatch", -- used to highlight the part of the item that matches the input
					},
				},
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = false, -- requires hrsh7th/nvim-cmp
				},
				hover = {
					silent = true,
				},
			},
			-- you can enable a preset for easier configuration
			-- presets = {
			-- bottom_search = true, -- use a classic bottom cmdline for search
			-- command_palette = true, -- position the cmdline and popupmenu together
			-- long_message_to_split = true, -- long messages will be sent to a split
			-- inc_rename = false, -- enables an input dialog for inc-rename.nvim
			-- lsp_doc_border = true, -- add a border to hover docs and signature help
			-- },
		})
	end,
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
}
