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
Plug 'vim-syntastic/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
if filereadable(expand('~/.vimrc.work'))
  source ~/.vimrc.work
else
  "Plug 'Valloric/YouCompleteMe'   " god mode
  Plug 'tpope/vim-fugitive'       " git integration
  "Plug 'tpope/vim-sleuth'              " detect indentation
  Plug 'slashmili/alchemist.vim'        " elixir semantics
  Plug 'zchee/deoplete-jedi'            " python semantics
  Plug 'mhartington/nvim-typescript'    " typescript semantics
  Plug 'zchee/deoplete-clang'           " c-family langs
  Plug 'eagletmt/neco-ghc'              " haskell
  if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'Shougo/deoplete.nvim'
  endif
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
"let g:racer_experimental_completer = 1
"let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
"let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:echodoc_enable_at_startup = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
set runtimepath+=~/.vim/plugged/LanguageClient-neovim
let g:LanguageClient_serverCommands = {
  \ 'rust': ['rls'],
  \ }
let g:LanguageClient_loggingLevel = 'DEBUG'
" paths are good for Arch Linux
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header  = '/usr/lib/clang/'

inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

augroup typescript_shortcuts
  autocmd!
  autocmd FileType typescript nnoremap <leader>gg :TSDef<CR>
  autocmd FileType typescript nnoremap <leader>ht :TSType<CR>
  autocmd FileType typescript nnoremap <leader>gt :TSTypeDef<CR>
augroup END

augroup rust_shortcuts
  autocmd!
  autocmd FileType rust nnoremap <leader>gg :call LanguageClient_textDocument_definition()<CR>
  autocmd FileType rust nnoremap <leader>ht :call LanguageClient_textDocument_hover()<CR>
augroup END

" Key mapping
nnoremap <space> <nop>
nnoremap <leader>ne :NERDTreeToggle<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>rt :set sw=2 sts=2 ts=2 expandtab<cr>:retab<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>
"nnoremap <leader>gg :YcmCompleter GoToDefinition<cr>
"nnoremap <leader>gi :YcmCompleter GoToDeclaration<cr>
"nnoremap <leader>h :YcmCompleter GetDoc<cr>
nnoremap <leader>c :pc<cr>

set modeline
set hlsearch
set number
set fillchars+=vert:\ 
"set cmdheight=2

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

colorscheme SerialExperimentsLain  " this is needed, trust me
colorscheme jellybeans
"colorscheme gruvbox

" Syntax highlighting
syntax on
