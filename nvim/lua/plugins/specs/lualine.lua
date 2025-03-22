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
        },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          'mode',
          {
            function()
              return vim.o.paste and 'PASTE' or ''
            end,
            color = { gui = 'bold' },
          },
        },
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
        lualine_y = {
          {
            'lsp_status',
            symbols = {
              separator = ' · ',
            },
          },
        },
        lualine_z = { 'progress', 'location' }
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
