-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remove default keymaps
for _, key in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>" }) do
  vim.api.nvim_del_keymap("n", key)
end

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", function()
  require("tmux").resize_top()
end, { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", function()
  require("tmux").resize_bottom()
end, { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", function()
  require("tmux").resize_left()
end, { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", function()
  require("tmux").resize_right()
end, { desc = "Increase window width" })
