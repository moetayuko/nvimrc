local overseer = require("overseer")

local tmpl = {
  params = { cmd = { type = "string" } },
  builder = function(params)
    local file = vim.fn.expand("%:p")
    local file_noext = vim.fn.fnamemodify(file, ":t:r")
    return {
      name = params.cmd .. " build and run",
      strategy = {
        "orchestrator",
        tasks = {
          {
            "shell",
            name = "build",
            cmd = string.format("%s -g -O2 -Wall -lm %s -o %s", params.cmd, file, file_noext),
            components = { { "on_output_quickfix", open = true }, "default" },
          },
          {
            "shell",
            name = "run",
            cmd = "./" .. file_noext,
            strategy = { "toggleterm", direction = "horizontal" },
          },
        },
      },
    }
  end,
}

return {
  generator = function(opts, cb)
    cb({
      overseer.wrap_template(tmpl, { name = "gcc build and run", condition = { filetype = "c" } }, { cmd = "gcc" }),
      overseer.wrap_template(tmpl, { name = "g++ build and run", condition = { filetype = "cpp" } }, { cmd = "g++" }),
    })
  end,
  condition = {
    filetype = { "c", "cpp" },
  },
}
