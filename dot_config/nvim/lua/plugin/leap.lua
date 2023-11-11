local M = {
	"ggandor/leap.nvim",
	commit = "b6ae80f8fc9993638608fc1a51c6ab0eeb12618c",
	enabled = false,
}

function M.config()
	local opt = require("leap").opts
	require("leap").add_default_mappings()
	opt.max_phase_one_targets = nil
	opt.highlight_unlabeled_phase_one_targets = false
	opt.max_highlighted_traversal_targets = 10
	opt.case_sensitive = false
	opt.equivalence_classes = { " \t\r\n" }
	opt.substitute_chars = {}
	opt.safe_labels = { "s", "f", "n", "u", "t" }
	opt.labels = { "s", "f", "n", "j", "k" }
	opt.special_keys = {
		next_target = "<enter>",
		prev_target = "<tab>",
		next_group = "<space>",
		prev_group = "<tab>",
		multi_accept = "<enter>",
		multi_revert = "<backspace>",
	}
end

return M
