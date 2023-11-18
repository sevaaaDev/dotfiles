local M = {
	"neovim/nvim-lspconfig",
	commit = "649137cbc53a044bffde36294ce3160cb18f32c7",
	lazy = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
			commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef",
		},
	},
}

function M.config()
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
	local function lsp_keymaps(bufnr)
		local function keymap(buf, mode, lhs, rhs, opts)
			opts = opts or {}
			opts.noremap = true
			opts.silent = true
			vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, opts)
		end
		keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Go to Declaration" })
		keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition" })
		keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
		keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Implementation" })
		keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "References" })
		keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Diagnostic open float" })
		keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code action" })
		keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LspInfo" })
		keymap(bufnr, "n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason" })
		keymap(
			bufnr,
			"n",
			"<leader>lj",
			"<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>",
			{ desc = "Go to next diagnostic" }
		)
		keymap(
			bufnr,
			"n",
			"<leader>lk",
			"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
			{ desc = "Go to prev diagnostic" }
		)
		keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Lsp Rename" })
		keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Lsp Signature" })
		keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Lsp Setloclist" })
	end

	local lspconfig = require("lspconfig")
	local on_attach = function(client, bufnr)
		lsp_keymaps(bufnr)
	end
	for _, server in pairs(require("lsp-server").servers) do
		Opts = {
			on_attach = on_attach,
			capabilities = capabilities,
		}

		server = vim.split(server, "@")[1]

		local require_ok, conf_opts = pcall(require, "settings." .. server)
		if require_ok then
			Opts = vim.tbl_deep_extend("force", conf_opts, Opts)
		end

		lspconfig[server].setup(Opts)
	end
	lspconfig.emmet_ls.setup({
		-- on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"eruby",
			"html",
			"javascriptreact",
			"less",
			"sass",
			"scss",
			"svelte",
			"pug",
			"typescriptreact",
			"vue",
		},
		init_options = {
			html = {
				options = {
					-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
					["bem.enabled"] = true,
				},
			},
		},
	})

	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = true,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
			suffix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "single",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

return M
