local M = {}

function M.open()
  local lines = {
    "────────────────────",
    " 🧠 Cheat Sheet ",
    "────────────────────",
    "",  
    "leader          : '\\\' ",
    "",
    " 📁 File Explorer (NvimTree)",
    "",
    "<ctrl>+n        : Toggle Nvim Tree",
    "<ctrl>+t        : Nvim Tree Open file in a new tab",
    "<ctrl>+f        : Reveal current file in NvimTree",
    "g+?             : Nvim Tree Help",
    "",
    " 🔍 Telescope",
    "",
    "<leader>+p or <ctrl>+p    : Open recent projects via Telescope",
    "<leader>+vi               : Find files under the neovim configuration directory",
    ":UpdateProjects           : Calling lua script to update telescope cache",
    "",
    "🔧 LSP (Language Server Protocol)",
    "",
    "gd                : Go to definition",
    "K                 : Show Hower information",
    "<leader>+rn       : Rename symbol",
    "<leader>+ca       : Show Code Actions",
    "<ctrl>+e          : Show Diagnostic in float",
    "",
    "🔣 Function Keys (Custom Tools & Toggles)",
    "",
    "F2              : Toggle paste mode",
    "F3              : Toggle git diff view",
    "F4              : Toggle Markview mode",
    "F5              : Remove trailling spaces",
    "<leader>ff      : Find files",
    "<leader>fg      : Live grep",
    "<leader>bb      : List buffers",
    "<leader>ch      : Show this window",
    "<ctrl>+r        : Toggle terminal",
    "",
    " Commands ",
    "----------",
    "",
    ":LoadUnusedColorschemes  : You can load unused not loaded colorschemes",
    "",
    "Press q to close this window",
  }

  local width = 100
  local height = #lines
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>bd!<CR>", { noremap = true, silent = true })

  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = (vim.o.lines - height) / 2,
    col = (vim.o.columns - width) / 2,
    border = "rounded",
  }

  vim.api.nvim_open_win(buf, true, opts)
end

return M
