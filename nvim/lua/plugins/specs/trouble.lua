return {
  'folke/trouble.nvim',

  lazy = true,
  cmd  = { 'Trouble' },
  opts = {},

  keys = {
    {
      "<Leader>,",
      "<CMD>Trouble diagnostics toggle<CR>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<Leader><",
      "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<Leader>.",
      "<CMD>Trouble symbols toggle focus=false<CR>",
      desc = "Symbols (Trouble)",
    },
    {
      "<Leader>>",
      "<CMD>Trouble lsp toggle focus=false win.position=right<CR>",
      desc = "LSP (definitions/references/etc.)",
    },
    {
      "<Leader>xL",
      "<CMD>Trouble loclist toggle<CR>",
      desc = "Location List (Trouble)",
    },
    {
      "<Leader>xQ",
      "<CMD>Trouble qflist toggle<CR>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
