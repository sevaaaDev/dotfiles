local M = {
	"rebelot/heirline.nvim",
	commit = "170e1b1fd7c11db00e46d802165fb277db601ae7",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true, commit = "3af745113ea537f58c4b1573b64a429fefad9e07" },
	},
	enabled = false,
}
function M.config()
	local utils = require("heirline.utils")
	local conditions = require("heirline.conditions")
	local ViMode = {
		-- get vim current mode, this information will be required by the provider
		-- and the highlight functions, so we compute it only once per component
		-- evaluation and store it as a component attribute
		init = function(self)
			self.mode = vim.fn.mode(1) -- :h mode()
		end,
		-- Now we define some dictionaries to map the output of mode() to the
		-- corresponding string and color. We can put these into `static` to compute
		-- them at initialisation time.
		static = {
			mode_names = { -- change the strings if you like it vvvvverbose!
				n = "N",
				no = "N?",
				nov = "N?",
				noV = "N?",
				["no\22"] = "N?",
				niI = "Ni",
				niR = "Nr",
				niV = "Nv",
				nt = "Nt",
				v = "V",
				vs = "Vs",
				V = "V_",
				Vs = "Vs",
				["\22"] = "^V",
				["\22s"] = "^V",
				s = "S",
				S = "S_",
				["\19"] = "^S",
				i = "I",
				ic = "Ic",
				ix = "Ix",
				R = "R",
				Rc = "Rc",
				Rx = "Rx",
				Rv = "Rv",
				Rvc = "Rv",
				Rvx = "Rv",
				c = "C",
				cv = "Ex",
				r = "...",
				rm = "M",
				["r?"] = "?",
				["!"] = "!",
				t = "T",
			},
			mode_colors = {
				n = "red",
				i = "green",
				v = "cyan",
				V = "cyan",
				["\22"] = "cyan",
				c = "orange",
				s = "purple",
				S = "purple",
				["\19"] = "purple",
				R = "orange",
				r = "orange",
				["!"] = "red",
				t = "red",
			},
		},
		-- We can now access the value of mode() that, by now, would have been
		-- computed by `init()` and use it to index our strings dictionary.
		-- note how `static` fields become just regular attributes once the
		-- component is instantiated.
		-- To be extra meticulous, we can also add some vim statusline syntax to
		-- control the padding and make sure our string is always at least 2
		-- characters long. Plus a nice Icon.
		provider = function(self)
			return " %2(" .. self.mode_names[self.mode] .. "%)"
		end,
		-- Same goes for the highlight. Now the foreground will change according to the current mode.
		hl = function(self)
			local mode = self.mode:sub(1, 1) -- get only the first mode character
			return { fg = self.mode_colors[mode], bold = true }
		end,
		-- Re-evaluate the component only on ModeChanged event!
		-- Also allows the statusline to be re-evaluated when entering operator-pending mode
		update = {
			"ModeChanged",
			pattern = "*:*",
			callback = vim.schedule_wrap(function()
				vim.cmd("redrawstatus")
			end),
		},
	}

	local FileNameBlock = {
		-- let's first set up some attributes needed by this component and it's children
		init = function(self)
			self.filename = vim.api.nvim_buf_get_name(0)
		end,
	}
	-- We can now define some children separately and add them later

	local FileIcon = {
		init = function(self)
			local filename = self.filename
			local extension = vim.fn.fnamemodify(filename, ":e")
			self.icon, self.icon_color =
				require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
		end,
		provider = function(self)
			return self.icon and (self.icon .. " ")
		end,
		hl = function(self)
			return { fg = self.icon_color }
		end,
	}

	local FileName = {
		provider = function(self)
			-- first, trim the pattern relative to the current directory. For other
			-- options, see :h filename-modifers
			local filename = vim.fn.fnamemodify(self.filename, ":.")
			if filename == "" then
				return "[No Name]"
			end
			-- now, if the filename would occupy more than 1/4th of the available
			-- space, we trim the file path to its initials
			-- See Flexible Components section below for dynamic truncation
			if not conditions.width_percent_below(#filename, 0.25) then
				filename = vim.fn.pathshorten(filename)
			end
			return filename
		end,
		hl = { fg = utils.get_highlight("Directory").fg },
	}

	local FileFlags = {
		{
			condition = function()
				return vim.bo.modified
			end,
			provider = "[+]",
			hl = { fg = "green" },
		},
		{
			condition = function()
				return not vim.bo.modifiable or vim.bo.readonly
			end,
			provider = "",
			hl = { fg = "orange" },
		},
	}

	-- Now, let's say that we want the filename color to change if the buffer is
	-- modified. Of course, we could do that directly using the FileName.hl field,
	-- but we'll see how easy it is to alter existing components using a "modifier"
	-- component

	local FileNameModifer = {
		hl = function()
			if vim.bo.modified then
				-- use `force` because we need to override the child's hl foreground
				return { fg = "cyan", bold = true, force = true }
			end
		end,
	}

	-- let's add the children to our FileNameBlock component
	FileNameBlock = utils.insert(
		FileNameBlock,
		FileIcon,
		utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
		FileFlags,
		{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
	)
	local status = {
		ViMode,
		FileNameBlock,
	}
	require("heirline").setup({
		statusline = status,
	})
end

return M