-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
vim.g.indent_blankline_filetype_exclude = {'help', 'prompt', 'Telescope','fish', 'Executer', 'Term', 'terminal'}
vim.g.indent_blankline_bufname_exclude = {'help', 'prompt', 'Telescope','fish', 'Executer', 'Term', 'terminal'}

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = false,
    show_current_context_start = true,
    space_char_blankline = " ",
}
