local formatters_by_ft = {
	lua = { "stylua" },
	python = { "isort", "black" },
	rust = { "rustfmt" },
	haskell = { "stylish-haskell" },
	json = { "prettier", "jq", stop_after_first = true },
}

local js_formatters = { "prettier" }

for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
	formatters_by_ft[language] = js_formatters
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
		formatters = {},
		formatters_by_ft = formatters_by_ft,
	},
}
