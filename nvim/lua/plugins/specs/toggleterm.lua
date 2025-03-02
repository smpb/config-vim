return {
  'akinsho/toggleterm.nvim',

  version = '*',
  lazy = false,
  cmd  = { 'ToggleTerm' },

  -- configuration
  config = function()
    require('toggleterm').setup({
      size            = 15,
      open_mapping    = [[<C-/>]],
      hide_numbers    = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor  = 0,
      start_in_insert = true,
      persist_size    = true,
      direction       = 'float',
      close_on_exit   = true,
      shell           = vim.o.shell,
      float_opts = {
        border = 'curved',
      },
    })

    -- keymaps
    vim.keymap.set('n', '<Leader>tt', '<CMD>ToggleTerm<CR>', { desc = 'Toggle terminal' })
  end
}
