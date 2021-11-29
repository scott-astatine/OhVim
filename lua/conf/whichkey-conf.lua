local M = {}

local mappings = {
  ["s"] = { "<cmd>w!<CR>", "Save" },
  ["e"] = { "<cmd>NvimTreeFocus<CR>", "Save" },
  ["q"] = { "<cmd>q<CR>", "Quit" },
  ["/"] = { "<cmd>lua require('Comment').toggle()<CR>", "Comment" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["L"] = { "<cmd>bn<CR>", "Next Buffer" },
  ["H"] = { "<cmd>bp<CR>", "Previous Buffer" },
  ["x"] = "Ex Mode",

  f = {
    name = "File",
    f = { "<cmd>Telescope find_files<CR>", "Find File" },
    r = { "<cmd>Telescope oldfiles<CR>", "Recent Files" },
    l = { "<cmd>blast<CR>", "Find File" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    p = {
      "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },

  },

  w = {
    name = "Window",
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    l = {"<C-w>l", "Left"},
    h = {"<C-w>h", "Right"},
    j = {"<C-w>j", "Up"},
    k = {"<C-w>k", "Down"}
  },

  b = {
    name = "Buffers",
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    f = { "<cmd>Telescope buffers<cr>", "Find" },
    b = { "<cmd>bp<cr>", "Previous" },
    w = { "<cmd>Bwipeout<cr>", "Wipeout" },
    c = { "<cmd>Bdelete<CR>", "Close Buffer" },
    p = {
      "<cmd>BufferLinePickClose<cr>",
      "Pick close buffers",
    },
    h = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all to the left" },
    l = {
      "<cmd>BufferCloseBuffersRight<cr>",
      "Close all to the right",
    },
    D = {
      "<cmd>BufferOrderByDirectory<cr>",
      "Sort by directory",
    },
    L = {
      "<cmd>BufferOrderByLanguage<cr>",
      "Sort by language",
    },
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
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
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Git Diff",
    },
  },

  l = {
    name = "LSP",
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
}

M.config = {
    setup = {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
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
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      window = {
        border = "double", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 4, 3, 0, 4 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      },
      layout = {
        height = { min = 6, max = 25 }, -- min and max height of the columns
        width = { min = 15, max = 50 }, -- min and max width of the columns
        spacing = 8, -- spacing between columns
        align = "center"
      },
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      show_help = false, -- show help message on the command line when the popup is visible
    },

    opts = {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    },
    vopts = {
      mode = "v",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    },

    -- vmappings = {
    --   ["/"] = { "<ESC><CMD>lua ___comment_gc(vim.fn.visualmode())<CR>", "Comment" },
    -- },
    mappings = mappings
}



local wk = require("which-key")
wk.setup(M.config.setup)
wk.register(M.config.mappings, M.config.opts)


