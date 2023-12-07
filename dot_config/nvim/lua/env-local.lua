local env = {}

env.lspconfig = {
  servers = { 'tsserver', 'angularls', 'bashls', 'cssls', 'html', 'jsonls', 'yamlls', 'vimls', 'sumneko_lua', 'dockerls', 'terraformls'}
}

env.treesitter = {
	ensure_installed = {
		"java",
		"typescript",
		"javascript",
		"css",
		"html",
		"json",
		"yaml",
		"lua",
		"python",
		"fish",
		"vim",
    "terraform"
	},
}

return env
