local config = {
	cmd = { "/home/gsus/install/jdtls/bin/jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
require("jdtls").start_or_attach(config)
require("settings-utils").keys({
	normal = {
		["<space>rv"] = { cmd = "lua require 'jdtls'.extract_variable() end" },
		["<space>rc"] = { cmd = "lua require 'jdtls'.extract_constant() end" },
	},
	visual = {
		["<space>rv"] = { cmd = "lua require 'jdtls'.extract_variable(true)" },
		["<space>rc"] = { cmd = 'lua require "jdtls".extract_constant(true)' },
		["<space>rm"] = { cmd = 'lua require "jdtls".extract_method(true)' },
	},
})
