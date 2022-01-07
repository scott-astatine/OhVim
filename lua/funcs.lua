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
      { key = "q", cb = "<cmd>Bdelete!<cr>" },
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
    if s == 2 then
        vim.cmd("12 split term://" .. shell)
    elseif s == 1 then
        vim.cmd("90 vsplit term://" .. shell)
    end
    vim.cmd[[startinsert]]
    termConf()
end

_G.openTerm = function ()
    vim.cmd[[terminal]]
    termConf()
end

local state = {
    winh = nil,
    bufh = nil,
    chan = nil,
    last_command = nil
}

local function win_is_open()
    return state.winh ~= nil and vim.api.nvim_win_is_valid(state.winh) == true
end

local function buf_is_valid()
    return state.bufh ~= nil and vim.api.nvim_buf_is_valid(state.bufh) == true
end

_G.floatingTerm = function (c)
    local mode = c or 1
    local buf_created = false
    if buf_is_valid() == false then
        state.bufh = vim.api.nvim_create_buf(false, true)
        buf_created = true
    end

    if win_is_open() ~= true then
        local ui = vim.api.nvim_list_uis()[1]


        local winopts = {
            relative = "editor",
            width = math.floor(ui.width / 2),
            height = ui.height - vim.o.cmdheight - 2,
            row = 1,
            col = ui.width,
            style = "minimal",
            border = "double"
        }
        if mode == 1 then
            winopts.width = ui.width - 4
            winopts.height = math.floor((ui.height - vim.o.cmdheight - 2) / 3)
            winopts.row = (2 * winopts.height)
        elseif mode == 3 then
            winopts.width = ui.width - 4
            winopts.height = winopts.height - 1
            winopts.col = 1
        end

        state.winh = vim.api.nvim_open_win(state.bufh, true, winopts)

        if buf_created then
            vim.cmd [[term]]
            state.chan = vim.b.terminal_job_id
            vim.api.nvim_buf_set_name(state.bufh, "Term")
            vim.api.nvim_buf_set_option(state.bufh, "buflisted", false)
        end
        vim.cmd[[startinsert]]
    end
end

