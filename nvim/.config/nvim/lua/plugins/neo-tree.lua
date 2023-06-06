return {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
  cmd = 'Neotree',
	keys = {
		{
			'<leader>e',
			'<cmd>NeoTreeFocusToggle<CR>',
			desc = 'Toggle NeoTree Explorer',
		}
	},
}
