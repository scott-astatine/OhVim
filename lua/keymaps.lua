local keymap = vim.api.nvim_set_keymap
local ops = { noremap = true, silent = true }


keymap('n', 'Space', '<NOP>', ops)

vim.g.mapleader = ' '

keymap('n', '<Leader>h', ':set hlsearch!<CR>', ops)
keymap('n', '<Leader>s', ':w<CR>', ops)
keymap('n', '<Leader>q', ':q<CR>', ops)
keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', ops)
keymap('n', '<Leader>e', ':NvimTreeFocus<CR>', ops)
keymap('n', '<Leader>x', ':', ops)

-- Telescope
keymap('n', '<Leader>ff', ':Telescope find_files<CR>', ops)
keymap('n', '<Leader>gl', ':Telescope live_grep<CR>', ops)

-- Window navigation
keymap('n', '<C-h>', '<C-w>h', ops)
keymap('n', '<C-j>', '<C-w>j', ops)
keymap('n', '<C-k>', '<C-w>k', ops)
keymap('n', '<C-l>', '<C-w>l', ops)

-- Kommentry
vim.api.nvim_set_keymap("n", "<leader>cl", "<Plug>kommentary_line_increase", {})
vim.api.nvim_set_keymap("n", "<leader>ci", "<Plug>kommentary_motion_increase", {})
vim.api.nvim_set_keymap("x", "<leader>cl", "<Plug>kommentary_visual_increase", {})
vim.api.nvim_set_keymap("n", "<leader>cdc", "<Plug>kommentary_line_decrease", {})
vim.api.nvim_set_keymap("n", "<leader>cd", "<Plug>kommentary_motion_decrease", {})
vim.api.nvim_set_keymap("x", "<leader>cd", "<Plug>kommentary_visual_decrease", {})

-- Buffer nav
keymap('n', 'L', ':bnext<CR>', ops)
keymap('n', 'H', ':bprevious<CR>', ops)
keymap('n', '<Leader>bp', ':bprevious<CR>', ops)
keymap('n', '<Leader>bn', ':bnext<CR>', ops)
keymap('n', '<Leader>bl', ':Telescope buffers<CR>', ops)
keymap('n', '<Leader>bc', ':bdelete<CR>', ops)

keymap('i', '<expr><TAB>', 'pumvisible() ? \"\\<C-n>\" : \\"<TAB>\"', ops)

keymap('n', '<', '<gv', ops)
keymap('n', '>', '>gv', ops)
keymap('v', '<', '<gv', ops)
keymap('v', '>', '>gv', ops)

keymap('i', 'jk', '<ESC>', ops)
keymap('i', 'kj', '<ESC>', ops)
keymap('i', 'jj', '<ESC>', ops)

