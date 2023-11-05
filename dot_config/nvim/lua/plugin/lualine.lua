local M = {
	"nvim-lualine/lualine.nvim",
	commit = "45e27ca739c7be6c49e5496d14fcf45a303c3a63",
	event = "BufEnter",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true, commit = "3af745113ea537f58c4b1573b64a429fefad9e07" },
		{ "nvim-lua/plenary.nvim", lazy = true, commit = "50012918b2fc8357b87cff2a7f7f0446e47da174" },
	},
}

function M.config()
	local status_ok, lualine = pcall(require, "lualine")
	if not status_ok then
		return
	end
	local colors = {
		black = "#1e1e2e",
		white = "#cdd6f4",
		red = "#f38ba8",
		green = "#a6e3a1",
		blue = "#74c7ec",
		purple = "#ca9ee6",
		gray = "#313244",
		darkgray = "#050515",
		lightgray = "#45475a",
		inactivegray = "#7c6f64",
	}
	local tes = {
		normal = {
			a = { bg = colors.purple, fg = colors.darkgray, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.purple },
			c = { bg = colors.darkgray, fg = colors.white },
			y = { bg = colors.lightgray, fg = colors.purple },
			z = { bg = colors.purple, fg = colors.black, gui = "bold" },
		},
		insert = {
			a = { bg = colors.darkgray, fg = colors.blue, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.blue },
			c = { bg = colors.darkgray, fg = colors.white },
			y = { bg = colors.lightgray, fg = colors.blue },
			z = { bg = colors.blue, fg = colors.black, gui = "bold" },
		},
		visual = {
			a = { bg = colors.darkgray, fg = colors.green, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.green },
			c = { bg = colors.darkgray, fg = colors.white },
			y = { bg = colors.lightgray, fg = colors.green },
			z = { bg = colors.green, fg = colors.black, gui = "bold" },
		},
		replace = {
			a = { bg = colors.darkgray, fg = colors.red, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.red },
			c = { bg = colors.darkgray, fg = colors.white },
			y = { bg = colors.lightgray, fg = colors.red },
			z = { bg = colors.red, fg = colors.black, gui = "bold" },
		},
		command = {
			a = { bg = colors.darkgray, fg = colors.gray, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.gray },
			c = { bg = colors.darkgray, fg = colors.white },
			y = { bg = colors.lightgray, fg = colors.gray },
			z = { bg = colors.gray, fg = colors.black, gui = "bold" },
		},
		inactive = {
			a = { bg = colors.black, fg = colors.lightgray, gui = "bold" },
			b = { bg = colors.black, fg = colors.lightgray },
			c = { bg = colors.black, fg = colors.lightgray },
		},
	}

	lualine.setup({
		options = {
			component_separators = "|",
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "packer", "NvimTree" },
			theme = tes,
		},
		sections = {
			lualine_a = {
				{ "mode", icon = { "", align = "left" } },
			},
			-- lualine_b = {'buffers'},
			lualine_b = {
				"branch",
			},
			lualine_c = {
				{
					"filename",
					file_status = true, -- Displays file status (readonly status, modified status)
					symbols = {
						modified = "", -- Text to show when the file is modified.
						readonly = "󰌾", -- Text to show when the file is non-modifiable or readonly.
						unnamed = "[No Name]", -- Text to show for unnamed buffers.
						newfile = "[New]", -- Text to show for newly created file before first write
					},
				},
				"diagnostics",
			},
			lualine_x = { { "filetype", icon_only = true } },
		},

		winbar = {
			lualine_c = { "buffers" },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "buffers" },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	})
end

return M
