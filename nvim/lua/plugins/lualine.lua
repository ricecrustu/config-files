return {
	"nvim-lualine/lualine.nvim",
	enabled = true,
	dependencies = {
		-- "nvim-tree/nvim-web-devicons" ,
		"echasnovski/mini.nvim",
	},
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")
		local icon = require("mini.icons")
		icon.mock_nvim_web_devicons()

		local custom_mocha = require("lualine.themes.catppuccin-mocha")

		custom_mocha.normal.c.bg = "#1e1e2e"

		-- -- Function to get the current mode indicator as a single character
		local function get_mode()
			-- Map of modes to their respective shorthand indicators
			local mode_map = {
				n = "", -- Normal mode
				i = "", -- Insert mode
				v = "", -- Visual mode
				[""] = "", -- Visual block mode
				V = "", -- Visual line mode
				c = "", -- Command-line mode
				no = "", -- NInsert mode
				s = "󰒇", -- Select mode
				S = "󰒇", -- Select line mode
				ic = "", -- Insert mode (completion)
				R = "󰬲", -- Replace mode
				Rv = "󰬲", -- Virtual Replace mode
				cv = "", -- Command-line mode
				ce = "", -- Ex mode
				r = "", -- Prompt mode
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
			-- color = "lualine_transparent",
		}

		local filename = {
			"filename",
			file_status = true,
			path = 0,
			icon = { "", color = { fg = "#CBA6F7" } },
			-- icon = { "", color = { fg = "#CBA6F7" } },
			-- color = "lualine_transparent",
		}

		local diagnostics = {
			"diagnostics",
			symbols = { error = " ", warn = " ", info = " ", hint = "" },
			sections = { "error", "warn", "info" },
		}

		local pyenv = function()
			local venv = require("whichpy.envs").current_selected_name()
			if not venv then
				return ""
			end

			if string.find(venv, "%.venv") then
				venv = vim.fn.fnamemodify(venv, ":h:t")
			elseif string.find(venv, "envs") then
				venv = vim.fn.fnamemodify(venv, ":t")
			end
			return "🐍" .. venv
		end

		local function is_python_file()
			return vim.bo.filetype == "python"
		end

		lualine.setup({
			icons_enabled = true,
			options = {
				theme = custom_mocha,
				section_separators = "",
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { "branch" },
				lualine_c = {
					diff,
					diagnostics,
					filename,
				},
				-- lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_x = {
					{ lazy_status.updates, cond = lazy_status.has_updates },
					"encoding",
					"filetype",
					{ pyenv, cond = is_python_file },
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
