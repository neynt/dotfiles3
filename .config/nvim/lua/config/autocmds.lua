-- autocommands
local augroup = vim.api.nvim_create_augroup('neynt', { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- filetype-specific settings
autocmd('FileType', {
  group = augroup,
  pattern = { 'html', 'go', 'cpp', 'c', 'perl', 'ocaml', 'markdown' },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.tabstop = 2
  end,
})

autocmd('FileType', {
  group = augroup,
  pattern = 'python',
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.tabstop = 4
  end,
})

autocmd('FileType', {
  group = augroup,
  pattern = 'haskell',
  callback = function()
    vim.bo.expandtab = true
  end,
})

autocmd('FileType', {
  group = augroup,
  pattern = 'vim',
  callback = function()
    vim.wo.foldmethod = 'marker'
  end,
})

-- vue file syntax sync fix
autocmd('BufEnter', {
  group = augroup,
  pattern = '*.vue',
  command = 'syntax sync fromstart',
})

-- goyo: hide lualine in padding windows
autocmd('User', {
  group = augroup,
  pattern = 'GoyoEnter',
  callback = function()
    require('lualine').hide()
  end,
})

autocmd('User', {
  group = augroup,
  pattern = 'GoyoLeave',
  callback = function()
    require('lualine').hide({ unhide = true })
  end,
})

-- glsl file detection
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup,
  pattern = { '*.vs', '*.fs' },
  callback = function()
    vim.bo.filetype = 'glsl'
  end,
})
