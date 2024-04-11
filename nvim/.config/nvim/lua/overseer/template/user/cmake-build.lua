return {
  name = "cmake build",
  builder = function()
    return {
      cmd = { "cmake" },
      args = {
        "--build",
        "build",
      },
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
}
