local env = require("env")
local utils = require("utils")
local ensure_installed = env.treesitter.ensure_installed

if utils.isModuleAvailable("env-local") then
  ensure_installed = require("env-local").treesitter.ensure_installed
end

require("nvim-treesitter.configs").setup({
	ensure_installed = ensure_installed,
	highlight = {
		enable = true, -- false will disable the whole extension
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = false,
	},
	autotag = {
		enable = true,
	},
})
