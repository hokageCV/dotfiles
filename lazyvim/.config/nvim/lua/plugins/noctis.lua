return {
  "talha-akram/noctis.nvim",
  lazy = false,
  priority = 3000,
  config = function()
    vim.cmd.colorscheme("noctis")
    vim.cmd([[colorscheme noctis_obscuro]])
  end,
}
