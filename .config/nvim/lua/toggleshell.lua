-- ~/.config/nvim/lua/toggleshell.lua

local M = {}
local terminal_buf = nil
local previous_win = nil

function M.toggle()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()

  -- If we're in terminal buffer and toggle is pressed, go back to previous window
  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) and current_buf == terminal_buf then
    if previous_win and vim.api.nvim_win_is_valid(previous_win) then
      vim.api.nvim_set_current_win(previous_win)
    else
      vim.cmd("b#")  -- fallback to previous buffer
    end
    return
  end

  -- If terminal exists, switch to it
  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    previous_win = current_win
    vim.cmd("buffer " .. terminal_buf)
    return
  end

  -- Otherwise, open terminal and remember its buffer
  previous_win = current_win
  vim.cmd("split | terminal")
  terminal_buf = vim.api.nvim_get_current_buf()
end

return M

