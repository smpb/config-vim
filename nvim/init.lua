--  __       __ __      __
-- |__.-----|__|  |_   |  .--.--.---.-.
-- |  |     |  |   _|__|  |  |  |  _  |
-- |__|__|__|__|____|__|__|_____|___._|
--

-- Load core configurations
require('core.vimrc')
require('core.functions')
require('core.keymaps')

-- Initialize plugins
require('plugins').setup()

-- Load secondary configurations
require('secondary').load()
