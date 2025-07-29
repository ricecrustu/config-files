return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- signs = true,
		-- highlight = {
		--     before = "fg",
		--     keyword = "bg",
		--     after = "fg",
		-- },
	},
	keys = {
		{
			"<Leader>pt",
			function()
				require("snacks").picker.todo_comments()
			end,
			desc = "Pick Todo",
		},
		{
			"<Leader>pT",
			function()
				require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
			end,
			desc = "Pick TODO/FIX/FIXME",
		},
	},
}
