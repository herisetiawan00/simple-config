vim.keymap.set('x', 'Y', '"+y', { desc = 'Copy to System Clipboard' })
vim.keymap.set('n', '<leader>B', '<cmd>let @+=expand("%:p")<cr>', { desc = 'Copy Path of Current Buffer' })

vim.keymap.set('n', '<C-l>', '<cmd>vertical resize +5<cr>', { desc = 'Resize Window Bigger Vertically' })
vim.keymap.set('n', '<C-h>', '<cmd>vertical resize -5<cr>', { desc = 'Resize Window Smaller Vertically' })
vim.keymap.set('n', '<C-k>', '<cmd>horizontal resize +5<cr>', { desc = 'Resize Window Bigger Horizontally' })
vim.keymap.set('n', '<C-j>', '<cmd>horizontal resize -5<cr>', { desc = 'Resize Window Bigger Horizontally' })

vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.definition, { desc = 'Definition' })
vim.keymap.set('n', '<leader>lc', vim.lsp.buf.declaration, { desc = 'Declaration' })
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.references, { desc = 'References' })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format' })

vim.keymap.set('n', '<leader>f', '<cmd>FzfLua<cr>', { desc = 'Finder' })