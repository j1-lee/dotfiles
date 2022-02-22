local cmp = require 'cmp'

cmp.setup {
  snippet = {expand = function(args) vim.fn['vsnip#anonymous'](args.body) end},
  sources = cmp.config.sources({{name = 'nvim_lsp'}}, {{name = 'buffer'}}),
  completion = {completeopt = 'menuone,noinsert'},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(_, bufnr)
  local nmap_buf = function(lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, {silent = true})
  end
  nmap_buf('<Leader>e', '<Cmd>lua vim.diagnostic.open_float()<CR>')
  nmap_buf('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
end

local lspconfig = require 'lspconfig'
local servers = {'pyright'}
for _, server in ipairs(servers) do
  lspconfig[server].setup {capabilities = capabilities, on_attach = on_attach}
end
