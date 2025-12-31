-- neovim options
local opt = vim.opt
local g = vim.g

-- leader keys (set early)
g.mapleader = ' '
g.maplocalleader = '\\'

-- encoding
opt.encoding = 'utf-8'
opt.fileencodings = 'utf-8'

-- appearance
opt.number = true
opt.signcolumn = 'number'
opt.termguicolors = true
opt.fillchars:append({ vert = ' ' })
opt.pumheight = 16
opt.scrolloff = 5  -- min context around cursor
opt.list = true  -- show whitespace
opt.splitbelow = true  -- preview window on bottom

-- searching
opt.hlsearch = true

-- text formatting
opt.linebreak = true
opt.formatoptions:remove('t')  -- no automatic wrapping
opt.joinspaces = false  -- don't double-space after period

-- tabs and indentation
opt.expandtab = true
opt.autoindent = true
opt.copyindent = true
opt.preserveindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- files and directories
opt.modeline = true
opt.directory = vim.fn.expand('~/.vim/tmp//') .. ',.'
opt.undodir = vim.fn.expand('~/.vim/undo//') .. ',.'
opt.backupdir = vim.fn.expand('~/.vim/backup//') .. ',.'
opt.backupcopy = 'yes'
opt.undofile = true

-- timing
opt.timeoutlen = 1000
opt.ttimeoutlen = 0

-- misc
opt.mouse = 'a'
opt.lispwords:append('λ')

-- gui-specific settings
if vim.fn.has('gui_running') == 1 then
  opt.guifont = 'curie 9'
  opt.guioptions = 'aeigt'
end

-- syntax highlighting
vim.cmd.syntax('on')

-- filetype detection
vim.cmd.filetype('plugin', 'indent', 'on')
