local r = require("utils.remaps")

-- which-key-vscode
r.noremap({"n", "v"}, "<LocalLeader>", "<cmd>lua require('vscode').action('whichkey.show')<cr>", "Show Which Key")

-- Window movement
r.noremap("n", "<C-w>H", "<cmd>lua require('vscode').action('workbench.action.moveEditorToLeftGroup')<cr>", "Focus Left Window")
r.noremap("n", "<C-w>J", "<cmd>lua require('vscode').action('workbench.action.moveEditorToBelowGroup')<cr>", "Focus Below Window")
r.noremap("n", "<C-w>K", "<cmd>lua require('vscode').action('workbench.action.moveEditorToAboveGroup')<cr>", "Focus Above Window")
r.noremap("n", "<C-w>L", "<cmd>lua require('vscode').action('workbench.action.moveEditorToRightGroup')<cr>", "Focus Right Window")

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

r.noremap("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
r.noremap("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
r.noremap("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
r.noremap("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

r.noremap("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
r.noremap("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
r.noremap("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
r.noremap("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

r.noremap("n", "=p", "<Plug>(YankyPutAfterFilter)")
r.noremap("n", "=P", "<Plug>(YankyPutBeforeFilter)")
