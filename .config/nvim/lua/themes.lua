--themes.lua
return{
  -- 🌃 Tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    colorscheme = true,
    scheme_name = "tokyonight",
  },

  -- ☕ Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    colorscheme = true,
    scheme_name = "catppuccin",
    lazy = true
  },

  -- 🧛 Dracula
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    lazy = false,
    --config = function()
    --	vim.cmd.colorscheme("dracula")
    --end
  },

  -- 🌲 Everforest
  {
    "sainnhe/everforest",
    colorscheme = true,
    scheme_name = "everforest",
    lazy = true
  },

  -- ❄️ Nord
  {
    "shaunsingh/nord.nvim",
    colorscheme = true,
    scheme_name = "nord",
    lazy = true
  },

  -- 🔥 Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    colorscheme = true,
    scheme_name = "gruvbox",
    lazy = true
  },

  -- 🌙 OneDark
  {
    "navarasu/onedark.nvim",
    colorscheme = true,
    scheme_name = "onedark",
    lazy = true
  },

  -- 🌹 Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    colorscheme = true,
    scheme_name = "rose-pine",
    lazy = true
  },

  -- 🎨 Material
  {
    "marko-cerovac/material.nvim",
    colorscheme = true,
    scheme_name = "material",
    lazy = true
  },

  -- 🦊 Nightfox
  {
    "EdenEast/nightfox.nvim",
    colorscheme = true,
    scheme_name = "nightfox",
    lazy = true
  },
}
