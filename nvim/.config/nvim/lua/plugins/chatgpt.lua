return {
  "jackMort/ChatGPT.nvim",
  cmd = {
    "ChatGPT",
    "ChatGPTActAs",
    "ChatGPTEditWithInstructions",
    "ChatGPTRun",
    "ChatGPTCompleteCode",
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  },
  keys = {
    { "<leader>ai", "<cmd>ChatGPT<cr>",                     desc = "ChatGPT",       mode = "n", },
    { "<leader>ac", "<cmd>ChatGPTCompleteCode<cr>",         desc = "Complete Code", mode = "n", },
    { "<leader>aa", "<cmd>ChatGPTActAs<cr>",                desc = "Act As GPT",    mode = "n", },
    { "<leader>ae", "<cmd>ChatGPTEditWithInstructions<cr>", desc = "Edit GPT",      mode = { "n", "v" } },
    { "<leader>ar", "<cmd>lua _RUN_ACTIONS()<cr>",          desc = "Run Actions",   mode = "v" },
  },
  opts = {
    api_key_cmd = "gpg --decrypt " .. vim.fn.expand("$HOME") .. "/.openai.key",
    edit_with_instructions = {
      diff = false,
      keymaps = {
        close = "<C-c>",
        accept = "<C-g>",
        toggle_diff = "<C-d>",
        toggle_settings = "<C-o>",
        cycle_windows = "<Tab>",
        use_output_as_input = "<C-i>",
      },
    },
    actions_paths = {
      "~/.config/nvim/lua/configs/chatgpt_actions.json",
    },
  },
  config = function(_, opts)
    require("chatgpt").setup(opts)

    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"
    local run_actions = require("chatgpt.flows.actions").read_actions()
    local notify = require("notify")

    local dropdownTheme = require("telescope.themes").get_dropdown();
    local keys = {}
    for key, _ in pairs(run_actions) do
      table.insert(keys, key)
    end
    table.sort(keys)
    local action_picker = pickers.new(dropdownTheme, {
      prompt_title = "Run GPT Actions",
      finder = finders.new_table {
        results = keys
      },
      sorter = require("telescope.config").values.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        -- Custom keymap to execute the selected command
        map('i', '<C-CR>', function()
          local selection = action_state.get_selected_entry(prompt_bufnr)
          -- if selection is null then notify an error message
          if selection == nil then
            notify("No selection", "error", { title = "Error" })
            return
          end
          actions.close(prompt_bufnr)
          vim.ui.input({ prompt = 'Args: ' }, function(input)
            vim.cmd("ChatGPTRun " .. selection.value .. " " .. input)
          end)
        end)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry(prompt_bufnr)
          if selection == nil then
            notify("No selection", "error", { title = "Error" })
            return
          end
          vim.cmd("ChatGPTRun " .. selection.value)
        end)
        return true
      end,
    })
    function _RUN_ACTIONS()
      action_picker:find()
    end
  end,
}
