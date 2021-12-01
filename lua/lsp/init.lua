require('lsp.lua-ls')

local lspconf = require 'lspconfig'

lspconf.rust_analyzer.setup {
  cmd = {'rust-analyzer'}
}

lspconf.clangd.setup {}

lspconf.bashls.setup {}

lspconf.jsonls.setup {}

lspconf.vimls.setup {}

lspconf.pylsp.setup {}

lspconf.tsserver.setup {}

lspconf.cmake.setup {}

