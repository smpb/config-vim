local M = {}

-- load all secondary configurations
function M.load()
  local specs_path = vim.fn.stdpath('config') .. '/lua/secondary/specs'

  local ok, _ = vim.loop.fs_stat(specs_path)
  if not ok then
    vim.notify('Specs directory not found: ' .. specs_path, vim.log.levels.WARN)
    return
  end

  for name, type in vim.fs.dir(specs_path) do
    if name:match('%.lua$') then
      local ok, err = pcall(require, 'secondary.specs.' .. name:gsub('%.lua$', ''))
      if not ok then
        vim.notify(
          string.format('Failed to load %s: %s', name, err),
          vim.log.levels.ERROR
        )
      end
    end
  end
end

return M
