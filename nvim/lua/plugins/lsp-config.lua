return {
	{
		"williamboman/mason.nvim",
		event = "BufReadPre",

		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",

		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, { silent = true })
		end,
	},
}
