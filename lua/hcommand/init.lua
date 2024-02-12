local popup = require("plenary.popup")

local augroup = vim.api.nvim_create_augroup
local hcommandGroup = augroup('Akmyradov_hcommand', {})

local M = {}

M.config = require("hcommand.config")

M.setup = function ()
    require("hcommand.keymaps")()

    local file = io.open(M.config.cache, "w")

    if file == nil then
        error("Could not open file")
        return
    end

    file:write(vim.fn.json_encode({ commands = {} }))

    file:close()
end

vim.api.nvim_create_autocmd({ "BufLeave", "VimLeave" }, {
    callback = function()
        if M.config.win_info.win_id ~= nil then
            M.close()
        end
    end,
    group = hcommandGroup,
})

M._get_commands = function ()
    local file = io.open(M.config.cache, "r")
    local commands = {}

    if file == nil then
        error("Could not open file")
        return
    end

    local content = file:read("*a")

    if content ~= "" then
        commands = vim.fn.json_decode(content).commands
    end

    file:close()

    return commands
end

M._create_window = function ()
    local bufnr = vim.api.nvim_create_buf(false, false)

    local window_id, _ = popup.create(bufnr, {
        title = "Commands",
        highlight = "hCommandWindow",
        focusable = true,
        line = math.floor(((vim.o.lines - M.config.window.height) / 2) - 1),
        col = math.floor((vim.o.columns - M.config.window.width) / 2),
        minwidth = M.config.window.width,
        minheight = M.config.window.height,
        borderchars = M.config.window.borderchars
    })

    return {
        win_id = window_id,
        bufnr = bufnr
    }
end

M.open = function ()
    M.config.win_info = M._create_window()

    local contents = M._get_commands()

    vim.api.nvim_win_set_option(M.config.win_info.win_id, "number", true)
    vim.api.nvim_buf_set_name(M.config.win_info.bufnr, "hcommand-menu")
    vim.api.nvim_buf_set_lines(M.config.win_info.bufnr, 0, #contents, false, contents)
    vim.api.nvim_buf_set_option(M.config.win_info.bufnr, "filetype", "hcommand")
    vim.api.nvim_buf_set_option(M.config.win_info.bufnr, "buftype", "acwrite")
    vim.api.nvim_buf_set_option(M.config.win_info.bufnr, "bufhidden", "delete")
end

M.close = function ()
    local file = io.open(M.config.cache, "w")

    if file == nil then
        error("Could not open file")
        return
    end

    -- get the buffer content
    local commands = vim.api.nvim_buf_get_lines(M.config.win_info.bufnr, 0, -1, false)

    file:write(vim.fn.json_encode({
        commands = commands
    }))
    file:close()

    vim.api.nvim_win_close(M.config.win_info.win_id, true)

    M.config.win_info = {
        win_id = nil,
        bufnr = nil
    }
end

M.execute = function (value)
    local commands = M._get_commands()

    if #commands == 0 or commands == nil then
        print("No commands found")
        return
    end

    if commands[value] == nil then
        print("No command found")
        return
    end

    print("Executing commands...", commands[value])
    vim.cmd(':' .. commands[value])
end

M.toggle = function ()
    if M.config.win_info.win_id == nil then
        M.open()
    else
        M.close()
    end
end

return M

