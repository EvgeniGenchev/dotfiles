local w = vim.wo
local o = vim.o
--local b = vim.bo
local set = vim.opt
local run = vim.cmd

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
w.wrap = true
w.number = true
w.relativenumber = true
o.encoding = 'utf-8'
o.dir = '.,,**'
o.clipboard = "unnamedplus"

--------------python-syntax------------------------
run("let g:python_highlight_all=1")
run("let g:python_highlight_func_calls=1")
run("let g:python_highlight_string_format=1")
run("let g:python_highlight_indent_errors=1")
run("let g:python_highlight_exceptions=1")
----------end-python-syntax------------------------

--------------lightline----------------------------

run("let lightline={'colorscheme' : 'jellybeans',}")

-----------end-lightline----------------------------

-----------nerd-tree--------------------------------
run("let NERDTreeShowHidden=1")
-----------end-nerd-tree----------------------------


-----------vim-plug---------------------------------
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')

Plug 'wgwoods/vim-systemd-syntax'
Plug 'ap/vim-css-color'
Plug 'amadeus/vim-css'
Plug 'alvan/vim-closetag'
Plug 'EvgeniGenchev/ducky-vim'
Plug 'itchyny/lightline.vim'
Plug 'cespare/vim-toml'
Plug 'preservim/nerdtree'
Plug 'neovim/nvim-lspconfig'
Plug 'tami5/lspsaga.nvim'
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'wilriker/gcode.vim'
Plug 'chrisbra/csv.vim'
Plug 'vim-python/python-syntax'

vim.call('plug#end')
-----------end-vim-plug-----------------------------


-----------lspconfig--------------------------------

require'lspconfig'.pyright.setup{ignore={"**/.config/qutebrowser/config.py"},}
require'lspconfig'.sumneko_lua.setup{settings={Lua={diagnostics={globals={'vim'},}}}}
require'lspconfig'.ccls.setup{}
require'lspconfig'.bashls.setup{}

-------end-lspconfig--------------------------------

-------lspsaga--------------------------------------

local saga = require'lspsaga'

saga.init_lsp_saga {
	border_style = "round",
}

local smap = vim.api.nvim_buf_set_keymap
smap(0, "n", "K",  ":Lspsaga hover_doc<cr>", {silent = true, noremap = true})
smap(0, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
smap(0, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
smap(0, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
smap(0, "n", "gx", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
--smap(0, "n", "gs", "<cmd>Lspsaga signiture_help<cr>", {silent = true, noremap = true})
---end-lspsaga--------------------------------------




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
