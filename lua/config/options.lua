-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.fileencodings = "ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1"

local Util = require("lazyvim.util")
if not Util.is_win() then
  vim.g.python3_host_prog = "/usr/bin/python3"
end
