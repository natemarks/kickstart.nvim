M = {}
-- This file is the custom plugin import entrypoint for Lazy.
--
-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- Load custom LuaSnip setup and filetype snippets.
require('custom.luasnip').setup()

-- Return module table (kept for consistency with other custom config files).
return M
