local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = function(client, buf)
            vim.cmd([[command! Format execute 'lua vim.lsp.buf.formatting()']])

            if client.name == "sumneko_lua" then
                vim.api.nvim_buf_set_keymap(
                    buf,
                    "n",
                    "<leader>lf",
                    '<cmd>lua require("stylua-nvim").format_file()<CR>',
                    { noremap = true }
                )
                vim.g.fmtCmd = 'lua require("stylua-nvim").format_file()'
            else
                vim.g.fmtCmd = "lua vim.lsp.buf.formatting()"
            end
        end,
    }

    if server.name == "sumneko_lua" then
        local lualspConf = require("lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", lualspConf, opts)
    end

    server:setup(opts)
end)

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
