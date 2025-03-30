-- Diagnostics settings

vim.diagnostic.config({
  jump = {
    severity = {
      min = vim.diagnostic.severity.WARN
    },
  },
  float = false,
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
})

-- Toggle between displaying diagnostics under the current line or in virtual ones
local function toggle_diagnostic_current_virtual()
    local config = vim.diagnostic.config()

    if config.virtual_lines == false then
      config.virtual_text = false
      config.virtual_lines = { current_line = true }
    else
      config.virtual_text = { current_line = true }
      config.virtual_lines = false
    end

    vim.diagnostic.config(config)
end

-- keymaps
vim.keymap.set('n', '<Leader>dt', toggle_diagnostic_current_virtual, { desc = 'Toggle diagnostic between current and virtual line' })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_prev({ float = false })
end, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next({ float = false })
end, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Add diagnostics to the location list' })
vim.keymap.set('n', '<Leader>Q', vim.diagnostic.setqflist, { desc = 'Add diagnostics to the quickfix list' })
