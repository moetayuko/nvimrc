return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>o"] = { name = "+overseer" },
      },
    },
  },
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    keys = {
      { "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "Toggle the overseer window" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run a task from a template" },
      { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Open the task builder" },
      {
        "<leader>oq",
        "<cmd>OverseerQuickAction<cr>",
        desc = "Run an action on the most recent task, or the task under the cursor",
      },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Select a task to run an action on" },
    },
    opts = {
      templates = { "builtin", "user" },
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
        bindings = {
          ["q"] = function()
            vim.cmd("OverseerClose")
          end,
        },
      },
    },
  },
}
