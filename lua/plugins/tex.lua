local ignored = {
  "Underfull",
  "Overfull",
  "math shift",
}

return {
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-verbose",
          "-file-line-error",
          "-shell-escape",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
      vim.g.vimtex_view_method = "zathura_simple"
      vim.g.vimtex_quickfix_ignore_filters = ignored
      vim.g.vimtex_matchparen_enabled = 0
      vim.g.vimtex_syntax_packages = {
        fontawesome5 = {
          conceal = 0,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              diagnostics = {
                ignoredPatterns = ignored,
              },
            },
          },
        },
      },
    },
  },
}
