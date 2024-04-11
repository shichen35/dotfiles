return {
  name = "cmake build & run",
  params = {
    target_binary = {
      type = "string",
      name = "Target",
      order = 1,
      optional = false,
      default = "app",
    },
    args = {
      type = "string",
      name = "Arguments",
      order = 2,
      optional = false,
      default = "",
    },
  },
  builder = function(params)
    return {
      cmd = { "./build/" .. params.target_binary },
      args = {
        params.args,
      },
      components = {
        {
          "dependencies",
          task_names = { { cmd = "cmake", args = { "--build", "build", "--target", params.target_binary } } },
        },
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
}
