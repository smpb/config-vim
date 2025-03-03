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
    'hrsh7th/nvim-cmp',

    dependencies = {
      'hrsh7th/cmp-nvim-lsp',         -- LSP completion
      'hrsh7th/cmp-buffer',           -- Buffer completions
      'hrsh7th/cmp-path',             -- Path completions
      'hrsh7th/cmp-cmdline',          -- Command-line completions
      'saadparwaiz1/cmp_luasnip',     -- LuaSnip as cmp source
    },

    -- configuration
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        sources = {
          { name = 'buffer' },
          { name = 'nvim_lsp' },
          { name = 'treesitter' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'copilot' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),      -- Scroll documentation up
          ['<C-f>'] = cmp.mapping.scroll_docs(4),       -- Scroll documentation down
          ['<C-Space>'] = cmp.mapping.complete(),       -- Show completion menu
          ['<C-e>'] = cmp.mapping.abort(),              -- Close completion menu
          ['<CR>'] = cmp.mapping.confirm({              -- Confirm completion
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          }),
          ['<Tab>'] = cmp.mapping(function(fallback)    -- Cycle to next completion item
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)  -- Cycle to previous completion item
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
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
}
