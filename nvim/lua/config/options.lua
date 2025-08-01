local opt = vim.opt

-- General options
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.clipboard = "unnamedplus" -- Sync with system clipboard

opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals

opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.showmode = false -- Disable showing mode in command line
opt.linebreak = true -- Wrap lines at convenient points

opt.list = true -- Show some invisible characters (tabs...
opt.listchars = {
	tab = "▸ ", -- Character to show for tab
	trail = "·", -- Character to show for trailing spaces
	nbsp = "␣", -- Character to show for non-breaking space
}

opt.mouse = "a" -- Enable mouse mode
opt.termguicolors = true -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key

opt.undofile = true
opt.undolevels = 10000

opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

if vim.g.vscode then
	-- VSCode specific settings
else
	-- NeoVim settings
	-- opt.autowrite = true -- Enable auto write
	opt.cursorline = true -- Enable highlighting of the current line
	opt.completeopt = "menu,menuone,noselect"
	opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
	opt.expandtab = true -- Use spaces instead of tabs
	opt.foldlevel = 99
	-- opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
	-- opt.formatoptions = "jcroqlnt" -- tcqj
	opt.grepformat = "%f:%l:%c:%m"
	opt.grepprg = "rg --vimgrep"

	opt.shiftwidth = 4 -- The number of spaces inserted for each indentation (default: 8)
	opt.tabstop = 4 -- Insert n spaces for a tab (default: 8)
	opt.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations (default: 0)

	vim.wo.number = true -- Print line number
	opt.relativenumber = true -- Relative line numbers
	opt.pumblend = 10 -- Popup blend
	opt.pumheight = 10 -- Maximum number of entries in a popup

	opt.ruler = false -- Disable the default ruler
	opt.scrolloff = 10 -- Lines of context
	opt.smartindent = true -- Insert indents automatically

	opt.splitright = true -- Put new windows right of current
	opt.splitkeep = "screen"
	opt.splitbelow = true -- Put new windows below current

	opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
	opt.winminwidth = 5 -- Minimum window width
	opt.wildmode = "longest:full,full" -- Command-line completion mode
	opt.wrap = true -- line wrap
	opt.breakindent = true -- line wrap in respect to identation
	opt.textwidth = 80 -- Maximum width of text that is being inserted

	-- associate file types
	vim.filetype.add({
		extension = {
			log = "log",
		},
	})
end
