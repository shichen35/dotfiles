-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

return packer.startup(function(use)
use 'wbthomason/packer.nvim' -- Packer can manage itself

use 'lewis6991/impatient.nvim'
use 'williamboman/mason.nvim'
use 'williamboman/mason-lspconfig.nvim'

use 'nvim-telescope/telescope.nvim'
use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
use 'nvim-lua/plenary.nvim'
use 'nvim-telescope/telescope-ui-select.nvim'

-- lsp and cmp
use 'neovim/nvim-lspconfig'
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-nvim-lsp-signature-help'
use 'hrsh7th/cmp-vsnip'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-buffer'
use 'simrat39/rust-tools.nvim'
use 'hrsh7th/vim-vsnip'
use 'rafamadriz/friendly-snippets'
-- dap
use 'rcarriga/nvim-dap-ui'
use 'mfussenegger/nvim-dap'

use 'j-hui/fidget.nvim' -- standalone UI for nvim-lsp progress

-- use 'tpope/vim-fugitive'

use 'm-demare/hlargs.nvim'
use 'nvim-treesitter/nvim-treesitter'
use 'nvim-treesitter/nvim-treesitter-context'

use 'AndrewRadev/splitjoin.vim'
use 'lukas-reineke/indent-blankline.nvim'
use 'ap/vim-css-color'
use {
  'phaazon/hop.nvim',
  branch = 'v2',
  config = function()
    require'hop'.setup {}
  end
}
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
end)

