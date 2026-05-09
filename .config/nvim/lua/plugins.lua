local config = require 'config'

local function use(plugins)
  for _, plugin in ipairs(plugins) do
    if type(plugin) == "string" then plugin = { plugin } end
    local req, src, cfg = plugin.requires, unpack(plugin)
    if req then use(req) end
    vim.pack.add { "https://github.com/" .. src }
    if cfg then cfg() end
  end
end

use {

  -- colorscheme and status
  { 'rebelot/kanagawa.nvim', config.kanagawa },
  { 'nvim-lualine/lualine.nvim', config.lualine },
  { 'lewis6991/gitsigns.nvim', config.gitsigns },

  -- editing
  { 'windwp/nvim-autopairs', config.autopairs },
  { 'junegunn/vim-easy-align', config.easy_align },
  { 'kylechui/nvim-surround' },

  -- filetypes
  { 'j1-lee/vim-maki', config.maki },
  { 'R-nvim/R.nvim', config.r },
  { 'lervag/vimtex' },
  { 'nvim-treesitter/nvim-treesitter' },

  -- LSP, completion, and snippet
  {
    'hrsh7th/nvim-cmp', config.cmp,
    requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-omni' }
  },
  { 'L3MON4D3/LuaSnip', config.luasnip },
  { 'neovim/nvim-lspconfig', config.lspconfig },

  -- others
  { 'ludovicchabant/vim-gutentags', config.gutentags },
  {
    'nvim-telescope/telescope.nvim', config.telescope,
    requires = { 'nvim-lua/plenary.nvim' }
  },

}
