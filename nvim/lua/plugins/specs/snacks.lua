return {
  'folke/snacks.nvim',

  priority = 1000,
  lazy = false,

  opts = {
    bigfile = { enabled = true },
    image = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
    words = { enabled = true },
  },
}
