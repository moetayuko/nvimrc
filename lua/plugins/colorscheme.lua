return {
  -- catppuccin
  {
    "catppuccin",
    opts = {
      transparent_background = true,
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
