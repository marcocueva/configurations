require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})

vim.keymap.set("n", "<c-n>", ":NvimTreeFindFile<CR>")
-- custom mappings
-- vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
-- vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
