return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"leafOfTree/vim-svelte-plugin",
	},
	config = function()
		local svelte = require("nvim-treesitter.configs")

		svelte.setup({
			ensure_installed = { "svelte", "typescript", "javascript" },
			highlight = { enable = true },
		})
	end,
}
