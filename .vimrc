set nocompatible

call plug#begin('~/.vim/plugged')
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'scrooloose/nerdtree'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-syntastic/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
if filereadable(expand('~/.vimrc.work'))
  " work
  source ~/.vimrc.work
else
  Plug 'Chiel92/vim-autoformat'
  Plug 'Valloric/YouCompleteMe'
  Plug 'tpope/vim-sleuth'
  " git integration
  Plug 'tpope/vim-fugitive'
  "Plug 'airblade/vim-gitgutter'
  " languages
  Plug 'rust-lang/rust.vim'
  Plug 'kchmck/vim-coffee-script'
  Plug 'gkz/vim-ls'
  Plug 'petRUShka/vim-sage'
  Plug 'rhysd/vim-crystal'
  Plug 'posva/vim-vue'
  Plug 'digitaltoad/vim-pug'
  " clojure repl
  Plug 'tpope/vim-fireplace'
  " elixir semantics
  Plug 'slashmili/alchemist.vim'
end
Plug 'elixir-lang/vim-elixir'
Plug 'JuliaEditorSupport/julia-vim'

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
let NERDTreeQuitOnOpen = 1
"let g:gruvbox_contrast_dark = "hard"

" Key mapping
nnoremap <space> <nop>
nnoremap <leader>ne :NERDTreeToggle<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" modeline
set modeline

set hlsearch
set number

" tabs
set ts=2 sts=2 sw=2 smarttab expandtab
set autoindent

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
  set guifont=Fira\ Mono\ 9
  set guioptions=aeigt
endif

" Filetype detection, smart plugins and indents
filetype plugin indent on
autocmd FileType html setlocal sw=2 ts=2
autocmd FileType go setlocal sw=2 ts=2
autocmd BufEnter *.vue syntax sync fromstart

colorscheme SerialExperimentsLain  " this is needed, trust me
colorscheme jellybeans
"colorscheme gruvbox

" Syntax highlighting
syntax on
