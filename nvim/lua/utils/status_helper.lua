local H = {}
local mini = require("mini.statusline")

local simple_filename = function()
	-- In terminal always use plain name
	if vim.bo.buftype == "terminal" then
		return "%t"
	end
	-- local modified = vim.bo.modified and "❌" or "✅"
	-- return (MiniStatusline.is_truncated(140) and "%f" or "%F") .. modified .. "%r"
	local f = vim.api.nvim_buf_get_name(0)
	f = vim.fn.fnamemodify(f, ":.")
	f = vim.fn.pathshorten(f)
	if f == "" then
		f = "[No Name]"
	end
	return f .. "%m%r"
end

local CTRL_S = vim.api.nvim_replace_termcodes("<C-S>", true, true, true)
local CTRL_V = vim.api.nvim_replace_termcodes("<C-V>", true, true, true)
local mode_map = setmetatable({
	["n"] = { long = "Normal", short = "", hl = "MiniStatuslineModeNormal" },
	["v"] = { long = "Visual", short = "", hl = "MiniStatuslineModeVisual" },
	["V"] = { long = "V-Line", short = "", hl = "MiniStatuslineModeVisual" },
	[CTRL_V] = { long = "V-Block", short = "", hl = "MiniStatuslineModeVisual" },
	["s"] = { long = "Select", short = "󰒇", hl = "MiniStatuslineModeVisual" },
	["S"] = { long = "S-Line", short = "󰒇", hl = "MiniStatuslineModeVisual" },
	[CTRL_S] = { long = "S-Block", short = "󰒇", hl = "MiniStatuslineModeVisual" },
	["i"] = { long = "Insert", short = "", hl = "MiniStatuslineModeInsert" },
	["R"] = { long = "Replace", short = "󰬲", hl = "MiniStatuslineModeReplace" },
	["c"] = { long = "Command", short = "", hl = "MiniStatuslineModeCommand" },
	["r"] = { long = "Prompt", short = "", hl = "MiniStatuslineModeOther" },
	["!"] = { long = "Shell", short = "", hl = "MiniStatuslineModeOther" },
	["t"] = { long = "Terminal", short = "", hl = "MiniStatuslineModeOther" },
}, {
	-- By default return 'Unknown' but this shouldn't be needed
	__index = function()
		return { long = "Unknown", short = "U", hl = "%#MiniStatuslineModeOther#" }
	end,
})

local get_mode = function(args)
	local mode_info = mode_map[vim.fn.mode()]

	-- local mode = MiniStatusline.is_truncated(args.trunc_width) and mode_info.short or mode_info.long
	local mode = mode_info.short

	return mode, mode_info.hl
end

local get_icon = function(filetype)
	local icon = require("mini.icons")
	local fileicon = icon.get("filetype", filetype)
	return fileicon
end

local diagnostic_icons = { ERROR = " ", WARN = " ", INFO = " ", HINT = " " }

local numOfDiag = function(severity)
	local get_count = function(buf_id)
		return vim.diagnostic.count(buf_id)
	end
	local count = get_count(vim.api.nvim_get_current_buf())
	if count == nil or not vim.diagnostic.is_enabled({ bufnr = 0 }) then
		return ""
	end
	local icon = diagnostic_icons[severity] or ""
	local n = count[vim.diagnostic.severity[severity]] or 0
	local str = n > 0 and (icon .. n) or ""
	return str
end

H.active_content = function()
	local mode, mode_hl = get_mode({ trunc_width = 120 })
	local git = mini.section_git({ trunc_width = 40 })
	local diff = mini.section_diff({ trunc_width = 75 })
	local filename = simple_filename()
	local encoding = vim.bo.fileencoding or vim.bo.encoding
	local filetype = vim.bo.filetype
	local fileicon = get_icon(filetype)
	local location = "%3l:%-2v"
	-- local search = mini.section_searchcount({ trunc_width = 75 })

	return mini.combine_groups({
		{ hl = mode_hl, strings = { mode } },
		-- { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
		{ hl = "MiniStatuslineDevinfo", strings = { git, diff } },
		{ hl = "DiagnosticSignError", strings = { numOfDiag("ERROR") } },
		{ hl = "DiagnosticSignWarn", strings = { numOfDiag("WARN") } },
		{ hl = "DiagnosticSignInfo", strings = { numOfDiag("INFO") } },
		{ hl = "DiagnosticSignHint", strings = { numOfDiag("HINT") } },
		"%<", -- Mark general truncate point
		{ hl = "MiniStatuslineFilename", strings = { filename } },
		"%=", -- End left alignment
		{ hl = "MiniStatuslineFilename", strings = { encoding } },
		{ hl = "MiniStatuslineFilename", strings = { fileicon, filetype } },
		{ hl = mode_hl, strings = { location } },
	})
end

return H
