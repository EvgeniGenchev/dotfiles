set number relativenumber
set encoding=utf-8
set path=.,,**
set nowrap

let g:python_highlight_buildins 	= 1
let g:python_highlight_func_calls 	= 1
let g:python_highlight_string_format 	= 1
let g:python_highlight_string_formatting= 1
let g:python_highlight_indent_errors 	= 1
let g:python_highlight_exceptions 	= 1
let g:python_highlight_class_vars       = 1
" let g:python_highlight_space_errors	= 1
let g:lightline = {'colorscheme' : 'jellybeans', }


call plug#begin('~/local/share/nvim/plugged')

Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim'
Plug 'cespare/vim-toml'
Plug 'justinmk/vim-syntax-extra'
Plug 'vim-python/python-syntax'

Plug 'preservim/nerdtree'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'kiteco/vim-plugin'
Plug 'codota/tabnine-vim'

call plug#end()
