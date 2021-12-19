require('lsp.lua-ls')
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == "sumneko_lua" then
        opts = {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                        path = vim.split(package.path, ';')
                    },
                    diagnostics = {
                        globals = {'vim'}
                    },
                    workspace = {
                        library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
                    }
                }
            }

        }
    end


    server:setup(opts)
end)

vim.cmd [[ autocmd CursorHold * lua vim.lsp.buf.hover() ]]

vim.diagnostic.config({virtual_text = true, signs = true, underline = true, update_in_insert = false, severity_sort = false})

local signs = {Error = " ", Warn = " ", Hint = " ", Info = " "}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

