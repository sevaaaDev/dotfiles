local M = {
	"mfussenegger/nvim-lint",
	commit = "67f74e630a84ecfa73a82783c487bdedd8cecdc3",
	event = "BufReadPre",
	-- enabled = false
}

function M.config()
	require("lint").linters_by_ft = {
		javascript = { "eslint_d" },
	}
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		callback = function()
			require("lint").try_lint()
		end,
	})
end

return M
