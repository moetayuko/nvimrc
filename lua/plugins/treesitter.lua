return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if jit.os:find("Windows") then
        require("nvim-treesitter.install").prefer_git = false
      end
      return vim.tbl_deep_extend("force", opts, {
        textobjects = {
          swap = {
            enable = true,
            swap_next = {
              [">,"] = { query = "@parameter.inner", desc = "Swap next parameter" },
            },
            swap_previous = {
              ["<,"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
            },
          },
          move = {
            enable = true,
            goto_next_start = { ["]a"] = { query = "@parameter.outer", desc = "Goto next parameter" } },
            goto_previous_start = { ["[a"] = { query = "@parameter.outer", desc = "Goto previous parameter" } },
          },
        },
      })
    end,
  },
}
