vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.number = true
vim.o.wrap = false

vim.cmd [[
  hi Normal guibg=none
  hi NonText guibg=none
  hi Normal ctermbg=none
  hi NonText ctermbg=none
  hi StatusLine guibg=none ctermbg=none guifg=#aaaaaa ctermfg=white
]]

vim.diagnostic.config({ virtual_lines = { current_line = true } })

vim.pack.add({
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/f-person/git-blame.nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/hrsh7th/cmp-nvim-lsp',
	'https://github.com/hrsh7th/cmp-buffer',
	'https://github.com/hrsh7th/cmp-path',
	'https://github.com/hrsh7th/nvim-cmp',
	'https://github.com/nvim-flutter/flutter-tools.nvim',
})

vim.keymap.set('x', 'Y', '"+y', { desc = 'Copy to System Clipboard' })

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

vim.lsp.enable({ 'eslint_ls', 'kotlin_ls', 'lua_ls', 'tailwindcss_ls', 'ts_ls' })

local cmp = require('cmp')
cmp.setup({
	snippet = { expand = vim.snippet.expand },
	completion = { completeopt = "menu,menuone,noinsert" },
	preselect = cmp.PreselectMode.Item,
	mapping = cmp.mapping.preset.insert({
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources(
		{ { name = "nvim_lsp" }, { name = "path" } },
		{ { name = "buffer" } }
	),
})
