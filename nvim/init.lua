vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.o.number = true
vim.o.wrap = false
vim.o.cmdheight = 0
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.foldmethod = 'indent'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 1
vim.o.statusline = '[%{v:lua.M()}] %f %r%m %=%{&ft} %{v:lua.L()}'
vim.o.mouse = ''
vim.diagnostic.config({ virtual_lines = { current_line = true } })
vim.lsp.enable({ 'eslint_ls', 'kotlin_ls', 'lua_ls', 'tailwindcss_ls', 'ts_ls', 'rust_ls', 'kulala.ls' })
vim.pack.add(vim.tbl_map(function(u) return u:match('^https://') and u or 'https://github.com/' .. u end, {
  'nvim-lua/plenary.nvim', 'ibhagwan/fzf-lua', 'f-person/git-blame.nvim', 'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'hrsh7th/nvim-cmp', 'nvim-flutter/flutter-tools.nvim',
  'nvim-treesitter/nvim-treesitter', 'catppuccin/nvim', 'mistweaverco/kulala.nvim',
  'MeanderingProgrammer/render-markdown.nvim', 'nvim-tree/nvim-tree.lua'
}))
for k, v in pairs({
  cmp = function(cmp)
    cmp.setup({
      snippet = { expand = function(a) vim.snippet.expand(a.body) end },
      completion = { completeopt = 'menu,menuone,noinsert' },
      preselect = cmp.PreselectMode.Item,
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<cr>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'path' } }, { { name = 'buffer' } })
    })
  end,
  catppuccin = function(catppuccin)
    catppuccin.setup({ transparent_background = true, integrations = { fzf = true, } })
    vim.cmd.colorscheme 'catppuccin'
  end,
  ['nvim-tree'] = function(tree) tree.setup({ update_focused_file = { enable = true } }) end
}) do v(require(k)) end

for m, s in pairs({
  x = {
    Y = '"+y',
    ['<leader>B'] = '<cmd>let @+=expand(\'%:p\')<cr>',
  },
  n = {
    ['<C-l>'] = '<cmd>vertical resize +5<cr>',
    ['<C-h>'] = '<cmd>vertical resize -5<cr>',
    ['<C-k>'] = '<cmd>horizontal resize +5<cr>',
    ['<C-j>'] = '<cmd>horizontal resize -5<cr>',
    ['<C-e>'] = '<cmd>NvimTreeToggle<cr>',
    ['<leader>f'] = '<cmd>FzfLua<cr>',
    ['<leader>la'] = vim.lsp.buf.code_action,
    ['<leader>ld'] = vim.lsp.buf.definition,
    ['<leader>lc'] = vim.lsp.buf.declaration,
    ['<leader>ls'] = vim.lsp.buf.references,
    ['<leader>lr'] = vim.lsp.buf.rename,
    ['<leader>lf'] = vim.lsp.buf.format,
  }
}) do for k, c in pairs(s) do vim.keymap.set(m, k, c) end end

function _G.M()
  return ({ n = 'N', i = 'I', v = 'V', V = 'VL', ['\026'] = 'VB', c = 'C', R = 'R', t = 'T' })
      [vim.api.nvim_get_mode().mode] or '?'
end

function _G.L()
  local n = vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 }))
  return #n > 0 and '(' .. table.concat(n, ', ') .. ')' or ''
end
