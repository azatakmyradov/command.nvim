return function ()
    vim.keymap.set('n', '<leader>qq', '<cmd>lua require("hcommand").toggle()<cr>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>qr', '<cmd>lua require("hcommand").execute(1)<cr>', { noremap = true, silent = true })
end
