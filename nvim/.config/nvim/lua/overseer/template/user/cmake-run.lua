return {
  name = "cmake run",
  params = {
    target = {
      type = "string",
      name = "Target",
      order = 1,
      optional = false,
      default = "app",
    },
    args = {
      type = "list",
      delimiter = " ",
      name = "Arguments",
      order = 2,
      optional = true,
    },
  },
  builder = function(params)
    return {
      cmd = { "./build/" .. params.target },
      args = params.args,
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
}
