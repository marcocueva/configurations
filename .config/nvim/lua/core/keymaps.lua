local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts) -- left window
keymap("n", "<C-k>", "<C-w>k", opts) -- up window
keymap("n", "<C-j>", "<C-w>j", opts) -- down window
keymap("n", "<C-l>", "<C-w>l", opts) -- right window

-- Resize with arrows when using multiple windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<c-down>", ":resize +2<cr>", opts)
keymap("n", "<c-right>", ":vertical resize -2<cr>", opts)
keymap("n", "<c-left>", ":vertical resize +2<cr>", opts)

-- navigate buffers
keymap("n", "<tab>", ":bnext<cr>", opts) -- Next Tab
keymap("n", "<s-tab>", ":bprevious<cr>", opts) -- Previous tab
keymap("n", "<leader>h", ":nohlsearch<cr>", opts) -- No highlight search

-- move text up and down
keymap("n", "<a-j>", "<esc>:m .+1<cr>==gi", opts) -- Alt-j
keymap("n", "<a-k>", "<esc>:m .-2<cr>==gi", opts) -- Alt-k

-- insert --
-- press jk fast to exit insert mode
keymap("i", "jk", "<esc>", opts) -- Insert mode -> jk -> Normal mode
keymap("i", "kj", "<esc>", opts) -- Insert mode -> kj -> Normal mode

-- visual --
-- stay in indent mode
keymap("v", "<", "<gv", opts) -- Right Indentation
keymap("v", ">", ">gv", opts) -- Left Indentation

-- move text up and down
keymap("v", "<a-j>", ":m .+1<cr>==", opts)
keymap("v", "<a-k>", ":m .-2<cr>==", opts)

-- Visual Block --
-- Move text up and down
--Terminal --
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Easily escape terminal mode back to normal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
	desc = "Exit terminal mode",
})

-- Autoformat
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (conform)" })

-- -- Map <leader>ca to trigger LSP code actions
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

--Toggle Flashing warning underline
local diagnostics_underlined = true

-- Toggle diagnostic underlines, from a yellow background
vim.keymap.set("n", "<leader>du", function()
	diagnostics_underlined = not diagnostics_underlined

	vim.diagnostic.config({
		underline = diagnostics_underlined,
	})

	print("Diagnostic underlines: " .. (diagnostics_underlined and "ON" or "OFF"))
end, { desc = "Toggle diagnostic underlines" })

-- Php formatting
vim.keymap.set("n", "<leader>lf", function()
	require("conform").format()
end)

-- Linting
vim.keymap.set("n", "<leader>ll", function()
	require("lint").try_lint()
end, { desc = "Run lint" })

local function toggle_diagnostic_loclist()
	-- Check if a location list window is already open
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.loclist == 1 then
			vim.cmd("lclose")
			return
		end
	end

	-- If closed, populate with current buffer diagnostics and open
	vim.diagnostic.setloclist({ open = true })
end

-- Map <leader>ld to toggle the diagnostic location list
vim.keymap.set("n", "<leader>ld", toggle_diagnostic_loclist, { desc = "Toggle diagnostic location list" })

-- Map <leader>rw to toggle the diagnostic location list
vim.keymap.set("n", "<leader>rw", function()
	-- Open a prompt in the command line for the user to type the width
	local input = vim.fn.input("Enter column width (default 80): ")
	local width = tonumber(input)

	-- Fall back to 80 if nothing was entered or input was invalid
	if not width or width <= 0 then
		width = 80
	end

	-- Apply the resize and soft-wrap settings
	vim.cmd("vertical resize " .. width)
	vim.opt_local.wrap = true
	vim.opt_local.linebreak = true
end, { desc = "Prompt for width and soft-wrap window" })

-- These keymaps cover the most common ways of working with an agent:
-- To write a prompt from any buffer:
vim.keymap.set({ "n", "v" }, "<LocalLeader>cp", function()
	return require("codecompanion").cli({ prompt = true })
end, { desc = "Prompt the CLI agent" })

-- Adding Context, to share the current buffer, or the visual selection, without writing a prompt:
vim.keymap.set({ "n", "v" }, "<LocalLeader>ca", function()
	return require("codecompanion").cli("#{this}", { focus = false })
end, { desc = "Add context to the CLI agent" })

-- Fixing LSP Diagnostics, to send the current buffer's diagnostics and ask the agent to fix them:
vim.keymap.set("n", "<LocalLeader>cd", function()
	return require("codecompanion").cli("#{diagnostics} Can you fix these?", { focus = false, submit = true })
end, { desc = "Send diagnostics to CLI agent" })

-- Open url under cursor
vim.keymap.set("n", "gx", "<esc>:URLOpenUnderCursor<cr>")
