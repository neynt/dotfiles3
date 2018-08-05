set nocompatible

call plug#begin('~/.vim/plugged')
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'scrooloose/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'albfan/nerdtree-git-plugin'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'  " auto sessions
Plug 'vim-syntastic/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/gitignore'
if filereadable(expand('~/.vimrc.work'))
  source ~/.vimrc.work
end
if filereadable(expand('~/.vimrc.deoplete'))
  source ~/.vimrc.deoplete
end
Plug 'tpope/vim-fugitive'             " git integration
"if filereadable(expand('~/.vimrc.ocaml'))
"  source ~/.vimrc.ocaml
"end
" language syntax
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'kchmck/vim-coffee-script'
Plug 'gkz/vim-ls'
Plug 'petRUShka/vim-sage'
Plug 'solarnz/thrift.vim'
"Plug 'rhysd/vim-crystal'
Plug 'neynt/vim-vue'
Plug 'digitaltoad/vim-pug'
Plug 'elixir-lang/vim-elixir'
"Plug 'JuliaEditorSupport/julia-vim'
"Plug 'flxf/uCpp.vim'
"Plug 'tikhomirov/vim-glsl'
"Plug 'dleonard0/pony-vim-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'supercollider/scvim'
Plug 'solarnz/thrift.vim'
Plug 'calviken/vim-gdscript3'
Plug 'wlangstroth/vim-racket'
" colors
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
call plug#end()

let mapleader = ","
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:jellybeans_overrides = {}
let g:jellybeans_overrides["background"] = {}
let g:jellybeans_overrides["background"]["256ctermbg"] = "none"
let NERDTreeQuitOnOpen = 1
let g:gruvbox_contrast_dark = "hard"

" Key mapping
nnoremap <space> <nop>
nnoremap <leader>ne :NERDTreeToggle<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>rt :set sw=2 sts=2 ts=2 expandtab<cr>:retab<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>
nnoremap <leader>c :pc<cr>
nnoremap == gg=G''
nnoremap gq gggqG<C-o><C-o>
nnoremap <space> :
vnoremap <space> :

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
set ts=2 sts=2 sw=2 smarttab expandtab
set autoindent
"set breakindent
"set breakindentopt=shift:2
set nojoinspaces " don't double-space after period with gq

if has("nvim")
  set guicursor=
endif

if has("mouse")
  set mouse=a
endif

" make gvim pretty
if has("gui_running")
  set guifont=Fira\ Mono\ 10
  set guioptions=aeigt
endif

" Filetype detection, smart plugins and indents
filetype plugin indent on

augroup neynt
  autocmd!
  autocmd FileType html setlocal sw=2 sts=2 ts=2
  autocmd FileType go setlocal sw=2 sts=2 ts=2
  autocmd FileType cpp setlocal sw=2 sts=2 ts=2
  autocmd BufEnter *.vue syntax sync fromstart
  autocmd BufNewFile,BufRead *.vs,*.fs set ft=glsl
augroup END

" this is needed, trust me; just jellybeans isn't perfect
colorscheme SerialExperimentsLain
colorscheme jellybeans
"colorscheme gruvbox

" Syntax highlighting
syntax on
