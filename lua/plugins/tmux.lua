return {
  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    commit = "0f4a7de5246ca052844a878c00a02d8a31e54e1b",
    opts = {
      navigation = {
        enable_default_keybindings = false,
      },
      resize = {
        enable_default_keybindings = false,
      },
      copy_sync = {
        enable = true,
        sync_registers_keymap = false,
      },
    },
    config = function(_, opts)
      require("tmux").setup(opts)
      if vim.env.TMUX then
        LazyVim.on_load("which-key.nvim", function()
          local reg = require("which-key.plugins.registers")
          local expand = reg.expand
          function reg.expand()
            require("tmux.copy").sync_registers()
            return expand()
          end
        end)

        if LazyVim.has("yanky.nvim") then
          LazyVim.on_load("yanky.nvim", function()
            local yanky = require("yanky")
            local put = yanky.put
            function yanky.put(type, is_visual, callback)
              require("tmux.copy").sync_registers()
              return put(type, is_visual, callback)
            end
          end)
        end
      end
    end,
    keys = {
      {
        "<A-H>",
        function()
          require("tmux").move_left()
        end,
        desc = "Go to left window",
        remap = true,
      },
      {
        "<A-J>",
        function()
          require("tmux").move_bottom()
        end,
        desc = "Go to lower window",
        remap = true,
      },
      {
        "<A-K>",
        function()
          require("tmux").move_top()
        end,
        desc = "Go to upper window",
        remap = true,
      },
      {
        "<A-L>",
        function()
          require("tmux").move_right()
        end,
        desc = "Go to right window",
        remap = true,
      },
    },
  },
}
