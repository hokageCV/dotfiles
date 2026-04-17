-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.fixendofline = true
vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 1000
-- This keeps undo files in one place instead of project folders
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"

vim.g.autoformat = true

-- vertical bar in insert mode in terminal
vim.opt.guicursor = "n-v-c:block,i-ci-ve-t:ver25"
