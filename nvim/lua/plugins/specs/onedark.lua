return {
  'navarasu/onedark.nvim',

  -- configuration
  config = function()
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
  end
}
