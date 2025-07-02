local r = require("utils.remaps")

-- which-key-vscode
r.noremap({"n", "v"}, "<LocalLeader>", "<cmd>lua require('vscode').action('whichkey.show')<cr>", "Show Which Key")

-- Tab Navigation
r.noremap("n", "<tab>", "<cmd>Tabnext<cr>", "Next Tab" )
r.noremap("n", "<s-tab>", "<cmd>Tabprevious<cr>", "Previous Tab" )

-- Buffer/File Navigation
r.noremap("n", "<Leader>be", "<cmd>Edit<cr>", "Edit file/Quick Open in VSCode" )
r.noremap("n", "<Leader>bl", "<cmd>lua require('vscode').action('workbench.action.showEditorsInActiveGroup')<cr>", "List Buffers in current group" )
r.noremap("n", "<Leader>bL", "<cmd>lua require('vscode').action('workbench.action.showAllEditors')<cr>", "List all Buffers" )


r.noremap({"n", "v"}, "<Leader>ff", function() -- Find in files for word under cursor
  require('vscode').action("workbench.action.findInFiles", {
    args = { query = vim.fn.expand('<cword>') }
  })
end)

-- Debug
r.noremap("n", "<Leader>dd", "<cmd>lua require('vscode').action('workbench.action.debug.start')<cr>", "Start Debugging" )
r.noremap("n", "<Leader>dr", "<cmd>lua require('vscode').action('workbench.action.debug.run')<cr>", "Debugging Run" )
r.noremap("n", "<Leader>dc", "<cmd>lua require('vscode').action('workbench.action.debug.continue')<cr>", "Continue Debugging" )
r.noremap("n", "<Leader>dx", "<cmd>lua require('vscode').action('workbench.action.debug.stop')<cr>", "Stop Debugging" )
r.noremap("n", "<Leader>dR", "<cmd>lua require('vscode').action('workbench.action.debug.restart')<cr>", "Restart Debugging" )
r.noremap("n", "<Leader>di", "<cmd>lua require('vscode').action('workbench.action.debug.stepInto')<cr>", "Step Into Debugging" )
r.noremap("n", "<Leader>do", "<cmd>lua require('vscode').action('workbench.action.debug.stepOver')<cr>", "Step Over Debugging" )
r.noremap("n", "<Leader>dO", "<cmd>lua require('vscode').action('workbench.action.debug.stepOut')<cr>", "Step Out Debugging" )
r.noremap("n", "<Leader>db", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<cr>", "Toggle Breakpoint" )
r.noremap("n", "<Leader>dh", "<cmd>lua require('vscode').action('editor.debug.action.showDebugHover')<cr>", "Show Debug Hover" )


-- Action
r.noremap({ "n", "x" }, "<leader>ar", function()
  vscode.with_insert(function()
    vscode.action("editor.action.rename")
  end)
end)

r.noremap({ "n", "x" }, "<leader>aR", function()
  vscode.with_insert(function()
    vscode.action("editor.action.refactor")
  end)
end)

r.noremap({"n", "x"}, "<leader>aq", "<cmd>lua require('vscode').action('editor.action.quickFix')<cr>", "Quick Fix" )


-- Error
r.noremap("n", "<Leader>el", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<cr>", "View Problems" )
r.noremap("n", "<Leader>en", "<cmd>lua require('vscode').action('editor.action.marker.next')<cr>", "Go to Next Problems" )
r.noremap("n", "<Leader>ep", "<cmd>lua require('vscode').action('editor.action.marker.previous')<cr>", "Go to Previous Problems" )


---------- Plugins ----------
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
