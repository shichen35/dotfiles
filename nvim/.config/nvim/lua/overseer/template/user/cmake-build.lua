return {
  name = "cmake build",
  builder = function()
    return {
      cmd = { "cmake" },
      args = {
        "--build",
        "build"
      },
    }
  end,
}
