-- Diagnostics settings

vim.diagnostic.config {
  virtual_text = false,
  update_in_insert = true,
}

-- trigger diagnostic hover message on cursor hold
local diag_hover_enabled = true

local function toggle_diag_hover()
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
      print('Diagnostic hover: ON')
    else
      vim.api.nvim_clear_autocmds({ group = 'DiagHover' })
      print('Diagnostic hover: OFF')
    end

    diag_hover_enabled = not diag_hover_enabled
end

toggle_diag_hover()

-- keymaps
vim.keymap.set('n', '<Leader>e', toggle_diag_hover, { silent = true, desc = 'Toggle diagnostic hover' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<Leader>Q', vim.diagnostic.setqflist)
