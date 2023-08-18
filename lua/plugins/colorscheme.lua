return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true,
    },
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local custom_gruvbox = require("lualine.themes.gruvbox")
      custom_gruvbox.normal.c.bg = "None"
      opts.theme = custom_gruvbox
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
