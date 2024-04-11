return {
  name = "cmake run",
  params = {
    target_binary = {
      type = "string",
      name = "Target",
      optional = false,
      default = "app",
    },
  },
  builder = function(params)
    return {
      cmd = { "./build/" .. params.target_binary },
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
}
