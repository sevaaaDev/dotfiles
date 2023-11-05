local M = {
	"kylechui/nvim-surround",
	commit = "1c2ef599abeeb98e40706830bcd27e90e259367a",
	event = "BufReadPre",
	config = function()
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
		})
	end,
}

return M
