return {
  name = "cmake build",
  params = {
    target = {
      type = "string",
      name = "Target",
      order = 1,
      optional = false,
      default = "app",
    },
  },
  builder = function(params)
    return {
      cmd = { "cmake" },
      args = {
        "--build",
        "build",
        "--target",
        params.target,
      },
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
}
