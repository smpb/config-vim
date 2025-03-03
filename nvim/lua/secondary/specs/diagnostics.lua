-- Diagnostics settings

vim.diagnostic.config {
  virtual_text = false,
  update_in_insert = true,
}

-- keymaps
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<Leader>Q', vim.diagnostic.setqflist)
