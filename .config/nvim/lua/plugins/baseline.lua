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
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      -- install missing parsers
      local wanted = {
        'bash', 'c', 'cpp', 'css', 'go', 'html', 'javascript', 'json',
        'lua', 'markdown', 'python', 'rust', 'typescript', 'tsx', 'vim',
        'vimdoc', 'yaml', 'zig', 'ocaml', 'svelte',
      }
      local installed = require('nvim-treesitter.config').get_installed()
      local to_install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, wanted)
      if #to_install > 0 then
        require('nvim-treesitter.install').install(to_install)
      end

      -- enable treesitter highlighting
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
      -- also enable for any buffers already open
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          pcall(vim.treesitter.start, buf)
        end
      end
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      completion = {
        documentation = { auto_show = true },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      signature = { enabled = true },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        local opts = { buffer = bufnr }
        vim.keymap.set('n', ']c', gs.next_hunk, opts)
        vim.keymap.set('n', '[c', gs.prev_hunk, opts)
        vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts)
        vim.keymap.set('n', '<leader>hs', gs.stage_hunk, opts)
        vim.keymap.set('n', '<leader>hr', gs.reset_hunk, opts)
        vim.keymap.set('n', '<leader>hb', gs.blame_line, opts)
      end,
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps" },
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>cf", function() require("conform").format({ async = true }) end, desc = "Format buffer" },
    },
    opts = {
      formatters_by_ft = {
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        rust = { "rustfmt" },
        go = { "gofmt" },
        lua = { "stylua" },
        ocaml = { "ocamlformat" },
      },
      -- format_on_save disabled; use <leader>cf to format manually
      format_on_save = false,
    },
  },
  { "tpope/vim-sleuth" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')
      local opts = { silent = true }

      telescope.setup({
        defaults = {
          file_ignore_patterns = { "^%.git/" },
        },
        pickers = {
          find_files = {
            hidden = true,
            -- fd respects .gitignore by default; --strip-cwd-prefix for cleaner paths
            find_command = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix" },
          },
        },
      })

      -- files
      vim.keymap.set('n', '<leader>f', builtin.find_files, opts)

      -- load file browser extension
      telescope.load_extension('file_browser')
      vim.keymap.set('n', '<leader>o', function()
        local cwd = vim.fn.expand('%:p:h')
        require('telescope.pickers').new({}, {
          prompt_title = 'Files in ' .. vim.fn.fnamemodify(cwd, ':t'),
          finder = require('telescope.finders').new_oneshot_job(
            { 'sh', '-c', 'fd --type f --absolute-path | sort' },
            {
              cwd = cwd,
              entry_maker = function(entry)
                -- display relative to cwd, but open via absolute path
                local rel = entry:sub(#cwd + 2)  -- +2 to skip the trailing /
                return {
                  value = entry,
                  display = rel,
                  ordinal = rel,
                }
              end,
            }
          ),
          sorter = require('telescope.config').values.generic_sorter({}),
          previewer = require('telescope.config').values.file_previewer({}),
        }):find()
      end, opts)
      vim.keymap.set('n', '<leader>O', function()
        telescope.extensions.file_browser.file_browser({ path = vim.fn.expand('%:p:h') })
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
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-obsession" }, -- auto sessions
  { "tpope/vim-unimpaired" },
  { "easymotion/vim-easymotion" },
  { "junegunn/goyo.vim" },
  { "junegunn/vim-easy-align" },
  { "tpope/vim-fugitive" }, -- git integration
}
