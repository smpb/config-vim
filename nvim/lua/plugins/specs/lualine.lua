return {
  'nvim-lualine/lualine.nvim',

  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },

  -- configuration
  config = function()
    require('lualine').setup({
      options = {
        theme = 'onedark',
        component_separators = {
          left  = '·',
          right = '·',
        },
        section_separators = {
          left  = '',
          right = '',
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnosticsl' },
        lualine_c = {
          {
            'buffers',
            mode = 0,
            symbols = {
              modified       = ' ●',
              directory      =  '',
              alternate_file = '',
            },
          },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
    });
  end
}
