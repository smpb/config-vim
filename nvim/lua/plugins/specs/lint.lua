return {
  'mfussenegger/nvim-lint',

  -- configuration
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      dockerfile = { 'hadolint' },
      go         = { 'golangcilint' },
      markdown   = { 'vale' },
      php        = { 'php' },
      yaml       = { 'yamllint' },
      zsh        = { 'zsh' },
    }

    lint.linters['npm-groovy-lint'].ignore_exitcode = true

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      callback = function()
        lint.try_lint()
      end,
    })

    -- keymaps
    vim.keymap.set('n', '<leader>dl', function()
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })
  end
}
