vim.keymap.set("n", " ", "<nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local r = require("utils.remaps")

-- better up/down
r.noremap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", "Down", { expr = true, silent = true })
r.noremap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", "Up", { expr = true, silent = true })

-- better left/right
r.noremap({ "n", "v", "o" }, "<S-h>", "^", "Start of Line")
r.noremap({ "n", "v", "o" }, "<S-l>", "$", "End of Line")

-- Clear search and stop snippet on escape
r.noremap({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	return "<esc>"
end, "Escape and Clear hlsearch", { expr = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
r.noremap("n", "n", "'Nn'[v:searchforward].'zv'", "Next Search Result", { expr = true })
r.noremap("x", "n", "'Nn'[v:searchforward]", "Next Search Result", { expr = true })
r.noremap("o", "n", "'Nn'[v:searchforward]", "Next Search Result", { expr = true })
r.noremap("n", "N", "'nN'[v:searchforward].'zv'", "Prev Search Result", { expr = true })
r.noremap("x", "N", "'nN'[v:searchforward]", "Prev Search Result", { expr = true })
r.noremap("o", "N", "'nN'[v:searchforward]", "Prev Search Result", { expr = true })

-- Paste without replacing the clipboard content
r.noremap("x", "<leader>p", [["_dP]], "Paste without replacing clipboard content", { silent = true })
r.noremap("v", "p", '"_dp', "Paste without replacing clipboard content", { silent = true })
-- Delete characters without copying to the clipboard
r.noremap("n", "x", '"_x', "Delete character without copying to clipboard", { silent = true })
-- Replace word under cursor globally
r.noremap(
	"n",
	"<leader>rw",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>]],
	"Replace word under cursor globally"
)
-- Replace selected content globally
r.noremap("x", "<leader>rw", [[y:%s/<C-r>"//gcI<Left><Left><Left><Left>]], "Replace selected content globally")
-- copy and comment out the current line then paste it below
r.map("n", "yc", "yygccp", "Copy and Comment Out Current Line then paste it below")

-- File
r.noremap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", "Save File")
r.noremap("n", "<Leader>fP", function()
	vim.cmd("normal! ggVGp")
end, "Paste clipboard to file (replace all)")
r.noremap("n", "<Leader>fY", function()
	vim.cmd("%y")
end, "Copy file to clipboard")

-- better indenting
r.noremap("v", "<", "<gv", "Unindent", { silent = true })
r.noremap("v", ">", ">gv", "Indent", { silent = true })

-- commenting
r.noremap("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Below")
r.noremap("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Above")

if vim.g.vscode then
	-- VSCode Neovim
	require("config.keymaps_vscode")
else
	-- ordinary Neovim
	require("config.keymaps_neovim")
end
