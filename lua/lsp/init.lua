require('lsp.lua-ls')

local lspconf = require 'lspconfig'

lspconf.rust_analyzer.setup {cmd = {'rust-analyzer'}}

lspconf.clangd.setup {cmd = {'clangd'}}

lspconf.bashls.setup {}

lspconf.jsonls.setup {}


lspconf.pylsp.setup {}

lspconf.tsserver.setup {
    cmd = {"typescript-language-server", "--stdio"},
    filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"},
    init_options = {hostInfo = "neovim"}
}

lspconf.cmake.setup {cmd = {'cmake-language-server'}}

