return {
  -- catppuccin
  {
    "catppuccin",
    opts = {
      transparent_background = true,
      float = {
        transparent = true,
      },
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
