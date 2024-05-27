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


-- ========[ PLUGIN SETTINGS ]========

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazyplugins = {
  -- git
  { 'airblade/vim-gitgutter' },

  -- interface and color
  { 'joshdick/onedark.vim' },
  { 'vim-airline/vim-airline' },

  -- code syntax and tags
  { 'dense-analysis/ale' },
  { 'ntpeters/vim-better-whitespace' },
  { 'preservim/tagbar' },
  { 'tpope/vim-commentary' },
  { 'wellle/context.vim' },

  -- text and related objects
  { 'tpope/vim-characterize' },
  { 'tpope/vim-sleuth'   },
  { 'tpope/vim-surround' },

  -- file management
  { 'ctrlpvim/ctrlp.vim' },
  { 'preservim/nerdtree' },

  -- llm
  {
    "dustinblackman/oatmeal.nvim",
    opts = {
      backend = "ollama",
      model = "codellama:latest",
    },
  },
}

require('lazy').setup(lazyplugins, {
  defaults = {
    lazy = false,
  },
})


-- ========[ NEOVIM SETTINGS ]========

-- open terminal below all splits
vim.api.nvim_set_keymap('n', '<Leader>t', ':split<BAR>terminal<CR><C-w>J:resize 15<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>o', ':Oatmeal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>o', ':Oatmeal<CR>', { noremap = true, silent = true })


-- ========[ NEOVIDE SETTINGS ]========

if vim.g.neovide then
  -- allow the use of Cmd on macOS
  vim.g.neovide_input_use_logo = true

  -- interprets <Alt+whatever> as <M-whatever>
  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

  -- hide mouse when typing
  vim.g.neovide_hide_mouse_when_typing = true

  -- use the window size from the previous session
  vim.g.neovide_remember_window_size = true

  -- produce particles behind the cursor
  vim.g.neovide_cursor_vfx_mode = "torpedo"
end

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
vim.api.nvim_set_keymap('i', '<D-v>', '<ESC>"+pi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<D-v>', '"+p<CR>',   { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '"+p<CR>',   { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '"+p<CR>',   { noremap = true, silent = true })

