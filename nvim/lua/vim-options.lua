vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- LazyVim auto format
vim.g.autoformat = true

vim.keymap.set("n", ",p", '"0p', { silent = true })
vim.keymap.set("n", "<leader>`", "ysiw`", { silent = true })
vim.keymap.set("n", "<leader>w", ":up<CR>", { noremap = true, silent = true })

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { silent = true })
vim.keymap.set("n", "<leader>Y", [["+Y]], { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { silent = true })

-- make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- go to end of line
vim.keymap.set({ "n", "v" }, "<leader>k", "$", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>j", "^", { noremap = true, silent = true })

-- executing the q register macro (useful for throw-away macros)
vim.keymap.set("n", "Q", "@q", { noremap = true, silent = true })

-- copy relative lines and paste in current cursor position
vim.keymap.set("n", "+", ":<C-u>+co.<left><left><left>", { noremap = true, silent = true })
vim.keymap.set("n", "-", ":<C-u>-co.<left><left><left>", { noremap = true, silent = true })

-- window commands using <Leader><Leader>
-- vim.keymap.set('n', '<Leader><Leader>', '<C-W>', { noremap = true, silent = true })

-- window commands using ,w
vim.keymap.set("n", ",w", "<C-W>", { noremap = true, silent = true })

-- indent
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- hybrid line numbering
vim.wo.number = true
vim.wo.relativenumber = true

local opt = vim.opt

opt.cursorline = true -- Enable highlighting of the current line
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.scrolloff = 4 -- Lines of context
opt.showmode = false -- Dont show mode since we have a statusline
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
