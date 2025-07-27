-- keymaps.lua 

----------------------
-- INCLUDE FUNCTIONS
----------------------

------------------ CHEATSHEET
local cheatsheet = require("cheatsheet")
--------- ScanProjects :UpdateProjects
local scanprojects = require("scanprojects")
--------- ToggleShell
local shell = require("toggleshell")

-- NVIMTREE 
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })

-- Open list of recent projects
vim.keymap.set("n", "<C-p>", "<cmd>Telescope projects<CR>", { desc = "Projects" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<C-e>", vim.diagnostic.open_float, { desc = "Show diagnostic" })


-- VIM.OPT.PASTE screwing up features like telescope , workaround
vim.api.nvim_set_keymap('n', '<F2>', [[:lua TogglePasteMode()<CR>]], { noremap = true, silent = true })

-- Gitdiff Toggle
vim.api.nvim_set_keymap('n', '<F3>', [[:ToggleGitDiff<CR>]], { noremap = true, silent = true })

-- Markview Toggle
vim.api.nvim_set_keymap('n', '<F4>', [[:MarkdownPreviewToggle<CR>]], { noremap = true, silent = true })

-- Trimming Trailing Space
vim.api.nvim_set_keymap('n', '<F5>', [[:TrimSpace<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>p', ':Telescope projects<CR>', { noremap = true, silent = true })

-- Show NVIM configurations
vim.keymap.set('n', '<leader>vi', function()
  require("telescope.builtin").find_files({ cwd = "~/.config/nvim" })
end)

-- CHEATSHEET DOC SEE Includes section
vim.keymap.set("n", "<leader>ch", cheatsheet.open, { desc = "Open cheat sheet" })

-- Toggle Shell
-- Map <leader>s to toggle terminal
vim.keymap.set("n", "<leader>s", shell.toggle, { desc = "Toggle shell" })
