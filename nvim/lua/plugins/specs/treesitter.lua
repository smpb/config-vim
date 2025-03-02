return {
  {
    'nvim-treesitter/nvim-treesitter',

    build  = ':TSUpdate',

    -- configuration
    config = function ()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        ensure_installed = {
          'bash', 'c', 'comment', 'css', 'csv', 'diff', 'dockerfile',
          'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
          'go', 'gomod', 'gosum', 'gotmpl', 'helm', 'html', 'http', 'javascript',
          'jq', 'json', 'lua', 'markdown', 'markdown_inline', 'make', 'perl',
          'php', 'regex', 'sql', 'ssh_config', 'tmux', 'toml', 'typescript',
          'vim', 'vimdoc', 'xml', 'yaml'
        },
        sync_install     = false,
        highlight        = { enable = true },
        indent           = { enable = true },
      })
    end
  },

  {
    'nvim-treesitter/nvim-treesitter-context',

    -- configuration
    config = function ()
      require('treesitter-context').setup({
        enable = true,
        separator = '—',
      })
    end
  },
}
