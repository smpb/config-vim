return {
  'ibhagwan/fzf-lua',

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  -- configuration
  config = function()
    local fzf = require('fzf-lua')

    fzf.setup({
      'default-title',
      winopts = {
        preview = {
          default = 'builtin',
        },
      },
      fzf_opts = {
        ['--cycle'] = true,
      },
    })

    -- keymaps: find
    vim.keymap.set('n', '<Leader>:',  fzf.command_history, {})
    vim.keymap.set('n', '<Leader>/',  function() fzf.live_grep({ grep_open_files = true }) end, {})
    vim.keymap.set('n', '<Leader>fb', function() fzf.buffers({ sort_mru = true, sort_lastused = true }) end, {})
    vim.keymap.set('n', '<Leader>ff', fzf.files, {})
    vim.keymap.set('n', '<Leader>fg', fzf.live_grep, {})
    vim.keymap.set('n', '<Leader>fr', fzf.oldfiles, {})

    -- keymaps: git
    vim.keymap.set('n', '<Leader>gf', fzf.git_files, {})
    vim.keymap.set('n', '<Leader>gc', fzf.git_commits, {})
    vim.keymap.set('n', '<Leader>gs', fzf.git_status, {})

    -- keymaps: search
    vim.keymap.set('n', '<Leader>s"', fzf.registers, {})
    vim.keymap.set('n', '<Leader>sa', fzf.autocmds, {})
    vim.keymap.set('n', '<Leader>sb', fzf.lgrep_curbuf, {})
    vim.keymap.set('n', '<Leader>sc', fzf.command_history, {})
    vim.keymap.set('n', '<Leader>sC', fzf.commands, {})
    vim.keymap.set('n', '<Leader>sd', fzf.diagnostics_workspace, {})
    vim.keymap.set('n', '<Leader>sD', fzf.diagnostics_document, {})
    vim.keymap.set('n', '<Leader>sh', fzf.help_tags, {})
    vim.keymap.set('n', '<Leader>sH', fzf.highlights, {})
    vim.keymap.set('n', '<Leader>sj', fzf.jumps, {})
    vim.keymap.set('n', '<Leader>sk', fzf.keymaps, {})
    vim.keymap.set('n', '<Leader>sl', fzf.loclist, {})
    vim.keymap.set('n', '<Leader>sm', fzf.marks, {})
    vim.keymap.set('n', '<Leader>sM', fzf.manpages, {})
    vim.keymap.set('n', '<Leader>so', fzf.nvim_options, {})
  end,
}

