vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "c", "lua", "rust", "ruby", "vim",
    "html", "php", "css", "javascript",
    "json", "markdown", "python"
  },
  callback = function()
    local ok = pcall(vim.treesitter.start)

    if ok then
      local has_parser = pcall(vim.treesitter.get_parser, 0)

      if has_parser then
        vim.bo.indentexpr =
        "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end
  end,
})

-- Spell checking for Python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us", "sv", "es" }
  end,
})
