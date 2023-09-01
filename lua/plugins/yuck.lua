return {
  {
    "elkowar/yuck.vim",
    ft = "yuck",
  },
  -- add yuck specific modules to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "yuck" })
      end
    end,
  },
}
