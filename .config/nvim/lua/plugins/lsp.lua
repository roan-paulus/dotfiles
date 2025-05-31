-- LSP Configuration & Plugins
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", opts = {} },

		-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		{ "folke/neodev.nvim", opts = {} },

		-- Rust tools for debugger/lsp and formatters
		{
			"mrcjkb/rustaceanvim",
			version = "^4",
			lazy = false, -- This plugin is already lazy
			init = function()
				vim.g.rustaceanvim = {
					tools = {
						enable_clippy = true,
					},
					server = {
						default_settings = {
							["rust-analyzer"] = {},
						},
					},
				}
			end,
		},
	},
	config = function()
		vim.diagnostic.config({
			underline = true,
			virtual_text = false,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ss", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>r", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>a", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					-- [[ Autocmd version of the above ]]
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end

				if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		local servers = {
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = { "W391", "E741" },
							},
						},
					},
				},
			},
			-- hls = {
			-- 	settings = {
			-- 		{
			-- 			haskell = {
			-- 				cabalFormattingProvider = "cabalfmt",
			-- 				formattingProvider = "stylish-haskell",
			-- 			},
			-- 		},
			-- 	},
			-- },
			lua_ls = {
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
							-- Make sure love2d is able to be found by the lsp
							library = { "${3rd}/love2d/library" },
						},
						telemetry = { enable = false },
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = { disable = { "missing-fields", "lowercase-global" } },
						format = {
							enable = false,
						},
					},
				},
			},
			ts_ls = {},
			jsonls = {},
		}
		require("mason").setup()
		local ensure_installed = vim.tbl_keys(servers or {})
		ensure_installed.hls = nil
		vim.list_extend(ensure_installed, {
			"stylua", -- lua formatter
			-- "rustfmt", Deprecated, install via rustup instead
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for tsserver)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
