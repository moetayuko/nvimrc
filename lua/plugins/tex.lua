return {
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_compiler_latexmk = {
        ["options"] = {
          "-verbose",
          "-file-line-error",
          "-shell-escape",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
      vim.g.vimtex_view_method = "zathura_simple"
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull",
        "Overfull",
        "math shift",
      }
    end,
  },
}
