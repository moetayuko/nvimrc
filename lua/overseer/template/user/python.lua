return {
  name = "python run",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "python" },
      args = { file },
      strategy = { "toggleterm", direction = "horizontal" },
    }
  end,
  condition = {
    filetype = { "python" },
  },
}
