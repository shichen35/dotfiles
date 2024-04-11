return {
  name = "cmake configure",
  params = {
    build_type = {
      type = "enum",
      name = "Build type",
      order = 1,
      optional = false,
      default = "debug",
      choices = { "debug", "release", "coverage" },
    },
    -- build_dir = {
    --   name = "Build Directory",
    --   order = 2,
    --   optional = true,
    --   default = "build",
    -- },
  },
  builder = function(params)
    return {
      cmd = { "cmake" },
      args = {
        ".",
        "-B=build",
        -- "-B=" .. tostring(params.build_dir),
        -- '-G=Unix Makefiles',
        "-DCMAKE_BUILD_TYPE=" .. tostring(params.build_type),
        "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
      },
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
}
