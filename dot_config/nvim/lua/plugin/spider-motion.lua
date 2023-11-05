local M = {
	"chrisgrieser/nvim-spider",
	keys = {
		{ -- example for lazy-loading and keymap
			"e",
			"<cmd>lua require('spider').motion('e')<CR>",
			mode = { "n", "o", "x" },
		},
	},
	commit = "a12b9e8189d09f1670e6b58b0eecf1cecb97e41c",
}

function M.config()
	require("spider").setup({
		skipInsignificantPunctuation = false,
	})

	vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
	vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
	vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
	vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
end

return M
