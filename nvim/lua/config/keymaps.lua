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

  -- which-key-vscode
  r.noremap({"n", "v"}, "wk", "<cmd>lua require('vscode').action('whichkey.show')<cr>", "Show Which Key")

  -- Tab Navigation
  r.noremap("n", "<tab>", "<cmd>Tabnext<cr>", "Next Tab" )
  r.noremap("n", "<s-tab>", "<cmd>Tabprevious<cr>", "Previous Tab" )

  -- yanky.nvim
  r.noremap({"n","x"}, "p", "<Plug>(YankyPutAfter)")
  r.noremap({"n","x"}, "P", "<Plug>(YankyPutBefore)")
  r.noremap({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
  r.noremap({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

  r.noremap("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
  r.noremap("n", "<c-n>", "<Plug>(YankyNextEntry)")

else
  -- ordinary Neovim

  -- lazy
  -- r.noremap("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

  -- new file
  r.noremap("n", "<leader>fn", "<cmd>enew<cr>","New File" )

  -- location list
  r.noremap("n", "<leader>xl", function()
    local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
    if not success and err then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end, "Location List" )

  -- Move to window using the <ctrl> hjkl keys
  r.map("n", "<C-h>", "<C-w>h", "Go to Left Window")
  r.map("n", "<C-j>", "<C-w>j", "Go to Lower Window")
  r.map("n", "<C-k>", "<C-w>k", "Go to Upper Window")
  r.map("n", "<C-l>", "<C-w>l", "Go to Right Window")

-- Resize window using <ctrl> arrow keys
  r.noremap("n", "<C-Up>", "<cmd>resize +2<cr>", "Increase Window Height" )
  r.noremap("n", "<C-Down>", "<cmd>resize -2<cr>", "Decrease Window Height" )
  r.noremap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease Window Width" )
  r.noremap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Increase Window Width" )

  -- buffers
  r.noremap("n", "<S-h>", "<cmd>bprevious<cr>", "Prev Buffer" )
  r.noremap("n", "<S-l>", "<cmd>bnext<cr>", "Next Buffer" )
  r.noremap("n", "[b", "<cmd>bprevious<cr>", "Prev Buffer" )
  r.noremap("n", "]b", "<cmd>bnext<cr>", "Next Buffer" )
  r.noremap("n", "<leader>bb", "<cmd>e #<cr>", "Switch to Other Buffer" )
  r.noremap("n", "<leader>`", "<cmd>e #<cr>", "Switch to Other Buffer" )

  -- windows
  r.map("n", "<leader>-", "<C-W>s", "Split Window Below")
  r.map("n", "<leader>|", "<C-W>v", "Split Window Right")
  r.map("n", "<leader>wd", "<C-W>c", "Delete Window")
  -- Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
  -- Snacks.toggle.zen():map("<leader>uz")

  -- tabs
  r.noremap("n", "<leader><tab>l", "<cmd>tablast<cr>", "Last Tab" )
  r.noremap("n", "<leader><tab>o", "<cmd>tabonly<cr>", "Close Other Tabs" )
  r.noremap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", "First Tab" )
  r.noremap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", "New Tab" )
  r.noremap("n", "<leader><tab>]", "<cmd>tabnext<cr>", "Next Tab" )
  r.noremap("n", "<leader><tab>d", "<cmd>tabclose<cr>", "Close Tab" )
  r.noremap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", "Previous Tab" )

  -- diagnostic
  local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
      go({ severity = severity })
    end
  end
  r.noremap("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics" )
  r.noremap("n", "]d", diagnostic_goto(true), "Next Diagnostic" )
  r.noremap("n", "[d", diagnostic_goto(false), "Prev Diagnostic" )
  r.noremap("n", "]e", diagnostic_goto(true, "ERROR"), "Next Error" )
  r.noremap("n", "[e", diagnostic_goto(false, "ERROR"), "Prev Error" )
  r.noremap("n", "]w", diagnostic_goto(true, "WARN"), "Next Warning" )
  r.noremap("n", "[w", diagnostic_goto(false, "WARN"), "Prev Warning" )

  -- highlights under cursor
  r.noremap("n", "<leader>ui", vim.show_pos, "Inspect Pos")
  -- r.noremap("n", "<leader>uI", function() vim.treesitter.inspect_tree() vim.api.nvim_input("I") end, desc = "Inspect Tree")
  -- Move Lines
  r.noremap("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", "Move Down" )
  r.noremap("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", "Move Up" )
  r.noremap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move Down" )
  r.noremap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move Up" )
  r.noremap("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", "Move Down" )
  r.noremap("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", "Move Up" )

  -- r.map("n", "<leader>bd", function()
  --   Snacks.bufdelete()
  -- end, { desc = "Delete Buffer" })
  -- map("n", "<leader>bo", function()
  --   Snacks.bufdelete.other()
  -- end, { desc = "Delete Other Buffers" })
  -- map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })


  -- quickfix list
  r.noremap("n", "<leader>xq", function()
    local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
    if not success and err then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end, "Quickfix List" )

  r.noremap("n", "[q", vim.cmd.cprev, "Previous Quickfix" )
  r.noremap("n", "]q", vim.cmd.cnext, "Next Quickfix" )

  -- formatting
  -- map({ "n", "v" }, "<leader>cf", function()
  --   LazyVim.format({ force = true })
  -- end, { desc = "Format" })


  -- stylua: ignore start

  -- toggle options
  -- LazyVim.format.snacks_toggle():map("<leader>uf")
  -- LazyVim.format.snacks_toggle(true):map("<leader>uF")
  -- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
  -- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
  -- Snacks.toggle.diagnostics():map("<leader>ud")
  -- Snacks.toggle.line_number():map("<leader>ul")
  -- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
  -- Snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<leader>uA")
  -- Snacks.toggle.treesitter():map("<leader>uT")
  -- Snacks.toggle.option("background", { off = "light", on = "dark" , name = "Dark Background" }):map("<leader>ub")
  -- Snacks.toggle.dim():map("<leader>uD")
  -- Snacks.toggle.animate():map("<leader>ua")
  -- Snacks.toggle.indent():map("<leader>ug")
  -- Snacks.toggle.scroll():map("<leader>uS")
  -- Snacks.toggle.profiler():map("<leader>dpp")
  -- Snacks.toggle.profiler_highlights():map("<leader>dph")

  -- if vim.lsp.inlay_hint then
  --   Snacks.toggle.inlay_hints():map("<leader>uh")
  -- end

  -- lazygit
  -- if vim.fn.executable("lazygit") == 1 then
  --   map("n", "<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
  --   map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
  --   map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
  --   map("n", "<leader>gl", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, { desc = "Git Log" })
  --   map("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })
  -- end

  -- map("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
  -- map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
  -- map({"n", "x" }, "<leader>gY", function()
  --   Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
  -- end, { desc = "Git Browse (copy)" })

  -- Clear search, diff update and redraw
  -- taken from runtime/lua/_editor.lua
  -- map(
  --   "n",
  --   "<leader>ur",
  --   "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  --   { desc = "Redraw / Clear hlsearch / Diff Update" }
  -- )

  --keywordprg
  r.noremap("n", "<leader>K", "<cmd>norm! K<cr>","Keywordprg" )

  -- floating terminal
  -- map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
  -- map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
  -- map("n", "<c-/>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
  -- map("n", "<c-_>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })

  -- Terminal Mappings
  r.noremap("t", "<C-/>", "<cmd>close<cr>", "Hide Terminal" )
  r.noremap("t", "<c-_>", "<cmd>close<cr>", "which_key_ignore" )

  -- Add undo break-points
  r.noremap("i", ",", ",<c-g>u")
  r.noremap("i", ".", ".<c-g>u")
  r.noremap("i", ";", ";<c-g>u")

  -- quit
  r.noremap("n", "<leader>qq", "<cmd>qa<cr>", "Quit All" )
end
