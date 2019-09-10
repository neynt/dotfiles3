set nocompatible

call plug#begin('~/.vim/plugged')
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'tpope/vim-sleuth'
Plug 'scrooloose/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'albfan/nerdtree-git-plugin'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession' " auto sessions
Plug 'vim-scripts/a.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-syntastic/syntastic'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/gitignore'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fugitive' " git integration
Plug 'dense-analysis/ale'
" language syntax
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'kchmck/vim-coffee-script'
Plug 'gkz/vim-ls'
Plug 'petRUShka/vim-sage'
Plug 'rgrinberg/vim-ocaml'
Plug 'let-def/ocp-indent-vim'
Plug 'solarnz/thrift.vim'
"Plug 'rhysd/vim-crystal'
Plug 'neynt/vim-vue'
Plug 'digitaltoad/vim-pug'
Plug 'elixir-lang/vim-elixir'
Plug 'JuliaEditorSupport/julia-vim'
"Plug 'flxf/uCpp.vim'
"Plug 'tikhomirov/vim-glsl'
"Plug 'dleonard0/pony-vim-syntax'
"Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
"Plug 'supercollider/scvim'
"Plug 'solarnz/thrift.vim'
Plug 'calviken/vim-gdscript3'
Plug 'wlangstroth/vim-racket'
Plug 'iloginow/vim-stylus'
Plug 'purescript-contrib/purescript-vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'xolox/vim-misc'
Plug 'tbastos/vim-lua'
Plug 'idris-hackers/idris-vim'
" colors
Plug 'morhetz/gruvbox'

let mapleader = ","
if filereadable(expand('~/.vimrc.work'))
  source ~/.vimrc.work
end
if filereadable(expand('~/.vimrc.deoplete'))
  source ~/.vimrc.deoplete
end
if filereadable(expand('~/.vimrc.coc'))
  source ~/.vimrc.coc
end
if filereadable(expand('~/.vimrc.ocaml'))
  source ~/.vimrc.ocaml
end
call plug#end()

if filereadable(expand('~/.vimrc.after'))
  source ~/.vimrc.after
end

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:syntastic_mode_map = { 'mode': 'passive' }
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:jellybeans_overrides = {}
let g:jellybeans_overrides["background"] = {}
let g:jellybeans_overrides["background"]["256ctermbg"] = "none"
"let NERDTreeQuitOnOpen = 1
let g:gruvbox_contrast_dark = "hard"
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "-",
    \ "Staged"    : "✚",
    \ "Untracked" : "·",
    \ "Renamed"   : "»",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "x",
    \ "Dirty"     : "-",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '?',
    \ "Unknown"   : "?"
    \ }

set lispwords+=λ

" Key mapping
nnoremap <leader>bd :bd<cr>
nnoremap <leader>bn :bn<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>c :pc<cr>:lclose<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gy :Goyo<cr>
nnoremap <leader>f :NERDTreeToggle<cr>
nnoremap <space> :
vnoremap <space> :

" Search for selected text.
" Copied from http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

set wrap
set linebreak
set modeline
set hlsearch
set number
set fillchars+=vert:\ 
"set cmdheight=2

set pumheight=16

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
set softtabstop=0
set shiftwidth=2

"set breakindent " indent long broken lines
"set breakindentopt=shift:2
set nojoinspaces " don't double-space after period
set list " show tabs
set splitbelow " preview window on bottom

if has('persistent_undo')
  set undofile
endif

if has("nvim")
  set guicursor=
endif

if has("mouse")
  set mouse=a
endif

" make gvim pretty
if has("gui_running")
  set guifont=Iosevka\ 10
  set guioptions=aeigt
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Filetype detection, smart plugins and indents
filetype plugin indent on

augroup neynt
  autocmd!
  "autocmd FileType html setlocal sw=2 sts=2 ts=2
  "autocmd FileType go setlocal sw=2 sts=2 ts=2
  "autocmd FileType cpp setlocal sw=2 sts=2 ts=2
  autocmd FileType haskell setlocal expandtab
  autocmd BufEnter *.vue syntax sync fromstart
  autocmd BufNewFile,BufRead *.vs,*.fs set ft=glsl
augroup END

colorscheme jellybeans

" Syntax highlighting
syntax on
