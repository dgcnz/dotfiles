"     ____  __            _           
"    / __ \/ /_  ______ _(_)___  _____
"   / /_/ / / / / / __ `/ / __ \/ ___/
"  / ____/ / /_/ / /_/ / / / / (__  ) 
" /_/   /_/\__,_/\__, /_/_/ /_/____/  
"               /____/                
"

let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug initialization
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Specifying a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'KeitaNakamura/neodark.vim'
" Plug 'airblade/vim-rooter'

Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
" Plug 'neovimhaskell/haskell-vim'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'airblade/vim-gitgutter'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Plug 'vifm/vifm.vim'
" colorschemes
" Plug 'morhetz/gruvbox'
" Plug 'dracula/vim', {'name': 'dracula'}
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'cocopon/lightline-hybrid.vim'
" Plug 'joshdick/onedark.vim'
" Plug 'shinchu/lightline-gruvbox.vim'

" languages
Plug 'posva/vim-vue'
Plug 'lervag/vimtex'

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
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
 
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tmuxline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('$TMUX')
	au InsertEnter * Tmuxline lightline_insert
	au InsertLeave * Tmuxline lightline
endif

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
                    \   'vue': ['eslint', 'vls'],
                    \   'css': ['prettier'],
                    \   'python': ['flake8'],
                    \   'cpp': ['cc'],
                    \   'c': ['clang'],
                    \   'haskell': ['ghc']
                    \}

        " let g:ale_cpp_clang_options = '-I/gs/dgcnz/development/resources/include -Wc++17-extensions -std=c++17 -Wall -Werror -Wextra -DDBG_MACRO_NO_WARNING'
        let g:ale_cpp_cc_executable = '/usr/local/bin/gcc-10'
        " let g:ale_cpp_gcc_executable = '/usr/local/bin/gcc-10'
        let g:ale_cpp_cc_options = '-I/Users/dgcnz/development/resources/include -std=c++17 -Wall -Werror -Wextra -DDBG_MACRO_NO_WARNING'
        " let g:ale_cpp_gcc_options = '-I/gs/dgcnz/development/resources/include -Wc++17-extensions -std=c++17 -Wall -Werror -Wextra -DDBG_MACRO_NO_WARNING'

        " let g:ale_sign_error = 'x'
        " let g:ale_sign_warning = '!'
        let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

        nmap <silent> <leader>a <Plug>(ale_next_wrap)


        " Only run linting when saving the file
        let g:ale_lint_on_text_changed = 'never'
        let g:ale_lint_on_enter = 0
        let g:ale_fix_on_save = 1


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" " => Git gutter (Git diff)
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        let g:gitgutter_enabled=0
        nnoremap <silent> <leader>d :GitGutterToggle<cr>

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => MarkdownPreview
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        let g:mkdp_auto_close = 0
        let g:mkdp_browser = 'google-chrome-stable'


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => fzf (fuzzy finder)
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " This is the default extra key bindings
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-o': ':r !g++ -E -P -nostdinc 2> /dev/null'}

    " Enable per-command history.
    " CTRL-N and CTRL-P will be automatically bound to next-history and
    " previous-history instead of down and up. If you don't like the change,
    " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
    let g:fzf_history_dir = '~/.local/share/fzf-history'

    map <C-f> :Files<CR>
    map <leader>b :Buffers<CR>
    nnoremap <leader>g :Rg<CR>
    nnoremap <leader>t :Tags<CR>
    nnoremap <leader>m :Marks<CR>


    let g:fzf_tags_command = 'ctags -R'
    " Border color
    let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

    let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
    let $FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-vcs"


    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

    "Get Files
    command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


    " Get text in files with Rg
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

    " Ripgrep advanced
    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

    " Git grep
    command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Coc
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " if hidden is not set, TextEdit might fail.
    set hidden

    " Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup

    " Better display for messages
    set cmdheight=2

    " You will have bad experience for diagnostic messages when it's default 4000.
    set updatetime=300

    " don't give |ins-completion-menu| messages.
    set shortmess+=c

    " always show signcolumns
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => VimTex
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    let g:tex_flavor = 'latex'
    let g:vimtex_view_method = 'zathura'


    "     ____             _     
    "    / __ )____ ______(_)____
    "   / __  / __ `/ ___/ / ___/
    "  / /_/ / /_/ (__  ) / /__  
    " /_____/\__,_/____/_/\___/  
    "                           
        set number                  " add line numbers
        set encoding=utf-8
        set nocompatible            " Disable compatibility to old-time vi
        set showmatch               " Show matching brackets.
        set ignorecase              " Do case insensitive matching
        set wildmode=full           " get bash-like tab completions
        set clipboard+=unnamedplus
        set noshowmode


    " -----------------------------
    "
if has("termguicolors")     " set true colors
    set t_8f=\[[38;2;%lu;%lu;%lum
    set t_8b=\[[48;2;%lu;%lu;%lum
    set termguicolors
endif
    "
    set background=dark
    colorscheme hybrid_material
highlight Normal guibg=none
highlight NonText guibg=none
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! SignColumn     guibg=None
        " let g:enable_bold_font = 1
        " let g:enable_italic_font = 1
    let g:hybrid_transparent_background = 1
        " colorscheme neodark         " colorscheme
        "let g:gruvbox_contrast_dark = 'hard'

        " highlight Normal guibg=NONE ctermbg=NONE


        " highlight GruvboxRedSign  ctermfg=167 ctermbg=237 guifg=#fb4934 guibg=NONE
        " highlight GruvboxYellowSign ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=None
        " highlight CursorLineNr  ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=None
        " highlight SignColumn     guibg=None
        "               links to CursorLine
        "
        " let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
        " let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
        " let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
        " let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
        " let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
    " let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
    " let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
    " let g:haskell_classic_highlighting = 1

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
    " highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE 
    set cursorline

    function! SyntaxItem()
      return synIDattr(synID(line("."),col("."),1),"name")
    endfunction

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc



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

    " let g:tmux_navigator_no_mappings = 1

    " nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
    " nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
    " nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
    " nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
    " nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

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

    autocmd filetype cpp nnoremap <F8> :call CompileSettings() <bar> term g++ -I$ACLIB -I$CPPLIBS -I$CPLIB -std=c++17 -Wall -Werror -Wextra -DDBG_MACRO_NO_WARNING -fsanitize=address,undefined % -o %:p:h/%:t:r.out && ./%:r.out<CR>
    " autocmd filetype cpp nnoremap <F8> :call CompileSettings() <bar> term g++ -std=c++17 % -Wall -Werror -Wextra -o %:p:h/%:t:r.out && ./%:r.out<CR>
    autocmd filetype c nnoremap <F8> :call CompileSettings() <bar> term gcc -std=c99 -Wall -Werror -Wextra % -o %:p:h/%:t:r.out && ./%:r.out<CR>
    autocmd filetype java nnoremap <F8> :call CompileSettings() <bar> term javac % && java -enableassertions %:p <CR>
    autocmd filetype python nnoremap <F8> :call CompileSettings() <bar> term python3 % <CR>
    autocmd filetype perl nnoremap <F8> :call CompileSettings() <bar> term perl % <CR>
    autocmd filetype sh nnoremap <F8> :call CompileSettings() <bar> term sh % <CR>
    autocmd filetype go nnoremap <F8> :call CompileSettings() <bar> term go build % && ./%:p <CR>
    autocmd filetype js nnoremap <F8> :call CompileSettings <bar> term node % <CR>
    autocmd filetype markdown nnoremap <F8> :w <bar> :MarkdownPreview <CR>
    autocmd fileType tex nnoremap <F8> :call CompileSettings() <bar> term pdflatex % && zathura %:t:r.pdf<CR><CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Debugging
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function CPInit ()
    0r $HOME/development/algorithms/competitive-programming/template.cpp
    let date = strftime("%Y-%m-%d")
    execute "%s/YY-MM-DD/". date . "/g"
endfunction

function CPTemplate ()
    :Files $HOME/development/algorithms/kactl/content
endfunction

function! CPYank ()
    :! python3 $ACLIB/expander.py % -c --lib $ACLIB | xclip -selection clipboard
endfunction

command! CPI call CPInit()
command! CPT call CPTemplate()
command! CPY call CPYank()
