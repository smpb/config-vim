return {
  'dense-analysis/ale',

  -- configuration
  config = function()
    vim.g.ale_virtualtext_cursor = 'disabled'
    vim.g.ale_disable_lsp = 1

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'helm' },
      callback = function()
          vim.b.ale_enabled = 0
      end,
    })
  end
}
