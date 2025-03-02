return {
  'hrsh7th/nvim-cmp',

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',  -- LSP completion
    'hrsh7th/cmp-buffer',    -- Buffer completions
    'hrsh7th/cmp-path',      -- Path completions
    'hrsh7th/cmp-cmdline',   -- Command-line completions
  },

  -- configuration
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      sources = {
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'treesitter' },
        { name = 'path' },
        { name = 'copilot' },
      },
      mapping = cmp.mapping.preset.insert({
        ['<Down>'] = cmp.mapping.select_next_item(),       -- Down arrow for next suggestion
        ['<Up>'] = cmp.mapping.select_prev_item(),         -- Up arrow for previous suggestion
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),           -- Scroll documentation up
        ['<C-f>'] = cmp.mapping.scroll_docs(4),            -- Scroll documentation down
        ['<C-Space>'] = cmp.mapping.complete(),            -- Show completion menu
        ['<C-e>'] = cmp.mapping.abort(),                   -- Close completion menu
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
      }),
      view = {
        entries = { name = 'custom', selection_order = 'near_cursor' },
      },
      formatting = {
        format = function(entry, vim_item)
          if vim.tbl_contains({ 'path' }, entry.source.name) then
            local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
            if icon then
              vim_item.kind = icon
              vim_item.kind_hl_group = hl_group
              return vim_item
            end
          end
          return vim_item
        end
      }
    })

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources(
        {
          { name = 'path' }
        },
        {
          { name = 'cmdline' }
        }
      )
    })
  end
}
