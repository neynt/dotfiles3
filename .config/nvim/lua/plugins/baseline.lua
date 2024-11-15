return {
  { "tpope/vim-sensible" },
  { "tpope/vim-sleuth" },
  -- { "scrooloose/nerdtree" },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      vim.keymap.set('n', '<leader>f', function()
        require('nvim-tree.api').tree.toggle({ find_file = true, focus = true })
      end, { noremap = true, silent = true })
      --vim.keymap.set('n', '<leader>f', ':NvimTreeToggle<CR>', {})
      require("nvim-tree").setup({
        renderer = {
          icons = {
            show = {
              file = false,
              folder = false,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              folder = {
                arrow_closed = ">",
                arrow_open = "v",
              },
              git = {
                unstaged = "~",
                staged = "+",
                unmerged = "!",
                renamed = ">",
                untracked = "?",
                deleted = "x",
                ignored = "-",
              },
            },
          },
        },
        view = {
          side = "right",
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>F', builtin.find_files, {})
      vim.keymap.set('n', '<leader>b', builtin.buffers, { silent = true })
      vim.keymap.set('n', '<leader>h', builtin.help_tags, { silent = true })
      vim.keymap.set('n', '<leader>g', builtin.live_grep, { silent = true })
    end,
  },
  { "ConradIrwin/vim-bracketed-paste" },
  -- { "SirVer/ultisnips" },
  { "honza/vim-snippets" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-obsession" }, -- auto sessions
  { "tpope/vim-unimpaired" },
  -- { "vim-scripts/a.vim" },
  -- { "vim-airline/vim-airline" },
  -- { "vim-syntastic/syntastic" },
  -- { "ctrlpvim/ctrlp.vim" },
  { "jremmen/vim-ripgrep" },
  { "easymotion/vim-easymotion" },
  { "vim-scripts/gitignore" },
  { "junegunn/goyo.vim" },
  { "junegunn/vim-easy-align" },
  { "tpope/vim-fugitive" }, -- git integration
  -- { "dense-analysis/ale" },
  -- { "lambdalisue/suda.vim" },
  { "tmux-plugins/vim-tmux-focus-events" },
  -- { "github/copilot.vim" },
  { "djoshea/vim-autoread" },
  { "neovim/nvim-lspconfig" },
  -- language syntax
  { "rust-lang/rust.vim" },
  { "kchmck/vim-coffee-script" },
  { "gkz/vim-ls" },
  { "petRUShka/vim-sage" },
  { "rgrinberg/vim-ocaml" },
  { "let-def/ocp-indent-vim" },
  -- { "solarnz/thrift.vim" },
  -- { "alaviss/nim.nvim" },
  -- { "rhysd/vim-crystal" },
  -- { "neynt/vim-vue" },
  { "digitaltoad/vim-pug" },
  -- { "elixir-lang/vim-elixir" },
  -- { "JuliaEditorSupport/julia-vim" },
  -- { "flxf/uCpp.vim" },
  -- { "tikhomirov/vim-glsl" },
  -- { "dleonard0/pony-vim-syntax" },
  -- { "HerringtonDarkholme/yats.vim" },
  { "leafgarland/typescript-vim" },
  -- { "supercollider/scvim" },
  -- { "solarnz/thrift.vim" },
  -- { "calviken/vim-gdscript3" },
  -- { "wlangstroth/vim-racket" },
  { "iloginow/vim-stylus" },
  -- { "purescript-contrib/purescript-vim" },
  -- { "reasonml-editor/vim-reason-plus" },
  { "xolox/vim-misc" },
  -- { "tbastos/vim-lua" },
  -- { "idris-hackers/idris-vim" },
  { "PProvost/vim-ps1" },
  { "ziglang/zig.vim" },
  { "zah/nim.vim" },
  { "evanleck/vim-svelte" },
}
