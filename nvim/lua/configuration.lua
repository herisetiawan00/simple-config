local configuration = {
  disabled_plugin = {
    '2html_plugin',
    'tohtml',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logipat',
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
    'matchit',
    'tar',
    'tarPlugin',
    'rrhelper',
    'spellfile_plugin',
    'vimball',
    'vimballPlugin',
    'zip',
    'zipPlugin',
    'tutor',
    'rplugin',
    'syntax',
    'synmenu',
    'optwin',
    'compiler',
    'bugreport',
    'ftplugin',
  },
  options = {
    number = true,
    wrap = false,
    cmdheight = 0,
    tabstop = 2,
    shiftwidth = 2,
    softtabstop = 2,
    expandtab = true,
    ignorecase = true,
    smartcase = true,
    incsearch = true,
    foldmethod = 'indent',
    foldexpr = 'nvim_treesitter#foldexpr()',
    foldlevelstart = 1,
    statusline = '[%{v:lua.S_MODE()}] %f %r%m %=%{&ft} %{v:lua.S_LSP()} [%{v:lua.S_AGENT()}]',
    mouse = ''
  },
  global = {
    mapleader = ' ',
    maplocalleader = '\\'
  },
  diagnostic = { virtual_lines = { current_line = true } },
  lsp = {
    'css_ls',
    'dart_ls',
    'eslint_ls',
    'kotlin_ls',
    'lua_ls',
    'prisma_ls',
    'rust_ls',
    'tailwindcss_ls',
    'ts_ls',
  },
  plugins = {
    'catppuccin/nvim',
    'f-person/git-blame.nvim',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/nvim-cmp',
    'ibhagwan/fzf-lua',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
  },
  plugins_setup = {
    cmp = function(cmp)
      cmp.setup({
        snippet = { expand = function(a) vim.snippet.expand(a.body) end },
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
    end,
    ['nvim-tree'] = function(tree) tree.setup({ update_focused_file = { enable = true } }) end,
  },
  keymaps = {
    x = {
      Y = '"+y',
    },
    n = {
      ['<C-l>'] = '<cmd>vertical resize +5<cr>',
      ['<C-h>'] = '<cmd>vertical resize -5<cr>',
      ['<C-k>'] = '<cmd>horizontal resize +5<cr>',
      ['<C-j>'] = '<cmd>horizontal resize -5<cr>',
      ['<C-e>'] = '<cmd>NvimTreeToggle<cr>',
      ['<leader>f'] = '<cmd>FzfLua<cr>',
      ['<leader>B'] = '<cmd>let @+=expand("%:p")<cr>',
      ['<leader>la'] = vim.lsp.buf.code_action,
      ['<leader>ld'] = vim.lsp.buf.definition,
      ['<leader>lc'] = vim.lsp.buf.declaration,
      ['<leader>ls'] = vim.lsp.buf.references,
      ['<leader>lr'] = vim.lsp.buf.rename,
      ['<leader>lf'] = vim.lsp.buf.format,
    }
  },
  colorscheme = 'catppuccin',
}

return configuration;
