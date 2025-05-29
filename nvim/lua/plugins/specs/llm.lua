return {
  {
    'github/copilot.vim',

    -- configuration
    config = function()
      -- keymaps
      vim.g.copilot_no_tab_map = true

      vim.keymap.set('i', '<M-Tab>', 'copilot#Accept("\\<Tab>")', {
        expr = true,
        replace_keycodes = false
      })
    end,
  },

  {
    'olimorris/codecompanion.nvim',

    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },

    -- configuration
    config = function()
      local ollama_scheme = os.getenv('OLLAMA_SCHEME') or 'http'
      local ollama_host = os.getenv('OLLAMA_HOST') or 'localhost:11434'

      require('codecompanion').setup({
        adapters = {
          opts = {
            show_defaults = false,
          },
          claude = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = 'claude-3.7-sonnet',
                },
              },
            })
          end,
          claude_thought = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = 'claude-3.7-sonnet-thought',
                },
              },
            })
          end,
          ollama = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = {
                model = {
                  default = 'qwen2.5-coder:14b',
                },
                num_ctx = {
                  default = 16384,
                },
              },
              env = {
                url = ollama_scheme .. '://' .. ollama_host,
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = 'claude_thought',
            slash_commands = {
              ['file'] = {
                opts = {
                  provider = 'telescope',
                  contains_code = true,
                },
              },
              ['symbols'] = {
                opts = {
                  provider = 'telescope',
                  contains_code = true,
                },
              },
            },
          },
          inline = {
            adapter = 'claude',
          },
        },
        display = {
          action_palette = {
            provider = 'telescope',
            opts = {
              show_default_actions = true,
              show_default_prompt_library = true,
            },
          },
          chat = {
            show_settings = true,
            window = {
              layout = 'vertical',
              width = 0.4,
            },
          },
        },
      })

      -- keymaps
      vim.api.nvim_command('cabbrev cc CodeCompanion')
      vim.api.nvim_command('cabbrev ccc CodeCompanionChat')

      vim.keymap.set('n', '<Leader>cc', '<CMD>CodeCompanionChat Toggle<CR>',  { desc = 'Toggle CodeCompanion chat' })
      vim.keymap.set('v', '<Leader>cc', '<CMD>CodeCompanionChat Toggle<CR>',  { desc = 'Toggle CodeCompanion chat' })
      vim.keymap.set('n', '<Leader>cm', '<CMD>CodeCompanionActions<CR>',  { desc = 'CodeCompanion actions menu' })
      vim.keymap.set('v', '<Leader>cm', '<CMD>CodeCompanionActions<CR>',  { desc = 'CodeCompanion actions menu' })
    end
  },
}
