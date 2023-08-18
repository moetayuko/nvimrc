return {
  {
    "gbprod/substitute.nvim",
    dependencies = { "gbprod/yanky.nvim" },
    opts = {
      on_substitute = require("yanky.integration").substitute(),
    },
    keys = {
      -- Substitute operator --
      {
        "<leader>a",
        function()
          require("substitute").operator()
        end,
        desc = "Substitute text object",
      },
      {
        "<leader>ax",
        function()
          require("substitute").line()
        end,
        desc = "Substitute line",
      },
      {
        "<leader>a",
        function()
          require("substitute").visual()
        end,
        mode = "x",
        desc = "Substitute visual",
      },
      -- Exchange operator --
      {
        "cx",
        function()
          require("substitute.exchange").operator()
        end,
        desc = "Exchange text object",
      },
      {
        "cxc",
        function()
          require("substitute.exchange").cancel()
        end,
        desc = "Exchange cancel",
      },
      {
        "cxx",
        function()
          require("substitute.exchange").line()
        end,
        desc = "Exchange line",
      },
      {
        "X",
        function()
          require("substitute.exchange").visual()
        end,
        desc = "Exchange visual",
        mode = "x",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      operators = { ["<leader>a"] = "Substitute", ["cx"] = "Exchange" },
    },
  },
}
