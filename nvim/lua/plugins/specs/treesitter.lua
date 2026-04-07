-- https://github.com/nvim-treesitter/nvim-treesitter/discussions/8621
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy   = false,
    build  = ':TSUpdate',

    config = function()
      -- Ensure parsers are installed
      require('nvim-treesitter').install({
        'bash', 'c', 'comment', 'css', 'csv', 'diff', 'dockerfile',
        'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
        'go', 'gomod', 'gosum', 'gotmpl', 'helm', 'html', 'http', 'janet_simple',
        'javascript', 'jq', 'json', 'lua', 'markdown', 'markdown_inline', 'make',
        'perl', 'php', 'regex', 'sql', 'ssh_config', 'tmux', 'toml', 'typescript',
        'vim', 'vimdoc', 'xml', 'yaml'
      }):wait(300000)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          -- Enable Tree-sitter highlighting via Neovim core
          pcall(vim.treesitter.start, args.buf)

          -- Enable folding
          -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.wo[0][0].foldmethod = 'expr'

          -- Enable indentation (best-effort: unstable in 0.12)
          vim.bo.indentexpr = "v:lua.vim.treesitter.indentexpr()"
        end,
      })
    end,
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
