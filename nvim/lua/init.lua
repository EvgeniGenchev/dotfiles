local w = vim.wo
local o = vim.o
--local b = vim.bo
local run = vim.cmd

w.wrap = false
w.number = true
w.relativenumber = true
o.encoding = 'utf-8'
o.dir = '.,,**'

--------------python-syntax------------------------
run("let g:python_highlight_buildins=1")
run("let g:python_highlight_func_calls=1")
run("let g:python_highlight_string_format=1")
run("let g:python_highlight_indent_errors=1")
run("let g:python_highlight_exceptions=1")
----------end-python-syntax------------------------

--------------lightline----------------------------

run("let lightline={'colorscheme' : 'jellybeans',}")

-----------end-lightline----------------------------

-----------vim-plug---------------------------------
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/local/share/nvim/plugged')

Plug 'ap/vim-css-color'
Plug 'amadeus/vim-css'
Plug 'alvan/vim-closetag'
Plug 'EvgeniGenchev/ducky-vim'
Plug 'itchyny/lightline.vim'
Plug 'cespare/vim-toml'
Plug 'preservim/nerdtree'
Plug 'neovim/nvim-lspconfig'
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

vim.call('plug#end')
-----------end-vim-plug-----------------------------


-----------lspconfig--------------------------------

require'lspconfig'.pyright.setup{}
require'lspconfig'.sumneko_lua.setup{settings={Lua={diagnostics={globals={'vim'},}}}}
require'lspconfig'.ccls.setup{}
require'lspconfig'.bashls.setup{}

-------end-lspconfig--------------------------------

------------key-mapping-----------------------------

local function  map(st, cmd)
	vim.api.nvim_set_keymap('n', st, cmd, { noremap = true, silent = true })
end


map('tm', ':Telescope find_files<CR>')

------splits-------------
map('mm', ':wincmd w<CR>')
map('mk', ':vsp<CR>')
------end-splits---------

---------tabs---------
map('tt',':tabnew<CR>')
map('tj',':tabp<CR>')
map('tk',':tabn<CR>')
-------end-tabs-------

----nerd-tree--------
map('mn', ':NERDTree<CR>')
---end-nerd-tree-----

--------end-key-mapping-----------------------------






