function _G.S_MODE()
  local modes = {
    n = 'N',
    i = 'I',
    v = 'V',
    V = 'VL',
    ['\026'] = 'VB',
    c = 'C',
    R = 'R',
    t = 'T',
  }
  return (modes)[vim.api.nvim_get_mode().mode] or '?'
end

function _G.S_AGENT()
  local enabled = vim.lsp.inline_completion.is_enabled()
  return enabled and "AI" or "NO-AI"
end

function _G.S_LSP()
  local n = vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 }))
  return #n > 0 and '(' .. table.concat(n, ', ') .. ')' or ''
end

