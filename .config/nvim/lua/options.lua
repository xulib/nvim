-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   callback = function()
--     require("nvim-tree.api").tree.open()
--   end,
-- })

-- Markdown settings 

vim.g.mkdp_theme = 'light'
-- vim.g.mkdp_markdown_css = vim.fn.expand('~/my_markdown.css')
-- vim.g.mkdp_browser = "chrome.exe"
vim.g.mkdp_port = "3000"
vim.g.mkdp_auto_close = 0
vim.g.mkdp_node_command = "/usr/local/bin/node-wrapper"



--- enable git signs
vim.opt.signcolumn = "yes"


----------- COLORIZATION ---------------------------------
-- Set colorscheme (industry is not included by default)
-- Use a fallback if 'industry' doesn't exist
local ok = pcall(vim.cmd.colorscheme, "dracula")
if not ok then
   print("Colorscheme 'dracula' not found")
end
----------------------------------------------------------
-------------
-- TELESCOPE 
-------------
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {}, -- optionally clear ignore patterns
    find_files = {
      hidden = true,
      no_ignore = true,
    },
  }
}
-- Load telescope projects extension after setup
require('telescope').load_extension('projects')

----------------
-- FUNCTIONS 
----------------
local scanprojects = require("scanprojects")
vim.api.nvim_create_user_command("UpdateProjects", function()
  scanprojects.update_cache()
end, { desc = "Scan and update projects cache" })

function TrimTrailingSpaces()
    vim.cmd("%s/\\s\\+$//e")
end

vim.api.nvim_create_user_command(
    "TrimSpaces",
    TrimTrailingSpaces,
    { desc = "Remove trailing spaces" }
)

local diff_enabled = false
local gs = require("gitsigns")

function ToggleGitDiff()
  if diff_enabled then
    -- Disable diff (toggle it off)
    gs.diffthis()

    -- Close all windows with diff enabled
    local wins = vim.api.nvim_list_wins()
    for _, win in ipairs(wins) do
      local is_diff = vim.api.nvim_win_get_option(win, "diff")
      if is_diff then
        if vim.fn.winnr('$') > 1 then
          vim.api.nvim_set_current_win(win)
          pcall(vim.cmd, "close")
        end
      end
    end

    diff_enabled = false
    print("Git diff OFF")
  else
    -- Enable diff (toggle it on)
    gs.diffthis()
    diff_enabled = true
    print("Git diff ON")
  end
end


function ToggleGitDiff2()
    if diff_enabled then
        if vim.fn.winnr('$') > 1 then
            -- Ensure the upper split (diff window) is closed
            vim.cmd("wincmd k")  -- Move to the upper window
            vim.cmd("wincmd c")  -- Close the upper window
        else
            print("Cannot close the last window.")
        end
        -- Refresh gitsigns to ensure indicators are restored
        vim.cmd("Gitsigns refresh")

        diff_enabled = false
        print("Git diff OFF")
    else
        -- Show the Git diff view
        vim.cmd("Gitsigns diffthis")
        diff_enabled = true
        print("Git diff ON")
    end
end


vim.api.nvim_create_user_command(
    "ToggleGitDiff",
    ToggleGitDiff,
    { desc = "Toggle Git diff view" }
)

-- COLORSCHEME LOADER
-- please set in the colorscheme in laze the variable, colorscheme = true and e.g. scheme_name = "onedark",
--

function LoadUnusedColorschemes(selected_scheme)
    local Lazy = require("lazy")
    local plugins = Lazy.plugins()
    local colorschemes = {}

    -- Collect unloaded colorscheme plugins
    for _, plugin in ipairs(plugins) do
        if plugin.colorscheme and not plugin._.loaded then
            colorschemes[plugin.scheme_name] = plugin.name  -- Map colorscheme name to plugin name
        end
    end

    if vim.tbl_isempty(colorschemes) then
        print("No unloaded colorschemes found!")
        return
    end

    -- Validate selected_scheme and map to correct plugin name
    -- local chosen_scheme = selected_scheme or next(colorschemes) -- Default to first colorscheme
    local chosen_scheme = (selected_scheme ~= "" and selected_scheme) or next(colorschemes)
    local plugin_name = colorschemes[chosen_scheme] -- Get corresponding plugin name

    if not plugin_name then
        print("Error: Colorscheme '" .. (chosen_scheme or "<none>") .. "' not found in unloaded plugins!")
        return
    end

    -- Load the plugin before applying colorscheme
    --vim.cmd("Lazy load " .. plugin_name)

    -- Wait briefly before setting the colorscheme (prevents E185 error)
    --vim.defer_fn(function()
    --    vim.cmd("colorscheme " .. chosen_scheme)
    --    print("Loaded colorscheme: " .. chosen_scheme)
    --end, 100)
    --
    require("lazy").load({ plugins = { plugin_name } })

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      once = true,
      callback = function(args)
        if args.data == plugin_name then
          vim.cmd.colorscheme(chosen_scheme)
          print("✅ Loaded colorscheme: " .. chosen_scheme)
        end
      end,
    })

end

vim.api.nvim_create_user_command(
    "LoadUnusedColorscheme",
    function(opts)
        LoadUnusedColorschemes(opts.args)
    end,
    {
        nargs = "?",
        complete = function()
            local Lazy = require("lazy")
            local plugins = Lazy.plugins()
            local colorschemes = {}

            for _, plugin in ipairs(plugins) do
                if plugin.colorscheme and not plugin._.loaded then
                    table.insert(colorschemes, plugin.scheme_name) -- Autocomplete using correct scheme names
                end
            end

            return colorschemes -- Suggest colorschemes during tab completion
        end,
        desc = "Load an unloaded colorscheme plugin",
    }
)

function TogglePasteMode()
  if vim.o.paste then
    vim.o.paste = false
    vim.api.nvim_echo({{"Paste mode disabled", "WarningMsg"}}, false, {})
  else
    vim.o.paste = true
    vim.api.nvim_echo({{"Paste mode enabled", "WarningMsg"}}, false, {})
  end
end
