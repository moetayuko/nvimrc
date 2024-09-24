return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "s1n7ax/nvim-window-picker",
      opts = {
        filter_rules = {
          bo = { filetype = { "NvimTree", "neo-tree", "notify", "noice", "qf" } },
        },
      },
    },
    opts = function(_, opts)
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
      return vim.tbl_deep_extend("force", opts, {
        filesystem = {
          window = {
            mappings = {
              ["yn"] = {
                function(state)
                  local log = require("neo-tree.log")
                  local node = state.tree:get_node()
                  vim.fn.setreg("+", node.name)
                  vim.fn.setreg('"', node.name)
                  log.info("Copied filename " .. node.name .. " to clipboard")
                end,
                desc = "Copy Filename to Clipboard",
              },
              ["yp"] = {
                -- https://github.com/nvim-neo-tree/neo-tree.nvim/pull/1016
                ---Copies a node relative path to clipboard.
                ---@param state table The state of the source
                function(state)
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
                  log.info("copy " .. node.name .. " relative path to clipboard")
                end,
                desc = "Copy Relative Path to Clipboard",
              },
              ["S"] = "split_with_window_picker",
              ["s"] = "vsplit_with_window_picker",
              ["<cr>"] = "open_with_window_picker",
              ["w"] = "noop",
            },
          },
        },
      })
    end,
  },
  {
    "telescope.nvim",
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
    event = "VeryLazy",
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
      "GitConflictRefresh",
    },
    opts = {
      default_mappings = false,
    },
    config = function(_, opts)
      require("git-conflict").setup(opts)
      vim.cmd([[GitConflictRefresh]])
    end,
    keys = {
      { "[n", "<Plug>(git-conflict-prev-conflict)", desc = "Previous Conflict" },
      { "]n", "<Plug>(git-conflict-next-conflict)", desc = "Next Conflict" },
      { "<leader>go", "<Plug>(git-conflict-ours)", desc = "Select the current changes" },
      { "<leader>gt", "<Plug>(git-conflict-theirs)", desc = "Select the incoming changes" },
      { "<leader>gb", "<Plug>(git-conflict-both)", desc = "Select both changes" },
      { "<leader>g0", "<Plug>(git-conflict-none)", desc = "Select none of the changes" },
      { "<leader>gq", "<cmd>GitConflictListQf<cr>", desc = "Get all conflict to quickfix" },
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
    "lambdalisue/vim-suda",
    event = "LazyFile",
    lazy = vim.fn.argc(-1) == 0, -- load suda early when opening a file from the cmdline
    init = function()
      vim.g.suda_smart_edit = 1
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    opts = {
      scope_chdir = "tab",
    },
  },
  {
    "h-hg/fcitx.nvim",
    event = "InsertEnter",
    vscode = true,
  },
  {
    "iamcco/markdown-preview.nvim",
    init = function()
      vim.g.mkdp_auto_close = 0
    end,
  },
  {
    "Darazaki/indent-o-matic",
    event = "BufReadPre",
  },
  {
    "willothy/flatten.nvim",
    opts = {
      window = {
        open = "alternate",
      },
    },
    lazy = false,
    priority = 1001,
  },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    cond = not (LazyVim.is_win() or vim.g.vscode),
    dependencies = {
      "leafo/magick",
    },
    opts = {
      tmux_show_only_in_active_window = true,
    },
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = nil }
      vim.g.matchup_override_vimtex = 1
    end,
  },
}
