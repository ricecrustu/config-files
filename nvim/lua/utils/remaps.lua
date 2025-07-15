local keymap = vim.keymap
local check_duplicates = require("utils.duplicates").check_duplicates

local KeymapUtils = {}
-- local deferred_wk_mappings = {}

-- Helper to register mappings with which-key lazily
-- local function register_deferred_wk(input)
--   table.insert(deferred_wk_mappings, input)
-- end

-- local function add_wk_mapping(input)
--   local wk_ready, wk = pcall(require, "which-key")
--   if wk_ready and wk.did_setup then
--     if next(deferred_wk_mappings) ~= nil then
--       register_deferred_wk(input)
--       wk.add(deferred_wk_mappings)
--       deferred_wk_mappings = {}
--     else
--       wk.add(input)
--     end
--   else
--     register_deferred_wk(input)
--   end
-- end

--- Main mapping function
--- @param mode string | table: keymap mode(s), e.g. "n" or {"n", "v"}
--- @param lhs string: keys to bind
--- @param rhs string | function: command or callback
--- @param desc string | nil: description
--- @param opts table | nil: additional vim options
function KeymapUtils.map(mode, lhs, rhs, desc, opts)
  local options = { remap = true, desc = desc }
  if opts then
    options = vim.tbl_deep_extend("force", options, opts)
  end
  keymap.set(mode, lhs, rhs, options)
  check_duplicates(mode, lhs, desc)
end

--- Non-recursive mapping
function KeymapUtils.noremap(mode, lhs, rhs, desc, opts)
  local options = { remap = false, desc = desc }
  if opts then
    options = vim.tbl_deep_extend("force", options, opts)
  end
  KeymapUtils.map(mode, lhs, rhs, desc, options)
end

--- Register a virtual mapping or which-key hint
-- function KeymapUtils.map_virtual(input)
--   add_wk_mapping(input)
-- end

--- Flush deferred which-key mappings explicitly (optional)
-- function KeymapUtils.flush_wk()
--   local wk_ready, wk = pcall(require, "which-key")
--   if wk_ready and next(deferred_wk_mappings) ~= nil then
--     wk.add(deferred_wk_mappings)
--     deferred_wk_mappings = {}
--   end
-- end


function KeymapUtils.get_visual_selection()
  return table.concat(vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos(".")), "\n")
end


return KeymapUtils
