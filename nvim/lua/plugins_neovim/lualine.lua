return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		-- -- Function to get the current mode indicator as a single character
		local function get_mode()
			-- Map of modes to their respective shorthand indicators
			local mode_map = {
				n = "", -- Normal mode
				i = "", -- Insert mode
				v = "", -- Visual mode
				[""] = "", -- Visual block mode
				V = "", -- Visual line mode
				c = "", -- Command-line mode
				no = "", -- NInsert mode
				s = "S", -- Select mode
				S = "S", -- Select line mode
				ic = "", -- Insert mode (completion)
				R = "R", -- Replace mode
				Rv = "R", -- Virtual Replace mode
				cv = "", -- Command-line mode
				ce = "", -- Ex mode
				r = "R", -- Prompt mode
				rm = "M", -- More mode
				["r?"] = "", -- Confirm mode
				["!"] = "", -- Shell mode
				t = "", -- Terminal mode
			}
			-- Return the mode shorthand or [UNKNOWN] if no match
			return mode_map[vim.fn.mode()] or "[UNKNOWN]"
		end

		local mode = {
			"mode",
			fmt = function(str)
				-- return ' '
				-- displays only the first character of the mode
				-- return ' ' .. get_mode()
				return get_mode()
			end,
		}

		local diff = {
			"diff",
			colored = true,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			-- cond = hide_in_width,
		}

		local filename = {
			"filename",
			file_status = true,
			path = 0,
		}

		lualine.setup({
			icons_enabled = true,
			options = {
				theme = "auto",
				section_separators = { left = " ", right = "" },
				component_separators = { left = " ", right = "" },
			},
			sections = {
				lualine_a = { mode },
				-- lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_b = { "branch" },
				-- lualine_c = { 'filename', 'filesize' },
				lualine_c = { "diff", "filename" },
				-- lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_x = {
					{ lazy_status.updates, cond = lazy_status.has_updates },
					"encoding",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
