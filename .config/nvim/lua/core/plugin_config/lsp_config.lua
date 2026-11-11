-- Configure individual servers
vim.lsp.config('solargraph', {
  cmd = { 'solargraph', 'stdio' },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
    },
  },
})

vim.lsp.config('ltex', {
  cmd = { '/home/marco/ltex-ls-16.0.0/bin/ltex-ls' },
  filetypes = { "markdown", "tex", "gitcommit", "text", "python", "php", "html" },
  settings = {
    ltex = {
      language = "en-US",
      dictionary = {
        ["en-US"] = { "Neovim", "LSP", "Lua" },
        ["es-ES"] = { "Neovim", "LSP" },
        ["sv-SE"] = { "Neovim", "LSP" },
      },
      disabledRules = {
        ["en-US"] = { "PROPOBJ_WITHOUT_NOUN" },
      },
    },
  },
})

vim.lsp.config('phpactor', {
  cmd = { "phpactor", "language-server" },
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact' },
  --  root_dir = vim.lsp.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
})

vim.lsp.config('emmet_ls', {
  cmd = { 'emmet-ls', '--stdio' },
  filetypes = { 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  -- root_dir = vim.lsp.util.root_pattern('.git'),
})

vim.lsp.config('pyright', {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- off | basic | strict
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  -- root_dir = vim.lsp.util.root_pattern('.git'),
})

-- Enable the language servers for active buffers
vim.lsp.enable('solargraph')
vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('emmet_ls')
vim.lsp.enable('ltex')
vim.lsp.enable('phpactor')
vim.lsp.enable ('bashls')

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = "■",
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN]  = "W",
      [vim.diagnostic.severity.INFO]  = "I",
      [vim.diagnostic.severity.HINT]  = "H",
    },
  },
  underline = true,
  update_in_insert = false,
  float = {
    border = "rounded",
    source = "always",
  },
})
