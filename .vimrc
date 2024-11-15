set nocompatible
scriptencoding utf-8
set encoding=utf-8
set fileencodings=utf-8

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let mapleader = ","

" Lets {{{
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:jellybeans_overrides = {}
let g:jellybeans_overrides["background"] = {}
let g:jellybeans_overrides["background"]["guibg"] = "NONE"
"let g:jellybeans_use_gui_italics = 0
let NERDTreeQuitOnOpen = 1
"let g:gruvbox_contrast_dark = "hard"
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "-",
    \ "Staged"    : "+",
    \ "Untracked" : "·",
    \ "Renamed"   : "»",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "x",
    \ "Dirty"     : "-",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '?',
    \ "Unknown"   : "?"
    \ }
let g:suda_smart_edit = 1
" }}}

" Key mapping {{{
nnoremap <leader>bd :bd<cr>
nnoremap <leader>bn :bn<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>a :A<cr>
nnoremap <leader>c :pc<cr>:lclose<cr>
nnoremap <silent> <leader>h :cd %:p:h<cr>
nnoremap <leader>cn :cnext<cr>
nnoremap <leader>cp :cprev<cr>
"nnoremap <leader>en :lnext<cr>
"nnoremap <leader>ep :lprev<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gy :Goyo<cr>
nnoremap <leader>rg :Rg 
"nnoremap <leader>ht :MerlinTypeOf<cr>
nnoremap <leader>dt :diffthis<cr>
nnoremap <leader>dn :diffoff<cr>
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)
nnoremap <leader>rt :set expandtab<cr>:retab<cr>
nnoremap <leader>n :nohlsearch<cr>
"nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
nnoremap <space> :
vnoremap <space> :
nnoremap H ^
nnoremap L $
"nnoremap / /\v
vnoremap <silent><Leader>y "yy <Bar> :call system('xclip -selection clipboard', @y)<cr>

" Search for selected text.
" Copied from http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
" }}}

" Sets {{{
set lispwords+=λ
"set wrap
set linebreak
set formatoptions-=t  " no automatic wrapping
set modeline
set hlsearch
set number
set fillchars+=vert:\ 
"set cmdheight=2
"set autoread
set autochdir
set pumheight=16
set scrolloff=5 " min context around cursor

" swap files
set dir=~/.vim/tmp//,.
set undodir=~/.vim/undo//,.
set backupdir=~/.vim/backup//,.
set backupcopy=yes
set timeoutlen=1000 ttimeoutlen=0

" tabs
set expandtab
set autoindent
set copyindent
set preserveindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set signcolumn=number

"set breakindent " indent long broken lines
"set breakindentopt=shift:2
set nojoinspaces " don't double-space after period
set list       " show whitespace
"set listchars=tab:-->
set splitbelow " preview window on bottom

if has('persistent_undo')
  set undofile
endif

if has("nvim")
  "set guicursor=
endif

if has("mouse")
  set mouse=a
endif

" make gvim pretty
if has("gui_running")
  set guifont=curie\ 9
  set guioptions=aeigt
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" }}}

" Filetype detection, smart plugins and indents
filetype plugin indent on

augroup neynt
  autocmd!
  autocmd FileType html      setlocal sw=2 sts=2 ts=2
  autocmd FileType go        setlocal sw=2 sts=2 ts=2
  autocmd FileType cpp       setlocal sw=2 sts=2 ts=2
  autocmd FileType c         setlocal sw=2 sts=2 ts=2
  autocmd FileType perl      setlocal sw=2 sts=2 ts=2
  autocmd FileType haskell   setlocal expandtab
  autocmd FileType vim       setlocal foldmethod=marker
  autocmd FileType ocaml     setlocal sw=2 sts=2 ts=2
  autocmd FileType python    setlocal sw=4 sts=4 ts=4
  autocmd FileType markdown  setlocal sw=2 sts=2 ts=2
  "autocmd FileType markdown setlocal textwidth=80
  autocmd BufEnter *.vue syntax sync fromstart
  autocmd BufNewFile,BufRead *.vs,*.fs set ft=glsl

  " for :set autoread
  "autocmd FocusGained,BufEnter * :checktime
  "autocmd CursorHold * checktime
augroup END

colorscheme jellybeans

" Syntax highlighting
syntax on

" ocaml {{{
"let g:opamshare = substitute(system('opam var share'), '\n$', '', '''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"
" }}}
