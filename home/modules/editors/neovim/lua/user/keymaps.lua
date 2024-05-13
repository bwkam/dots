local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":m '>+1<CR>gv=gv", opts)
keymap("x", "K", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- NvimTree --
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>f", ":Format<CR>", opts)

-- Misc --
keymap("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", opts)
keymap("n", "<leader>z", "<cmd>ZenMode<CR>", opts)

-- hover
-- keymap("n", "K", require("hover").hover, { desc = "hover.nvim" })
-- keymap("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
-- keymap("n", "<C-p>", function()
-- 	require("hover").hover_switch("previous")
-- end, { desc = "hover.nvim (previous source)" })
-- keymap("n", "<C-n>", function()
-- 	require("hover").hover_switch("next")
-- end, { desc = "hover.nvim (next source)" })

-- Mouse support
-- keymap("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
vim.o.mousemoveevent = true

-- nvim-ufo
keymap("n", "zR", require("ufo").openAllFolds)
keymap("n", "zM", require("ufo").closeAllFolds)

vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format {async = true}' ]])
