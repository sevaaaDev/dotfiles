local M = {
	"hrsh7th/nvim-cmp",
	commit = "5dce1b778b85c717f6614e3f4da45e9f19f54435",
	dependencies = {
		{
			"hrsh7th/cmp-buffer",
			commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
		},
		{
			"hrsh7th/cmp-path",
			commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
		},
		{
			"saadparwaiz1/cmp_luasnip",
			commit = "18095520391186d634a0045dacaa346291096566",
		},
		{
			"L3MON4D3/LuaSnip",
			commit = "9bff06b570df29434a88f9c6a9cea3b21ca17208",
			event = "InsertEnter",
			dependencies = {
				"rafamadriz/friendly-snippets",
				commit = "a6f7a1609addb4e57daa6bedc300f77f8d225ab7",
			},
		},
		{
			"hrsh7th/cmp-nvim-lua",
			commit = "f3491638d123cfd2c8048aefaf66d246ff250ca6",
		},
		{
			"hrsh7th/cmp-cmdline",
			commit = "8ee981b4a91f536f52add291594e89fb6645e451",
		},
	},
	event = {
		"InsertEnter",
		"CmdlineEnter",
	},
}

function M.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	require("luasnip/loaders/from_vscode").lazy_load()

	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	local kind_icons = {
		Text = "󰉿",
		Method = "m",
		Function = "󰊕",
		Constructor = "",
		Field = "",
		Variable = "󰆧",
		Class = "󰌗",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "󰎠",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "󰏘",
		File = "󰈙",
		Reference = "",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰇽",
		Struct = "",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "󰊄",
		Codeium = "󰚩",
		Copilot = "",
	}

	cmp.setup({
		enabled = function()
			local buftype = vim.api.nvim_buf_get_option(0, "buftype")
			local context = require("cmp.config.context")
			if buftype == "prompt" then
				return false
			end
			if vim.api.nvim_get_mode().mode == "c" then
				return true
			else
				return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
			end
		end,

		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<Tab>"] = cmp.mapping.confirm({ select = true }),
			--[[ ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }), ]]
			--
			--[[ ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }), ]]
			--
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = kind_icons[vim_item.kind]
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					nvim_lua = "",
					luasnip = "[Snip]",
					buffer = "[Bfr]",
					path = "",
					emoji = "",
				})[entry.source.name]
				return vim_item
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "neorg" },
			{ name = "buffer" },
			{ name = "path" },
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		experimental = {
			ghost_text = false,
		},
		cmp.setup.filetype("html", {
			sources = {
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "buffer" },
				{ name = "path" },
			},
		}),
		cmp.setup.filetype("css", {
			sources = {
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "buffer" },
				{ name = "path" },
			},
		}),
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "path" },

				{ name = "cmdline" },
			},
		}),
	})
end

return M
