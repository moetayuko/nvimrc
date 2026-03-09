return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "s1n7ax/nvim-window-picker",
      opts = {
        filter_rules = {
          bo = { filetype = { "NvimTree", "neo-tree", "notify", "noice", "qf", "snacks_notif" } },
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
              ["Y"] = {
                function(state)
                  -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370#discussioncomment-8303412
                  -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
                  -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
                  local node = state.tree:get_node()
                  local filepath = node:get_id()
                  local filename = node.name
                  local modify = vim.fn.fnamemodify

                  local results = {
                    filepath,
                    modify(filepath, ":."),
                    modify(filepath, ":~"),
                    filename,
                    modify(filename, ":r"),
                    modify(filename, ":e"),
                  }

                  vim.ui.select({
                    "1. Absolute path: " .. results[1],
                    "2. Path relative to CWD: " .. results[2],
                    "3. Path relative to HOME: " .. results[3],
                    "4. Filename: " .. results[4],
                    "5. Filename without extension: " .. results[5],
                    "6. Extension of the filename: " .. results[6],
                  }, { prompt = "Choose to copy to clipboard:" }, function(choice)
                    if choice then
                      local i = tonumber(choice:sub(1, 1))
                      if i then
                        local result = results[i]
                        vim.fn.setreg("+", result)
                        vim.fn.setreg('"', result)
                        vim.notify("Copied: " .. result)
                      else
                        vim.notify("Invalid selection")
                      end
                    else
                      vim.notify("Selection cancelled")
                    end
                  end)
                end,
                desc = "Copy Selector",
              },
              ["S"] = "split_with_window_picker",
              ["s"] = "vsplit_with_window_picker",
              ["<cr>"] = "open_with_window_picker",
              ["w"] = "noop",
              ["."] = {
                function(state)
                  local current_node = state.tree:get_node() -- this is the current node
                  local path = current_node:get_id() -- this gives you the path

                  require("neo-tree.sources.filesystem.commands").set_root(state) -- call the default set_root

                  -- do whatever you want to do here
                  vim.cmd("tcd " .. path)
                end,
                desc = "set_root",
              },
            },
          },
        },
      })
    end,
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
    "spacedentist/resolve.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
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
    "rimeinn/ime.nvim",
    cond = not (LazyVim.is_win() or vim.env.SSH_CONNECTION),
    event = { "InsertEnter", "CmdlineEnter" },
    vscode = true,
  },
  {
    "NMAC427/guess-indent.nvim",
    opts = {},
    event = "BufReadPre",
  },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    cond = not LazyVim.is_win(),
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
