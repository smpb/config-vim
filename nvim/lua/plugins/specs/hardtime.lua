return {
  'm4xshen/hardtime.nvim',

  lazy = false,

  dependencies = {
    'MunifTanjim/nui.nvim', -- UI component library for Neovim.
  },

  -- configuration
  opts = {
    disable_mouse = false,
    disabled_keys = {
      ['<Up>']    = {},
      ['<Down>']  = {},
      ['<Left>']  = {},
      ['<Right>'] = {},
    },
  }
}
