require("lazy").setup({
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	"tpope/vim-commentary",
	"mattn/emmet-vim",
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	"ellisonleao/gruvbox.nvim",
	"dracula/vim",
	"nvim-lualine/lualine.nvim",
	"nvim-treesitter/nvim-treesitter",
	"vim-test/vim-test",
	"lewis6991/gitsigns.nvim",
	"preservim/vimux",
	"christoomey/vim-tmux-navigator",
	"tpope/vim-fugitive",
	"tpope/vim-surround",
	"stevearc/oil.nvim",
	-- 1. Rainbow Delimiters
	{
		"HiPhish/rainbow-delimiters.nvim",
		submodules = false,
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"GruvboxRed",
					"GruvboxYellow",
					"GruvboxBlue",
					"GruvboxOrange",
					"GruvboxGreen",
					"GruvboxPurple",
					"GruvboxAqua",
				},
			}
		end,
	},

	-- 2. Indent Blankline

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local hooks = require("ibl.hooks")

			-- Define subtle inactive guides and vibrant active scope colors
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				-- Inactive indent lines (subtle Gruvbox background/gray tones)
				vim.api.nvim_set_hl(0, "IndentDimmed", { fg = "#3c3836" }) -- Gruvbox bg2 / dark gray

				-- Active scope rainbow palette (bright Gruvbox accents)
				vim.api.nvim_set_hl(0, "GruvboxRed", { fg = "#fb4934", bold = true })
				vim.api.nvim_set_hl(0, "GruvboxYellow", { fg = "#fabd2f", bold = true })
				vim.api.nvim_set_hl(0, "GruvboxBlue", { fg = "#83a598", bold = true })
				vim.api.nvim_set_hl(0, "GruvboxOrange", { fg = "#fe8019", bold = true })
				vim.api.nvim_set_hl(0, "GruvboxGreen", { fg = "#b8bb26", bold = true })
				vim.api.nvim_set_hl(0, "GruvboxPurple", { fg = "#d3869b", bold = true })
				vim.api.nvim_set_hl(0, "GruvboxAqua", { fg = "#8ec07c", bold = true })
			end)

			local active_scope_highlights = {
				"GruvboxRed",
				"GruvboxYellow",
				"GruvboxBlue",
				"GruvboxOrange",
				"GruvboxGreen",
				"GruvboxPurple",
				"GruvboxAqua",
			}

			require("ibl").setup({
				indent = {
					-- Use a single subtle highlight group for all inactive background guides
					highlight = { "IndentDimmed" },
					char = "│",
				},
				scope = {
					enabled = true,
					-- Rotate through the bright Gruvbox colors for nested active scopes
					highlight = active_scope_highlights,
					show_start = false,
					show_end = false,
				},
			})
		end,
	},

	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = { -- set to setup table
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	"windwp/nvim-ts-autotag",
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"toggleterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{
		"andrewferrier/wrapping.nvim",
		config = function()
			require("wrapping").setup()
		end,
	},

	-- completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-calc",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",

	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",
	"github/copilot.vim",
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			"github/copilot.vim",
			"nvim-lua/plenary.nvim",
		},
		build = "make tiktoken",
		opts = {
			model = "gpt-4o", -- Explicitly set a stable default model instead of relying on auto-discovery
			default_agent = "copilot",
		},
	},
	{
		"olimorris/codecompanion.nvim",
		version = "^19.0.0",
		opts = {
			-- Display settings control window layouts (float, vertical, horizontal, etc.)
			display = {
				chat = {
					window = {
						layout = "vertical", -- "float", "vertical", "horizontal", "tab", "buffer"
						position = "right",
						height = 0.6,
						width = 0.35,
						border = "single",
						opts = {
							winblend = 10, -- Slight transparency so code behind it is readable
						},
					},
				},
				cli = {
					window = {
						layout = "float",
						height = 0.6,
						width = 0.6,
						border = "single",
					},
				},
			},
			interactions = {
				chat = {
					adapter = { name = "ollama", model = "mistral-nemo" },
					tools = {
						["web_search"] = {
							opts = {
								adapter = "duckduckgo",
								opts = {
									search_depth = "advanced", -- Can be "basic" or "advanced"
									topic = "general", -- Can be "general" or "news"
									chunks_per_source = 3,
									max_results = 5,
								},
							},
						},
					},
				},
				inline = {
					adapter = { name = "ollama", model = "mistral-nemo" },
				},
				cli = {
					agent = "ollama_cli",
					agents = {
						ollama_cli = {
							cmd = "ollama",
							args = {
								"run",
								"mistral-nemo",
							},
							-- Environment variables injected into the CLI process
							env = {
								OLLAMA_HOST = "http://127.0.0.1:11434",
							},
							description = "Goose CLI agent running local mistral-nemo via Ollama",
							provider = "terminal",
						},
					},
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion", "codecompanion_chat_input" },
	},
	{
		"HakonHarnes/img-clip.nvim",
		opts = {
			filetypes = {
				codecompanion = {
					prompt_for_file_name = false,
					template = "[Image]($FILE_PATH)",
					use_absolute_path = true,
				},
			},
		},
	},
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"nvim-lua/plenary.nvim",

	{
		"prettier/vim-prettier",
		run = "yarn install --frozen-lockfile --production",
		branch = "release/0.x",
	},
	"phpactor/phpactor",
	"HiPhish/awk-ward.nvim",
	"MenkeTechnologies/vim-awk",
	{
		"squizlabs/PHP_CodeSniffer", -- For PHP formatting (phpcbf) geminiAI 2025-02-22 16:54
		build = "composer global require squizlabs/php_codesniffer:*", -- Or install via your system package manager if available
	},
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
		build = "make",
	},
	{
		"sontungexpt/url-open",
		event = "VeryLazy",
		cmd = "URLOpenUnderCursor",
		config = function()
			local status_ok, url_open = pcall(require, "url-open")
			if not status_ok then
				return
			end
			url_open.setup({})
		end,
	},
	{
		"goolord/alpha-nvim",
		-- dependencies = { 'echasnovski/mini.icons' },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local startify = require("alpha.themes.startify")
			-- available: devicons, mini, default is mini
			-- if provider not loaded and enabled is true, it will try to use another provider
			startify.file_icons.provider = "devicons"
			require("alpha").setup(startify.config)
		end,
	},
	-- conform -- Autoformat
	-- conform -- Autoformat
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo", "Format" }, -- Added "Format" so typing :Format triggers the plugin load
		opts = {
			log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_organize_imports", "ruff_format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				cpp = { "clang-format" },
				c = { "clang-format" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				json = { "prettier" },
				yaml = { "prettier" },
				toml = { "taplo" },
				php = { "phpcbf" },
			},
			formatters = {
				shfmt = {
					prepend_args = { "-i", "4" },
				},
				prettier = {
					prepend_args = { "--single-quote", "--print-width", "100" },
				},
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
		config = function(_, opts)
			local conform = require("conform")
			conform.setup(opts)

			-- Define the custom :Format user command
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				conform.format({ async = true, lsp_fallback = true, range = range })
			end, { range = true, desc = "Format current buffer or visual selection" })
		end,
	},
})
