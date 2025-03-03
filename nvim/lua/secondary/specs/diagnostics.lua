-- Diagnostics settings

vim.diagnostic.config({
  jump = {
    severity = {
      min = vim.diagnostic.severity.WARN
    },
    float = true,
  },
  severity_sort = true,
  underline = true,
  update_in_insert = true,
  virtual_text = false,
})

-- trigger diagnostic hover message on cursor hold
local diag_hover_enabled = true

local function toggle_diag_hover(quiet)
    if diag_hover_enabled then
      vim.api.nvim_create_augroup('DiagHover', { clear = true })
      vim.api.nvim_create_autocmd('CursorHold', {
        group = 'DiagHover',
        pattern = '*',
        callback = function()
          local opts = { focusable = false, close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' } }
          vim.diagnostic.open_float(nil, opts)
        end,
      })

      if not quiet then
        print('Diagnostic hover: ON')
      end
    else
      vim.api.nvim_clear_autocmds({ group = 'DiagHover' })

      if not quiet then
        print('Diagnostic hover: OFF')
      end
    end

    diag_hover_enabled = not diag_hover_enabled
end

toggle_diag_hover(true)

-- keymaps
vim.keymap.set('n', '<Leader>d', toggle_diag_hover, { silent = true, desc = 'Toggle diagnostic hover' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Add diagnostics to the location list' })
vim.keymap.set('n', '<Leader>Q', vim.diagnostic.setqflist, { desc = 'Add diagnostics to the quickfix list' })
