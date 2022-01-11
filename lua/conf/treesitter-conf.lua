local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main",
    },
}

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "rust",
        "lua",
        "c",
        "cpp",
        "javascript",
        "julia",
        "typescript",
        "tsx",
        "html",
        "css",
        "norg",
        "commonlisp",
        "python",
        "bash",
        "fish",
        "json",
        "toml",
        "graphql",
        "go",
        "gdscript",
        "rst",
        "cmake",
        "vim",
        "dot",
        "glsl",
        "scss",
        "svelte",
        "comment",
        "godot_resource",
    }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = true,
        disable = { "latex" },
    },
    playground = {
        enable = false,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },
    rainbow = { enable = true },
})
