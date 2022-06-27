local M = {}

M.config = {
    setup = {
        plugins = {
            marks = false,
            registers = true,
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            presets = {
                operators = false, -- adds help for operators like d, y, ...
                motions = false, -- adds help for motions
                text_objects = false, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            },
            spelling = { enabled = true, suggestions = 20 },
        },
        icons = {
            breadcrumb = "⇛≻",
            separator = "⇒ ",
            group = "∬ ",
        },
        window = {
            border = "double",
            position = "bottom",
            margin = { 0, 3, 0, 4 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        },
        layout = {
            height = { min = 6, max = 25 }, -- min and max height of the columns
            width = { min = 14, max = 40 }, -- min and max width of the columns
            spacing = 8, -- spacing between columns
            align = "center",
        },
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = false,
    },

    opts = { mode = "n", prefix = "<leader>", buffer = nil, silent = true, noremap = true, nowait = true },
    vopts = { mode = "v", prefix = "<leader>", buffer = nil, silent = true, noremap = true, nowait = true },
}

return M
