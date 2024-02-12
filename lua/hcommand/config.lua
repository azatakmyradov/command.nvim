return {
    cache = string.format("%s/hcommand.json", vim.fn.stdpath("cache")),
    win_info = {
        win_id = nil,
        bufnr = nil
    },
    window = {
        width = 40,
        height = 10,
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    }
}
