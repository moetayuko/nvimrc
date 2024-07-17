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
    dependencies = { "nvim-telescope/telescope.nvim", optional = true },
    config = function()
      require("textcase").setup({})
      if LazyVim.has("telescope.nvim") then
        LazyVim.on_load("telescope.nvim", function()
          require("telescope").load_extension("textcase")
        end)
      end
    end,
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
    cmd = {
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "uga-rosa/cmp-dictionary",
        opts = {
          paths = { vim.fn.stdpath("config") .. "/assets/american-english" },
          first_case_insensitive = true,
        },
      },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local sources = vim.list_extend(opts.sources, {
        {
          name = "dictionary",
          keyword_length = 2,
        },
      })
      for _, src in pairs(sources) do
        if src.name == "buffer" then
          src.option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          }
        end
      end
      opts.sources = cmp.config.sources(sources)
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
    event = "LazyFile",
    keys = {
      { "<leader>u<space>", "<Cmd>TrimToggle<CR>", desc = "Toggle trim on save" },
    },
  },
}
