return {
	{
		"sho-87/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"comfysage/evergarden",
		priority = 1000,
		opts = {
			theme = {
				variant = "fall", -- 'winter'|'fall'|'spring'
				accent = "green",
			},
			editor = {
				transparent_background = false,
				sign = { color = "none" },
				float = {
					color = "mantle",
					invert_border = false,
				},
				completion = {
					color = "surface0",
				},
			},
		},
	},
	{ "EdenEast/nightfox.nvim" },
}
