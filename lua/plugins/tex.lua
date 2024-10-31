local ignored = {
  "Underfull",
  "Overfull",
  "math shift",
}

return {
  {
    "lervag/vimtex",
    vscode = true,
    opts = function()
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

      -- disable features provided by LaTeX Workshop
      if vim.g.vscode then
        vim.g.vimtex_compiler_enabled = 0
        vim.g.vimtex_complete_enabled = 0
        vim.g.vimtex_indent_enabled = 0
        vim.g.vimtex_indent_bib_enabled = 0
        vim.g.vimtex_quickfix_enabled = 0
        vim.g.vimtex_syntax_enabled = 0
        vim.g.vimtex_toc_enabled = 0
        vim.g.vimtex_view_enabled = 0
      end
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
