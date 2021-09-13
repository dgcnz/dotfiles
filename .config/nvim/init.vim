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

" Basic
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Aesthetics
" Plug 'junegunn/goyo.vim'
" Plug 'itchyny/lightline.vim'
" Plug 'edkolev/tmuxline.vim'

" Previewing, compiling
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Colorscheme
" Plug 'kristijanhusak/vim-hybrid-material'
" Plug 'cocopon/lightline-hybrid.vim'

" Language support+
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'


" Initialize plugin system
call plug#end()


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
" => ALE (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}

let g:ale_fixers = {
    \   'javascript': ['eslint'],
    \   'vue': ['eslint'],
    \   'css': ['prettier'],
    \   'python': ['yapf'],
    \   'sql': ['pgformatter'],
    \   'cpp': ['clang-format'],
    \   'c': ['clang-format']
    \}

let g:ale_linters = {
    \   'javascript': ['eslint'],
    \   'vue': ['eslint', 'vls'],
    \   'css': ['prettier'],
    \   'python': ['yapf'],
    \   'cpp': ['cc'],
    \   'c': ['clang'],
    \   'haskell': ['ghc']
    \}

let g:ale_cpp_cc_executable = '/usr/bin/gcc'
let g:ale_cpp_cc_options = '-I$CPPINCLUDE -I$CPLIB -I$ACLIB -std=c++20 -fcoroutines -Wall -Werror -Wextra -DDBG_MACRO_NO_WARNING'

" let g:ale_sign_error = 'x'
" let g:ale_sign_warning = '!'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1


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
set relativenumber          " relative line numbering
set encoding=utf-8
set nocompatible            " Disable compatibility to old-time vi
set showmatch               " Show matching brackets.
set ignorecase              " Do case insensitive matching
set wildmode=full           " get bash-like tab completions
set clipboard+=unnamedplus
set noshowmode
set cursorline
set mouse=v                 " middle-click paste with mouse
filetype plugin indent on
" exrc allows loading local executing local rc files.
" secure disallows the use of :autocmd, shell and write commands in local .vimrc files.
set exrc
set secure

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" highlight Normal guibg=none
" highlight NonText guibg=none
" hi! Normal ctermbg=NONE guibg=NONE
" hi! NonText ctermbg=NONE guibg=NONE
" hi! SignColumn     guibg=None
" let g:hybrid_transparent_background = 1
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE 

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
set wrap 		    " Wrap lines

autocmd FileType vue setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
let g:mkdp_filetypes = ['markdown', 'md']
    
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Snippets
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" replace all is aliased to S.
nnoremap S :%s//g<Left><Left> 

" clears selections
map <silent> <leader><cr> :noh<cr>      

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Compilation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function CompileSettings ()
	write
	belowright split
	resize 10
	set nonumber
endfunction

autocmd filetype cpp nnoremap <F8> :call CompileSettings() <bar> term g++ -I$ACLIB -I$CPPINCLUDE -I$CPLIB -std=c++17 -Wall -Werror -Wextra -DDBG_MACRO_NO_WARNING -fsanitize=address,undefined % -o %:p:h/%:t:r.out && ./%:r.out<CR>
autocmd filetype c nnoremap <F8> :call CompileSettings() <bar> term gcc -std=c99 -Wall -Werror -Wextra % -o %:p:h/%:t:r.out && ./%:r.out<CR>
autocmd filetype java nnoremap <F8> :call CompileSettings() <bar> term javac % && java -enableassertions %:p <CR>
autocmd filetype python nnoremap <F8> :call CompileSettings() <bar> term python3 % <CR>
autocmd filetype sh nnoremap <F8> :call CompileSettings() <bar> term sh % <CR>
autocmd filetype markdown nnoremap <F8> :w <bar> :MarkdownPreview <CR>
autocmd fileType tex nnoremap <F8> :call CompileSettings() <bar> term pdflatex % && google-chrome-stable %:t:r.pdf<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Debugging
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function CPInit ()
    0r $CPDIR/template.cpp
    " let date = strftime("%Y-%m-%d")
    " execute "%s/YY-MM-DD/". date . "/g"
endfunction

function CPTemplate ()
    :Files $CPDIR/../kactl/content
endfunction

function! CPYank ()
    :! python3 $CPLIB/expander.py % -c --lib $CPLIB | python3 $ACLIB/expander.py /dev/stdin -c --lib $ACLIB | xclip -selection clipboard
endfunction

command! CPI call CPInit()
command! CPT call CPTemplate()
command! CPY call CPYank()



