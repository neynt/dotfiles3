set nocompatible

call plug#begin('~/.vim/plugged')
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'scrooloose/nerdtree'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'  " auto sessions
"Plug 'vim-syntastic/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
if filereadable(expand('~/.vimrc.work'))
  source ~/.vimrc.work
else
  Plug 'Chiel92/vim-autoformat'
  Plug 'Valloric/YouCompleteMe'
  "Plug 'tpope/vim-sleuth'  " detect indentation
  Plug 'tpope/vim-fugitive'  " git integration
  Plug 'tpope/vim-fireplace'  " clojure repl
  Plug 'slashmili/alchemist.vim'  " elixir semantics
end
"if filereadable(expand('~/.vimrc.ocaml'))
"  source ~/.vimrc.ocaml
"end
" languages
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'kchmck/vim-coffee-script'
Plug 'gkz/vim-ls'
Plug 'petRUShka/vim-sage'
Plug 'rhysd/vim-crystal'
Plug 'neynt/vim-vue'
Plug 'digitaltoad/vim-pug'
Plug 'elixir-lang/vim-elixir'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'flxf/uCpp.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'dleonard0/pony-vim-syntax'
" colors
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
call plug#end()

let mapleader = ","
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
"let g:syntastic_mode_map = { 'mode': 'passive' }
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:jellybeans_overrides = {}
let g:jellybeans_overrides["background"] = {}
let g:jellybeans_overrides["background"]["256ctermbg"] = "none"
let NERDTreeQuitOnOpen = 1
let g:gruvbox_contrast_dark = "hard"
let g:ycm_global_ycm_extra_conf = "/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"

" Key mapping
nnoremap <space> <nop>
nnoremap <leader>ne :NERDTreeToggle<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>rt :set sw=2 sts=2 ts=2 expandtab<cr>:retab<cr>

" modeline
set modeline

set hlsearch
set number

set fillchars+=vert:\ 

" swap files
set dir=~/.vim/tmp//,.
set undodir=~/.vim/undo//,.
set backupdir=~/.vim/backup//,.
set backupcopy=yes
set timeoutlen=1000 ttimeoutlen=0

if has("mouse")
  set mouse=a
endif

" make gvim pretty
if has("gui_running")
  set guifont=Fira\ Mono\ 10
  set guioptions=aeigt
endif


" Filetype detection, smart plugins and indents
" TODO: Get vim to stop overriding my tab settings
"filetype plugin indent on
autocmd FileType html setlocal sw=2 sts=2 ts=2
autocmd FileType go setlocal sw=2 sts=2 ts=2
autocmd FileType cpp setlocal sw=2 sts=2 ts=2
autocmd BufEnter *.vue syntax sync fromstart
autocmd BufNewFile,BufRead *.vs,*.fs set ft=glsl

" tabs
set ts=2 sts=2 sw=2 smarttab expandtab
set autoindent
set breakindent
"set breakindentopt=shift:2
set nojoinspaces " don't double-space after period with gq

colorscheme SerialExperimentsLain  " this is needed, trust me
colorscheme jellybeans
"colorscheme gruvbox

" Syntax highlighting
syntax on
