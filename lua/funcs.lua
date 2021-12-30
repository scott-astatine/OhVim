local shell = os.getenv('SHELL')

local function termConf()
    local winopts = {
        relativenumber = false,
        number = false,
        list = false,
        winfixwidth = true,
        winfixheight = true,
        foldenable = false,
        spell = false,
        signcolumn = 'yes',
        foldmethod = 'manual',
        foldcolumn = '0',
        cursorcolumn = false,
        cursorline = false,
        colorcolumn = '0',
        wrap = false,
    }

    local mappings = {
      { key = "q", cb = "<cmd>bdelete!<cr>" },
    }

    for i, v in pairs(winopts) do
        vim.wo[i] = v
    end
    for _, b in pairs(mappings) do
      vim.api.nvim_buf_set_keymap(vim.fn.bufnr(), b.mode or 'n', b.key, b.cb, {noremap = true, silent = true, nowait = true})
    end

    vim.api.nvim_buf_set_name(vim.fn.bufnr(), 'Term')
end
_G.splitTerm = function (s)
    if s == 0 then
        vim.cmd("12 split term://" .. shell)
    elseif s == 1 then
        vim.cmd("100 vsplit term://" .. shell)
    end
    termConf()
end

_G.openTerm = function ()
    vim.cmd[[terminal]]
    termConf()
end

