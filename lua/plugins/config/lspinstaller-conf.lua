local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings({

   ui = {
      icons = {
         server_installed = " ",
         server_pending = " ",
         server_uninstalled = " ﮊ",
      },
      keymaps = {
         toggle_server_expand = "<CR>",
         install_server = "i",
         update_server = "u",
         check_server_version = "c",
         update_all_servers = "U",
         check_outdated_servers = "C",
         uninstall_server = "X",
      },
   },

   max_concurrent_installers = 10,

})

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
        local luaLspConf = require("lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", luaLspConf, opts)
    end

    server:setup(opts)
end)



