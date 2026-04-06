vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.number = true
vim.o.wrap = false
vim.o.cmdheight = 0

function _G.normalized_mode()
	local modes = {
		n = 'NORMAL',
		i = 'INSERT',
		v = 'VISUAL',
		V = 'V-LINE',
		[''] = 'V-BLOCK',
		c = 'COMMAND',
		R = 'REPLACE',
		t = 'TERMINAL',
	}
	return modes[vim.api.nvim_get_mode().mode] or 'UNKNOWN'
end

function _G.lsp_names()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ''
	end
	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end
	return '(' .. table.concat(names, ', ') .. ')'
end

local statusline = { '[%{v:lua.normalized_mode()}]', ' %{fnamemodify(expand("%"), ":.")}', '%r', '%m', '%=',
	'%{&filetype} ' .. '%{v:lua.lsp_names()}' }

vim.o.statusline = table.concat(statusline, '')

vim.diagnostic.config({ virtual_lines = { current_line = true } })

vim.pack.add(
	vim.tbl_map(
		function(url)
			return url:match('^https://') and url or 'https://github.com/' .. url
		end,
		{
			'nvim-lua/plenary.nvim',
			'ibhagwan/fzf-lua',
			'f-person/git-blame.nvim',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/nvim-cmp',
			'nvim-flutter/flutter-tools.nvim',
			'nvim-treesitter/nvim-treesitter',
			'catppuccin/nvim',
			'mistweaverco/kulala.nvim',
		}
	)
)

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

vim.lsp.enable({ 'eslint_ls', 'kotlin_ls', 'lua_ls', 'tailwindcss_ls', 'ts_ls', 'rust_ls', 'kulala.ls' })

local cmp = require('cmp')
cmp.setup({
	snippet = { expand = function(args) vim.snippet.expand(args.body) end },
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

require("catppuccin").setup { transparent_background = true }
vim.cmd.colorscheme "catppuccin"
