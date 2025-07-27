local M = {}

local scan = require("plenary.scandir")
local uv = vim.loop

local base_dir = "~/git/"
-- local base_dir = "~/Projects"
-- local cache_file = vim.fn.stdpath("data") .. "~/project_nvim/project_history"
local cache_file = vim.fn.expand("~") .. "/project_nvim/project_history"


local function ensure_cache_path()
  local cache_dir = vim.fn.fnamemodify(cache_file, ":h") -- Get directory part of the path

  -- Check if directory exists
  local stat = uv.fs_stat(cache_dir)
  if not stat then
    -- Create the directory (recursive)
    local ok, err = uv.fs_mkdir(cache_dir, 493) -- 493 decimal == 0755 octal
    if not ok then
      print("Error creating cache directory: " .. err)
      return false
    end
  end

  -- Check if file exists, if not create it empty
  print("DEBUG cache_path =", vim.inspect(cache_file))
  local file_stat = uv.fs_stat(cache_file)
  if not file_stat then
    local fd, err = uv.fs_open(cache_file, "w", 420) -- 420 decimal == 0644 octal
    if not fd then
      print("Error creating cache file: " .. err)
      return false
    end
    uv.fs_close(fd)
  end

  return true
end

local function is_project_dir(path)
  local handle = uv.fs_scandir(path)
  if not handle then return false end
  while true do
    local name, _ = uv.fs_scandir_next(handle)
    if not name then break end
--    if name == ".git" or name == "package.json" or name == "Makefile" then
    if name == ".git" then
      return true
    end
  end
  return false
end

local function read_cache()
  local lines = {}
  local f = io.open(cache_file, "r")
  if f then
    for line in f:lines() do
      lines[line] = true
    end
    f:close()
  end
  return lines
end

local function write_cache(projects)
  local f = io.open(cache_file, "w")
  if not ensure_cache_path() then
    print("Failed to ensure cache file/directory")
    return
  end
  if not f then
    print("Error: Could not open project cache file for writing")
    return
  end
  for project_path in pairs(projects) do
    f:write(project_path .. "\n")
  end
  f:close()
end

function M.update_cache()
  local dir = vim.fn.expand(base_dir)
  local results = scan.scan_dir(dir, { depth = 2, only_dirs = true })

  local cached_projects = read_cache()

  for _, project_path in ipairs(results) do
    if is_project_dir(project_path) and not cached_projects[project_path] then
      cached_projects[project_path] = true
    end
  end

  write_cache(cached_projects)
  print("Project cache updated!")
end

return M

