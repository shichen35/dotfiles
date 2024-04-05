return {
  name = "cmake rm build",
  builder = function()
    return {
      cmd = { "rm" },
      args = { "-rf", "build" },
    }
  end,
}
