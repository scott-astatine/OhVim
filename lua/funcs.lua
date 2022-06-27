local shell = os.getenv("SHELL")

_G.qBufnWin = function()
    vim.cmd("Bdelete!")
    vim.cmd("quit")
end

_G.formatnSave = function()
    if vim.g.format_on_save then
        vim.lsp.buf.formatting()
        vim.defer_fn(function()
            vim.cmd("w")
        end, 70)
    end
end



local function termConf(ops)
    local nWops = ops or false
    local winopts = {
        relativenumber = false,
        number = false,
        list = false,
        winfixwidth = true,
        winfixheight = true,
        foldenable = false,
        spell = false,
        signcolumn = "yes",
        foldmethod = "manual",
        foldcolumn = "0",
        cursorcolumn = false,
        cursorline = false,
        colorcolumn = "0",
        wrap = false,
    }

    local mappings = {
        { key = "q", cb = "<cmd>lua qBufnWin()<cr>" },
    }

    if nWops ~= true then
        for i, v in pairs(winopts) do
            vim.wo[i] = v
        end
    end
    for _, b in pairs(mappings) do
        vim.api.nvim_buf_set_keymap(
            vim.fn.bufnr(),
            b.mode or "n",
            b.key,
            b.cb,
            { noremap = true, silent = true, nowait = true }
        )
    end

    vim.api.nvim_buf_set_option(vim.fn.bufnr(), "buflisted", false)
    vim.api.nvim_buf_set_name(vim.fn.bufnr(), "Term")
end

_G.splitTerm = function(s)
    if s == 2 then
        vim.cmd("12 split term://" .. shell)
    elseif s == 1 then
        vim.cmd("90 vsplit term://" .. shell)
    end
    if vim.g.term_in_insert == true then
        vim.cmd([[startinsert]])
    end
    termConf()
end

_G.openTerm = function()
    if vim.g.term_in_insert == true then
        vim.cmd([[startinsert]])
    end
    termConf()
    vim.cmd([[command! Term execute 'lua openTerm']])
end

local state = {
    winh = nil,
    bufh = nil,
    chan = nil,
    last_command = nil,
}

local function win_is_open()
    return state.winh ~= nil and vim.api.nvim_win_is_valid(state.winh) == true
end

local function buf_is_valid()
    return state.bufh ~= nil and vim.api.nvim_buf_is_valid(state.bufh) == true
end

_G.floatingTerm = function(c)
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
            width = math.floor(ui.width / 2) - 10,
            height = ui.height - vim.o.cmdheight - 2,
            row = 0,
            col = ui.width,
            style = "minimal",
            border = "double",
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
            vim.cmd([[term]])
            state.chan = vim.b.terminal_job_id
            termConf(true)
        end
        if vim.g.term_in_insert == true then
            vim.cmd([[startinsert]])
        end
    end
end


--- Bdelete
local api = vim.api
local bo = vim.bo

local buffdel = {}

-- Common kill function for bdelete and bwipeout
local function buf_kill(kill_command, bufnr, force)
    -- If buffer is modified and force isn't true, print error and abort
    if not force and bo[bufnr].modified then
        api.nvim_echo({ {
            string.format(
                'No write since last change for buffer %d. Would you like to:\n' ..
                '(s)ave and close\n(i)gnore changes and close\n(c)ancel',
                bufnr
            )
        } }, false, {})

        local choice = string.char(vim.fn.getchar())

        if choice == 's' or choice == 'S' then
            vim.cmd('write')
        elseif choice == 'i' or choice == 'I' then
            force = true;
        else
            return
        end
    end

    if bufnr == 0 or bufnr == nil then
        bufnr = api.nvim_get_current_buf()
    end

    if force then
        kill_command = kill_command .. '!'
    end

    -- Get list of windows IDs with the buffer to close
    local windows = vim.tbl_filter(
        function(win) return api.nvim_win_get_buf(win) == bufnr end,
        api.nvim_list_wins()
    )

    -- Get list of valid and listed buffers
    local buffers = vim.tbl_filter(
        function(buf) return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
        end,
        api.nvim_list_bufs()
    )

    -- If there is only one buffer (which has to be the current one), Neovim will automatically
    -- create a new buffer on :bd.
    -- For more than one buffer, pick the next buffer (wrapping around if necessary)
    if #buffers > 1 then
        for i, v in ipairs(buffers) do
            if v == bufnr then
                local next_buffer = buffers[i % #buffers + 1]
                for _, win in ipairs(windows) do
                    api.nvim_win_set_buf(win, next_buffer)
                end

                break
            end
        end
    end

    -- Check if buffer still exists, to ensure the target buffer wasn't killed
    -- due to options like bufhidden=wipe.
    if api.nvim_buf_is_valid(bufnr) then
        -- Execute the BDeletePre and BDeletePost autocommands before and after deleting the buffer
        api.nvim_exec_autocmds("User", { pattern = "BDeletePre" })
        vim.cmd(string.format('%s %d', kill_command, bufnr))
        api.nvim_exec_autocmds("User", { pattern = "BDeletePost" })
    end
end

-- Kill the target buffer (or the current one if 0/nil) while retaining window layout
function buffdel.bufdelete(bufnr, force)
    buf_kill('bd', bufnr, force)
end

-- Wipe the target buffer (or the current one if 0/nil) while retaining window layout
function buffdel.bufwipeout(bufnr, force)
    buf_kill('bw', bufnr, force)
end

-- Wrapper around buf_kill for use with vim commands
local function buf_kill_cmd(kill_command, bufnr, bang)
    buf_kill(kill_command, tonumber(bufnr == '' and '0' or bufnr), bang == '!')
end

-- Wrappers around bufdelete and bufwipeout for use with vim commands
function buffdel.bufdelete_cmd(bufnr, bang)
    buf_kill_cmd('bd', bufnr, bang)
end

function buffdel.bufwipeout_cmd(bufnr, bang)
    buf_kill_cmd('bw', bufnr, bang)
end

vim.g.buffer = buffdel
local new_cmd = api.nvim_create_user_command

new_cmd("Bdelete", function()
    buffdel.bufdelete(vim.fn.bufnr(), false)
end, {})

new_cmd("BWipeout", function()
    buffdel.bufwipeout(vim.fn.bufnr(), false)
end, {})
