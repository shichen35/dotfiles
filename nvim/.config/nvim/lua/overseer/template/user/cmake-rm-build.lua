return {
  name = 'cmake rm build',
  builder = function()
    return {
      cmd = { 'rm' },
      args = { '-rf', 'build' },
    }
  end,
}
-- {
--   name = "cmake build debug",
--   builder = function()
--     return {
--       cmd = { "cmake" },
--       args = {
--         ".",
--         "-B=build",
--         '-G="Unix Makefiles"',
--         "-DCMAKE_BUILD_TYPE=Debug",
--         "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
--       },
--     }
--   end,
-- },
