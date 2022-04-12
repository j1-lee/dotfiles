local j1_lsp = {}

local cmp = require 'cmp'
cmp.setup {
  snippet = {expand = function(args) vim.fn['vsnip#anonymous'](args.body) end},
  sources = cmp.config.sources({{name = 'nvim_lsp'}}, {{name = 'buffer'}}),
  completion = {completeopt = 'menuone,noinsert'},
}
cmp.setup.filetype({'tex'}, {
  sources = cmp.config.sources({{name = 'omni'}}, {{name = 'buffer'}})
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function on_attach(_, bufnr)
  local function nmap_buf(lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, {silent = true})
  end
  nmap_buf('<Leader>e', '<Cmd>lua vim.diagnostic.open_float()<CR>')
  nmap_buf('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  nmap_buf('[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>')
  nmap_buf(']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>')
end

function j1_lsp.setup(servers)
  local lspconfig = require 'lspconfig'
  for _, server in ipairs(servers) do
    lspconfig[server].setup {capabilities = capabilities, on_attach = on_attach}
  end
end

return j1_lsp
