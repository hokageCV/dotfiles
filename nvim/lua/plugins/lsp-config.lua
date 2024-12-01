return {
  {
    "williamboman/mason.nvim",
    lazy = false,

    config = function()
      require("mason").setup({
        PATH = "prepend", -- "skip" seems to cause the spawning error
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,

    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "ruby_lsp" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,

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
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { silent = true })
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { silent = true })
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { silent = true })
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, { silent = true })
      vim.keymap.set({ "n" }, "<leader>rn", vim.lsp.buf.rename, { silent = true })
    end,
  },
}
