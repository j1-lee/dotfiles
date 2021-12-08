local cmp = require 'cmp'

cmp.setup {
  snippet = {expand = function(args) vim.fn['vsnip#anonymous'](args.body) end},
  sources = cmp.config.sources({{name = 'nvim_lsp'}}, {{name = 'buffer'}}),
  completion = {completeopt = 'menuone,noinsert'},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require 'lspconfig'
local servers = {'pyright'}
for _, server in ipairs(servers) do
  lspconfig[server].setup {capabilities = capabilities}
end
