local r = require("utils.remaps")
local vscode = require("vscode")

local function manageEditorHeight(to)
  local count = vim.v.count ~= 0 and vim.v.count or 1
  local cmd = (to == "increase") and "workbench.action.increaseViewHeight" or "workbench.action.decreaseViewHeight"
  for _ = 1, count do
    vscode.action(cmd)
  end
end

local function manageEditorWidth(to)
  local count = vim.v.count ~= 0 and vim.v.count or 1
  local cmd = (to == "increase") and "workbench.action.increaseViewWidth" or "workbench.action.decreaseViewWidth"
  for _ = 1, count do
    vscode.action(cmd)
  end
end

-- which-key-vscode
r.noremap({ "n", "x" }, "<LocalLeader>", function()
  vscode.call('whichkey.show')
end, "Show Which Key")

-- Tab Navigation
r.noremap("n", "<tab>", "<cmd>Tabnext<cr>", "Next Tab")
r.noremap("n", "<s-tab>", "<cmd>Tabprevious<cr>", "Previous Tab")

-- Window Movement (overwriting the default keybindings to move the editor focus)
r.noremap("n", "<C-w>h", function()
  vscode.action('workbench.action.moveEditorToLeftGroup')
end, "Move editor to Left Window")
r.noremap("n", "<C-w>j", function()
  vscode.action('workbench.action.moveEditorToBelowGroup')
end, "Move editor to Below Window")
r.noremap("n", "<C-w>k", function()
  vscode.action('workbench.action.moveEditorToAboveGroup')
end, "Move editor to Above Window")
r.noremap("n", "<C-w>l", function()
  vscode.action('workbench.action.moveEditorToRightGroup')
end, "Move editor to Right Window")
r.noremap("n", "<C-w>m", function()
  vscode.action('workbench.action.toggleEditorWidths')
end, "Toggle Editor Widths")
r.noremap("n", "<C-w>p", function()
  vscode.action('workbench.action.toggleMaximizedPanel')
end, "Toggle Maximized Panel")

r.noremap("n", "<C-w><S-q>", function() -- Close the all other editor in group
  vscode.action("workbench.action.closeOtherEditors")
end, "Close Other Editors")

-- Window Sizing
r.noremap("n", "<Up>", function() manageEditorHeight("increase") end,
  "Increase Window Height")
r.noremap("n", "<Down>", function() manageEditorHeight("decrease") end,
  "Decrease Window Height")
r.noremap("n", "<Left>", function() manageEditorWidth("decrease") end,
  "Decrease Window Width")
r.noremap("n", "<Right>", function() manageEditorWidth("increase") end,
  "Increase Window Width")


r.noremap("n", "<Leader>ff", function() -- Find in files for word under cursor
  vscode.action("workbench.action.findInFiles", {
    args = { query = vim.fn.expand('<cword>') }
  })
end, "Find in Files for Word Under Cursor")

r.noremap("v", "<Leader>ff", function() -- Find in files for word under cursor
  vscode.action("workbench.action.findInFiles", {
    args = { query = r.get_visual_selection() }
  })
end, "Find in Files for Visual Selection")

-- Harpoon file navigation
r.noremap("n", "<Leader>he", function()
  vscode.action('vscode-harpoon.editEditors')
end, "Edit Harpoon Editors")
r.noremap("n", "<Leader>ha", function()
  vscode.action('vscode-harpoon.addEditor')
end, "Add Harpoon Editor")
r.noremap("n", "<Leader>hl", function()
  vscode.action('vscode-harpoon.EditorQuickPick')
end, "List and Select Harpoon Editors")
r.noremap("n", "<Leader>hj", function()
  vscode.action('vscode-harpoon.gotoPreviousHarpoonEditor')
end, "Go to Previous Harpoon Editor")



-- Action
-- r.noremap({ "n", "x" }, "<leader>aR", function()
--   vscode.with_insert(function()
--     vscode.action("editor.action.refactor")
--   end)
-- end)
