local ignored = {
  "Underfull",
  "Overfull",
  "math shift",
}

local function get_texlab_namespace(bufnr)
  local texlab_clients = vim.lsp.get_clients({ bufnr = bufnr, name = "texlab" })
  if #texlab_clients == 0 then
    return nil
  end

  local lsp_server_name = "vim.lsp.texlab." .. tostring(texlab_clients[1].id)
  for ns, ns_metadata in pairs(vim.diagnostic.get_namespaces()) do
    if vim.startswith(ns_metadata.name, lsp_server_name) then
      return ns
    end
  end

  return nil
end

local function vimtex_diagnostic_enable(bufnr, enable)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local ns = get_texlab_namespace(bufnr)
  if not ns then
    return
  end

  vim.diagnostic.enable(enable, { ns_id = ns })
end

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
      vim.g.vimtex_quickfix_open_on_warning = 0

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

      local vimtex_events = vim.api.nvim_create_augroup("vimtex_events", {})
      vim.api.nvim_create_autocmd("User", {
        pattern = { "VimtexEventCompileStarted", "VimtexEventCompiling" },
        group = vimtex_events,
        callback = function(opts)
          vimtex_diagnostic_enable(opts.buf, false)
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = { "VimtexEventCompileStopped", "VimtexEventCompileSuccess", "VimtexEventCompileFailed" },
        group = vimtex_events,
        callback = function(opts)
          vimtex_diagnostic_enable(opts.buf, true)
        end,
      })
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
