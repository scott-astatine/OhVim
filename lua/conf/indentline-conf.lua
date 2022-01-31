local ignoreBufs = { "help", "prompt", "Telescope", "Executer", "Term", "terminal", "Prompt", "packer", "NvimTree" }
vim.g.indent_blankline_filetype_exclude = ignoreBufs
vim.g.indent_blankline_bufname_exclude = ignoreBufs
<<<<<<< Updated upstream
=======
vim.g.indent_blankline_use_treesitter = true
>>>>>>> Stashed changes

require("indent_blankline").setup({
    -- for example, context is off by default, use this to turn it on
    show_current_context = false,
    show_current_context_start = true,
    space_char_blankline = " ",
})
