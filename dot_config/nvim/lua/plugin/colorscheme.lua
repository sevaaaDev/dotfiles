local M = {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
}

M.name = "catppuccin-mocha"

function M.config()
	local catppuccin = require("catppuccin")
	catppuccin.setup({
		flavour = "mocha",
		styles = {
			comments = { "italic" }, -- Change the style of comments
			conditionals = { "italic" },
			loops = { "italic" },
			functions = { "italic" },
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = { "italic" },
			types = {},
			operators = {},
		},
		color_overrides = {
			all = {
				text = "#ffffff",
			},
			latte = {},
			frappe = {},
			macchiato = {},
			mocha = {
				base = "#1e1e2e",
				overlay0 = "#6e738d",
				red = "#f67563",
			},
		},
		--   custom_highlights = function(C)
		-- 	return {
		-- 		CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
		-- 		CmpItemKindKeyword = { fg = C.base, bg = C.red },
		-- 		CmpItemKindText = { fg = C.base, bg = C.teal },
		-- 		CmpItemKindMethod = { fg = C.base, bg = C.blue },
		-- 		CmpItemKindConstructor = { fg = C.base, bg = C.blue },
		-- 		CmpItemKindFunction = { fg = C.base, bg = C.blue },
		-- 		CmpItemKindFolder = { fg = C.base, bg = C.blue },
		-- 		CmpItemKindModule = { fg = C.base, bg = C.blue },
		-- 		CmpItemKindConstant = { fg = C.base, bg = C.peach },
		-- 		CmpItemKindField = { fg = C.base, bg = C.green },
		-- 		CmpItemKindProperty = { fg = C.base, bg = C.green },
		-- 		CmpItemKindEnum = { fg = C.base, bg = C.green },
		-- 		CmpItemKindUnit = { fg = C.base, bg = C.green },
		-- 		CmpItemKindClass = { fg = C.base, bg = C.yellow },
		-- 		CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
		-- 		CmpItemKindFile = { fg = C.base, bg = C.blue },
		-- 		CmpItemKindInterface = { fg = C.base, bg = C.yellow },
		-- 		CmpItemKindColor = { fg = C.base, bg = C.red },
		-- 		CmpItemKindReference = { fg = C.base, bg = C.red },
		-- 		CmpItemKindEnumMember = { fg = C.base, bg = C.red },
		-- 		CmpItemKindStruct = { fg = C.base, bg = C.blue },
		-- 		CmpItemKindValue = { fg = C.base, bg = C.peach },
		-- 		CmpItemKindEvent = { fg = C.base, bg = C.blue },
		-- 		CmpItemKindOperator = { fg = C.base, bg = C.blue },
		-- 		CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
		-- 		CmpItemKindCopilot = { fg = C.base, bg = C.teal },
		-- 	}
		-- end,
	})
	local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
	if not status_ok then
		vim.notify("Colorscheme not found")
		return
	end
	vim.cmd([[:hi Normal guibg=none]])
end

return M
