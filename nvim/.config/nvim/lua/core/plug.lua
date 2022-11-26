-- nvim_lsp object
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }

-- Show diagnostic popup on cursor hover
-- autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
vim.api.nvim_create_autocmd(
  {"CursorHold"}, --,"CursorHoldI"},
  {callback = function()vim.diagnostic.open_float(nil, { focusable = false }) end}
)
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

require("which-key").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

local rt = require("rust-tools")
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>gk', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, bufopts)
  vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<C-l>', vim.diagnostic.setloclist, bufopts)
  -- Hover actions
  vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
  vim.keymap.set("n", "<leader>ha", rt.hover_actions.hover_actions, { buffer = bufnr })
  vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {}
  }
}

local release = vim.loop.os_uname().release
local sysname = vim.loop.os_uname().sysname

local liblldb_path
local extension_path

if string.find(release, "android") then
  liblldb_path = "/data/data/com.termux/files/usr/lib/liblldb.so"
  codelldb_path = "/data/data/com.termux/files/usr/bin/lldb-vscode"
else
  local install_root_dir = vim.fn.stdpath "data" .. "/mason"
  local extension_path = install_root_dir .. "/packages/codelldb/extension/"
  codelldb_path = extension_path .. "adapter/codelldb"
  if sysname == "Linux" then
    liblldb_path = extension_path .. "lldb/lib/liblldb.so"
  elseif sysname == "Darwin" then
    liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
  else
    error("invalid operation")
  end
end

local dap, dapui = require("dap"), require("dapui")
-- dap.adapters.codelldb = {
--   type = 'server',
--   port = "${port}",
--   executable = {
--     command = codelldb_path,
--     args = {"--port", "${port}"},
--     -- On windows you may have to uncomment this:
--     -- detached = false,
--   }
-- }
-- dap.configurations.cpp = {
--   {
--     name = "Launch file",
--     type = "codelldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = true,
--   },
-- }

-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "x",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local opts = {
  tools = { -- rust-tools options

    -- how to execute terminal commands
    -- options right now: termopen / quickfix
    executor = require("rust-tools/executors").termopen,

    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,

    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- automatically set inlay hints (type hints)
      -- default: true
      auto = true,

      -- Only show inlay hints for the current line
      only_current_line = false,

      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",

      -- whether to align to the length of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "Comment",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {

      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = true,
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- standalone file support
    -- setting it to false may improve startup time
    on_attach = on_attach,
    standalone = true,
  }, -- rust-analyzer options

  -- debugging stuff
  dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(
          codelldb_path, liblldb_path)
  },
}

rt.setup(opts)
rt.hover_range.hover_range()

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}

-- Completion Plugin Setup
local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip
  },
  window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
  },
  formatting = {
    -- fields = {'menu', 'abbr', 'kind'},
    fields = {'abbr', 'kind'},

    format = function(entry, vim_item)
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        vim_item.abbr = string.sub(vim_item.abbr, 1, 24)
        return vim_item
    end
  },
})

-- require("trouble").setup()
require("fidget").setup()
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]

require('nvim-treesitter.configs').setup {
  -- ensure_installed = { "bash", "c", "cmake", "css", "dockerfile", "go", "gomod", "gowork", "hcl", "help", "html", "http", "javascript", "json", "lua", "make", "markdown", "python", "regex", "ruby", "rust", "toml", "vim", "yaml", "zig" },
  ensure_installed = { "lua", "rust", "toml" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}
require('hlargs').setup()
require("mason").setup()

function set_hl()
  vim.api.nvim_set_hl(0, 'Red', {fg='#d95555'})
  vim.api.nvim_set_hl(0, 'Yellow', {fg='#efd472'})
  vim.api.nvim_set_hl(0, 'Orange', {fg='#fc6600'})
  vim.api.nvim_set_hl(0, 'Green', {fg='#98c379'})
  vim.api.nvim_set_hl(0, 'Blue', {fg='#61afef'})

  local signs = {
    { name = "DiagnosticSignError", text = "", hl = "Red" },
    { name = "DiagnosticSignWarn", text = "", hl = "Orange" },
    { name = "DiagnosticSignHint", text = "", hl = "Blue" },
    { name = "DiagnosticSignInfo", text = "", hl = "Yellow" },
    { name = "DapBreakpoint", text = "", hl = "Red" },
    { name = "DapBreakpointCondition", text = "ﳁ", hl = "Red" },
    { name = "DapBreakpointRejected", text = "", hl = "Red" },
    { name = "DapLogPoint", text = "", hl = "Blue" },
    { name = "DapStopped", text = "", hl = "Green" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { text = sign.text, linehl = sign.hl, texthl = sign.hl, numhl = sign.hl })
  end
end
set_hl()

vim.cmd([[
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! link CmpItemKindInterface CmpItemKindVariable
highlight! link CmpItemKindText CmpItemKindVariable
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! link CmpItemKindMethod CmpItemKindFunction
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! link CmpItemKindProperty CmpItemKindKeyword
highlight! link CmpItemKindUnit CmpItemKindKeyword

" Switching themes automatically in lightline.vim
function! s:onColorSchemeChange(scheme)
    lua set_hl()
    " Try a scheme provided already
    execute 'runtime autoload/lightline/colorscheme/'.a:scheme.'.vim'
    if exists('g:lightline#colorscheme#{a:scheme}#palette')
        let g:lightline.colorscheme = a:scheme
    else  " Try falling back to a known colour scheme
        let l:colors_name = get(g:colour_scheme_list, a:scheme, '')
        if empty(l:colors_name)
            return
        else
            let g:lightline.colorscheme = l:colors_name
        endif
    endif
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

augroup LightlineColorscheme
    autocmd!
    autocmd ColorScheme * call s:onColorSchemeChange(expand("<amatch>"))
augroup END

let g:lightline = {
            \ 'colorscheme': 'nord',
            \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'readonly', 'filename', 'modified' ] ],
                \   'right': [ [ 'lineinfo' ],
                \              [ 'percent' ],
                \              [ 'fileformat', 'fileencoding', 'filetype'] ]
                \ },
                \ 'component_function': {
                    \   'percent': 'ScrollIndicator',
                    \   'lineinfo': 'LightlineLineinfo',
                    \ },
                \ 'component': {
                    \  'filename': '%n:%t'
                    \ }
                    \ }

function! LightlineLineinfo()
    let l:current_line = printf('%3d', line('.'))
    let l:max_line = printf('%d', line('$'))
    let l:current_col = printf('%-2d', col('.'))
    let l:lineinfo = ' ' . l:current_line . '/' . l:max_line . ':' . l:current_col
    return l:lineinfo
endfunction

function! ScrollIndicator()
    let l:line_no_indicator_chars = ['⎺', '⎻', '─', '⎼', '⎽']
    let l:current_line = line('.')
    let l:total_lines = line('$')
    let l:line_no_fraction = floor(l:current_line) / floor(l:total_lines)
    if l:current_line == l:total_lines
        let l:index = len(l:line_no_indicator_chars) - 1
    else
        let l:index = float2nr(l:line_no_fraction * len(l:line_no_indicator_chars))
    endif
    let l:percentage = printf("%3d%%",float2nr(l:line_no_fraction * 100))
    "return l:percentage . ' ['.l:line_no_indicator_chars[l:index].']'
    return l:line_no_indicator_chars[l:index]
endfunction
]])
