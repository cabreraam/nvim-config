return {
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-lua/plenary.nvim",
		},
		ft = { "java" },
		config = function()
			local jdtls = require("jdtls")
			local home = os.getenv("HOME")

			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

			-- Find the JAR paths (requires mason)
			local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
			local debug_path = home .. "/.local/share/nvim/mason/packages/java-debug-adapter"

			local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
			local debug_bundle =
				vim.fn.glob(debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true)

			local config = {
				cmd = {
					"java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xms1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					launcher_jar,
					"-configuration",
					jdtls_path .. "/config_linux", -- change to config_mac or config_win if needed
					"-data",
					workspace_dir,
				},

				--root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

				init_options = {
					bundles = { debug_bundle },
				},
			}

			jdtls.start_or_attach(config)
			jdtls.setup_dap({ hotcodereplace = "auto" })
		end,
	},
}
