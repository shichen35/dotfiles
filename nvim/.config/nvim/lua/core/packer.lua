local fn = vim.fn
local api = vim.api

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print(PACKER_BOOTSTRAP)
  print "Packer installed..."
  print "Press Enter to install plugins"
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local packerGroup = api.nvim_create_augroup("PackerGroup", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
  desc = "Sync packer after modifying packer.lua",
  group = packerGroup,
  pattern = "packer.lua",
  command = "source <afile> | PackerSync",
})

-- Install your plugins here
return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  use 'lewis6991/impatient.nvim'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'

  -- lsp and cmp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  -- use 'simrat39/rust-tools.nvim'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  -- dap
  use 'rcarriga/nvim-dap-ui'
  use 'mfussenegger/nvim-dap'

  use 'j-hui/fidget.nvim' -- standalone UI for nvim-lsp progress

  -- use 'tpope/vim-fugitive'
  use 'goolord/alpha-nvim'

  use 'm-demare/hlargs.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-context'

  use 'AndrewRadev/splitjoin.vim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'ap/vim-css-color'
  use 'phaazon/hop.nvim'
  -- use 'easymotion/vim-easymotion'
  use 'haya14busa/is.vim' -- incremental search improved
  use 'itchyny/lightline.vim'
  use 'junegunn/vim-easy-align'
  use 'mbbill/undotree'
  use 'morhetz/gruvbox'
  use 'arcticicestudio/nord-vim'
  use 'preservim/nerdtree'
  -- use 'rust-lang/rust.vim'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'ryanoasis/vim-devicons'
  use 'folke/which-key.nvim'
  use 'lambdalisue/suda.vim'

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons",   -- keep this if you're using NvChad
    config = function()
      require("barbecue").setup()
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
    print "( After installing, please reopen NeoVim to load the plugins )"
  end
end)
