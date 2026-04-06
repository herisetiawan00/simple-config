require('global')

local configuration = require('configuration')

for _, p in pairs(configuration.disabled_plugin) do vim.g['loaded_' .. p] = 1 end

for k, v in pairs(configuration.options) do vim.o[k] = v end

for k, v in pairs(configuration.global) do vim.g[k] = v end

vim.diagnostic.config(configuration.diagnostic)

vim.lsp.enable(configuration.lsp)

local plugin_resolver = function(u) return u:match('^https://') and u or 'https://github.com/' .. u end

vim.pack.add(vim.tbl_map(plugin_resolver, configuration.plugins))

for k, v in pairs(configuration.plugins_setup) do v(require(k)) end

for m, s in pairs(configuration.keymaps) do for k, c in pairs(s) do vim.keymap.set(m, k, c) end end

vim.cmd('colorscheme ' .. configuration.colorscheme)
