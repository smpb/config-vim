return {
  {
    'williamboman/mason.nvim',

    -- configuration
    config = function()
      require('mason').setup()
    end
  },

  {
    'williamboman/mason-lspconfig.nvim',

    -- configuration
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'dockerls', 'docker_compose_language_service',
          'helm_ls', 'vale_ls', 'yamlls'
        },
      })
    end
  },

  {
    'neovim/nvim-lspconfig',

    event = { 'BufReadPre', 'BufNewFile', 'BufEnter' },

    -- configuration
    config = function()
      local lspconfig = require('lspconfig')

      vim.filetype.add({
        pattern = {
          ['compose.*%.ya?ml'] = 'yaml.docker-compose',
          ['docker%-compose.*%.ya?ml'] = 'yaml.docker-compose',
        },
      })

      lspconfig.dockerls.setup {}
      lspconfig.docker_compose_language_service.setup {}
      lspconfig.helm_ls.setup {}
      lspconfig.vale_ls.setup {}
      lspconfig.yamlls.setup {}

      -- keymaps
      vim.keymap.set('n', '<Leader>j', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
      vim.keymap.set('n', '<Leader>k', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
    end
  }
}
