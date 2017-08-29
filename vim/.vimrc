" load vimplug
call plug#begin('~/.vim/plugged')

"Plug 'junegunn/vim-easy-align'
"Plug 'junegunn/vim-github-dashboard'
Plug 'SirVer/ultisnips' 
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-obsession' "Save vim layout
Plug 'joshdick/onedark.vim' "color shceme
Plug 'rakr/vim-one' "other color scheme
Plug 'sheerun/vim-polyglot'
Plug 'tmux-plugins/vim-tmux'
Plug 'godlygeek/csapprox'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-sensible'
Plug 'powerline/powerline', { 'rtp': 'powerline/bindings/vim' }
Plug 'Valloric/YouCompleteMe' "Auto completion
Plug 'ConradIrwin/vim-bracketed-paste' " Sets paste when pasting with normal keybinds
Plug 'suan/vim-instant-markdown'

" Initialize plugin system
call plug#end()

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

colorscheme onedark
syntax on 

"powerline config
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

""" Colorscheme Approximation """
" This transforms colorschemes to terminal colorschemes
" The ctermbg=NONE hooks make backgrounds transparent in terminals
let g:CSApprox_hook_post = [
            \ 'highlight Normal            ctermbg=NONE',
            \ 'highlight LineNr            ctermbg=NONE',
            \ 'highlight SignifyLineAdd    cterm=bold ctermbg=NONE ctermfg=green',
            \ 'highlight SignifyLineDelete cterm=bold ctermbg=NONE ctermfg=red',
            \ 'highlight SignifyLineChange cterm=bold ctermbg=NONE ctermfg=yellow',
            \ 'highlight SignifySignAdd    cterm=bold ctermbg=NONE ctermfg=green',
            \ 'highlight SignifySignDelete cterm=bold ctermbg=NONE ctermfg=red',
            \ 'highlight SignifySignChange cterm=bold ctermbg=NONE ctermfg=yellow',
            \ 'highlight SignColumn        ctermbg=NONE',
            \ 'highlight CursorLine        ctermbg=NONE cterm=underline',
            \ 'highlight Folded            ctermbg=NONE cterm=bold',
            \ 'highlight FoldColumn        ctermbg=NONE cterm=bold',
            \ 'highlight NonText           ctermbg=NONE',
            \ 'highlight clear LineNr'
            \]

"enable line numbers
set number

set nocompatible

"Set you complete me path to the location to python2. 
let g:ycm_server_python_interpreter = '/usr/bin/python2'

"copy to system clipboard when yanking.
set clipboard=unnamedplus

"allow saving edits of files with sudo. To save a file just type w!!
cmap w!! w !sudo tee >/dev/null %

"snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Set instant markdown to not open preview on every markdown file.
let g:instant_markdown_autostart = 0
" Map a key to open the preview 
map <leader>md :InstantMarkdownPreview<CR>

"enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

" Start interactive EasyAlign in visual mode (e.g. vipga)
"xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
"nmap ga <Plug>(EasyAlign)

"dissable bell
set noeb vb t_vb=

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NerdTree open on directory open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"Bind opening nerdtree to set key
map <C-n> :NERDTreeToggle<CR>

"Close Nerdtree if it is the only open pane. [Exit vim]
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Show hidden files in nerdtree view
let NERDTreeShowHidden=1

"spaces instead of tabs with a default of 4
set tabstop=4 softtabstop=4 expandtab shiftwidth=4 

"set html tabs to be 2 spaces 
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
