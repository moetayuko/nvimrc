return {
  {
    "gbprod/substitute.nvim",
    dependencies = { "gbprod/yanky.nvim" },
    opts = {
      on_substitute = function()
        require("yanky.integration").substitute()
      end,
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
        "cx",
        function()
          require("substitute.exchange").visual()
        end,
        desc = "Exchange visual",
        mode = "x",
      },
    },
  },
}
