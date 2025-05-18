return {
  'rcarriga/nvim-notify',

  -- configuration
  config = function()
    vim.notify = require('notify')

    vim.notify.setup({
      -- animation style
      stages = 'static',

      -- render function for notifications
      render = 'wrapped-compact',

      -- default timeout for notifications
      timeout = 2000,

      -- minimum width for notification windows
      minimum_width = 50,

      -- icons for different levels
      icons = {
        ERROR = ' ',
        WARN  = ' ',
        INFO  = ' ',
        DEBUG = ' ',
        TRACE = '✎ ',
      },
    })
  end,
}
