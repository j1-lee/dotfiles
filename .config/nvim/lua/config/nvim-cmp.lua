local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end
  },
  sources = cmp.config.sources({{name = 'nvim_lsp'}}, {{name = 'buffer'}}),
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
  },
}
cmp.setup.filetype({'tex'}, {
  sources = cmp.config.sources({{name = 'omni'}}, {{name = 'buffer'}})
})
