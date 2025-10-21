-- bp fails to install on Windows
if LazyVim.is_win() then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "bp" } },
  },
}
