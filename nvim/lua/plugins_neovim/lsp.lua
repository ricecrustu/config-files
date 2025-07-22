return {
	{
		"neovim/nvim-lspconfig",
        event = "VeryLazy",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "mason-org/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			-- mason-lspconfig:
			-- - Bridges the gap between LSP config names (e.g. "lua_ls") and actual Mason package names (e.g. "lua-language-server").
			-- - Used here only to allow specifying language servers by their LSP name (like "lua_ls") in `ensure_installed`.
			-- - It does not auto-configure servers — we use vim.lsp.config() + vim.lsp.enable() explicitly for full control.
			"mason-org/mason-lspconfig.nvim",
			-- mason-tool-installer:
			-- - Installs LSPs, linters, formatters, etc. by their Mason package name.
			-- - We use it to ensure all desired tools are present.
			-- - The `ensure_installed` list works with mason-lspconfig to resolve LSP names like "lua_ls".
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{
				"j-hui/fidget.nvim",
				opts = {
					notification = {
						window = {
							winblend = 0, -- Background color opacity in the notification window
						},
					},
				},
			},

			-- Allows extra capabilities provided by nvim-cmp
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				-- Create a function that lets us more easily define mappings specific LSP related items.
				-- It sets the mode, buffer and description for us each time.
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-T>.
					map("gd", require("snacks.picker").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gr", require("snacks.picker").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("snacks.picker").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("gy", require("snacks.picker").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ss", require("snacks.picker").lsp_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace
					--  Similar to document symbols, except searches over your whole project.
					map("<leader>sS", require("snacks.picker").lsp_workspace_symbols, "[W]orkspace [S]ymbols")

					-- Rename the variable under your cursor
					--  Most Language Servers support renaming across files, etc.
					map("<leader>cn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
					map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
					map("<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, "[W]orkspace [L]ist Folders")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							-- [vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			-- By default, Neovim doesn't support everything that is in the LSP specification.
			-- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			-- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

			-- Enable the following language servers
			--
			-- Add any additional override configuration in the following tables. Available keys are:
			-- - cmd (table): Override the default command used to start the server
			-- - filetypes (table): Override the default list of associated filetypes for the server
			-- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			-- - settings (table): Override the default settings passed when initializing the server.
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = vim.api.nvim_get_runtime_file("", true),
							},
							diagnostics = {
								globals = { "vim" },
								disable = { "missing-fields" },
							},
							format = {
								enable = false,
							},
						},
					},
				},
				basedpyright = {
					-- Config options: https://github.com/DetachHead/basedpyright/blob/main/docs/settings.md
					settings = {
						basedpyright = {
							disableOrganizeImports = true, -- Using Ruff's import organizer
							disableLanguageServices = false,
							analysis = {
								-- ignore = { "*" }, -- Ignore all files for analysis to exclusively use Ruff for linting
								typeCheckingMode = "standard",
								diagnosticMode = "openFilesOnly", -- Only analyze open files
								-- useLibraryCodeForTypes = true,
								autoImportCompletions = true, -- whether pyright offers auto-import completions
								autoSearchPaths = true,
							},
						},
					},
				},
				ruff = {},
				jsonls = {},
				-- sqlls = {},
				-- terraformls = {},
				yamlls = {},
				bashls = {},
				-- dockerls = {},
				-- docker_compose_language_service = {},
				-- tailwindcss = {},
				-- graphql = {},
				-- html = { filetypes = { "html", "twig", "hbs" } },
				-- cssls = {},
				-- ltex = {},
				-- texlab = {},
			}

			-- Ensure the servers and tools above are installed
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for server, cfg in pairs(servers) do
				-- For each LSP server (cfg), we merge:
				-- 1. A fresh empty table (to avoid mutating capabilities globally)
				-- 2. Your capabilities object with Neovim + cmp features
				-- 3. Any server-specific cfg.capabilities if defined in `servers`
				cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})

				vim.lsp.config(server, cfg)
				vim.lsp.enable(server)
			end
		end,
	},
	{ -- Autocompletion
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			-- Snippet Engine
		},
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		config = function()
			require("blink.cmp").setup({
				keymap = {
					-- 'default' (recommended) for mappings similar to built-in completions
					--   <c-y> to accept ([y]es) the completion.
					--    This will auto-import if your LSP supports it.
					--    This will expand snippets if the LSP sent a snippet.
					-- 'super-tab' for tab to accept
					-- 'enter' for enter to accept
					-- 'none' for no mappings
					--
					-- For an understanding of why the 'default' preset is recommended,
					-- you will need to read `:help ins-completion`
					--
					-- No, but seriously. Please read `:help ins-completion`, it is really good!
					--
					-- All presets have the following mappings:
					-- <tab>/<s-tab>: move to right/left of your snippet expansion
					-- <c-space>: Open menu or open docs if already open
					-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
					-- <c-e>: Hide menu
					-- <c-k>: Toggle signature help
					--
					-- See :h blink-cmp-config-keymap for defining your own keymap
					preset = "default",

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				},

				appearance = {
					-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = "mono",
				},

				completion = {
					-- By default, you may press `<c-space>` to show the documentation.
					-- Optionally, set `auto_show = true` to show the documentation after a delay.
					documentation = { auto_show = false, auto_show_delay_ms = 500 },
				},

				sources = {
					default = { "lsp", "path", "snippets" },
					providers = {
						-- lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
					},
				},

				-- snippets = { preset = "luasnip" },

				-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
				-- which automatically downloads a prebuilt binary when enabled.
				--
				-- By default, we use the Lua implementation instead, but you may enable
				-- the rust implementation via `'prefer_rust_with_warning'`
				--
				-- See :h blink-cmp-config-fuzzy for more information
				-- fuzzy = { implementation = "lua" },

				-- Shows a signature help window while you type arguments for a function
				-- signature = { enabled = true },
			})
		end,
	},
}
