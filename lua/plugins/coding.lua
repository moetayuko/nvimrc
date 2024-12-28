return {
  {
    "L3MON4D3/LuaSnip",
    optional = true,
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
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "x", "o" },
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "x", "o" },
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "x", "o" },
      },
      {
        "ge",
        "<cmd>lua require('spider').motion('ge')<CR>",
        mode = { "n", "x", "o" },
      },
    },
  },
  {
    "echasnovski/mini.ai",
    opts = {
      custom_textobjects = {
        L = { "^%s*()[^\n]*()\n?$" }, -- line
      },
    },
  },
  {
    "johmsalas/text-case.nvim",
    event = "LazyFile",
    opts = {
      prefix = "gz",
    },
    keys = {
      "gz", -- Default invocation prefix
    },
    cmd = {
      "Subs",
      "TextCaseStartReplacingCommand",
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      { "saghen/blink.compat" },
      {
        "uga-rosa/cmp-dictionary",
        opts = {
          paths = { vim.fn.stdpath("config") .. "/assets/american-english" },
          first_case_insensitive = true,
        },
      },
    },
    opts = {
      sources = {
        compat = {
          "dictionary",
        },
        providers = {
          dictionary = {
            kind = "String",
          },
        },
      },
    },
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
    event = "LazyFile",
    keys = {
      { "<leader>u<space>", "<Cmd>TrimToggle<CR>", desc = "Toggle trim on save" },
    },
  },
  {
    "echasnovski/mini.align",
    opts = {},
    keys = {
      { "ga", mode = { "n", "v" }, desc = "Start alignment" },
      { "gA", mode = { "n", "v" }, desc = "Start alignment with preview" },
    },
  },
}
