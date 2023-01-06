"Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'

" =============================================================================
" ================================== PLUGINS ==================================
" =============================================================================

" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')
"Begin plugins
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'vimwiki/vimwiki'
Plug 'numToStr/FTerm.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'sainnhe/gruvbox-material'
Plug 'rebelot/kanagawa.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/calendar-vim'
Plug 'tpope/vim-repeat'
Plug 'kdheepak/lazygit.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

call plug#end()
" End plugins

" ============================================================================
" ================================== REMAPS ==================================
" ============================================================================

inoremap jk <ESC>
nnoremap <leader>n :NERDTreeFocus<CR>
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
nnoremap K {
vnoremap K {
nnoremap J }
vnoremap J }
nnoremap <silent> <CR> :noh<CR>
nnoremap L $
nnoremap H ^
let mapleader=","
nnoremap <silent> <leader>l :join<CR>
nnoremap <leader>z <C-W>r <CR>
nnoremap <leader>, :tabnew $MYVIMRC<CR>
nnoremap <Leader>zz :let &scrolloff=10-&scrolloff<CR>
nnoremap <leader>q :Ex<CR>
" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" keybind to copy and paste between system and vim or different vim instances
vnoremap <leader>y "+y
map <leader>p "+P
" Navigating splits
noremap <leader>v :vsp<CR><C-w><C-w>
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
" Navigating tabs
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>T :tabclose<CR>
nnoremap <S-TAB> gt
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader><left> :tabp<CR>
nnoremap <leader><right> :tabn<CR>
nnoremap <leader><S-Left> :-tabm<CR>
nnoremap <leader><S-Right> :+tabm<CR>
" Remaps capital leters to their lowercase commands
:command W w
:command Q q

" CtrlSF
nmap <leader>a <Plug>CtrlSFCwordPath -W<CR>
vnoremap <leader>a y:CtrlSF <C-r>0<CR>
nmap <leader>A :CtrlSF

" Pressing Ctrl + R in visual mode replaces current select
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :GFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <C-f> :Ag!
":Ag! current visual selection
vmap <C-f> y<C-f><C-r>0<CR>

nnoremap <leader>n :NERDTree<CR>
nnoremap <leader>N :NERDTreeToggle %<CR>

let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'

map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>E :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :vsplit <C-R>=expand("%:p:h") . "/" <CR>
map <leader>S :split <C-R>=expand("%:p:h") . "/" <CR>

" setup mapping to call :LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>

" Grep
nnoremap <leader>g :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Floating terminal command
" This Plugin requires nvim 0.5+(or something)
map <silent> <leader>' :lua require('FTerm').toggle()<CR>

" Faster resize
nnoremap <silent> <Leader>+ :vertical resize +10<CR>
nnoremap <silent> <Leader>- :vertical resize -10<CR>

" highlight the visual selection after pressing enter.
xnoremap <silent> <cr> "*y:silent! let searchTerm = '\V'.substitute(escape(@*, '\/'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>


" ==============================================================================
" ================================== COC stuff =================================
" ==============================================================================

" Show documentation
nnoremap <silent>? :call <SID>ShowDocumentation()<CR>
" requires tsserver
function! s:ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Autoread
set autoread
" Triger `autoread` when files changes on disk
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" coc remaps
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"should install the extensions on coc installation
"if not you have to manually use :CocInstall coc-eslint coc-prettier coc-json coc-tsserver
let g:coc_global_extensions = ['coc-eslint', 'coc-prettier', 'coc-json', 'coc-tsserver']

" coc preferences, accessible by :CocConfig
" listed here for completeness
"{
""coc.preferences.formatOnSaveFiletypes": [
""javascript",
""jsx",
""typescript",
""tsx",
""json"
"],
""diagnostic.messageTarget": "echo"
"}


" ==============================================================================
" ================================== Quality of life ===========================
" ==============================================================================

"Enable autocompletion
set wildmode=longest,list,full

syntax on

"Disables automatic commenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"nerdtree ignores node_modules
let g:NERDTreeIgnore = ['^node_modules$']
"nerdtree with single clicks
let g:NERDTreeMouseMode = 3

"Relative line number
set number relativenumber
set nu rnu

set smarttab
set autoindent
set smartindent
set cindent

" always show signcolumns
set signcolumn=yes

" Status line
set laststatus=2
set showcmd

" airline stuff
let g:airline_theme='wombat'
let g:airline_theme='lucius'
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''

" Escaping from insert mode delay
set timeoutlen=1000
set ttimeoutlen=5

set smartcase

"set tabstop=2
"set shiftwidth=2
set expandtab

"" Mouse
set mouse=a

set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=1
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" offset for scrolling
set scrolloff=10


" ==============================================================================
" ================================== AeStHeTiCs ================================
" ==============================================================================

" Cursor stuff
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" Colour stuff
set t_Co=256
set termguicolors

"Dark theme
set background=dark
colorscheme kanagawa

"Light theme
"colorscheme gruvbox-material
"set background=light

:hi Cursor guibg=reverse guifg=NONE

"Reds stuff that is after column 80
highlight OverLength guibg=#592929
match OverLength /\%>80v.\+/

"" Comments
highlight Comment guifg=grey
highlight Comment gui=none


" ==============================================================================
" ================================== VimWiki ===================================
" ==============================================================================

let g:vimwiki_list = [{'auto_diary_index': 1}]
set nocompatible
filetype plugin on

:hi VimwikiHeader1 guifg=#E46A78
:hi VimwikiHeader2 guifg=#957FB8
:hi VimwikiHeader3 guifg=#98BC6D
:hi VimwikiHeader4 guifg=#7EB3C9
:hi VimwikiHeader5 guifg=#E5C283
:hi VimwikiHeader6 guifg=#7EB3C9


" ==============================================================================
" ================================== Miscellaneous =============================
" ==============================================================================

" work in progress
" toggle line number on off, needs some tweaking to not cycle through [no numbers]
"nmap <silent> <F11> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>
"map <silent> <F11> :set invnumber<cr>

" Closetag Configs
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*js,*jsx,*ts,*tsx'
" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*js,*ts,*tsx'
" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml,js,jsx,ts,tsx'
" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js,ts,tsx'

" Use ag over grep
set grepprg=ag\ --nogroup\ --nocolor

let g:ctrlsf_auto_focus = {
    \ 'at': 'start',
    \ }

let g:ctrlsf_mapping = { "vsplit": "<C-S>" }
