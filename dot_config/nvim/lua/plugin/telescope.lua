local M = {
	"nvim-telescope/telescope.nvim",
	commit = "40c31fdde93bcd85aeb3447bb3e2a3208395a868",
	event = "Bufenter",
	cmd = { "Telescope" },
	dependencies = {

		{ "nvim-lua/plenary.nvim", lazy = true, commit = "50012918b2fc8357b87cff2a7f7f0446e47da174" },
	},
}

function M.config()
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
	vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
	vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing [B]uffers" })
	vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Find [G]it [F]iles" })
	local actions = require("telescope.actions")
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			path_display = { "smart" },
			file_ignore_patterns = { ".git/", "node_modules", ".git\\" },
			mappings = {
				i = {
					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
			},
		},
		pickers = {
			find_files = {
				theme = "dropdown",
			},
			buffers = {
				theme = "cursor",
			},
		},
	})
end

return M
