return {
  -- add matlab specific modules to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "matlab" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        matlab_ls = {},
      },
    },
  },
}
