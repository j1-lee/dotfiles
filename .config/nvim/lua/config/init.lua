local config = {}

function config.kanagawa()
  vim.opt.termguicolors = true
  require('kanagawa').setup {
    overrides = function(colors)
      return { CursorLine = { bg = colors.theme.ui.bg_p1 } }
    end
  }
  vim.cmd.colorscheme 'kanagawa'
end

function config.lualine()
  require('lualine').setup {
    options = {
      icons_enabled = false,
      globalstatus = true,
      section_separators = '', component_separators = '',
    }
  }
end

function config.gitsigns()
  local gitsigns = require 'gitsigns'

  gitsigns.setup {
    on_attach = function()
      if vim.wo.diff then return false end
      vim.keymap.set('n', '[c', gitsigns.prev_hunk, { buffer = true })
      vim.keymap.set('n', ']c', gitsigns.next_hunk, { buffer = true })
      vim.keymap.set('n', 'gh', gitsigns.preview_hunk, { buffer = true })
      vim.keymap.set('n', 'gs', gitsigns.stage_hunk, { buffer = true })
      vim.keymap.set('n', 'gr', gitsigns.reset_hunk, { buffer = true })
    end
  }
end

function config.surround()
  require('nvim-surround').setup()
end

function config.autopairs()
  local autopairs = require 'nvim-autopairs'

  autopairs.setup()

  vim.keymap.set({ 'n', 'i' }, '<M-p>', function()
    if autopairs.state.disabled then
      autopairs.enable()
      print("Autopairs on")
    else
      autopairs.disable()
      print("Autopairs off")
    end
  end)
end

function config.easy_align()
  vim.keymap.set({ 'x', 'n' }, 'ga', "<Plug>(EasyAlign)")
end

function config.maki()
  vim.g.maki_root = '$HOME/Sync/wiki'
  vim.g.maki_export = '$HOME/Sync/wiki/export'
  vim.g.maki_auto_export = 1
end

function config.r()
  vim.g.R_args = { '--no-save', '--no-restore', '--quiet' }
  vim.g.R_esc_term = 0
  vim.g.R_rconsole_width = 0 -- always use horizontal split
  vim.g.R_assign = 0 -- don't imap _ to ->
  vim.g.R_disable_cmds = { 'RSendFunction' } -- conflicts with telescope \ff
  vim.g.r_syntax_fun_pattern = 1
  vim.g.r_indent_align_args = 0 -- avoid wasteful indentation
end

function config.treesitter()
  require('nvim-treesitter.configs').setup {
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(lang, bufnr)
        if lang == 'latex' then return true end
        return vim.api.nvim_buf_line_count(bufnr) > 9999
      end
    }
  }
end

function config.lspconfig()
  local lspconfig = require 'lspconfig'
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local function on_attach(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  end

  lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } },
        runtime = { version = 'Lua 5.1' }
      }
    }
  }
end

function config.cmp()
  local cmp = require 'cmp'

  cmp.setup {
    snippet = {
      expand = function(args) require('luasnip').lsp_expand(args.body) end
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    }),
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    },
  }

  cmp.setup.filetype({ 'tex' }, {
    sources = cmp.config.sources({
      { name = 'omni' },
    }, {
      { name = 'buffer' },
    })
  })
end

function config.luasnip()
  local luasnip = require 'luasnip'

  luasnip.config.setup {
    region_check_events = 'InsertEnter',
    store_selection_keys = '<Tab>',
  }

  vim.keymap.set('i', '<Tab>', function()
    if luasnip.expand_or_jumpable() then
      return '<Plug>luasnip-expand-or-jump'
    else
      return '<Tab>'
    end
  end, { expr = true })
  vim.keymap.set('s', '<Tab>', function() luasnip.jump(1) end)
  vim.keymap.set({ 'i', 's' }, '<S-Tab>', function() luasnip.jump(-1) end)

  require("luasnip.loaders.from_snipmate").lazy_load()
end

function config.gutentags()
  vim.g.gutentags_exclude_project_root = { vim.env.HOME }
end

function config.telescope()
  local builtin = require 'telescope.builtin'

  require('telescope').setup {
    defaults = {
      layout_config = { prompt_position = 'top' },
      sorting_strategy = 'ascending',
      path_display = { 'truncate' } ,
    }
  }

  local function get_git_root()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    if vim.v.shell_error ~= 0 then return end
    local dot_git_path = vim.fn.finddir('.git', '.;')
    return vim.fn.fnamemodify(dot_git_path, ':h')
  end

  local function git_or_shallow(picker)
    return function()
      local git_root = get_git_root()

      if git_root then picker { cwd = git_root } return end

      local cwd = require('telescope.utils').buffer_dir()

      if picker == builtin.find_files then
        picker {
          cwd = cwd,
          find_command = { 'rg', '--files', '--color=never', '--max-depth=1' },
        }
      else
        picker {
          cwd = cwd,
          additional_args = { '--max-depth=1' },
        }
      end
    end
  end

  vim.keymap.set('n', '<Leader>sf', git_or_shallow(builtin.find_files))
  vim.keymap.set('n', '<Leader>sg', git_or_shallow(builtin.live_grep))
end

return config
