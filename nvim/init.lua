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
    local p = ev.data.params.value.percentage
    _G.LSP_PROGRESS = p and string.format("(%d%%) ", p) or ""
    vim.cmd('redrawstatus')
  end,
})
