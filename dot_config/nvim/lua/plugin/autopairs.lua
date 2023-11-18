local M = {
	"windwp/nvim-autopairs",
	commit = "3b664e8277c36accec37f43414d85a3b64feba5f",
	event = "InsertEnter",
}

function M.config()
	require("nvim-autopairs").setup({
		check_ts = true, -- treesitter integration
		disable_filetype = { "TelescopePrompt", "CSS" },
		ts_config = {
			lua = { "string", "source" },
			javascript = { "string", "template_string" },
			java = false,
		},
		fast_wrap = {
			map = "<M-e>",
			chars = { "{", "[", "(", '"', "'", "`" },
			pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
			offset = 0, -- Offset from pattern match
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			highlight = "PmenuSel",
			highlight_grey = "LineNr",
		},
	})
end

return M
