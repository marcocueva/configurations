vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.cmd [[ set noswapfile]]
vim.cmd [[ set termguicolors]]

--Line numbers
vim.wo.number = true

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"  -- Sync with system clipboard

vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true      -- Ignore case
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.list = true            -- Show some invisible characters (tabs...
vim.opt.incsearch = true
vim.opt.laststatus = 0
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.pumblend = 10         -- Popup blend
vim.opt.pumheight = 10        -- Maximum number of entries in a popup
vim.opt.scrolloff = 5         -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shortmess:append { W = true, I = true, c = true }
vim.opt.showmode = false   -- Don't show mode since we have a status line
vim.opt.sidescrolloff = 8  -- Columns of context
vim.opt.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true   -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = { "en_us", "sv", "es" }
vim.api.nvim_set_hl(0, "SpellBad", {
  undercurl = true,
  fg = "NONE",
  bg = "NONE",
  sp = "orange" -- Color of the wavy underline (change to "red" or any color you prefer)
})
-- Highlight style (optional): spell bad words with undercurl instead of heavy background
vim.cmd([[highlight SpellBad gui=undercurl guisp=Red]])
-- Disable warning underlines
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
  underline = false,
})
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait0-blinkoff0-blinkon0"
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.timeoutlen = 500  -- speed must be under 500ms in order for keys to work, increase if you are not able to.
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200               -- Save swap file and trigger CursorHold
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 5                -- Minimum window width
vim.opt.wrap = false                   -- Disable line wrap

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true


-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

--CDC =Change to directory of the current file
--vim.cmd [[command! CDC cd %:p:h]]
-- CDC = Change to directory of the current file with a fallback
vim.cmd [[command! CDC execute 'lcd ' . (empty(expand('%:p:h')) ? '.' : expand('%:p:h'))]]

-- This method uses a command line abbreviation so %% expands to the full path of the directory that contains the current file
vim.cmd [[cabbr <expr> %% expand('%:p:h')]]

-- Delete trailing whitespace
vim.api.nvim_set_keymap("n", "<Leader>rtw", ":%s/\\s\\+$//e<CR>", { noremap = true, silent = false })

-- Highlight tailing whitespace m.m.
vim.opt.list = true
vim.opt.listchars = {
  nbsp = '␣', -- Shows non-breaking spaces as an open box (or use '+')
  tab = '▸ ',
  trail = '•',
}
