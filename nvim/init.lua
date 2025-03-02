--  __       __ __      __
-- |__.-----|__|  |_   |  .--.--.---.-.
-- |  |     |  |   _|__|  |  |  |  _  |
-- |__|__|__|__|____|__|__|_____|___._|
--

-- ========[ LOAD VIMRC ]========

vim.opt.runtimepath:prepend('~/.vim')
vim.opt.runtimepath:append('~/.vim/after')
vim.opt.packpath = vim.opt.runtimepath:get()

vim.cmd('source ~/.vimrc')


-- ========[ PLUGIN SETTINGS ]========

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

local lazyplugins = {
  -- git
  { 'airblade/vim-gitgutter' },

  -- interface and color
  { 'navarasu/onedark.nvim' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- code syntax and tags
  { 'dense-analysis/ale' },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',  -- LSP completion
      'hrsh7th/cmp-buffer',    -- Buffer completions
      'hrsh7th/cmp-path',      -- Path completions
      'hrsh7th/cmp-cmdline',   -- Command-line completions
    },
  },
  { 'ntpeters/vim-better-whitespace' },
  {
    'nvim-treesitter/nvim-treesitter',
    build  = ':TSUpdate',
    config = function ()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        ensure_installed = {
          'bash', 'c', 'comment', 'css', 'csv', 'diff', 'dockerfile',
          'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
          'go', 'gomod', 'gosum', 'gotmpl', 'helm', 'html', 'http', 'javascript',
          'jq', 'json', 'lua', 'markdown', 'markdown_inline', 'make', 'perl',
          'php', 'regex', 'sql', 'ssh_config', 'tmux', 'toml', 'typescript',
          'vim', 'vimdoc', 'xml', 'yaml'
        },
        sync_install     = false,
        highlight        = { enable = true },
        indent           = { enable = true },
      })
    end
  },
  {
    'stevearc/aerial.nvim',
    lazy = true,
    cmd  = { 'AerialToggle', 'AerialNavToggle', 'AerialInfo' }
  },
  { 'tpope/vim-commentary' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  {
    "OXY2DEV/markview.nvim",
    lazy = false
  },

  -- text and related objects
  { 'tpope/vim-characterize' },
  { 'tpope/vim-sleuth'   },
  { 'tpope/vim-surround' },

  -- file management
  {
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    cmd  = 'NvimTreeToggle',
    init = function()
      -- disable netrw
      vim.g.loaded_netrw       = 1
      vim.g.loaded_netrwPlugin = 1
      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },

  -- LSP
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', "BufNewFile", "BufEnter" }
  },

  -- llm
  { 'github/copilot.vim' },
  {
    'olimorris/codecompanion.nvim',
    config = true,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
  },
  {
    'dustinblackman/oatmeal.nvim',
    opts = {
      model      = 'llama3:latest',
      backend    = 'ollama',
      ollama_url = 'http://h.smpb.eu:11434',
    },
  },

  -- terminal
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config  = true,
    lazy    = true,
    cmd     = { 'ToggleTerm' }
  },

  -- ui
  { 'nvim-tree/nvim-web-devicons', lazy = true },
}

require('lazy').setup(lazyplugins, {
  defaults = {
    lazy = false,
  },
})


-- ========[ HELPER FUNCTIONS ]========

-- function to handle pasting in insert mode
function PasteInInsertMode()
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


-- ========[ NEOVIM SETTINGS ]========

-- open terminal below all splits
vim.api.nvim_set_keymap('n', '<Leader>t', ':split<BAR>terminal<CR><C-w>J:resize 15<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>ao', ':Oatmeal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>ao', ':Oatmeal<CR>', { noremap = true, silent = true })

-- map <D-a> to select all
vim.api.nvim_set_keymap('n', '<D-a>', 'ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-a>', 'ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-a>', 'ggVG', { noremap = true, silent = true })

-- map <D-c> to copy to system clipboard
vim.api.nvim_set_keymap('n', '<D-c>', '"+y<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-c>', '"+y<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-c>', '"+y<CR>', { noremap = true, silent = true })

-- map <D-x> to cut to system clipboard
vim.api.nvim_set_keymap('n', '<D-x>', '"+d<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-x>', '"+d<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-x>', '"+d<CR>', { noremap = true, silent = true })

-- map <D-v> to paste from system clipboard
vim.api.nvim_set_keymap('i', '<D-v>', [[<C-o>:lua PasteInInsertMode()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<D-v>', '"+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '"+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '"+p<CR>', { noremap = true, silent = true })


-- ========[ AERIAL SETTINGS ]========

require('aerial').setup({
  filter_kind = false,
  nav = {
    autojump = true
  }
})

vim.keymap.set('n', '<Leader>.', '<CMD>AerialToggle<CR>')
vim.keymap.set('n', '<Leader>>', '<CMD>AerialNavToggle<CR>')


-- ========[ ALE SETTINGS ]========

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'dockerfile', 'helm' },
  callback = function()
      vim.b.ale_enabled = 0
  end,
})


-- ========[ CMP SETTINGS ]========

local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'treesitter' },
    { name = 'path' },
    { name = 'copilot' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<Down>'] = cmp.mapping.select_next_item(),       -- Down arrow for next suggestion
    ['<Up>'] = cmp.mapping.select_prev_item(),         -- Up arrow for previous suggestion
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),           -- Scroll documentation up
    ['<C-f>'] = cmp.mapping.scroll_docs(4),            -- Scroll documentation down
    ['<C-Space>'] = cmp.mapping.complete(),            -- Show completion menu
    ['<C-e>'] = cmp.mapping.abort(),                   -- Close completion menu
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
  }),
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' },
  },
  formatting = {
    format = function(entry, vim_item)
      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
          return vim_item
        end
      end
      return vim_item
    end
  }
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    {
      { name = 'path' }
    },
    {
      { name = 'cmdline' }
    }
  )
})


-- ========[ CONTEXT SETTINGS ]========

require('treesitter-context').setup({
  enable = true,
  separator = '—',
})


-- ========[ CODECOMPANION SETTINGS ]========

require('codecompanion').setup({
  adapters = {
    claude = function()
      return require('codecompanion.adapters').extend('copilot', {
        schema = {
          model = {
            default = 'claude-3.5-sonnet',
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = 'claude',
      slash_commands = {
        ['file'] = {
          opts = {
            provider = 'telescope',
            contains_code = true,
          },
        },
        ['symbols'] = {
          opts = {
            provider = 'telescope',
            contains_code = true,
          },
        },
      },
    },
    inline = {
      adapter = 'claude',
    },
  },
  display = {
    action_palette = {
      provider = 'telescope',
      opts = {
        show_default_actions = true,
        show_default_prompt_library = true,
      },
    },
    chat = {
      show_settings = true,
      window = {
        layout = 'vertical',
        width = 0.4,
      },
    },
  },
})

vim.api.nvim_command('cabbrev cc CodeCompanion')
vim.api.nvim_command('cabbrev ccc CodeCompanionChat')

vim.keymap.set('n', '<Leader>cc', '<CMD>CodeCompanionChat Toggle<CR>',  { desc = 'Toggle CodeCompanion chat' })
vim.keymap.set('v', '<Leader>cc', '<CMD>CodeCompanionChat Toggle<CR>',  { desc = 'Toggle CodeCompanion chat' })
vim.keymap.set('n', '<Leader>cm', '<CMD>CodeCompanionActions<CR>',  { desc = 'CodeCompanion actions menu' })
vim.keymap.set('v', '<Leader>cm', '<CMD>CodeCompanionActions<CR>',  { desc = 'CodeCompanion actions menu' })

-- ========[ COPILOT SETTINGS ]========

vim.keymap.set('i', '<M-Tab>', 'copilot#Accept("\\<Tab>")', {
  expr = true,
  replace_keycodes = false
})


-- ========[ LSP SETTINGS ]========

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'dockerls', 'docker_compose_language_service',
    'helm_ls', 'vale_ls', 'yamlls'
  },
})


local lspconfig = require('lspconfig')

vim.filetype.add({
  pattern = {
    ["compose.*%.ya?ml"] = "yaml.docker-compose",
    ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
  },
})

lspconfig.dockerls.setup {}
lspconfig.docker_compose_language_service.setup {}
lspconfig.helm_ls.setup {}
lspconfig.vale_ls.setup {}
lspconfig.yamlls.setup {}

vim.keymap.set('n', '<Leader>j', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', '<Leader>k', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })


-- ========[ NVIM-TREE SETTINGS ]========

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

vim.keymap.set('n', '<Leader>d', '<CMD>NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
vim.keymap.set('v', '<Leader>d', '<CMD>NvimTreeToggle<CR>', { desc = 'Toggle file tree' })


-- ========[ ONEDARK SETTINGS ]========

require('onedark').setup({
  style      = 'dark',
  colors = {
      fg = '#CDD1D9',
  },
  code_style = {
      comments  = 'none',
      keywords  = 'none',
      functions = 'none',
      strings   = 'none',
      variables = 'none',
  },
});
require('onedark').load();


-- ========[ LUALINE SETTINGS ]========

require('lualine').setup({
  options = {
    theme = 'onedark',
    component_separators = {
      left  = '·',
      right = '·',
    },
    section_separators = {
      left  = '',
      right = '',
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {
        'buffers',
        mode = 0,
        symbols = {
          modified       = ' ●',
          directory      =  '',
          alternate_file = '',
        },
      },
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
});


-- ========[ MARKVIEW SETTINGS ]========

require('markview').setup({
  preview = {
    filetypes = { 'codecompanion', 'helm', 'markdown', 'yaml' },
    ignore_buftypes = {},
    enable_hybrid_mode = true,
    hybrid_modes = { 'n', 'v' },
    linewise_hybrid_mode = false,
  },
  markdown = {
    block_quotes = {
      wrap = false,
    },
    headings = {
      shift_width = 0,
      heading_1 = { style = 'label', icon = '󰬺 ' },
      heading_2 = { style = 'label', icon = '󰬻 ' },
      heading_3 = { style = 'label', icon = '󰬼 ' },
      heading_4 = { style = 'label', icon = '󰬽 ' },
      heading_5 = { style = 'label', icon = '󰬾 ' },
      heading_6 = { style = 'label', icon = '󰬿 ' },
    },
    list_items = {
      marker_minus = {
        add_padding = false,
        text = '•',
      },
      marker_star = {
        add_padding = false,
        text = '',
      },
      ordered = { add_padding = false },
      shift_width = 2,
      wrap = false,
    },
  },
  yaml = {
    enable = false,
    properties = {
      data_types = {
        ['checkbox']    = { text = '' },
        ['date']        = { text = '' },
        ['date_&_time'] = { text = '' },
        ['list']        = { text = '' },
        ['number']      = { text = '' },
        ['text']        = { text = '' },
      },
      default = {
        border_top    = '│',
        border_middle = '│',
        border_bottom = '╰',
      },
    },
  },
})


-- ========[ NEOVIDE SETTINGS ]========

if vim.g.neovide then
  -- allow the use of Cmd on macOS
  vim.g.neovide_input_use_logo = true

  -- interprets <Alt+whatever> as <M-whatever>
  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

  -- hide mouse when typing
  vim.g.neovide_hide_mouse_when_typing = true

  -- use the window size from the previous session
  vim.g.neovide_remember_window_size = true

  -- produce particles behind the cursor
  vim.g.neovide_cursor_vfx_mode = 'torpedo'
end


-- ========[ TELESCOPE SETTINGS ]========

local tlscp = require('telescope')

-- load fzf-native extension
tlscp.load_extension('fzf')

-- load aerial extension
tlscp.load_extension('aerial')
vim.keymap.set('n', '<Leader>fs', tlscp.extensions.aerial.aerial, {})

-- find
vim.keymap.set('n', '<Leader>:',  '<CMD>Telescope command_history<CR>', {})
vim.keymap.set('n', '<Leader>/',  '<CMD>Telescope live_grep grep_open_files=true<CR>', {})
vim.keymap.set('n', '<Leader>fb', '<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>', {})
vim.keymap.set('n', '<Leader>ff', '<CMD>Telescope find_files<CR>', {})
vim.keymap.set('n', '<Leader>fg', '<CMD>Telescope live_grep<CR>', {})
vim.keymap.set('n', '<Leader>fr', '<CMD>Telescope oldfiles<CR>', {})
-- git
vim.keymap.set('n', '<Leader>gf', '<CMD>Telescope git_files<CR>', {})
vim.keymap.set('n', '<Leader>gc', '<CMD>Telescope git_commits<CR>', {})
vim.keymap.set('n', '<Leader>gs', '<CMD>Telescope git_status<CR>', {})
-- search
vim.keymap.set('n', '<Leader>s"', '<CMD>Telescope registers<CR>', {})
vim.keymap.set('n', '<Leader>sa', '<CMD>Telescope autocommands<CR>', {})
vim.keymap.set('n', '<Leader>sb', '<CMD>Telescope current_buffer_fuzzy_find<CR>', {})
vim.keymap.set('n', '<Leader>sc', '<CMD>Telescope command_history<CR>', {})
vim.keymap.set('n', '<Leader>sC', '<CMD>Telescope commands<CR>', {})
vim.keymap.set('n', '<Leader>sd', '<CMD>Telescope diagnostics<CR>', {})
vim.keymap.set('n', '<Leader>sD', '<CMD>Telescope diagnostics bufnr=0<CR>', {})
vim.keymap.set('n', '<Leader>sh', '<CMD>Telescope help_tags<CR>', {})
vim.keymap.set('n', '<Leader>sH', '<CMD>Telescope highlights<CR>', {})
vim.keymap.set('n', '<Leader>sj', '<CMD>Telescope jumplist<CR>', {})
vim.keymap.set('n', '<Leader>sk', '<CMD>Telescope keymaps<CR>', {})
vim.keymap.set('n', '<Leader>sl', '<CMD>Telescope loclist<CR>', {})
vim.keymap.set('n', '<Leader>sm', '<CMD>Telescope marks<CR>', {})
vim.keymap.set('n', '<Leader>sM', '<CMD>Telescope man_pages<CR>', {})
vim.keymap.set('n', '<Leader>so', '<CMD>Telescope vim_options<CR>', {})


-- ========[ TOGGLETERM SETTINGS ]========

require('toggleterm').setup({
  size            = 15,
  open_mapping    = [[<C-/>]],
  hide_numbers    = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor  = 0,
  start_in_insert = true,
  persist_size    = true,
  direction       = 'float',
  close_on_exit   = true,
  shell           = vim.o.shell,
  float_opts = {
    border = 'curved',
  },
})

vim.keymap.set('n', '<Leader>tt', '<CMD>ToggleTerm<CR>', { desc = 'Toggle terminal' })
