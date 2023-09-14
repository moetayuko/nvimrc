-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", function()
  require("tmux").move_left()
end, { desc = "Go to left window", remap = true })
map("n", "<C-j>", function()
  require("tmux").move_bottom()
end, { desc = "Go to lower window", remap = true })
map("n", "<C-k>", function()
  require("tmux").move_top()
end, { desc = "Go to upper window", remap = true })
map("n", "<C-l>", function()
  require("tmux").move_right()
end, { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", function()
  require("tmux").resize_top()
end, { desc = "Increase window height" })
map("n", "<C-Down>", function()
  require("tmux").resize_bottom()
end, { desc = "Decrease window height" })
map("n", "<C-Left>", function()
  require("tmux").resize_left()
end, { desc = "Decrease window width" })
map("n", "<C-Right>", function()
  require("tmux").resize_right()
end, { desc = "Increase window width" })
