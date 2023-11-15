return {
	"j-hui/fidget.nvim",
	tag = "legacy",
	event = "LspAttach",
	commit = "6c8274e13483de5782a5c6020a4fc837b81a7b49",
	opts = {

		notification = {
			override_vim_notify = true, -- Automatically override vim.notify() with Fidget

			window = {
				normal_hl = "Comment", -- Base highlight group in the notification window
				winblend = 0, -- Background color opacity in the notification window
				border = "none", -- Border around the notification window
				zindex = 45, -- Stacking priority of the notification window
				max_width = 0, -- Maximum width of the notification window
				max_height = 0, -- Maximum height of the notification window
				x_padding = 1, -- Padding from right edge of window boundary
				y_padding = 0, -- Padding from bottom edge of window boundary
				align_bottom = true, -- Whether to bottom-align the notification window
				relative = "editor", -- What the notification window position is relative to
			},
		},
	},
}
