return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "haml",
      "embedded_template",
    })
    return opts
  end,
}
