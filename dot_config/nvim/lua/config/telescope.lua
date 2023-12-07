local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),
		},
	},
})

require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")

vim.keymap.set("n", "<space>f", "<cmd>lua require'telescope.builtin'.find_files{}<CR>")
vim.keymap.set("n", "<space>r", "<cmd>lua require'telescope.builtin'.live_grep{}<CR>")
vim.keymap.set("n", "<space>wf", "<cmd>lua require'telescope.builtin'.find_files{ cwd = '~/wiki' }<CR>")
vim.keymap.set("n", "<space>wr", "<cmd>lua require'telescope.builtin'.live_grep{ cwd = '~/wiki'}<CR>")
vim.keymap.set("n", "<space>b", "<cmd>lua require'telescope.builtin'.buffers{}<CR>")
vim.keymap.set("n", "<space>h", "<cmd>lua require'telescope.builtin'.help_tags{}<CR>")

-- LSP
vim.keymap.set("n", "gd", "<cmd>lua require'telescope.builtin'.lsp_definitions{}<CR>")
vim.keymap.set("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>")
vim.keymap.set("n", "gi", "<cmd>lua require'telescope.builtin'.lsp_implementations{}<CR>")
vim.keymap.set("n", "gs", "<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>")
vim.keymap.set("n", "gS", "<cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>")
vim.keymap.set("n", "<space>d", "<cmd>lua require'telescope.builtin'.diagnostics{}<CR>")

-- git
vim.keymap.set("n", "<space>gb", "<cmd>lua require'telescope.builtin'.git_branches{}<CR>")
vim.keymap.set("n", "<space>gc", "<cmd>lua require'telescope.builtin'.git_commits{}<CR>")
