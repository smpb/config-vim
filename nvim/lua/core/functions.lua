-- Helper functions

local M = {}

-- handle pasting in insert mode
M.paste_in_insert_mode = function()
  local original_autoindent  = vim.bo.autoindent
  local original_smartindent = vim.bo.smartindent

  -- Temporarily disable autoindent and smartindent
  vim.bo.autoindent  = false
  vim.bo.smartindent = false

  vim.opt.paste = true

  -- Force a redraw to apply the paste mode,
  --  so the cursor will be at the right place after pasting
  vim.cmd.redraw()

  vim.api.nvim_input('<C-r>+')
  vim.opt.paste = false

  -- Reset autoindent and smartindent
  vim.bo.autoindent  = original_autoindent
  vim.bo.smartindent = original_smartindent
end

return M
