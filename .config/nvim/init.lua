-- Set options
-- Show line numbers
vim.opt.number = true
vim.opt.relativenumber = true -- relative number on other lines
-- Enable paste mode (you may want to toggle this manually)
-- vim.opt.paste = true
vim.opt.mouse = "a"
-- Enable system clipboard support
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true


-- Show invisible characters (tabs, etc.)
vim.opt.list = true
vim.opt.listchars = {
    eol = "$",   -- Show end-of-line markers as $
    tab = ">-",  -- Show tabs as >
    space = "·", -- Show spaces as ·
}


-- Tab Removal and replace with spaces
vim.opt.expandtab = true  -- Replace tabs with spaces
vim.opt.shiftwidth = 2    -- Number of spaces for indentation
vim.opt.tabstop = 2       -- Number of spaces a tab represents
vim.opt.softtabstop = 2   -- Number of spaces inserted when pressing Tab

-- Automatically insert spaces instead of tabs:
vim.opt.expandtab = true  -- Convert tabs to spaces
vim.opt.tabstop = 4       -- Each tab is equivalent to 4 spaces
vim.opt.shiftwidth = 4    -- Indentation uses 4 spaces
vim.opt.softtabstop = 4   -- Pressing Tab inserts 4 spaces

--
-- Highlight search matches
vim.opt.hlsearch = true
--

-- vim.opt.termguicolors = true
-- Enable syntax highlighting
vim.cmd('syntax on')


-- Neovide related configurations
if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font:h14"  -- Customize font and size
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_size = 0.4
  vim.g.neovide_cursor_vfx_mode = "torpedo"  -- Options: railgun, torpedo, pixiedust, etc.
  vim.g.neovide_opacity = 0.95
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_input_macos_option_key_is_meta = true
end

-- Optional: install lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)


-- Separation of keymaps, Options, and Plugins 
--require("themes")
--require("plugins")


local theme_plugins = require("themes")
local general_plugins = require("plugins")

-- Correctly combine two list-style plugin tables
local all_plugins = vim.list_extend(theme_plugins, general_plugins)

require("lazy").setup(all_plugins)

-- vim.cmd.colorscheme("dracula")
-- vim.cmd("colorscheme tokyonight")
-- vim.cmd("colorscheme oxocarbon")


--- enable git signs
vim.opt.signcolumn = "yes"

require("options")
require("keymaps")

-- END OF MESE
print("✅ Neovim init.lua loaded!")
