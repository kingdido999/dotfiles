require("plugins")

-- TODO Migrate vim to lua
local core_conf_files = {
	"config.vim",
	"key-mappings.vim",
}

-- source all the core config files
for _, name in ipairs(core_conf_files) do
	local path = string.format("%s/%s", vim.fn.stdpath("config"), name)
	local source_cmd = "source " .. path
	vim.cmd(source_cmd)
end
