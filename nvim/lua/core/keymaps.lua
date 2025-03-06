-- Global keymaps

-- open terminal below all splits
vim.api.nvim_set_keymap('n', '<Leader>t', ':split<BAR>terminal<CR><C-w>J:resize 15<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>ao', ':Oatmeal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>ao', ':Oatmeal<CR>', { noremap = true, silent = true })

-- map <D-a> to select all
vim.api.nvim_set_keymap('n', '<D-a>', 'ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-a>', 'ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-a>', 'ggVG', { noremap = true, silent = true })

-- map <D-c> to copy to system clipboard
vim.api.nvim_set_keymap('n', '<D-c>', '"+y<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-c>', '"+y<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-c>', '"+y<CR>', { noremap = true, silent = true })

-- map <D-x> to cut to system clipboard
vim.api.nvim_set_keymap('n', '<D-x>', '"+d<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-x>', '"+d<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-x>', '"+d<CR>', { noremap = true, silent = true })

-- map <D-v> to paste from system clipboard
vim.api.nvim_set_keymap('i', '<D-v>', [[<C-o>:lua require("core.functions").paste_in_insert_mode()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<D-v>', '"+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', [[<C-\><C-n>"+pa]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '"+p<CR>', { noremap = true, silent = true })
