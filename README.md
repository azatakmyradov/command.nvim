# command.nvim

This plugin was influenced by Harpoon for nvim. It has a similar functionality
where you can define list of commands and run it using a set of keymaps.

# Installation
```lua
-- Lazy
{
    'azatakmyradov/command.nvim',
    config = function()
        require("hcommand").setup()
    end
}
```

Ex:
```lua
vim.keymap.set('n', '<leader>qe', '<cmd>lua require("hcommand").open()<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>qw', '<cmd>lua require("hcommand").close()<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>qr', '<cmd>lua require("hcommand").execute(1)<cr>', { noremap = true, silent = true })
```
