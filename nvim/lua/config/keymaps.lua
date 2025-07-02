-- This file is automatically loaded by lazyvim.config.init

-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local r = require("utils.remaps")

-- better up/down
r.noremap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", "Down", {expr = true, silent = true })
r.noremap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", "Down", {expr = true, silent = true })
r.noremap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'","Up", {expr = true, silent = true })
r.noremap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'","Up", {expr = true, silent = true })

-- better left/right
r.noremap({"n", "v", "o"}, "H", "^", "Start of Line")
r.noremap({"n", "v", "o"}, "L", "$", "End of Line")

-- Clear search and stop snippet on escape
r.noremap({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end,"Escape and Clear hlsearch", { expr = true})

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
r.noremap("n", "n", "'Nn'[v:searchforward].'zv'","Next Search Result" , { expr = true})
r.noremap("x", "n", "'Nn'[v:searchforward]","Next Search Result" , { expr = true})
r.noremap("o", "n", "'Nn'[v:searchforward]","Next Search Result" , { expr = true})
r.noremap("n", "N", "'nN'[v:searchforward].'zv'","Prev Search Result" , { expr = true})
r.noremap("x", "N", "'nN'[v:searchforward]","Prev Search Result" , { expr = true})
r.noremap("o", "N", "'nN'[v:searchforward]","Prev Search Result" , { expr = true})

-- save file
r.noremap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>","Save File" )

-- better indenting
r.noremap("v", "<", "<gv")
r.noremap("v", ">", ">gv")

-- commenting
r.noremap("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Below" )
r.noremap("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Above" )


if vim.g.vscode then
  -- VSCode Neovim
  require("config.keymaps_vscode")

else
  -- ordinary Neovim
  require("config.keymaps_neovim")
end
