-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
-- Packer can manage itself
use 'wbthomason/packer.nvim'

use 'williamboman/mason.nvim'
use 'williamboman/mason-lspconfig.nvim'

use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
}
use {'nvim-telescope/telescope-ui-select.nvim' }

use 'neovim/nvim-lspconfig'
--
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-nvim-lsp-signature-help'
use 'hrsh7th/cmp-vsnip'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-buffer'
use 'simrat39/rust-tools.nvim'
use 'hrsh7th/vim-vsnip'
use 'rafamadriz/friendly-snippets'

use 'nvim-lua/popup.nvim'

use 'weilbith/nvim-code-action-menu'
use 'j-hui/fidget.nvim'
-- use {
--   'kosayoda/nvim-lightbulb',
--   requires = 'antoinemadec/FixCursorHold.nvim',
-- }
use 'm-demare/hlargs.nvim'
use 'nvim-treesitter/nvim-treesitter'
use 'nvim-treesitter/nvim-treesitter-context'

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
end)

