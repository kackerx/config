let mapleader=" "

call plug#begin('~/.local/share/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'KeitaNakamura/neodark.vim'
Plug 'tpope/vim-surround'
" Plug '/root/.fzf/bin/fzf'
" Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf',  {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'lyokha/vim-xkbswitch'
Plug 'majutsushi/tagbar'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'
Plug 'lyokha/vim-xkbswitch'
Plug 'itchyny/lightline.vim'
Plug 'chr4/nginx.vim'
Plug 'SirVer/ultisnips'
Plug 'sillybun/zyt-snippet'
Plug 'honza/vim-snippets'
" Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'
"if has('nvim')
""  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
""  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  "  Plug 'roxma/vim-hug-neovim-rpc'
"  "endif
call plug#end()
" let g:XkbSwitchIMappings = ['ru']
" echo libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')
" call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', 'us')
"============================================
" map f <Plug>Sneak_f
" map F <Plug>Sneak_F
" map t <Plug>Sneak_t
" map T <Plug>Sneak_T
" map s <Plug>Sneak_s
" let g:sneak#label = 1
"============================================easymotion
nmap <LEADER><LEADER>f <Plug>(easymotion-s2)
nnoremap <C-f> :FZF<CR>

"============================================rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
      \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
      \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
      \   'operators': '_,\|+\|-_',
      \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
      \   'separately': {
      \       '*': {},
      \       'tex': {
      \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
      \       },
      \       'css': 0,
      \   }
      \}
"===================gg
let g:UltiSnipsSnippetDirectories=[$HOME."/.local/share/nvim/plugged/vim-snippets"]
autocmd FileType python nnoremap <LocalLeader>l :0,$!yapf<CR>
"============tagbar===
nnoremap <LEADER>t :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/bin/ctags'
let g:tagbar_width=25
let g:tagbar_sort = 0
let g:tagbar_autopreview = 1
let g:tagbar_autofocus = 1
"============================================colorscheme
colorscheme neodark
let g:neodark#use_256color = 1 " default: 0
let g:neodark#background = '#202020'
let g:lightline = {}
let g:lightline.colorscheme = 'neodark'
"==============Ranger
let g:ranger_map_keys = 0
noremap <leader>f :w<CR>:RangerNewTab<CR>
let g:vim_markdown_folding_disabled = 1
" hi Normal ctermfg=252 ctermbg=none
" let g:neodark#terminal_transparent = 1 " default: 0
"=============================================Coc-explor
let g:coc_explorer_global_presets = {
\   'kacker': {
\      'root-uri': '~/kacker',
\      'width': 30
\   },
\ }
noremap <leader>e :CocCommand explorer --preset kacker<CR>
"============================================专用映射
noremap K 6k
noremap J 6j
noremap H 6h
noremap L 6l
nnoremap S :w <CR>
nnoremap Q :q <CR>
nnoremap ; :
nnoremap : ;
nnoremap R :source ~/.config/nvim/init.vim <CR>
map U <C-r>
"sl 向右分屏
nnoremap sl :set splitright<CR>:vsplit<CR>
nnoremap sj :set splitbelow<CR>:split<CR>
" 空格+方向键，切换光标所在窗口
nnoremap <LEADER>l <C-w>l
nnoremap <LEADER>h <C-w>h
nnoremap <LEADER>k <C-w>k
nnoremap <LEADER>j <C-w>j
inoremap <C-q> <esc>la
inoremap <C-e> #
" 标签页﹡＆……％df。。。。。。。df.。。。。df。。。。
nnoremap tn :tabe<CR>
nnoremap <C-w> :-tabnext<CR>
nnoremap <C-e> :+tabnext<CR>
inoremap <C-d> __import__('ipdb').set_trace() # XXX BREAKPOINT!

set fdm=indent
set foldlevel=99
set noswapfile
set noshowmode
set ignorecase
set relativenumber
set showcmd
set wildmenu
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase
set cursorline
set expandtab
set tabstop=2
set shiftwidth=2
set scrolloff=5
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\""
"
"
set laststatus=2
set autochdir
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" nnoremap <C-m> :!python3 %<CR>
autocmd FileType python nnoremap <buffer> <C-m> :!python3 % <CR>
autocmd FileType python nnoremap <buffer> <C-b> :!black % <CR><CR>
