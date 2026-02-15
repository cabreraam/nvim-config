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

			-- Paths
			local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
			local debug_path = home .. "/.local/share/nvim/mason/packages/java-debug-adapter"

			-- Launcher jar
			local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
			if launcher_jar == "" then
				vim.notify("JDTLS launcher jar not found! Run :MasonInstall jdtls", vim.log.levels.ERROR)
				return
			end

			-- Debug bundle (optional)
			local debug_bundle =
				vim.fn.glob(debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true)

			-- Project root
			local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
			if not root_dir then
				vim.notify("Could not find Java project root", vim.log.levels.ERROR)
				return
			end

			-- Workspace dir
			local workspace_dir = home .. "/.cache/jdtls/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

			-- Config
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
					jdtls_path .. "/config_linux",
					"-data",
					workspace_dir,
				},
				root_dir = root_dir,
				init_options = {
					bundles = debug_bundle ~= "" and { debug_bundle } or {},
				},
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			}

			-- Start or attach
			jdtls.start_or_attach(config)

			-- Optional: DAP
			-- jdtls.setup_dap({ hotcodereplace = "auto" })
		end,
	},
}
