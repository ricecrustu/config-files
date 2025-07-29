return {
	-- disable flash
	{ "folke/flash.nvim", enabled = true, optional = false },

	-- easily jump to any location and enhanced f/t motions for Leap
	{
		"ggandor/flit.nvim",
		enabled = false,
		keys = function()
			---@type LazyKeysSpec[]
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
			end
			return ret
		end,
		opts = { labeled_modes = "nx" },
	},
	{
		"ggandor/leap.nvim",
		enabled = false,
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap to" },
			-- { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
			-- { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			-- leap.add_default_mappings(true)
			leap.opts.safe_lables = {}
			vim.keymap.set("n", "s", "<Plug>(leap-anywhere)")
			vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap)")
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},
}
