return {
    cache = string.format("%s/hcommand.json", vim.fn.stdpath("data")),
    win_info = {
        win_id = nil,
        bufnr = nil
    },
    window = {
        width = 60,
        height = 10,
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    }
}
