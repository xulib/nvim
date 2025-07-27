--plugins.lua
return{
  -- TELESCOPE
  {
    "nvim-telescope/telescope.nvim",
    version = false, -- latest from main branch
    dependencies = { "nvim-lua/plenary.nvim" },
--    config = function()
--      require("telescope").setup({})
--    end,
  },
  -- TREESITTER
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "vim", "bash", "json", "yaml" },
  disable = { "lua" }, -- disable for Lua files
        highlight = {
          enable = false,
    disable = { "lua" }, -- disable for Lua files
        },
      })
    end
  },
  -- File explorer: nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons", -- for file icons (optional)
    config = function()
      require("nvim-tree").setup({
        -- your options here
        view = {
          width = 30,
          side = "left",
          -- you can tweak more options here
        },
        -- disable netrw at startup
        disable_netrw = true,
        hijack_netrw = true,
      })

    end,
-- Optional: install lazy.nvim plugin manager
--      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--      if not vim.loop.fs_stat(lazypath) then
--        vim.fn.system({
--          "git",
--          "clone",
--          "--filter=blob:none",
--          "https://github.com/folke/lazy.nvim.git",
--          "--branch=stable", -- latest stable release
--          lazypath,
--        })
--      end
--      vim.opt.rtp:prepend(lazypath)
  },
  -- PROJECT MANAGEMENT
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
  show_hidden = true,
        on_project_selected = function(project)
    local opts = {
      cwd = project,
      hidden = true,
      show_hidden = true,
      no_ignore = true,
      find_command = { "fd", "--type", "f", "--hidden", "--no-ignore", "--follow" },
    }
    local is_git = vim.fn.isdirectory(project .. "/.git") == 1
    if is_git then
      require("telescope.builtin").git_files(opts)
    else
        require("telescope.builtin").find_files(opts)
    end

        require("telescope.builtin").find_files({
      cwd = project,
      hidden = true,
      show_hidden = true,
      no_ignore = true,
      find_command = { "fd", "--type", "f", "--hidden", "--no-ignore", "--follow" },
    })
    end,
        detection_methods = { "git", "lsp", "pattern" },
        patterns = { ".git", "package.json", "Makefile" },
    manual_mode = false,  -- auto detect project root (set true to disable auto detection)
        -- 📁 Optional: show Telescope files when switching
  --projects = {
      --  "/root/eosgit/usermanagement/",  -- or any other directory you want to scan
    --},
      })
    end,
  },
  ---------------
  -- LSP s 
  ---------------
  -- NULL LS needs shellcheck
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.shellcheck,
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").clangd.setup({
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = require("lspconfig.util").root_pattern(".git", "compile_commands.json", "Makefile")
      })
    end
  },
  --------------
  -- Completion
  --------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" }
        }
      })
    end
  },
  --------
  -- GIT
  --------
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('gitsigns').setup()
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require('neogit').setup()
      vim.api.nvim_set_keymap('n', '<leader>gs', ':Neogit<CR>', { noremap = true, silent = true })
    end,
  },
  --- Toggle Terminal 
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-r>]],
        direction = "float", -- or 'float' or 'vertical'
        size = 100,
        shade_terminals = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_mode = false,
        persist_size = false,
      })
    end
  },
  -- install without yarn or npm
  -- MARKDOWN PREVIEW
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}


