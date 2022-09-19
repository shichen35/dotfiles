return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-ui-select.nvim' }

    use 'AndrewRadev/splitjoin.vim'
    use 'Yggdroot/indentLine'
    use 'ap/vim-css-color'
    use 'easymotion/vim-easymotion'
    -- use 'haya14busa/is.vim'
    use 'itchyny/lightline.vim'
    use 'junegunn/vim-easy-align'
    use 'mbbill/undotree'
    -- use 'mg979/vim-visual-multi', {'branch': 'master'}
    use 'morhetz/gruvbox'
    use 'arcticicestudio/nord-vim'
    -- use 'preservim/nerdtree'
    -- use 'rust-lang/rust.vim'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'



    -- use 'folke/trouble.nvim'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    -- use 'hrsh7th/cmp-vsnip'
    -- use 'hrsh7th/vim-vsnip'
    -- use 'hrsh7th/vim-vsnip-integ'
    use 'j-hui/fidget.nvim'
    use {
        'kosayoda/nvim-lightbulb',
        requires = 'antoinemadec/FixCursorHold.nvim',
    }
    use 'm-demare/hlargs.nvim'
    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'simrat39/rust-tools.nvim'
    use 'weilbith/nvim-code-action-menu'
    use 'williamboman/nvim-lsp-installer'

    require("telescope").load_extension("ui-select")
    -- require("trouble").setup()
    require("fidget").setup()
    vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]
    local cmp = require('cmp')
    cmp.setup({
        snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'nvim_lsp_signature_help' },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
            return vim_item
        end
    }
})

require('nvim-treesitter.configs').setup {
  ensure_installed = { "bash", "c", "cmake", "css", "dockerfile", "go", "gomod", "gowork", "hcl", "help", "html", "http", "javascript", "json", "lua", "make", "markdown", "python", "regex", "ruby", "rust", "toml", "vim", "yaml", "zig" },
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}
require('hlargs').setup()
local rt = {
    server = {
        settings = {
            on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                require 'illuminate'.on_attach(client)
            end,
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            },
        }
    },
}
require('rust-tools').setup(rt)

end)
