return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      search = {
        -- search/jump in all windows
        multi_window = false
      },
      modes = {
        char = {
          -- jump_labels = false,            -- show labels for jumps
          keys = { "f", "F", "t", "T" }, -- keys to use for char mode
           config = function(opts)
            -- disable jump labels when not enabled, when using a count,
            -- or when recording/executing registers
            -- opts.jump_labels = opts.jump_labels
            --   and vim.v.count == 0
            --   and vim.fn.reg_executing() == ""
            --   and vim.fn.reg_recording() == ""

            -- Show jump labels only in operator-pending mode
            opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
      end,
        }
      },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = "VeryLazy" },
}

-- easily jump to any location and enhanced f/t motions for Leap
-- {
--   "ggandor/flit.nvim",
--   enabled = true,
--   keys = function()
--     ---@type LazyKeysSpec[]
--     local ret = {}
--     for _, key in ipairs({ "f", "F", "t", "T" }) do
--       ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
--     end
--     return ret
--   end,
--   opts = { labeled_modes = "nx" },
-- },
-- {
--   "ggandor/leap.nvim",
--   enabled = true,
--   keys = {
--     { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
--     { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
--     { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
--   },
--   config = function(_, opts)
--     local leap = require("leap")
--     for k, v in pairs(opts) do
--       leap.opts[k] = v
--     end
--     leap.add_default_mappings(true)
--     vim.keymap.del({ "x", "o" }, "x")
--     vim.keymap.del({ "x", "o" }, "X")
--   end,
-- },
