require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    hijack_netrw_behavior = "open_default",
    follow_current_file = true
  }
})

-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
vim.keymap.set("n", "<space>e", "<cmd>Neotree toggle<CR>")
