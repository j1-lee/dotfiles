require('packer').startup(function(use)

  local config = require 'config'

  use 'wbthomason/packer.nvim'

  -- colorscheme

  use { 'rebelot/kanagawa.nvim', config = config.kanagawa }

  -- status (or the like)

  use { 'nvim-lualine/lualine.nvim', config = config.lualine }
  use { 'lewis6991/gitsigns.nvim', config = config.gitsigns }

  -- editing

  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use { 'windwp/nvim-autopairs', config = config.autopairs }
  use { 'junegunn/vim-easy-align', config = config.easy_align }

  -- filetypes

  use 'lervag/vimtex'
  use { 'j1-lee/vim-maki', config = config.maki }
  use { 'jalvesaq/Nvim-R', config = config.r }

  -- LSP, completion, and snippet

  use { 'neovim/nvim-lspconfig', config = config.lspconfig }
  use {
    'hrsh7th/nvim-cmp', config = config.cmp,
    requires = { -- completion sources
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-omni',
    }
  }
  use { 'L3MON4D3/LuaSnip', config = config.luasnip }

  -- others

  use { 'ludovicchabant/vim-gutentags', config = config.gutentags }

end)
