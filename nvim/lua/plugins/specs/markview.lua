return {
  'OXY2DEV/markview.nvim',

  -- configuration
  config = function()
    require('markview').setup({
      preview = {
        filetypes = { 'codecompanion', 'helm', 'markdown', 'yaml' },
        ignore_buftypes = {},
        enable_hybrid_mode = true,
        hybrid_modes = { 'n', 'v' },
        linewise_hybrid_mode = false,
      },
      json = {
        enable = false,
      },
      markdown = {
        block_quotes = {
          wrap = false,
        },
        headings = {
          shift_width = 0,
          heading_1 = { style = 'label', icon = '󰬺 ' },
          heading_2 = { style = 'label', icon = '󰬻 ' },
          heading_3 = { style = 'label', icon = '󰬼 ' },
          heading_4 = { style = 'label', icon = '󰬽 ' },
          heading_5 = { style = 'label', icon = '󰬾 ' },
          heading_6 = { style = 'label', icon = '󰬿 ' },
        },
        list_items = {
          marker_minus = {
            add_padding = false,
            text = '•',
          },
          marker_star = {
            add_padding = false,
            text = '',
          },
          ordered = { add_padding = false },
          shift_width = 2,
          wrap = false,
        },
      },
      yaml = {
        enable = false,
        properties = {
          data_types = {
            ['checkbox']    = { text = '' },
            ['date']        = { text = '' },
            ['date_&_time'] = { text = '' },
            ['list']        = { text = '' },
            ['number']      = { text = '' },
            ['text']        = { text = '' },
          },
          default = {
            border_top    = '│',
            border_middle = '│',
            border_bottom = '╰',
          },
        },
      },
    })
  end
}
