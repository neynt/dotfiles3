-- LSP configuration using vim.lsp.config (nvim 0.11+)

-- diagnostic keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- LSP keymaps (set on attach)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    -- enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end,
})

-- helper for custom root_dir detection
local function package_json_with_marker(marker)
  return function(path)
    local has_marker = false
    return vim.fs.root(path, function(name, dir_path)
      if name == marker then
        has_marker = true
      end
      if name == 'package.json' and has_marker then
        return true
      end
    end)
  end
end

-- configure LSP servers
vim.lsp.config.pyright = {}
vim.lsp.config.rust_analyzer = {}
vim.lsp.config.nimls = {}
vim.lsp.config.ocamllsp = {}
vim.lsp.config.svelte = {}

-- typescript with custom root_dir
vim.lsp.config.ts_ls = {
  root_dir = package_json_with_marker('.ts-root'),
}

-- deno with custom root_dir
vim.lsp.config.denols = {
  root_dir = package_json_with_marker('.deno-root'),
}

-- enable all servers
local servers = { 'pyright', 'ts_ls', 'nimls', 'rust_analyzer', 'denols', 'ocamllsp', 'svelte' }
for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end
