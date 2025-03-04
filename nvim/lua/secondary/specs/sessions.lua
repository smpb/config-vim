-- Session loading

vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function()
    if vim.fn.argc() == 0 then
      local cwd = vim.fn.getcwd()
      local files = vim.fn.glob(cwd .. '/*.vim', false, true)

      if #files == 0 then
        return
      elseif #files == 1 then
        -- One file: load it, but defer to ensure all initialization is complete
        vim.defer_fn(function()
          vim.cmd('source ' .. files[1])
        end, 0)
      else
        -- Multiple files: show menu and defer loading of selected session
        vim.defer_fn(function()
          local display_names = {}

          -- Convert full paths to relative names for display
          for _, file in ipairs(files) do
            display_names[file] = vim.fn.fnamemodify(file, ':t')
          end

          vim.ui.select(files, {
            prompt = 'Select session to load:',
            format_item = function(item)
              return display_names[item]
            end
          }, function(choice)
            if choice then
              vim.cmd('source ' .. choice)
            end
          end)
        end, 0)
      end
    end
  end,
  once = true  -- Run only once during startup
})
