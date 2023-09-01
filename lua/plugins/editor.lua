return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "s1n7ax/nvim-window-picker",
    },
    opts = {
      filesystem = {
        bind_to_cwd = true,
        commands = {
          copy_file_name = function(state)
            local log = require("neo-tree.log")
            local node = state.tree:get_node()
            vim.fn.setreg("+", node.name)
            vim.fn.setreg('"', node.name)
            log.info("Copied filename " .. node.name .. " to clipboard")
          end,
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/pull/1016
          ---Copies a node relative path to clipboard.
          ---@param state table The state of the source
          copy_path = function(state)
            local log = require("neo-tree.log")
            local node = state.tree:get_node()
            if node.type == "message" then
              return
            end
            local pwdpath = state.path
            local content = node.path
            local rpath = "." .. string.sub(content, string.len(pwdpath) + 1)
            vim.fn.setreg("+", rpath)
            vim.fn.setreg('"', rpath)
            log.info("copy " .. node.name .. " path to clipboard")
          end,

          ---Copies a node absolute path to clipboard.
          ---@param state table The state of the source
          copy_abspath = function(state)
            local log = require("neo-tree.log")
            local node = state.tree:get_node()
            if node.type == "message" then
              return
            end
            local content = node.path
            vim.fn.setreg("+", content)
            vim.fn.setreg('"', content)
            log.info("copy " .. node.name .. "abs path to clipboard")
          end,
        },
        window = {
          mappings = {
            ["Y"] = "copy_file_name",
            ["S"] = "split_with_window_picker",
            ["s"] = "vsplit_with_window_picker",
            ["<cr>"] = "open_with_window_picker",
            ["w"] = "noop",
            ["yp"] = "copy_path",
            ["yP"] = "copy_abspath",
          },
        },
      },
    },
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    opts = {
      pickers = {
        live_grep = {
          additional_args = { "--hidden" },
        },
        grep_string = {
          additional_args = { "--hidden" },
        },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = {
      "ToggleTerm",
      "ToggleTermToggleAll",
      "TermExec",
      "TermSelect",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
      "ToggleTermSetName",
    },
    opts = {
      open_mapping = [[<c-_>]],
      direction = "float",
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
    end,
    keys = {
      { "<c-/>", nil, mode = "n", desc = "Terminal (cwd)" },
      { "<c-_>", nil, mode = "n", desc = "which_key_ignore" },
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Ggrep",
      "Glgrep",
      "Gclog",
      "Gllog",
      "Gcd",
      "Glcd",
      "Gedit",
      "Gsplit",
      "Gvsplit",
      "Gtabedit",
      "Gpedit",
      "Gdrop",
      "Gread",
      "Gwrite",
      "Gwq",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Ghdiffsplit",
      "GMove",
      "GRename",
      "GDelete",
      "GRemove",
      "GUnlink",
      "GBrowse",
    },
  },
  {
    "akinsho/git-conflict.nvim",
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
    },
    config = true,
    opts = {
      default_mappings = false,
    },
    keys = {
      { "[n", "<Plug>(git-conflict-prev-conflict)", desc = "Previous Conflict" },
      { "]n", "<Plug>(git-conflict-next-conflict)", desc = "Next Conflict" },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewLog",
    },
  },
  {
    "lambdalisue/suda.vim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = true,
      scope_chdir = "tab",
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        -- nvim lsp as LSP client
        -- Tell the server the capability of foldingRange,
        -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
        "neovim/nvim-lspconfig",
        opts = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
        },
      },
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function(bufnr, _, _)
        local function handleFallbackException(err, providerName)
          if type(err) == "string" and err:match("UfoFallbackException") then
            return require("ufo").getFolds(bufnr, providerName)
          else
            return require("promise").reject(err)
          end
        end

        return require("ufo")
          .getFolds(bufnr, "lsp")
          :catch(function(err)
            return handleFallbackException(err, "treesitter")
          end)
          :catch(function(err)
            return handleFallbackException(err, "indent")
          end)
      end,
    },

    config = function(opts)
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.keymap.set("n", "zM", function() end)
      require("ufo").setup(opts)
    end,
    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    map = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
      },
    },
  },
}
