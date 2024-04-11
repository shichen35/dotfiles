return {
  name = "cmake build & run",
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
        {
          "dependencies",
          task_names = { { cmd = "cmake", args = { "--build", "build", "--target", params.target } } },
        },
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
}
