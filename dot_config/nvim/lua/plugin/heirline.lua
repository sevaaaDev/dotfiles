local M = {
	"rebelot/heirline.nvim",
	commit = "170e1b1fd7c11db00e46d802165fb277db601ae7",
	event = "BufEnter",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true, commit = "3af745113ea537f58c4b1573b64a429fefad9e07" },
	},
	-- enabled = false,
}
function M.config()
	local colors = {
		red = "#f38ba8",
		mauve = "#cba6f7",
		green = "#a6e3a1",
		peach = "#fab387",
		blue = "#89b4fa",
		white = "#cdd6f4",
		base = "#1e1e2e",
	}
	local utils = require("heirline.utils")
	local conditions = require("heirline.conditions")
	local ViMode = {
		init = function(self)
			self.mode = vim.fn.mode(1) -- :h mode()
		end,
		static = {
			mode_names = {
				["n"] = "NORMAL",
				["no"] = "OP-PENDING",
				["nov"] = "OP-PENDING",
				["noV"] = "OP-PENDING",
				["no\22"] = "OP-PENDING",
				["niI"] = "NORMAL",
				["niR"] = "NORMAL",
				["niV"] = "NORMAL",
				["nt"] = "NORMAL",
				["ntT"] = "NORMAL",
				["v"] = "VISUAL",
				["vs"] = "VISUAL",
				["V"] = "VISUAL",
				["Vs"] = "VISUAL",
				["\22"] = "VISUAL",
				["\22s"] = "VISUAL",
				["s"] = "SELECT",
				["S"] = "SELECT",
				["\19"] = "SELECT",
				["i"] = "INSERT",
				["ic"] = "INSERT",
				["ix"] = "INSERT",
				["R"] = "REPLACE",
				["Rc"] = "REPLACE",
				["Rx"] = "REPLACE",
				["Rv"] = "VIRT REPLACE",
				["Rvc"] = "VIRT REPLACE",
				["Rvx"] = "VIRT REPLACE",
				["c"] = "COMMAND",
				["cv"] = "VIM EX",
				["ce"] = "EX",
				["r"] = "PROMPT",
				["rm"] = "MORE",
				["r?"] = "CONFIRM",
				["!"] = "SHELL",
				["t"] = "TERMINAL",
			},
			mode_colors = {
				n = colors.mauve,
				i = colors.blue,
				v = colors.green,
				V = colors.green,
				["\22"] = colors.green,
				c = colors.white,
				s = colors.mauve,
				S = colors.mauve,
				["\19"] = colors.mauve,
				R = colors.red,
				r = colors.red,
				["!"] = colors.white,
				t = colors.white,
			},
		},
		{
			provider = "",
			hl = function(self)
				local mode = self.mode:sub(1, 1) -- get only the first mode character
				return { fg = self.mode_colors[mode], bold = true }
			end,
		},
		{
			provider = function(self)
				return "%2(" .. self.mode_names[self.mode] .. "%)"
			end,
			hl = function(self)
				local mode = self.mode:sub(1, 1) -- get only the first mode character
				return { fg = "black", bg = self.mode_colors[mode], bold = true }
			end,
		},
		{
			provider = " ",
			hl = function(self)
				local mode = self.mode:sub(1, 1) -- get only the first mode character
				return { fg = self.mode_colors[mode], bold = true }
			end,
		},
		update = {
			"ModeChanged",
			pattern = "*:*",
			callback = vim.schedule_wrap(function()
				vim.cmd("redrawstatus")
			end),
		},
	}
	local Git = {
		condition = conditions.is_git_repo,
		init = function(self)
			self.dict = vim.b.gitsigns_status_dict
		end,
		{
			provider = "",
			hl = {
				fg = colors.peach,
			},
		},
		{
			provider = function(self)
				return " " .. self.dict.head
			end,
			hl = {
				bg = colors.peach,
				fg = "black",
			},
		},
		{
			provider = "",
			hl = {
				fg = colors.peach,
			},
		},
	}
	local Filename = {
		provider = " %t",
	}
	local Divider = {
		provider = "%=",
	}
	local Fileicon = {
		provider = function()
			local filename = vim.api.nvim_buf_get_name(0)
			local extension = vim.fn.fnamemodify(filename, ":t:e")
			local icon =
				require("nvim-web-devicons").get_icon(vim.fn.fnamemodify(filename, ":t"), extension, { default = true })
			return icon
		end,
	}
	local Modified = {
		provider = "%m",
	}
	local Percentage = {
		{
			provider = "",
			hl = {
				fg = colors.peach,
			},
		},
		{
			provider = "%3p%%",
			hl = {
				bg = colors.peach,
				fg = "black",
			},
		},
		{
			provider = "",
			hl = {
				fg = colors.peach,
			},
		},
	}
	local LSPinfo = {
		condition = conditions.lsp_attached,
		provider = function()
			local clients = vim.lsp.get_active_clients()
			local clients_list = {}
			for _, client in pairs(clients) do
				table.insert(clients_list, client.name)
			end
			local name = table.concat(clients_list, ", ")
			return " [" .. name .. "] "
		end,
		hl = { fg = colors.mauve },
	}

	local Formatters = {
		condition = function(self)
			local next = next
			self.conform = require("conform")
			if next(self.conform.list_formatters()) == nil then
				return false
			end
			return true
		end,

		provider = function(self)
			local fmts = self.conform.list_formatters()
			local fmt_list = {}
			for _, fmt in pairs(fmts) do
				table.insert(fmt_list, fmt.name)
			end
			local name = table.concat(fmt_list, ", ")
			return "󰛗 [" .. name .. "] "
		end,

		hl = { fg = colors.green },
	}

	local Diagnostics = {

		condition = conditions.has_diagnostics,

		static = {
			error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
			warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
			info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
			hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
		},

		init = function(self)
			self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
			self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
			self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
			self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		end,

		update = { "DiagnosticChanged", "BufEnter" },
		{
			provider = " ",
		},
		{
			provider = function(self)
				-- 0 is just another output, we can decide to print it or not!
				return self.errors > 0 and (self.error_icon .. self.errors .. " ")
			end,
			hl = { fg = colors.red },
		},
		{
			provider = function(self)
				return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
			end,
			hl = { fg = colors.peach },
		},
		{
			provider = function(self)
				return self.info > 0 and (self.info_icon .. self.info .. " ")
			end,
			hl = { fg = colors.blue },
		},
		{
			provider = function(self)
				return self.hints > 0 and (self.hint_icon .. self.hints)
			end,
			hl = { fg = colors.blue },
		},
	}
	local buf = {
		provider = function()
			local num = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
			return "BufOpn : " .. num
		end,
	}
	local status = {
		ViMode,
		Git,
		Diagnostics,
		Divider,
		{ Fileicon, Filename, Modified },
		Divider,
		Formatters,
		LSPinfo,
		Percentage,
		hl = {
			bg = colors.base,
		},
	}
	local tabline = {
		Divider,
		buf,
		Divider,
	}
	require("heirline").setup({
		statusline = status,
		tabline = tabline,
	})
end

return M
