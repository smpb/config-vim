-- Helper functions

local M = {}

-- handle pasting in insert mode
M.paste_in_insert_mode = function()
  if vim.o.paste then
    local original_autoindent  = vim.bo.autoindent
    local original_smartindent = vim.bo.smartindent

    -- Temporarily disable autoindent and smartindent
    vim.wo.autoindent  = false
    vim.wo.smartindent = false

    vim.api.nvim_command('set nopaste') -- Temporarily disable paste mode
    vim.api.nvim_input('<C-r>+')        -- Paste from the system clipboard
    vim.api.nvim_command('set paste')   -- Re-enable paste mode

    -- Reset autoindent and smartindent
    vim.wo.autoindent  = original_autoindent
    vim.wo.smartindent = original_smartindent
  else
    vim.api.nvim_input('<C-r>+')        -- Paste from the system clipboard
  end
end

return M
