return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "s1n7ax/nvim-window-picker",
      opts = {
        filter_rules = {
          bo = { filetype = { "NvimTree", "neo-tree", "notify", "noice" } },
        },
      },
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
    config = function(_, opts)
      -- NOTE: sync with upstream
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "neo-tree" },
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          vim.api.nvim_create_autocmd("BufEnter", {
            buffer = buf,
            callback = function()
              if package.loaded["ufo"] then
                require("ufo").detach()
                return true
              end
            end,
          })
        end,
      })
    end,
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
    "h-hg/fcitx.nvim",
    event = "VeryLazy",
  },
}
