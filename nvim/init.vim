"     ____  __            _           
"    / __ \/ /_  ______ _(_)___  _____
"   / /_/ / / / / / __ `/ / __ \/ ___/
"  / ____/ / /_/ / /_/ / / / / (__  ) 
" /_/   /_/\__,_/\__, /_/_/ /_/____/  
"               /____/                

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug initialization
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Specifying a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fugitive'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'joshdick/onedark.vim'
Plug 'posva/vim-vue'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " autocmd VimEnter * NERDTree
    let g:NERDTreeWinPos = "left"
    let NERDTreeShowHidden=0
    let g:NERDTreeWinSize=35
    map <leader>nn :NERDTreeToggle<cr>
    map <leader>nb :NERDTreeFromBookmark<Space>
    map <leader>nf :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:goyo_width=100
    let g:goyo_margin_top = 2
    let g:goyo_margin_bottom = 2
    nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
    let g:ale_linters = {'vue': ['eslint', 'vls']}

    let g:ale_fixers = {
                \   'javascript': ['eslint'],
                \   'vue': ['eslint'],
                \   'css': ['prettier'],
                \   'python': ['yapf'],
                \   'cpp': ['clang-format'],
                \   'c': ['clang-format']
                \}

    let g:ale_linters = {
                \   'javascript': ['eslint'],
                \   'vue': ['eslint'],
                \   'css': ['prettier'],
                \   'python': ['flake8'],
                \   'cpp': ['clang'],
                \   'c': ['clang']
                \}

    let g:ale_cpp_clang_options = '-std=c++17 -Wall'

    let g:ale_sign_error = 'x'
    let g:ale_sign_warning = '!'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

    nmap <silent> <leader>a <Plug>(ale_next_wrap)

    highlight ALEWarning ctermfg=11 guifg=Yellow
    highlight ALEError ctermfg=13 guifg=#ffa0a0 guibg=NONE ctermbg=NONE
    highlight Warning ctermfg=11 guifg=Yellow
    highlight Error ctermfg=13 guifg=#ffa0a0 guibg=NONE ctermbg=NONE
    highlight ErrorMsg ctermfg=13 guifg=#ffa0a0 guibg=NONE ctermbg=NONE

    " Only run linting when saving the file
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 0
    let g:ale_fix_on_save = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    let g:gitgutter_enabled=0
    nnoremap <silent> <leader>d :GitGutterToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MarkdownPreview
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    let g:mkdp_auto_close = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf (fuzzy finder)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"     ____             _     
"    / __ )____ ______(_)____
"   / __  / __ `/ ___/ / ___/
"  / /_/ / /_/ (__  ) / /__  
" /_____/\__,_/____/_/\___/  
"                           

    colorscheme onedark         " colorscheme
    highlight Normal guibg=NONE ctermbg=NONE
    set number                  " add line numbers
    set encoding=utf-8
    set nocompatible            " Disable compatibility to old-time vi
    set showmatch               " Show matching brackets.
    set ignorecase              " Do case insensitive matching
    set wildmode=full           " get bash-like tab completions
    set clipboard+=unnamedplus
    set noshowmode

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Text, tab and indent related
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Use spaces instead of tabs
    set expandtab

    " Be smart when using tabs ;)
    set smarttab

    " 1 tab == 4 spaces
    set shiftwidth=4
    set tabstop=4

    " Linebreak on 500 characters
    set lbr
    set tw=500

    set autoindent              " indent a new line the same amount as the line just typed
    set smartindent             " smart indentation
    set wrap "Wrap lines

    
    autocmd FileType vue setlocal ts=2 sts=2 sw=2
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " highlight current line number
    highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE 
    set cursorline


    let mapleader = ","

    " " Copy to clipboard
    vnoremap  <leader>y  "+y
    nnoremap  <leader>Y  "+yg_
    nnoremap  <leader>y  "+y
    nnoremap  <leader>yy  "+yy

    " " Paste from clipboard
    nnoremap <leader>p "+p
    nnoremap <leader>P "+P
    vnoremap <leader>p "+p
    vnoremap <leader>P "+P

    " Filetype compatibility
    
    filetype plugin indent on
    
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    set mouse=v                 " middle-click paste with mouse

    map <C-j> <C-W>j            " Moving between windows
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    map <silent> <leader><cr> :noh<cr>      " clears selections


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Snippets
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Replace all is aliased to S.
    nnoremap S :%s//g<Left><Left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Compilation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    function CompileSettings ()
        write
        belowright split
        resize 10
        set nonumber
    endfunction

    autocmd filetype cpp nnoremap <F8> :call CompileSettings() <bar> term g++ -std=c++17 % -o %:p:h/%:t:r.out && ./%:r.out<CR>
    autocmd filetype c nnoremap <F8> :call CompileSettings() <bar> term gcc -std=c99 -Wall -Werror -Wextra % -o %:p:h/%:t:r.out && ./%:r.out<CR>
    autocmd filetype java nnoremap <F8> :call CompileSettings() <bar> term javac % && java -enableassertions %:p <CR>
    autocmd filetype python nnoremap <F8> :call CompileSettings() <bar> term python3 % <CR>
    autocmd filetype perl nnoremap <F8> :call CompileSettings() <bar> term perl % <CR>
    autocmd filetype sh nnoremap <F8> :call CompileSettings() <bar> term sh % <CR>
    autocmd filetype go nnoremap <F8> :call CompileSettings() <bar> term go build % && ./%:p <CR>
    autocmd filetype js nnoremap <F8> :call CompileSettings <bar> term node % <CR>
    autocmd filetype markdown nnoremap <F8> :w <bar> :MarkdownPreview <CR>
    autocmd fileType tex nnoremap <F8> :call CompileSettings() <bar> term pdflatex % && open %:t:r.pdf<CR><CR>

