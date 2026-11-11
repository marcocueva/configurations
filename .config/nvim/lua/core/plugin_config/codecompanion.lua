-- lua/plugin_config/codecompanion.lua
return {
	display = {
		chat = {
			window = {
				layout = "float",
				position = "bottom",
				height = 0.8,
				width = 0.85,
				border = "single",
			},
		},
		cli = {
			window = {
				layout = "float",
				height = 0.8,
				width = 0.85,
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
							search_depth = "advanced",
							topic = "general",
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
					env = {
						OLLAMA_HOST = "http://127.0.0.1:11434",
					},
					description = "Interactive Ollama CLI session running mistral-nemo",
					provider = "terminal",
				},
			},
		},
	},
}
