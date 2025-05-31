local formatters_by_ft = {
	lua = { "stylua" },
	python = { "isort", "black" },
	rust = { "rustfmt" },
	haskell = { "stylish-haskell" },
	json = { "prettier", "jq", stop_after_first = true },
}

for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
	formatters_by_ft[language] = { "prettier", "prettierd", stop_after_first = true }
end

return {
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters = {
			-- Disable using cabal file. I noticed at 30-03-2025 this is incompatible with -
			-- a version higher then 2.4. Although setting a file to this fixes it, it's still inconvenient.
			fourmolu = { args = "--no-cabal" },
		},
		formatters_by_ft = formatters_by_ft,
	},
}
