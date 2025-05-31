return {
	-- Indentation guides
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = { scope = { enabled = false } } },
	-- Tab width/Whitespace based on file
	{ "tpope/vim-sleuth" },
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = {
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "s",
				normal_cur = "ss",
				normal_line = "S",
				normal_cur_line = "SS",
				visual = "s",
				visual_line = "S",
				delete = "ds",
				change = "cs",
				change_line = "cS",
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "┃" },
				topdelete = { text = "┃" },
				changedelete = { text = "┃" },
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			toggler = {
				line = "<leader>cc",
				block = "<leader>cb",
			},
			opleader = {
				line = "<leader>cc",
				block = "<leader>cb",
			},
			extra = {
				above = "<leader>cO",
				below = "<leader>co",
				eol = "<leader>cA",
			},
		},
	},
	-- Git wrapper
	{ "tpope/vim-fugitive" },
	{
		-- Context scrolls with you
		"nvim-treesitter/nvim-treesitter-context",
		opts = {},
		init = function()
			local ts_context = require("treesitter-context")

			vim.keymap.set("n", "<leader>tc", ts_context.toggle, { desc = "[T]oggle [C]ontext" })
			vim.keymap.set("n", "[c", function()
				ts_context.go_to_context(vim.v.count1)
			end, { silent = true })
		end,
	},
}
