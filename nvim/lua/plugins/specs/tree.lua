return {
  'nvim-tree/nvim-tree.lua',

  lazy = true,
  cmd  = 'NvimTreeToggle',

  init = function()
    -- disable netrw
    vim.g.loaded_netrw       = 1
    vim.g.loaded_netrwPlugin = 1
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    -- keymaps
    vim.keymap.set('n', '<Leader>d', '<CMD>NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
    vim.keymap.set('v', '<Leader>d', '<CMD>NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
  end,

  -- configuration
  config = function()
    require('nvim-tree').setup({
      on_attach = function(bufnr)
        vim.api.nvim_set_hl(0, 'NvimTreeNormal',      { bg = '#282C34' })
        vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { bg = '#282C34' })
      end,
      sort = {
        sorter = 'case_sensitive',
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })
  end
}
