local r = require("utils.remaps")

-- new file
r.noremap("n", "<leader>fn", "<cmd>enew<cr>", "New File")

-- location list
r.noremap("n", "<leader>xl", function()
	local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, "Location List")

-- Escape
r.noremap("i", "jk", "<esc>", "Escape Insert Mode")

-- Move to window using the <ctrl> hjkl keys
r.map("n", "<C-h>", "<C-w>h", "Go to Left Window")
r.map("n", "<C-j>", "<C-w>j", "Go to Lower Window")
r.map("n", "<C-k>", "<C-w>k", "Go to Upper Window")
r.map("n", "<C-l>", "<C-w>l", "Go to Right Window")

-- Resize window using <ctrl> arrow keys
r.noremap("n", "<C-Up>", "<cmd>resize +2<cr>", "Increase Window Height")
r.noremap("n", "<C-Down>", "<cmd>resize -2<cr>", "Decrease Window Height")
r.noremap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease Window Width")
r.noremap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Increase Window Width")

-- buffers
r.noremap("n", "[b", "<cmd>bprevious<cr>", "Prev Buffer")
r.noremap("n", "]b", "<cmd>bnext<cr>", "Next Buffer")
r.noremap("n", "<leader>bb", "<cmd>e #<cr>", "Switch to Other Buffer")
r.noremap("n", "<leader>`", "<cmd>e #<cr>", "Switch to Other Buffer")

-- windows
r.map("n", "<leader>-", "<C-W>s", "Split Window Below")
r.map("n", "<leader>|", "<C-W>v", "Split Window Right")
r.map("n", "<leader>wd", "<C-W>c", "Delete Window")

-- tabs
r.noremap("n", "<leader>tl", "<cmd>tablast<cr>", "Last Tab")
r.noremap("n", "<leader>to", "<cmd>tabonly<cr>", "Close Other Tabs")
r.noremap("n", "<leader>tf", "<cmd>tabfirst<cr>", "First Tab")
r.noremap("n", "<leader>tt", "<cmd>tabnew<cr>", "New Tab")
r.noremap("n", "<leader>tn", "<cmd>tabnext<cr>", "Next Tab")
r.noremap("n", "<leader>td", "<cmd>tabclose<cr>", "Close Tab")
r.noremap("n", "<leader>tp", "<cmd>tabprevious<cr>", "Previous Tab")

-- highlights under cursorLazyFile
r.noremap("n", "<leader>ui", vim.show_pos, "Inspect Pos")
r.noremap("n", "<leader>uI", function()
	vim.treesitter.inspect_tree()
	vim.api.nvim_input("I")
end, "Inspect Tree")

-- Copy absolute filepath to the clipboard
r.noremap("n", "<leader>f/", function()
	-- local filepath = vim.fn.expand(vim.fn.expand("%:p"))
	local filepath = vim.api.nvim_buf_get_name(0)
	vim.fn.setreg("+", filepath)
	vim.notify("Copied file path: " .. filepath, vim.log.levels.INFO)
end, "Copy absolute File Path to Clipboard")

-- Copy relative filepath to the clipboard
r.noremap("n", "<leader>f.", function()
	local filepath = vim.fn.fnamemodify(vim.fn.expand("%:~"), ":~:.")
	vim.fn.setreg("+", filepath)
	vim.notify("Copied file path: " .. filepath, vim.log.levels.INFO)
end, "Copy relative File Path to Clipboard")

-- Move Lines
-- r.noremap("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", "Move Down" )
-- r.noremap("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", "Move Up" )
-- r.noremap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move Down" )
-- r.noremap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move Up" )
-- r.noremap("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", "Move Down" )
-- r.noremap("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", "Move Up" )

-- r.noremap("n", "<leader>bd", function()
--   Snacks.bufdelete()
-- end, "Delete Buffer")
-- r.noremap("n", "<leader>bo", function()
--   Snacks.bufdelete.other()
-- end, "Delete Other Buffers")
-- r.noremap("n", "<leader>bD", "<cmd>:bd<cr>", "Delete Buffer and Window")

-- quickfix list
r.noremap("n", "<leader>xq", function()
	local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, "Quickfix List")

r.noremap("n", "[q", vim.cmd.cprev, "Previous Quickfix")
r.noremap("n", "]q", vim.cmd.cnext, "Next Quickfix")

-- formatting
-- map({ "n", "v" }, "<leader>cf", function()
--   LazyVim.format({ force = true })
-- end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

r.noremap("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
r.noremap("n", "]d", diagnostic_goto(true), "Next Diagnostic")
r.noremap("n", "[d", diagnostic_goto(false), "Prev Diagnostic")
r.noremap("n", "]e", diagnostic_goto(true, "ERROR"), "Next Error")
r.noremap("n", "[e", diagnostic_goto(false, "ERROR"), "Prev Error")
r.noremap("n", "]w", diagnostic_goto(true, "WARN"), "Next Warning")
r.noremap("n", "[w", diagnostic_goto(false, "WARN"), "Prev Warning")

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
r.noremap("n", "<leader>K", "<cmd>norm! K<cr>", "Keywordprg")

-- floating terminal
-- r.noremap("n", "<leader>fT", function() Snacks.terminal() end, "Terminal (cwd)")
-- r.noremap("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, "Terminal (Root Dir)")
-- r.noremap("n", "<c-/>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, "Terminal (Root Dir)")
-- r.noremap("n", "<c-_>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, "which_key_ignore")

-- Terminal Mappings
r.noremap("t", "<C-/>", "<cmd>close<cr>", "Hide Terminal")
r.noremap("t", "<c-_>", "<cmd>close<cr>", "which_key_ignore")

-- Add undo break-points
r.noremap("i", ",", ",<c-g>u")
r.noremap("i", ".", ".<c-g>u")
r.noremap("i", ";", ";<c-g>u")

-- quit
r.noremap("n", "<leader>qq", "<cmd>qa<cr>", "Quit All")
