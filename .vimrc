set nocompatible

call plug#begin('~/.vim/plugged')
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'scrooloose/nerdtree'
Plug 'ConradIrwin/vim-bracketed-paste'
if filereadable(expand('~/.vimrc.work'))
  " work
  source ~/.vimrc.work
else
  Plug 'Valloric/YouCompleteMe'
  " git integration
  Plug 'tpope/vim-fugitive'
  "Plug 'airblade/vim-gitgutter'
  " languages
  Plug 'rust-lang/rust.vim'
  Plug 'kchmck/vim-coffee-script'
  Plug 'gkz/vim-ls'
  Plug 'elixir-lang/vim-elixir'
  Plug 'petRUShka/vim-sage'
  Plug 'rhysd/vim-crystal'
  Plug 'posva/vim-vue'
  " elixir semantics
  Plug 'slashmili/alchemist.vim'
end
call plug#end()

let mapleader = ","

colorscheme SerialExperimentsLain
colorscheme jellybeans

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

if has("mouse")
  set mouse=a
endif

" make gvim pretty
if has("gui_running")
  set guifont=Source\ Code\ Pro\ Semibold\ 10.5
  set guioptions=aeigtm
endif

" NERDTree toggle
nmap <leader>ne :NERDTreeToggle<cr>

" Filetype detection, smart plugins and indents
filetype plugin indent on
autocmd FileType html setlocal sw=2 ts=2

autocmd FileType go setlocal sw=2 ts=2

" Syntax highlighting
syntax on
