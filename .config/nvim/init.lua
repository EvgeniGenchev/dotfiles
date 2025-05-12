local vim = vim -- luacheck: ignore
local w = vim.wo
local o = vim.o
-- local b = vim.bo
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
o.mouse = ''
set.termguicolors = true
set.scrolloff = 5
vim.cmd('set colorcolumn=100')

--------------lightline----------------------------

run("let lightline={'colorscheme' : 'jellybeans',}")

-----------end-lightline----------------------------

-----------nerd-tree--------------------------------
run("let NERDTreeShowHidden=1")
-----------end-nerd-tree----------------------------

-----------vim-plug---------------------------------
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')

Plug 'github/copilot.vim'
Plug 'wgwoods/vim-systemd-syntax'
Plug 'ap/vim-css-color'
Plug 'amadeus/vim-css'
Plug 'alvan/vim-closetag'
Plug 'EvgeniGenchev/ducky-vim'
Plug 'itchyny/lightline.vim'
Plug 'cespare/vim-toml'
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'wilriker/gcode.vim'
Plug 'chrisbra/csv.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'glepnir/zephyr-nvim'
Plug 'EvgeniGenchev/smokinq-nvim'
Plug 'EvgeniGenchev/comment-nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'goolord/alpha-nvim'
Plug 'zah/nim.vim'
Plug 'iamcco/markdown-preview.nvim'
Plug 'neoclide/coc.nvim'
Plug 'ThePrimeagen/vim-be-good'

vim.call('plug#end')
-----------end-vim-plug-----------------------------

-- Plug 'neovim/nvim-lspconfig'
-- Plug 'tami5/lspsaga.nvim'

require"ibl".setup()

---------treesitter--------------------------------
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
-------end-treesitter------------------------------

-------coc--------------------------------------
set.backup = false
set.writebackup = false
set.updatetime = 300

local keyset = vim.keymap.set
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end


keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "gk", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "gj", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

keyset("n", "<M>rn", "<Plug>(coc-rename)", {silent = true})
---end-coc--------------------------------------


------------key-mapping-----------------------------
local function  map(st, cmd)
	vim.api.nvim_set_keymap('n', st, cmd, { noremap = true, silent = true })
end

map('tm', ':Telescope find_files<CR>')

------splits-------------
map('mm', ':wincmd w<CR>')
map('mk', ':vsp<CR>')
map('mh', ':sp<CR>')
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
require('smokinq')

require('comment').setup({
	languages = {
		sh = "#",
		nim = "#",
		zig = "//",
		conf = "#",
		dockerfile = "#",
		rust = "//",
		go = "//",
	},
})

require('colorizer').setup()

require'alpha'.setup(require'alpha.themes.startify'.config)
-- require('copilot.vim').setup()

-----------cursor-tree--------------------------------
vim.opt.cursorline = true
vim.cmd[[ highlight CursorLine guibg=#30302c ]]


-- Disable cursor line in insert mode
vim.cmd([[
augroup CursorLineToggle
  autocmd!
  autocmd InsertEnter * set nocursorline
  autocmd InsertLeave * set cursorline
augroup END
]])
-----------end-cursor-tree----------------------------
vim.opt.rtp:append("~/.config/nvim/Howto-nvim")
require('howto').setup()

function Transparent()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
Transparent()
