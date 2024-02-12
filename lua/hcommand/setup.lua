return function ()
    vim.keymap.set('n', '<leader>ow', '<cmd>lua require("hcommand").open()<cr>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>qw', '<cmd>lua require("hcommand").close()<cr>', { noremap = true, silent = true })
end
