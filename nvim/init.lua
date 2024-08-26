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

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazyplugins = {
  -- git
  { 'airblade/vim-gitgutter' },

  -- interface and color
  { 'navarasu/onedark.nvim' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- code syntax and tags
  { 'dense-analysis/ale' },
  { 'ntpeters/vim-better-whitespace' },
  {
    'nvim-treesitter/nvim-treesitter',
    build  = ':TSUpdate',
    config = function ()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        ensure_installed = {
          'bash', 'c', 'comment', 'css', 'csv', 'diff', 'dockerfile',
          'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
          'go', 'gomod', 'gosum', 'gotmpl', 'helm', 'html', 'http', 'javascript',
          'jq', 'json', 'lua', 'make', 'perl', 'php', 'regex', 'sql', 'ssh_config',
          'tmux', 'toml', 'typescript', 'vim', 'vimdoc', 'xml', 'yaml'
        },
        sync_install     = false,
        highlight        = { enable = true },
        indent           = { enable = true },
      })
    end
  },
  { 'stevearc/aerial.nvim' },
  { 'tpope/vim-commentary' },
  { 'wellle/context.vim' },

  -- text and related objects
  { 'tpope/vim-characterize' },
  { 'tpope/vim-sleuth'   },
  { 'tpope/vim-surround' },

  -- file management
  { 'preservim/nerdtree' },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },

  -- llm
  {
    'dustinblackman/oatmeal.nvim',
    opts = {
      model      = 'llama3:latest',
      backend    = 'ollama',
      ollama_url = 'http://h.smpb.eu:11434',
    },
  },

  -- ui
  { 'nvim-tree/nvim-web-devicons', lazy = true },
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
  vim.g.neovide_cursor_vfx_mode = 'torpedo'
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


-- ========[ AERIAL SETTINGS ]========

require('aerial').setup({
  filter_kind = false,
  nav = {
    autojump = true
  }
})

vim.keymap.set('n', '<Leader>.', '<CMD>AerialToggle<CR>')
vim.keymap.set('n', '<Leader>>', '<CMD>AerialNavToggle<CR>')


-- ========[ ONEDARK SETTINGS ]========

require('onedark').setup({
  style = 'dark'
});
require('onedark').load();


-- ========[ LUALINE SETTINGS ]========

require('lualine').setup({
  options = {
    theme = 'onedark'
  }
});


-- ========[ TELESCOPE SETTINGS ]========

local tlscp = require('telescope')

-- load fzf-native extension
tlscp.load_extension('fzf')

-- load aerial extension
tlscp.load_extension('aerial')
vim.keymap.set('n', '<Leader>fs', tlscp.extensions.aerial.aerial, {})

-- find
vim.keymap.set('n', '<Leader>:',  '<CMD>Telescope command_history<CR>', {})
vim.keymap.set('n', '<Leader>/',  '<CMD>Telescope live_grep grep_open_files=true<CR>', {})
vim.keymap.set('n', '<Leader>fb', '<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>', {})
vim.keymap.set('n', '<Leader>ff', '<CMD>Telescope find_files<CR>', {})
vim.keymap.set('n', '<Leader>fg', '<CMD>Telescope live_grep<CR>', {})
vim.keymap.set('n', '<Leader>fr', '<CMD>Telescope oldfiles<CR>', {})
-- git
vim.keymap.set('n', '<Leader>gf', '<CMD>Telescope git_files<CR>', {})
vim.keymap.set('n', '<Leader>gc', '<CMD>Telescope git_commits<CR>', {})
vim.keymap.set('n', '<Leader>gs', '<CMD>Telescope git_status<CR>', {})
-- search
vim.keymap.set('n', '<Leader>s"', '<CMD>Telescope registers<CR>', {})
vim.keymap.set('n', '<Leader>sa', '<CMD>Telescope autocommands<CR>', {})
vim.keymap.set('n', '<Leader>sb', '<CMD>Telescope current_buffer_fuzzy_find<CR>', {})
vim.keymap.set('n', '<Leader>sc', '<CMD>Telescope command_history<CR>', {})
vim.keymap.set('n', '<Leader>sC', '<CMD>Telescope commands<CR>', {})
vim.keymap.set('n', '<Leader>sd', '<CMD>Telescope diagnostics<CR>', {})
vim.keymap.set('n', '<Leader>sD', '<CMD>Telescope diagnostics bufnr=0<CR>', {})
vim.keymap.set('n', '<Leader>sh', '<CMD>Telescope help_tags<CR>', {})
vim.keymap.set('n', '<Leader>sH', '<CMD>Telescope highlights<CR>', {})
vim.keymap.set('n', '<Leader>sj', '<CMD>Telescope jumplist<CR>', {})
vim.keymap.set('n', '<Leader>sk', '<CMD>Telescope keymaps<CR>', {})
vim.keymap.set('n', '<Leader>sl', '<CMD>Telescope loclist<CR>', {})
vim.keymap.set('n', '<Leader>sm', '<CMD>Telescope marks<CR>', {})
vim.keymap.set('n', '<Leader>sM', '<CMD>Telescope man_pages<CR>', {})
vim.keymap.set('n', '<Leader>so', '<CMD>Telescope vim_options<CR>', {})

