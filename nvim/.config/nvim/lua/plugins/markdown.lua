return {
  "MeanderingProgrammer/markdown.nvim",
  name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
  ft = "markdown",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("render-markdown").setup({
      -- Capture groups that get pulled from markdown
      markdown_query = [[
        (atx_heading [
            (atx_h1_marker)
            (atx_h2_marker)
            (atx_h3_marker)
            (atx_h4_marker)
            (atx_h5_marker)
            (atx_h6_marker)
        ] @heading)

        (fenced_code_block) @code

        [
            (list_marker_plus)
            (list_marker_minus)
            (list_marker_star)
        ] @list_marker

        (block_quote (block_quote_marker) @quote_marker)
        (block_quote (paragraph (inline (block_continuation) @quote_marker)))

        (pipe_table_header) @table_head
        (pipe_table_delimiter_row) @table_delim
        (pipe_table_row) @table_row
    ]],
      -- Capture groups that get pulled from inline markdown
      inline_query = [[
        (code_span) @code
    ]],
      -- Filetypes this plugin will run on
      file_types = { "markdown" },
      -- Vim modes that will show a rendered view of the markdown file
      -- All other modes will be uneffected by this plugin
      render_modes = { "n", "c" },
      -- Characters that will replace the # at the start of headings
      headings = { "󰲠 ", "󰲢 ", "󰲤 ", "󰲦 ", "󰲨 ", "󰲪 " },
      -- Character to use for the bullet point in lists
      bullet = "•",
      -- Character that will replace the > at the start of block quotes
      quote = "┃",
      -- See :h 'conceallevel' for more information about meaning of values
      conceal = {
        -- conceallevel used for buffer when not being rendered, get user setting
        default = vim.opt.conceallevel:get(),
        -- conceallevel used for buffer when being rendered
        rendered = 3,
      },
      -- Define the highlight groups to use when rendering various components
      highlights = {
        heading = {
          -- Background of heading line
          backgrounds = { "DiffAdd", "DiffChange", "DiffDelete" },
          -- Foreground of heading character only
          foregrounds = {
            "markdownH1",
            "markdownH2",
            "markdownH3",
            "markdownH4",
            "markdownH5",
            "markdownH6",
          },
        },
        -- Code blocks
        code = "ColorColumn",
        -- Bullet points in list
        bullet = "Normal",
        table = {
          -- Header of a markdown table
          head = "@markup.heading",
          -- Non header rows in a markdown table
          row = "Normal",
        },
        -- LaTeX blocks
        latex = "@markup.math",
        -- Quote character in a block quote
        quote = "@markup.quote",
      },
    })
  end,
}
