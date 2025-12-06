set number
set relativenumber

set scrolloff=10

set autoindent

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" line cursor in insert mode, block in others
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" fix delay of cursor
set ttimeout
set ttimeoutlen=1
set ttyfast

colorscheme desert

set noswapfile

