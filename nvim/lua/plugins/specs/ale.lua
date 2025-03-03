return {
  'dense-analysis/ale',

  -- configuration
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'go', 'helm' },
      callback = function()
          vim.b.ale_enabled = 0
      end,
    })
  end
}
