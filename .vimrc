set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'ConradIrwin/vim-bracketed-paste'
if filereadable(expand('~/.vimrc.work'))
  " work
  source ~/.vimrc.work
else
  " git integration
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  " languages
  Plug 'rust-lang/rust.vim'
  Plug 'kchmck/vim-coffee-script'
  Plug 'gkz/vim-ls'
  Plug 'elixir-lang/vim-elixir'
  Plug 'petRUShka/vim-sage'
end
call plug#end()

let mapleader = ","

colorscheme SerialExperimentsLain
colorscheme jellybeans

set hlsearch
set number

" tabs
set sts=2
set ts=2
set sw=2
set smarttab
set expandtab
set autoindent

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

" Syntax highlighting
syntax on
