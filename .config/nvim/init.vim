call plug#begin('~/.config/nvim/plugged')

" Plugins {

    " Interface
    " ctrl-p is a fuzzy file finder.
    Plug 'ctrlpvim/ctrlp.vim'
    " airline is a better status line and a tab-bar for nvim.
    Plug 'vim-airline/vim-airline'
    " airline themes
    Plug  'vim-airline/vim-airline-themes'
    " nerdtree is tree structured file manager for vim.
    Plug 'scrooloose/nerdtree'
    " nerdcommenter for commenting and uncommenting.
    Plug 'scrooloose/nerdcommenter'

    " Color Schemes
    " base16 colorscheme.
    Plug 'chriskempson/base16-vim'
    " gruvbox
    Plug 'morhetz/gruvbox'

    " Git integration
    " vim fugitive git wrapper.
    Plug 'tpope/vim-fugitive'

    " Compilation and Linting
    " neomake - lint and make for multiple languages.
    Plug 'benekastah/neomake'
    " cmake project support.
    Plug 'vhdirk/vim-cmake'

    " Syntax and Languages
    " polygot language pack.
    Plug 'sheerun/vim-polyglot'
    " i3 config syntax support.
    Plug 'PotatoesMaster/i3-vim-syntax'
    " use external formatting programs with one command.
    Plug 'Chiel92/vim-autoformat'

    " Motions and General Text Editing
    " surround for adding parenthesis and brackets around words.
    Plug 'tpope/vim-surround'
    " automatically close parenthesis and brackets.
    Plug 'jiangmiao/auto-pairs'

    " Autocompletion
    " deoplete - dark powered autocompletion.
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " deoplete-clang - C/C++ completion for deoplete.
    Plug 'zchee/deoplete-clang'
    " deoplete-clang2 - uses 'clang -cc1' instead of 'libclang'
    "Plug 'tweekmonster/deoplete-clang2'
    " neoinclude - for header include completion
    Plug 'Shougo/neoinclude.vim'
    " echodoc - display source code docs in echo area
    Plug 'Shougo/echodoc.vim'

" }

call plug#end()

" Configuration {

    " search 
    set hlsearch                            " highlight search results.
    set incsearch                           " highlight partial mathces while searching.

    " formatting
    set linespace=0                         " set line-spacing to minimum.
    set nojoinspaces                        " Prevents inserting two spaces after punctuation on a join (J).
    set textwidth=0                         " hard-wrap long lines as you type them.

    " spaces, tabs & indentation
    set softtabstop=4                       " insert this many spaces when inserting tab.
    set expandtab                           " insert spaces when tab is pressed.
    set smarttab                            " insert tabs according to shiftwidth.
    set shiftwidth=4                        " Indentation amount for < and > commands.
    set shiftround                          " round indeht to multiple of shiftwidth (or tabstop if noexpandtab/nosmarttab).
    set autoindent                          " keep indent from previous line.
    set smartindent                         " or i let the smartindent take care of it.

    " ui options
    set number                              " show the line numbers on the left side.
    set ruler                               " show the line and column numbers of the cursor.
    set background=dark                     " set dark for dark colorscheme.
    set showcmd                             " show (partial) command in status line.
    let &showbreak='⤷   '                   " character to show at beginning of wrapped line.
    set cpoptions+=n                        " display showbreak string in line number gutter.
    set noshowmode                          " don't show current mode (airline does this).
    set cursorline                          " highlight the line the cursor is on.
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1     " blinking cursor with mode-specific shapes (0 off, 1 no-blink, 2 blink).

    " Tell Vim which characters to show for expanded TABs,
    " trailing whitespace, and end-of-lines. VERY useful!
    set listchars=tab:▸\ ,space:·,trail:·,extends:»,precedes:«,conceal:×,nbsp:˔,eol:¬

    " allow color schemes to do bright colors without forcing bold.
    set termguicolors

    " more natural splits
    set splitbelow                          " horizontal split below current.
    set splitright                          " vertical split to right of current.

    if !&scrolloff
    set scrolloff=3                         " show next 3 lines while scrolling.
    endif
    if !&sidescrolloff
    set sidescrolloff=5                     " show next 5 columns while side-scrolling.
    endif
    set nostartofline                       " do not jump to first character with page commands.

    " general
    "set ttimeout
    "set ttimeoutlen=100
    set mouse=a                             " enable mouse in terminal.
    set noerrorbells                        " no beeps.
    set modeline                            " enable modeline (commented commands that vim reads when opening files).
    " files & buffers
    set autoread                            " if file updates, load automatically.
    "set autochdir                          " switch to current file's parent directory.
    set hidden                              " allow buffers to hide in the background.
    set exrc                                " allow vim to load local .exrc for project specific settings

    " remove special characters for filename
    set isfname-=:
    set isfname-==
    set isfname-=+

    if executable('rg')
        set grepprg=rg\ --color=never       " use ripgrep as nvim's default grepprg.
    endif
    " path/file expansion in colon-mode.
    set wildmenu
    "set wildmode=list:longest
    set wildignore+=*/.git/*,*/tmp/*,*.swp

    "set completeopt               " no scratch window.

    " diff options
    set diffopt+=vertical

    " stop cursor from jumping over wrapped lines
    nnoremap j gj
    nnoremap k gk
" }

" Commands/Functions {

    " Relative numbering
    function! NumberToggle()
        if(&relativenumber == 1)
            set nornu
            set number
        else
            set rnu
        endif
    endfunc

    augroup VimStartup
        au!
        " don't continue comment marker on new line of after hitting o/O for any filetype.
        au FileType * set fo-=r fo-=o
    augroup END
" }

" Keybindings {

    " map the leader key to <space>
    let mapleader="\<space>"

    " use <c-l> to clear the highlighting of :set hlsearch.
    if maparg('<c-l>', 'n') ==# ''
      nnoremap <silent> <c-l> :nohlsearch<cr><c-l>
    endif

    " show problematic characters.
    nmap <leader>l :set list!<CR>

    " Toggle between normal and relative numbering.
    nnoremap <Leader>r :call NumberToggle()<CR>

    " save file
    nnoremap <Leader>w :w<CR>

    "copy and paste from system clipboard
    vmap <Leader>y "+y
    vmap <Leader>d "+d
    nmap <Leader>p "+p
    nmap <Leader>P "+P
    vmap <Leader>p "+p
    vmap <Leader>P "+P

    " shift line/selection up or down.
    nnoremap <A-j> :m .+1<CR>==
    nnoremap <A-k> :m .-2<CR>==
    inoremap <A-j> <Esc>:m .+1<CR>==gi
    inoremap <A-k> <Esc>:m .-2<CR>==gi
    vnoremap <A-j> :m '>+1<CR>gv=gv
    vnoremap <A-k> :m '<-2<CR>gv=gv

    " load/source init.vim
    nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
    nnoremap <Leader>sv :source $MYVIMRC<CR>
" }

" Plugin Settings {

    " airline
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 2
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline_theme= 'powerlineish'

    " Autoformat
    nnoremap <Leader>a :Autoformat<CR>

    " ctrlp
    " open file menu.
    nnoremap <Leader>o :CtrlP<CR>
    " open buffer menu.
    nnoremap <Leader>b :CtrlPBuffer<CR>
    " open most recently used files.
    nnoremap <Leader>f :CtrlPMRUFiles<CR>

    if executable('rg')
        let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
        let g:ctrlp_use_caching = 0
    endif

    " base16
    " set base16_shell_path.
    "let g:base16_shell_path="~/.config/base16-shell/scripts"
    " access colors present in 256 colorspace.
    "let base16colorspace=256
    " set base16 colorscheme.

    " gruvbox
    let g:gruvbox_italic=1
    let g:gruvbox_invert_selection=0
    colorscheme gruvbox

    " NERDTree
    " toggle tree
    noremap <Leader>t :NERDTreeToggle<CR>
    
    " neomake
    augroup NeoMakeStartup
      au!
      au BufWritePost * Neomake
    augroup END
    let g:neomake_cpp_enable_makers=['clang']
    let g:neomake_cpp_clang_args=["-std=c++14"]

    " deoplete
    let g:deoplete#enable_at_startup = 1
    "inoremap <silent><expr> <Tab>
                "\ pumvisible() ? "\<C-n>" : "<Tab>"

    " deoplete-clang
    let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
    let g:deoplete#sources#clang#clang_header = "/usr/include/clang/"
" }
    
    " only allow certain settings in .exrc in project folders
    set secure                             
" vim:set ft=vim sw=2 ts=2:
