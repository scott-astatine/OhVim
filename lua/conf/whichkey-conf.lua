local M = {}

M.smap = {
    t = {"<cmd>tabnew<cr>", "New Tab"},
    v = {"<cmd>vsplit<cr>", "Vertical Split"},
    h = {"<cmd>split<cr>", "Horizontal Split"},
    x = {"<cmd>term<cr>", "Open Terminal"}
}

M.gmaps = {
    c = "Comment line",
    b = "Comment Block",
    d = {"<cmd>lua vim.lsp.buf.definition()<cr>", "GoTo Definition"},
    D = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "GoTo Declaration"},
    r = {"<cmd>lua vim.lsp.buf.references()<cr>", "GoTo References"},
    i = {"<cmd>lua vim.lsp.buf.implementation()<cr>", "GoTo Implementation"}
}

local mappings = {
    ["e"] = {"<cmd>NvimTreeFocus<CR>", "Explorer"},
    ["q"] = {"<cmd>q<CR>", "Quit"},
    ["h"] = {"<cmd>nohlsearch<CR>", "No Highlight"},
    ["x"] = {"<cmd>Bdelete<cr>", "Close Buffer"},
    ["r"] = "Refresh NvimTree",

    f = {
        name = "Project",
        f = {"<cmd>Telescope find_files<CR>", "Find File"},
        s = {"<cmd>w!<CR>", "Save"},
        r = {"<cmd>Telescope frecency<CR>", "Recent Files"},
        p = {"<cmd>Telescope projects<cr>", "List Projects"},
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        h = {"<cmd>Telescope help_tags<cr>", "Find Help"},
        M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
        R = {"<cmd>Telescope registers<cr>", "Registers"},
        t = {"<cmd>Telescope live_grep<cr>", "Text"},
        k = {"<cmd>Telescope keymaps<cr>", "Keymaps"},
        C = {"<cmd>Telescope commands<cr>", "Commands"},
        P = {"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>", "Colorscheme with Preview"}

    },

    w = {
        name = "Window",
        q = {"<cmd>qall<CR>", "Quit"},
        c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
        t = {"<cmd>tabnew<cr>", "New Tab"},
        l = {"<C-w>l", "Left"},
        h = {"<C-w>h", "Right"},
        j = {"<C-w>j", "Up"},
        k = {"<C-w>k", "Down"}
    },

    b = {
        name = "Buffers",
        j = {"<cmd>BufferLinePick<cr>", "Jump"},
        f = {"<cmd>Telescope buffers<cr>", "Find"},
        b = {"<cmd>bp<cr>", "Previous"},
        w = {"<cmd>Bwipeout<cr>", "Wipeout"},
        h = {"<cmd>Alpha<cr>", "Start Buffer"},
        c = {"<cmd>Bdelete<CR>", "Close Buffer"},
        p = {"<cmd>BufferLinePickClose<cr>", "Pick close buffers"},
        D = {"<cmd>BufferLineSortByDirectory<cr>", "Sort by directory"},
        L = {"<cmd>BufferLineSortByLanguage<cr>", "Sort by language"}
    },

    s = {
        name = "Session",
        n = {"<cmd>mksession<cr>", "New Session"},
        l = {"<cmd>LoadLastSession<cr>", "Last Session"},
        f = {"<cmd>Telescope sessions<cr>", "List Sessions"},
        s = {"<cmd>SaveSession<cr>", "Save Session"},
        d = {"<cmd>LoadCurrentDirSession<cr>", "CurrentDir Session"}
    },

    p = {
        name = "Packer",
        c = {"<cmd>PackerCompile<cr>", "Compile"},
        i = {"<cmd>PackerInstall<cr>", "Install"},
        s = {"<cmd>PackerSync<cr>", "Sync"},
        S = {"<cmd>PackerStatus<cr>", "Status"},
        u = {"<cmd>PackerUpdate<cr>", "Update"}
    },

    l = {
        name = "LangSpec",
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        w = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format"},
        r = {"<cmd>lua require('PExec').runProject()<cr>", "Run Project"},
        b = {"<cmd>lua require('PExec').buildProject()<cr>", "Build Project"},
        g = {"<cmd>lua require('PExec').generateConfig()<cr>", "Genrate Project run/build conf"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        I = {"<cmd>LspInstallInfo<cr>", "Installer Info"},
        q = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"}
    },

    g = {
        name = "Git",
        j = {"<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk"},
        k = {"<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk"},
        l = {"<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame"},
        p = {"<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk"},
        r = {"<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk"},
        R = {"<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer"},
        s = {"<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk"},
        u = {"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk"},
        f = {"<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage File"},
        o = {"<cmd>Telescope git_status<cr>", "Open changed file"},
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        c = {"<cmd>Telescope git_commits<cr>", "Checkout Commit"},
        C = {"<cmd>Telescope git_bcommits<cr>", "Checkout Commit(for current file)"},
        d = {"<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff"}
    }

}

for i = 1, 9 do
    local cmd = "<cmd>exe " .. i .. "'wincmd w'" .. "<cr>"
    mappings["" .. i] = {cmd, "Win " .. i}
    mappings.b["" .. i] = {"<cmd>BufferLineGoToBuffer " .. i .. "<cr>", "Buffer " .. i}
end

M.config = {
    setup = {
        plugins = {
            marks = false, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            presets = {
                operators = false, -- adds help for operators like d, y, ...
                motions = false, -- adds help for motions
                text_objects = false, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true -- bindings for prefixed with g
            },
            spelling = {enabled = true, suggestions = 20} -- use which-key for spelling hints
        },
        icons = {
            breadcrumb = "≻", -- symbol used in the command line area that shows your active key combo
            separator = "⇒ ", -- symbol used between a key and it's label
            group = "∬" -- symbol prepended to a group
        },
        window = {
            border = "shadow", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = {0, 3, 0, 4}, -- extra window margin [top, right, bottom, left]
            padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
        },
        layout = {
            height = {min = 6, max = 25}, -- min and max height of the columns
            width = {min = 14, max = 40}, -- min and max width of the columns
            spacing = 8, -- spacing between columns
            align = "center"
        },
        hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", "<leader>"}, -- hide mapping boilerplate
        show_help = false
    },

    opts = {mode = "n", prefix = "<leader>", buffer = nil, silent = true, noremap = true, nowait = true},
    vopts = {mode = "v", prefix = "<leader>", buffer = nil, silent = true, noremap = true, nowait = true},

    vmappings = {},
    mappings = mappings
}

return M

