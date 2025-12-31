return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        transparent = true,
      })
      vim.cmd.colorscheme('kanagawa-wave')
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',
          component_separators = { left = '│', right = '│' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      })
    end,
  },
  { "tpope/vim-sensible" },
  { "tpope/vim-sleuth" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local builtin = require('telescope.builtin')
      local opts = { silent = true }

      -- files
      vim.keymap.set('n', '<leader>f', builtin.find_files, opts)
      vim.keymap.set('n', '<leader>o', function()
        builtin.find_files({ cwd = vim.fn.expand('%:p:h') })
      end, opts)
      vim.keymap.set('n', '<leader>r', builtin.oldfiles, opts)

      -- search
      vim.keymap.set('n', '<leader>g', builtin.live_grep, opts)
      vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, opts)

      -- vim internals
      vim.keymap.set('n', '<leader>b', builtin.buffers, opts)
      vim.keymap.set('n', '<leader>h', builtin.help_tags, opts)
      vim.keymap.set('n', '<leader>k', builtin.keymaps, opts)
      vim.keymap.set('n', '<leader>:', builtin.command_history, opts)

      -- lsp (when available)
      vim.keymap.set('n', '<leader>d', builtin.diagnostics, opts)
      vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, opts)
      vim.keymap.set('n', '<leader>S', builtin.lsp_workspace_symbols, opts)
    end,
  },
  { "ConradIrwin/vim-bracketed-paste" },
  -- { "SirVer/ultisnips" },
  { "honza/vim-snippets" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-obsession" }, -- auto sessions
  { "tpope/vim-unimpaired" },
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
