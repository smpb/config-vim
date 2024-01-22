--  __       __ __      __
-- |__.-----|__|  |_   |  .--.--.---.-.
-- |  |     |  |   _|__|  |  |  |  _  |
-- |__|__|__|__|____|__|__|_____|___._|
--

-- ========[ LOAD VIMRC ]========

vim.cmd([[
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath

  source ~/.vimrc
]])


-- ========[ NEOVIDE SETTINGS ]========

-- allow the use of Cmd on macOS
vim.g.neovide_input_use_logo = 1

-- map <D-a> to select all
vim.api.nvim_set_keymap('t', '<D-a>', 'ggVG',    { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-a>', 'ggVG',    { noremap = true, silent = true })

-- map <D-c> to copy to system clipboard
vim.api.nvim_set_keymap('n', '<D-c>', '"+y<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-c>', '"+y<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-c>', '"+y<CR>', { noremap = true, silent = true })

-- map <D-x> to cut to system clipboard
vim.api.nvim_set_keymap('n', '<D-x>', '"+d<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-x>', '"+d<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-x>', '"+d<CR>', { noremap = true, silent = true })

-- map <D-v> to paste from system clipboard
vim.api.nvim_set_keymap('n', '<D-v>', '"+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '"+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '"+p<CR>', { noremap = true, silent = true })

