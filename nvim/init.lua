require('global')
local cfg = require('configuration')
for _, p in pairs(cfg.disabled_plugin) do vim.g['loaded_' .. p] = 1 end
for k, v in pairs(cfg.options) do vim.o[k] = v end
for k, v in pairs(cfg.global) do vim.g[k] = v end
vim.diagnostic.config(cfg.diagnostic)
vim.lsp.enable(cfg.lsp)
local plugin_resolver = function(u) return u:match('^https://') and u or 'https://github.com/' .. u end
vim.pack.add(vim.tbl_map(plugin_resolver, cfg.plugins))
for k, v in pairs(cfg.plugins_setup) do v(require(k)) end
for m, s in pairs(cfg.keymaps) do for k, c in pairs(s) do vim.keymap.set(m, k, c) end end
vim.cmd.colorscheme(cfg.colorscheme)

vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data.params.value
    local percentage = value.percentage;

    if percentage then
      vim.o.statusline = '[%{v:lua.S_MODE()}] %f %r%m %=%{&ft} (' ..
          string.format("%d%%%%", percentage) .. ') %{v:lua.S_LSP()} [%{v:lua.S_AGENT()}]';
    else
      vim.o.statusline = cfg.options.statusline;
    end
    vim.cmd('redrawstatus')
  end,
})
