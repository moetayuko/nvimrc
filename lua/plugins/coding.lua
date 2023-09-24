return {
  {
    "L3MON4D3/LuaSnip",
    opts = {
      store_selection_keys = "<Tab>",
    },
    keys = {
      { "<tab>", nil, mode = "v" },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        "w",
        function()
          require("spider").motion("w")
        end,
        mode = { "n", "x", "o" },
      },
      {
        "e",
        function()
          require("spider").motion("e")
        end,
        mode = { "n", "x", "o" },
      },
      {
        "b",
        function()
          require("spider").motion("b")
        end,
        mode = { "n", "x", "o" },
      },
      {
        "ge",
        function()
          require("spider").motion("ge")
        end,
        mode = { "n", "x", "o" },
      },
    },
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    keys = {
      {
        "aS",
        function()
          require("various-textobjs").subword(false)
        end,
        mode = { "o", "x" },
        desc = "a subword (with white space)",
      },
      {
        "iS",
        function()
          require("various-textobjs").subword(true)
        end,
        mode = { "o", "x" },
        desc = "inner subword",
      },
      {
        "aL",
        function()
          require("various-textobjs").lineCharacterwise(false)
        end,
        mode = { "o", "x" },
        desc = "current line (with indentation and trailing spaces)",
      },
      {
        "iL",
        function()
          require("various-textobjs").lineCharacterwise(true)
        end,
        mode = { "o", "x" },
        desc = "current line",
      },
      {
        "gG",
        function()
          require("various-textobjs").entireBuffer()
        end,
        mode = { "o", "x" },
        desc = "entire buffer as one text object",
      },
    },
  },
  {
    "johmsalas/text-case.nvim",
    config = true,
    event = "VeryLazy",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "uga-rosa/cmp-dictionary",
        config = function(_, opts)
          local dict = require("cmp_dictionary")
          dict.setup(opts)
          dict.switcher({ spelllang = {
            en = "/usr/share/dict/words",
          } })
        end,
      },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        {
          name = "dictionary",
          keyword_length = 2,
        },
      }))
    end,
  },
  {
    "JuanZoran/Trans.nvim",
    build = function()
      require("Trans").install()
    end,
    keys = {
      -- 可以换成其他你想映射的键
      { "mm", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = " Translate" },
      { "mk", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = " Auto Play" },
      -- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
      { "mi", "<Cmd>TranslateInput<CR>", desc = " Translate From Input" },
    },
    dependencies = { "kkharji/sqlite.lua" },
    config = true,
  },
  {
    "cappyzawa/trim.nvim",
    config = true,
    cmd = {
      "TrimToggle",
      "Trim",
    },
    event = "BufWritePre",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      if jit.os:find("Windows") then
        require("nvim-treesitter.install").prefer_git = false
      end
    end,
  },
}
