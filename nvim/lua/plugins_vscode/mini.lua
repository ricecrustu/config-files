return {
    { 'echasnovski/mini.ai', version = false },
    {
    "echasnovski/mini.move",
    version = false,
    event = "VeryLazy",
    opts = {},
     },
  { 'echasnovski/mini.pairs', version = false },
    -- {
    --   "echasnovski/mini.comment",
    --  version = false,
    --   event = "VeryLazy",
    --   opts = {
    --     options = {
    --       custom_commentstring = function()
    --         return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
    --       end,
    --     },
    --   },
    -- },
    -- {
    -- "JoosepAlviste/nvim-ts-context-commentstring",
    -- lazy = true,
    -- opts = {
    --   enable_autocmd = false,
    -- },
    -- },
    -- rename surround mappings from gs to gz to prevent conflict with leap
    -- {
    --   "echasnovski/mini.surround",
    --   optional = true,
    --   opts = {
    --     mappings = {
    --       add = "gza", -- Add surrounding in Normal and Visual modes
    --       delete = "gzd", -- Delete surrounding
    --       find = "gzf", -- Find surrounding (to the right)
    --       find_left = "gzF", -- Find surrounding (to the left)
    --       highlight = "gzh", -- Highlight surrounding
    --       replace = "gzr", -- Replace surrounding
    --       update_n_lines = "gzn", -- Update `n_lines`
    --     },
    --   },
    --   keys = {
    --     { "gz", "", desc = "+surround" },
    --   },
    -- }
}
