return {
  'stevearc/aerial.nvim',

  lazy = true,
  cmd = { 'AerialToggle', 'AerialNavToggle', 'AerialInfo' },

  -- configuration
  config = function()
    require('aerial').setup({
      filter_kind = false,
      nav = {
        autojump = true
      }
    })

    -- keymaps
    vim.keymap.set('n', '<Leader>.', '<CMD>AerialToggle<CR>')
    vim.keymap.set('n', '<Leader>>', '<CMD>AerialNavToggle<CR>')
  end
}
