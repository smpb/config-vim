-- Plugins loader

local M = {}

-- Bootstrap 'lazy.nvim'
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load all plugin specs
local function load_plugins()
  local plugins = {}
  local specs_path = vim.fn.stdpath('config') .. '/lua/plugins/specs'

  for name in vim.fs.dir(specs_path) do
    if name:match('%.lua$') then
      local module = require('plugins.specs.' .. name:gsub('%.lua$', ''))

      -- Handle both single plugin specs and tables of specs
      if type(module) == 'table' then
        if module[1] or module.plugin then  -- single plugin spec
          table.insert(plugins, module)
        else                                -- multiple plugin specs
          for _, plugin in pairs(module) do
            table.insert(plugins, plugin)
          end
        end
      end

    end
  end

  return plugins
end

function M.setup()
  require('lazy').setup(load_plugins(), {
    defaults = {
      lazy = false,
    },
  })
end

return M
