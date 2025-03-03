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
      local ensure_installed = {}

      -- Load package configurations
      local tools_path = vim.fn.stdpath('config') .. '/lua/plugins/tools'

      for name in vim.fs.dir(tools_path) do
        if name:match('%.lua$') then
          local tool = require('plugins.tools.' .. name:gsub('%.lua$', ''))

          if tool.name and tool.lsp then
            table.insert(ensure_installed, tool.name)
          end
        end
      end

      require('mason-lspconfig').setup({
        ensure_installed = ensure_installed
      })
    end
  },

  {
    'neovim/nvim-lspconfig',

    event = { 'BufReadPre', 'BufNewFile', 'BufEnter' },

    -- configuration
    config = function()
      local lspconfig = require('lspconfig')

      -- keymaps
      local keymaps = function(_, bufnr)
        local attach_opts = { silent = true, buffer = bufnr }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, attach_opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, attach_opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, attach_opts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, attach_opts)
        vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, attach_opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, attach_opts)
        vim.keymap.set('n', 'sr', require('telescope.builtin').lsp_references, attach_opts)
      end

      -- nvim-cmp supports additional completion capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      vim.filetype.add({
        pattern = {
          ['compose.*%.ya?ml'] = 'yaml.docker-compose',
          ['docker%-compose.*%.ya?ml'] = 'yaml.docker-compose',
        },
      })

      -- setup servers
      local tools_path = vim.fn.stdpath('config') .. '/lua/plugins/tools'

      for name in vim.fs.dir(tools_path) do
        if name:match('%.lua$') then
          local tool = require('plugins.tools.' .. name:gsub('%.lua$', ''))

          if tool.name and tool.lsp then
            -- merge each tool configuration with the defaults
            local config = vim.tbl_extend('force', {
              on_attach = keymaps,
              capabilities = capabilities,
            }, tool.config or {})

            lspconfig[tool.name].setup(config)
          end
        end
      end
    end
  }
}
