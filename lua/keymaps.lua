-- WhichKey keymaps
local wkc = require("conf.whichkey-conf")
local wk = require("which-key")

-- Explicit keymaps
--
local keymap = vim.api.nvim_set_keymap
vim.g.mapleader = " "

local ops = { noremap = true, silent = true }

--- Window Navigation
keymap("n", "<C-l>", "<C-w>l", ops)
keymap("n", "<C-h>", "<C-w>h", ops)
keymap("n", "<C-j>", "<C-w>j", ops)
keymap("n", "<C-k>", "<C-w>k", ops)

-- Search
keymap("n", "/", ':lua require("searchbox").incsearch()<CR>', ops)
keymap("v", "/", '<Esc><cmd>lua require("searchbox").incsearch({visual_mode = true})<CR>', ops)

-- Buffer Navigation
keymap("n", "L", ":bn!<CR>", ops)
keymap("n", "H", ":bp!<CR>", ops)
keymap("v", "L", ":bn!<CR>", ops)
keymap("v", "H", ":bp!<CR>", ops)

keymap("n", "E", "$", ops)
keymap("v", "E", "$", ops)

-- Completion & Lsp
keymap("i", "<expr><TAB>", 'pumvisible() ? "\\<C-n>" : \\"<TAB>"', ops)
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", ops)

-- Tab indent
keymap("v", "<", "<gv", ops)
keymap("v", ">", ">gv", ops)
keymap("n", "<TAB>", "<gv", ops)
keymap("n", "<S-TAB>", ">gv", ops)
keymap("v", "<TAB>", "<gv", ops)
keymap("v", "<S-TAB>", ">gv", ops)

-- Escapes
keymap("i", "jk", "<ESC>", ops)
keymap("i", "kj", "<ESC>", ops)
keymap("i", "jj", "<ESC>", ops)

-- Smooth Scorlling
local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "450" } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "450" } }
t["F"] = { "scroll", { "-0.10", "false", "100" } }
t["N"] = { "scroll", { "0.10", "false", "100" } }
t["zt"] = { "zt", { "250" } }
t["zz"] = { "zz", { "250" } }
t["zb"] = { "zb", { "250" } }

require("neoscroll.config").set_mappings(t)

local smap = {
    t = { "<cmd>tabnew<cr>", "New Tab" },
    v = { "<cmd>vsplit<cr>", "Vertical Split" },
    h = { "<cmd>split<cr>", "Horizontal Split" },
}

local tmap = {
    h = { "<cmd>lua splitTerm(2)<cr>", "Horizontally Split Terminal" },
    v = { "<cmd>lua splitTerm(1)<cr>", "Vertically Split Terminal" },
    t = { "<cmd>lua floatingTerm(3)<cr>", "Open Terminal" },
}

local gmaps = {
    c = "Comment line",
    b = "Comment Block",
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "GoTo Definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "GoTo Declaration" },
    r = { "<cmd>lua vim.lsp.buf.references()<cr>", "GoTo References" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "GoTo Implementation" },
}

_G.formatnSave = function()
    vim.cmd(vim.g.fmtCmd)
    vim.cmd("write")
end

local mappings = {
    ["e"] = { "<cmd>NvimTreeFocus<CR>", "Explorer" },
    ["q"] = { "<cmd>q<CR>", "Quit" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["x"] = { "<cmd>Bdelete<cr>", "Close Buffer" },
    ["<SPC>"] = { "<ESC>", "ESC" },
    ["r"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Refactor" },

    c = {
        name = "Config",
        r = { "<cmd>so %" .. vim.fn.stdpath("config") .. "/init.lua" .. "<cr>", "Reload config" },
        o = { "<cmd>e " .. vim.fn.stdpath("config") .. "/init.lua" .. "<cr>", "Opens config" },
    },
    f = {
        name = "Project",
        f = { "<cmd>Telescope find_files<CR>", "Find File" },
        s = { [[<cmd>lua formatnSave()<CR>]], "Save" },
        r = { "<cmd>Telescope frecency<CR>", "Recent Files" },
        p = { "<cmd>Telescope projects<cr>", "List Projects" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
    },

    w = {
        name = "Window",
        q = { "<cmd>qall<CR>", "Quit Nvim" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        t = { "<cmd>tabnew<cr>", "New Tab" },
        l = { "<C-w>l", "Left" },
        h = { "<C-w>h", "Right" },
        j = { "<C-w>j", "Up" },
        k = { "<C-w>k", "Down" },
        i = { "<C-w>>", "Increase width" },
        d = { "<C-w><", "Decrease breadth" },
        e = { "<C-w>=", "Equal height & width" },
        f = { "<C-w>|", "Max out current win" },
        x = { "<C-w>x", "Swap current with next" },
        w = { "<C-w>w", "Switch Window" },
        T = { "<C-w>T", "Break out into Tab " },
        P = {
            "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
            "Colorscheme with Preview",
        },
    },

    b = {
        name = "Buffers",
        j = { "<cmd>BufferLinePick<cr>", "Jump" },
        f = { "<cmd>Telescope buffers<cr>", "Find" },
        b = { "<cmd>bp<cr>", "Previous" },
        w = { "<cmd>Bwipeout<cr>", "Wipeout" },
        h = { "<cmd>Alpha<cr>", "Start Buffer" },
        c = { "<cmd>Bdelete<CR>", "Close Buffer" },
        p = { "<cmd>BufferLinePickClose<cr>", "Pick close buffers" },
        D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
        L = { "<cmd>BufferLineSortByLanguage<cr>", "Sort by language" },
    },

    s = {
        name = "Session",
        n = { "<cmd>mksession<cr>", "New Session" },
        l = { "<cmd>LoadLastSession<cr>", "Last Session" },
        f = { "<cmd>Telescope sessions<cr>", "List Sessions" },
        s = { "<cmd>SaveSession<cr>", "Save Session" },
        d = { "<cmd>LoadCurrentDirSession<cr>", "CurrentDir Session" },
    },

    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    l = {
        name = "LangSpec",
        d = { "<cmd>Telescope diagnostics " .. vim.fn.bufnr() .. "<cr>", "Document Diagnostics" },
        w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
        r = { "<cmd>lua require('Executer').runProject()<cr>", "Run Project" },
        b = { "<cmd>lua require('Executer').buildProject()<cr>", "Build Project" },
        g = { "<cmd>lua require('Executer').generateConfig()<cr>", "Gen Project run/build conf" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        u = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    },

    g = {
        name = "Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
        f = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage File" },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout Commit" },
        C = { "<cmd>Telescope git_bcommits<cr>", "Checkout Commit(for current file)" },
        d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
    },
}

local vmappings = {}

for i = 1, 9 do
    local cmd = "<cmd>exe " .. i .. "'wincmd w'" .. "<cr>"
    mappings["" .. i] = { cmd, "Win " .. i }
    mappings.b["" .. i] = { "<cmd>BufferLineGoToBuffer " .. i .. "<cr>", "Buffer " .. i }
end

wk.setup(wkc.config.setup)

-- Leader keymaps
wk.register(mappings, wkc.config.opts)
wk.register(vmappings, wkc.config.vopts)
-- `s` keymaps
wk.register(smap, { mode = "n", prefix = "s", silent = true })
wk.register(smap, { mode = "v", prefix = "s", silent = true })

-- Terminal keymaps
wk.register(tmap, { mode = "n", prefix = "t", silent = true })
-- `g` keymaps
wk.register(gmaps, { mode = "v", prefix = "g", silent = true })
wk.register(gmaps, { mode = "n", prefix = "g", silent = true })
