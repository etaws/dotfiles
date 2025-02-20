-- leader key 为空
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 本地变量
local map = vim.api.nvim_set_keymap

local opt = {
	noremap = true,
	silent = true,
}

local pluginKeys = {}

-- map("n", "<leader>gf", "<cmd>Neoformat<CR>", opt)
-- map("n", "<leader>hh", "<cmd>SymbolsOutline<CR>", opt)

map("n", "<C-l>", ":ls<CR>:b<Space>", opt)
map("n", "<C-k>", ":bd<CR>", opt)
map("n", "<F8>", ":ccl<CR>", opt)

return pluginKeys
