vim.g.python3_host_prog = "/usr/bin/python3.12"

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

local options = {
	-- Spaces/Tabs
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	softtabstop = 0,
	autoindent = true,
	smarttab = true,
	-- Gutter
	number = true,
	relativenumber = true,
	-- Other
	mouse = "a",
	breakindent = true,
	undofile = true,
	ignorecase = true,
	smartcase = true,
	signcolumn = "yes",
	updatetime = 250,
	splitright = true,
	splitbelow = true,
	-- Sets how neovim will display certain whitespace characters in the editor.,
	list = true,
	-- Preview substitutions live, as you type! (hightlight -> :s)
	inccommand = "split",
	cursorline = false,
	scrolloff = 10,
	hlsearch = false,
	listchars = {
		tab = "  " --[[alternative value: "» "]],
		trail = "·",
		nbsp = "␣",
	},
}

-- [[ Mode = keymap = { function_or_keysToPlay, description } ]]
local keymap_conf = {
	normal = {
		["<C-s>"] = {
			":w<Enter>",
			"Save current file",
		},
		["[d"] = {
			function()
				vim.diagnostic.jump({ count = -1, float = true })
			end,
			"Go to previous [D]iagnostic message",
		},
		["]d"] = {
			function()
				vim.diagnostic.jump({ count = 1, float = true })
			end,
			"Go to next [D]iagnostic message",
		},
		["<leader>e"] = {
			vim.diagnostic.open_float,
			"Show diagnostic [E]rror messages",
		},
		["<leader>q"] = {
			vim.diagnostic.setloclist,
			"Open diagnostic [Q]uickfix list",
		},
		["<leader>Y"] = { '"+Y' },
	},
	insert = {
		-- Make sure autocommands will fire when using ctrl-c to go to normal mode
		["<C-c>"] = {
			"<Esc>",
		},
	},
	normal_visual = {
		["<leader>y"] = { '"+y' },
		["<leader>d"] = { '"_d' },
	},
}

local function set_options(opts)
	for name, val in pairs(opts) do
		vim.opt[name] = val
	end
end

local function set_keymaps(conf)
	local mode_mapping = {
		normal = "n",
		insert = "i",
		normal_visual = { "n", "v" },
	}

	for mode_name, keyconf in pairs(conf) do
		for key_sequence, tail in pairs(keyconf) do
			local strOrFn = tail[1]
			local description = tail[2]

			local opts = nil
			if description then
				opts = { desc = description }
			end

			vim.keymap.set(mode_mapping[mode_name], key_sequence, strOrFn, opts)
		end
	end
end

set_options(options)
set_keymaps(keymap_conf)

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
