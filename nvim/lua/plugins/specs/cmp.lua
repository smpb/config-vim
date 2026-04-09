return {
  {
    'L3MON4D3/LuaSnip',

    dependencies = {
      'rafamadriz/friendly-snippets', -- Snippets library
    },

    -- configuration
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'fang2hou/blink-copilot',
    },

    version = '*',

    opts = {
      snippets = { preset = 'luasnip' },

      sources = {
        default = { 'lsp', 'buffer', 'path', 'snippets', 'copilot' },
        per_filetype = {
          codecompanion = { 'codecompanion' },
        },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },

      keymap = {
        preset = 'default',
        ['<CR>'] = {
          function(cmp)
            if vim.bo.filetype == 'codecompanion' then
              return cmp.accept()
            end
          end,
          'fallback',
        },
      },

      completion = {
        documentation = { auto_show = true },
      },
    },
  },
}
