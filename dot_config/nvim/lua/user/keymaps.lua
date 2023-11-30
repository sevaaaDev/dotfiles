local function keymap(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = true
	opts.silent = true
	vim.keymap.set(mode, lhs, rhs, opts)
end
local term_opts = { silent = true }
--Remap space as leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
-- Normal --
-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- keymap("i", "/", function()
-- 	if vim.o.filetype == "lua" then
-- 		print("u are in lua")
-- 		return "//<Left>"
-- 	else                            -- cool feature
-- 		print("u are not in lua")
-- 	end
-- end, { expr = true })

keymap("n", "<leader>pv", ":Ex <cr>", { desc = "Open netrw" })

keymap("n", "<c-d>", "<c-d>zz", { desc = "down a half screen" })
keymap("n", "<c-u>", "<c-u>zz", { desc = "up a half screen" })
-- Navigating thru word wrapped line
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "resize up" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "resize down" })
keymap("n", "<C-Left>", ":vertical resize +2<CR>", { desc = "resize left" })
keymap("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "resize right" })

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", { desc = "go right buffers" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "go left buffers" })

-- Delete buffers
keymap("n", "<leader>bd", ":Bd<cr>", { desc = "delete buffer" })

-- Move text up and down
-- keymap("n", "<space><c-j>", ":m .+1<CR>==", opts)
-- keymap("n", "<c-k>", ":m .-2<CR>==", opts)

-- Easy write file
keymap("n", "<leader>w", ":w<cr>", { desc = "write" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^")
keymap("v", ">", ">gv^")

-- Move text up and down
-- keymap("v", "<c-J>", ":m '>+1<CR>gv=gv", opts)
-- keymap("v", "<c-K>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', { desc = "dont take deleted word to register" })

-- Visual Block --
-- Move text up and down
-- keymap("x", "J", ":m '>+1<CR>gv=gv", opts)
-- keymap("x", "K", ":m '<-2<CR>gv=gv", opts)
-- keymap("x", "<c-J>", ":m '>+1<CR>gv=gv", opts)
-- keymap("x", "<c-K>", ":m '<-2<CR>gv=gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
