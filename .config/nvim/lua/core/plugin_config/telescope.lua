require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      "node%_modules/.*",
      "^.git/",
      "target/.*",
      "build/.*",
    },
    preview = {
      treesitter = false, -- Disables the broken ft_to_lang call in previewers
    },
  },
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, { desc = 'Telescope old files' })
vim.keymap.set('n', '<Space>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<Space>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
