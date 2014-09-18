call pathogen#infect()
syntax enable
set background=dark

set hlsearch
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set foldmethod=marker
set nowrap
set textwidth=0
"map <F2> :w!<CR>
"map <F9> :! gcc -Wall -o %< %<CR>
map <F10> :! ./%<<CR>

au BufEnter,BufRead     *.inc   setf php
au BufEnter,BufRead     *.tpl   setf php
au BufNewFile,BufRead   *.tpl setf php
au BufNewFile,BufRead   *.inc setf php
"au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.pp set filetype=puppet
au BufRead,BufNewFile *.thtml set filetype=html.twig
au BufEnter *.css set nocindent
au BufLeave *.css set cindent
set mouse=a
set number
set autoindent
"set ttymouse=xterm2 this caused problems with wide terminals
"this works:
if has("mouse_urxvt")
    set ttymouse=urxvt
else
    set ttymouse=xterm2
end
set pastetoggle=<F12>

filetype plugin indent on

" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang,php,js set cindent
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType js set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType htm set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
let php_sql_query=1
let php_htmlInStrings=1
let mapleader = ","
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<c-n>"

autocmd FileType *
  \ if &omnifunc != '' |
  \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
  \   call SuperTabChain(&omnifunc, "<c-n>") |
  \ endif

let g:syntastic_phpcs_conf=" --standard=Drupal --extensions=php,module,inc,install,test,profile,theme"


if has('statusline')
  set laststatus=2
"" Broken down into easily includeable segments
  "set statusline=%<%f\ " Filename
  "set statusline+=%w%h%m%r " Options
  "set statusline+=%{fugitive#statusline()} " Git Hotness
  "set statusline+=\ [%{&ff}/%Y] " filetype
  "set statusline+=\ [%{getcwd()}] " current dir
  "set statusline+=%#warningmsg#
  "set statusline+=%{SyntasticStatuslineFlag()}
  "set statusline+=%*
  "let g:syntastic_enable_signs=1
  "set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif

"let g:stop_autocomplete=0
"function! CleverTab(type)
    "if a:type=='omni' && !pumvisible() && !g:stop_autocomplete
        "if !&omnifunc && &omnifunc != ''
            "return "\<C-X>\<C-O>\<C-P>"
        "endif
    "elseif a:type=='keyword' && !pumvisible() && !g:stop_autocomplete
        "let col = col('.') - 1
        "if !col || getline('.')[col - 1] !~ '\k'
            "let g:stop_autocomplete=1
            "return "\<TAB>"
        "endif
        ""return "\<C-X>\<C-N>\<C-P>"
        "return "\<C-N>\<C-P>"
    "elseif a:type=='next'
        "if pumvisible()
            "let g:stop_autocomplete=0
            "return "\<C-N>"
        "elseif g:stop_autocomplete
            "let g:stop_autocomplete=0
        "else
            "return "\<C-N>"
        "endif
    "elseif a:type=='back'
        "if pumvisible()
            "return "\<C-P>"
        "endif
    "endif
    "return ''
"endfunction
""inoremap <silent><TAB> <C-R>=CleverTab('keyword')<CR><C-R>=CleverTab('omni')<CR><C-R>=CleverTab('next')<CR>
"inoremap <silent><TAB> <C-R>=CleverTab('omni')<CR><C-R>=CleverTab('keyword')<CR><C-R>=CleverTab('next')<CR>
"inoremap <silent><S-TAB> <C-R>=CleverTab('back')<CR>

set list
set listchars=tab:>-,trail:-
set showmode                    " always show command or insert mode
set ruler
set showmatch
set completeopt+=menuone
set whichwrap=b,s,<,>,[,]

" More common in PEAR coding standard
" inoremap  { {<CR>}<C-O>O
" Maybe this way in other coding standards
" inoremap  { <CR>{<CR>}<C-O>O

" Standard mapping after PEAR coding standard
" Maybe this way in other coding standards
" inoremap ( ( )<LEFT><LEFT>

"; i command mode ger ; i slutet p� raden
noremap ; :s/\([^;]\)$/\1;/<cr>
"noremap <tab> :%s/\t/    /g<cr>

"Fixes for showing TABs only in golang files
"au FileType go noremap <F3> :set list!<CR>
au FileType go set nolist
au FileType go set noexpandtab


function! OpenPhpFunction (keyword)
  let proc_keyword = substitute(a:keyword , '_', '-', 'g')
  exe '10 split'
  exe 'enew'
  exe 'set buftype=nofile'
  exe 'silent r!links -dump http://www.php.net/manual/en/print/function.'.proc_keyword.'.php'
  exe 'norm gg'
  exe 'call search ("Description")'
  exe 'norm jdgg'
  exe 'call search("User Contributed Notes")'
  exe 'norm dGgg'
  exe 'norm V'
endfunction
au FileType php noremap K :call OpenPhpFunction(expand('<cword>'))<CR>

if has("autocmd")
  au  BufNewFile,BufRead *.hbt set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif

"fix autocomplete menu
highlight PMenu ctermbg=0 ctermfg=white cterm=None
highlight PMenuSel ctermbg=5 ctermfg=white cterm=Bold

"insert word under cursor in ctrlp
nmap <leader>lw :CtrlP<CR><C-\>w

source $HOME/.vimrc-custom
