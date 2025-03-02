return {
  'nvim-telescope/telescope.nvim',

  branch = '0.1.x',
  dependencies = {
    {
      'nvim-lua/plenary.nvim'
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
  },

  -- configuration
  config = function()
    local tlscp = require('telescope')

    -- load fzf-native extension
    tlscp.load_extension('fzf')

    -- load aerial extension
    tlscp.load_extension('aerial')
    vim.keymap.set('n', '<Leader>fs', tlscp.extensions.aerial.aerial, {})

    -- keymaps: find
    vim.keymap.set('n', '<Leader>:',  '<CMD>Telescope command_history<CR>', {})
    vim.keymap.set('n', '<Leader>/',  '<CMD>Telescope live_grep grep_open_files=true<CR>', {})
    vim.keymap.set('n', '<Leader>fb', '<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>', {})
    vim.keymap.set('n', '<Leader>ff', '<CMD>Telescope find_files<CR>', {})
    vim.keymap.set('n', '<Leader>fg', '<CMD>Telescope live_grep<CR>', {})
    vim.keymap.set('n', '<Leader>fr', '<CMD>Telescope oldfiles<CR>', {})

    -- keymaps: git
    vim.keymap.set('n', '<Leader>gf', '<CMD>Telescope git_files<CR>', {})
    vim.keymap.set('n', '<Leader>gc', '<CMD>Telescope git_commits<CR>', {})
    vim.keymap.set('n', '<Leader>gs', '<CMD>Telescope git_status<CR>', {})

    -- keymaps: search
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
  end,
}
