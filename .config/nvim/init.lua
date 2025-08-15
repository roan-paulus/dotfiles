vim.g.python3_host_prog = "/usr/bin/python3.12"

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.opt.splitright = true
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.listchars = {
	tab = "  " --[[alternative value: "» "]],
	trail = "·",
	nbsp = "␣",
}
vim.opt.hlsearch = false
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.inccommand = "split"
vim.opt.cursorline = false
vim.opt.scrolloff = 10
vim.opt.splitbelow = true
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.number = true

vim.keymap.set("n", "<leader>gl", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "<leader>Y", "+Y")
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')

vim.keymap.set("i", "<C-c>", "<Esc>")

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
