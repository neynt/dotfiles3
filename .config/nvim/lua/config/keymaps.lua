-- keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- buffer navigation
map('n', '<leader>bd', ':bd<cr>', opts)
map('n', '<leader>bn', ':bn<cr>', opts)
map('n', '<leader>bp', ':bp<cr>', opts)

-- window/quickfix management
map('n', '<leader>a', ':A<cr>', opts)
map('n', '<leader>c', ':pc<cr>:lclose<cr>', opts)
map('n', '<leader>h', ':cd %:p:h<cr>', { noremap = true, silent = true })

-- quickfix navigation
map('n', '<leader>cn', ':cnext<cr>', opts)
map('n', '<leader>cp', ':cprev<cr>', opts)

-- config editing
map('n', '<leader>ev', ':e $MYVIMRC<cr>', opts)
map('n', '<leader>sv', ':source $MYVIMRC<cr>', opts)

-- git commands
map('n', '<leader>gb', ':Gblame<cr>', opts)

-- goyo (distraction-free mode)
map('n', '<leader>gy', ':Goyo<cr>', opts)

-- ripgrep
map('n', '<leader>rg', ':Rg ', { noremap = true })

-- diff commands
map('n', '<leader>dt', ':diffthis<cr>', opts)
map('n', '<leader>dn', ':diffoff<cr>', opts)

-- easy align
map('x', 'ga', '<Plug>(EasyAlign)')
map('n', 'ga', '<Plug>(EasyAlign)')

-- formatting
map('n', '<leader>rt', ':set expandtab<cr>:retab<cr>', opts)

-- search
map('n', '<leader>n', ':nohlsearch<cr>', opts)

-- command mode shortcut
map('n', '<space>', ':', { noremap = true })
map('v', '<space>', ':', { noremap = true })

-- movement shortcuts
map('n', 'H', '^', { noremap = true })
map('n', 'L', '$', { noremap = true })

-- clipboard integration (copy to system clipboard)
map('v', '<leader>y', '"yy <Bar> :call system("xclip -selection clipboard", @y)<cr>', { noremap = true, silent = true })

-- visual mode: maintain selection when indenting
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })

-- search for selected text
-- adapted from http://vim.wikia.com/wiki/Search_for_visually_selected_text
map('v', '*', [[:<C-U>let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>gvy/<C-R><C-R>=substitute(escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>gV:call setreg('"', old_reg, old_regtype)<CR>]], { noremap = true, silent = true })
