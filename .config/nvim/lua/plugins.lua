return require('packer').startup(
  function(use)

    use 'wbthomason/packer.nvim'

    -- colorscheme

    use {
      'sainnhe/gruvbox-material',
      config = function()
        vim.opt.termguicolors = true
        vim.g.gruvbox_material_background = 'hard'
        vim.cmd [[colorscheme gruvbox-material]]
      end
    }


    -- status (or the like)

    use {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('lualine').setup {
          options = {
            icons_enabled = false,
            section_separators = '', component_separators = '',
            disabled_filetypes = {'netrw'}
          }
        }
      end
    }

    use 'mhinz/vim-signify'

    -- editing

    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'

    use {
      'windwp/nvim-autopairs',
      config = function()
        local autopairs = require 'nvim-autopairs'
        local rule = require 'nvim-autopairs.rule'

        autopairs.setup()
        autopairs.add_rule(rule('$', '$', 'tex'))

        vim.keymap.set({'n', 'i'}, '<M-p>', -- toggle autopairs
          function()
            if autopairs.state.disabled then
              autopairs.enable()
              print("Autopairs on")
            else
              autopairs.disable()
              print("Autopairs off")
            end
          end
        )
      end
    }

    use {
      'junegunn/vim-easy-align',
      config = function()
        vim.keymap.set({'x', 'n'}, 'ga', "<Plug>(EasyAlign)")
      end
    }

    -- filetypes

    use {
      'lervag/vimtex',
      config = function()
        vim.g.vimtex_quickfix_mode = 0 -- don't open quickfix automatically
      end
    }

    use {
      'j1-lee/vim-maki',
      config = function()
        vim.g.maki_root = '$HOME/Sync/wiki'
        vim.g.maki_export = '$HOME/Sync/wiki'
      end
    }

    use {
      'jalvesaq/Nvim-R',
      config = function()
        vim.g.R_args = {'--no-save', '--no-restore', '--quiet'}
        vim.g.R_esc_term = 0
        vim.g.R_rconsole_width = 0 -- always use horizontal split
        vim.g.r_syntax_fun_pattern = 1
      end
    }

    -- LSP, completion, and snippet

    use {
      'neovim/nvim-lspconfig',
      config = function()
        require 'config.nvim-lspconfig' -- config/nvim-lspconfig.lua
      end
    }

    use {
      'hrsh7th/nvim-cmp',
      config = function()
        require 'config.nvim-cmp' -- config/nvim-cmp.lua
      end
    }

    use {
      'hrsh7th/vim-vsnip',
      config = function()
        vim.keymap.set({'i', 's'}, '<Tab>',
          "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'",
          {expr = true})
        vim.keymap.set({'i', 's'}, '<S-Tab>',
          "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
          {expr = true})
        vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/vsnip'
      end
    }

    -- nvim-cmp sources

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-omni'

    -- others

    use {
      'ludovicchabant/vim-gutentags',
      config = function()
        vim.g.gutentags_exclude_project_root = {vim.env.HOME}
      end
    }

  end
)
