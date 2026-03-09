return {
  {
    "mini.ai",
    opts = {
      custom_textobjects = {
        L = { "^%s*()[^\n]*()\n?$" }, -- line
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      {
        "Kaiser-Yang/blink-cmp-dictionary",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    opts = {
      sources = {
        default = { "dictionary" },
        providers = {
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            min_keyword_length = 3,
            max_items = 8,
            score_offset = -5,
            opts = {
              dictionary_files = { vim.fn.stdpath("config") .. "/assets/american-english" },
            },
          },
        },
      },
      fuzzy = { implementation = "lua" },
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
    opts = {},
  },
  {
    "cappyzawa/trim.nvim",
    opts = {},
    cmd = {
      "TrimToggle",
      "Trim",
    },
    event = "LazyFile",
    keys = {
      { "<leader>u<space>", "<Cmd>TrimToggle<CR>", desc = "Toggle trim on save" },
    },
  },
}
