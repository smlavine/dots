" _________ _       __________________            _________ _______
" \__   __/( (    /|\__   __/\__   __/    |\     /|\__   __/(       )
"    ) (   |  \  ( |   ) (      ) (       | )   ( |   ) (   | () () |
"    | |   |   \ | |   | |      | |       | |   | |   | |   | || || |
"    | |   | (\ \) |   | |      | |       ( (   ) )   | |   | |(_)| |
"    | |   | | \   |   | |      | |        \ \_/ /    | |   | |   | |
" ___) (___| )  \  |___) (___   | |    _    \   /  ___) (___| )   ( |
" \_______/|/    )_)\_______/   )_(   (_)    \_/   \_______/|/     \|
"
" Copyright (c) 2017-2021 Sebastian LaVine <mail@smlavine.com>
" Copyright (c) 2017-2021 StackOverflow Contributors <stackoverflow.com>
" This file is licensed under the terms of CC BY-SA 4.0.
"_______________________________________________________________________

filetype plugin indent on

set wildmode=longest,list,full
set wildmenu

" Makes backspace 'normal'
set backspace=indent,eol,start

" Set leader key to space
let mapleader = " "

" Aligns C cases like:
" switch (x) {
" case 'a':
"     ...
" }
" instead of
" switch (x) {
"     case 'a':
"     ...
" }.
set cinoptions+=:0

" Aligns C function return type declarations like:
" static void
" usage()
" {
"   ...
" }
" instead of
"     static void
" usage()
" {
"   ...
" }
set cinoptions+=t0

" Indents expressions split across two lines like
" printf("foo",
"	bar);
" instead of
" printf("foo",
"		bar);
set cinoptions+=(s

" Continues to indent split if/for/while expressions like
" if (foo ==
"		NULL)
" instead of like
" if (foo ==
"	NULL)
" which would be the case with the (s cinoption added above.
set cinoptions+=k2s

" Indent the closing parenthesis of function calls across multiple lines like
" printf("foo",
"	bar
" );
" instead of
" printf("foo",
"	bar
"	);
set cinoptions+=m1

set iskeyword-=-

if !isdirectory('/tmp/nvim')
	call mkdir('/tmp/nvim')
endif
set backupdir=/tmp/nvim
set directory=/tmp/nvim
set backup

set number relativenumber
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set splitbelow
set splitright

set autoindent

" Tabs are 8 spaces wide.
set noexpandtab
set shiftwidth=8
set softtabstop=8
set tabstop=8

" Highlight parens without making it difficult to see what the characters
" being highlighted are.
hi MatchParen ctermbg=cyan ctermfg=black cterm=bold

" Disable .netrwhist being generated.
let g:netrw_dirhistmax=0

" I try to keep my max columns to 80 lines. This lets me know when I go over.
highlight ColorColumn ctermbg=black
let &colorcolumn=join(range(80,80),",")

" When writing Markdown, I prefer to use a 72 column max length. This allows
" me to toggle it quickly.
fun! ToggleColumnWidth()
	if (&colorcolumn == 80)
		let &colorcolumn=join(range(73, 80),",")
		set textwidth=72
	else
		let &colorcolumn=join(range(80,80),",")
		set textwidth=0
	endif
endfun
au BufNewFile,BufRead *.md call ToggleColumnWidth()

" html and css should be indented with spaces.
au BufNewFile,BufRead *.html setl shiftwidth=2 ts=2 softtabstop=2 expandtab
au BufNewFile,BufRead *.css  setl shiftwidth=2 ts=2 softtabstop=2 expandtab

" python should also be indented with spaces.
au BufNewFile,BufRead *.py setl shiftwidth=4 ts=4 softtabstop=4 expandtab

" This function makes it so invocations of the command :from will be
" interpreted as :to. See the following block including "W", "Wq", etc.
fun! SetupCommandAlias(from, to)
	exec 'cnoreabbrev <expr> '.a:from .' ((getcmdtype() is# ":" && getcmdline()
				\ is# "'.a:from.'")' .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" I often misspell these. Just fix 'em.
call SetupCommandAlias("W", "w")
call SetupCommandAlias("Wq", "wq")
call SetupCommandAlias("Q", "q")
call SetupCommandAlias("wQ", "wq")
call SetupCommandAlias("WQ", "wq")

nnoremap <F4> :set rnu!<CR>

nnoremap <F3> :!pandoc % -o /tmp/example.pdf &<CR><CR>

nnoremap <C-B> :call ToggleColumnWidth()<CR>

" Better window switching hotkeys.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Center window when going up/down a paragraph.
nnoremap [[ [[zz
nnoremap ]] ]]zz

" Center window when viewing search results.
nnoremap n nzz

" Bind swap escape and "terminal escape" in a terminal window
tnoremap <Esc> <C-\><C-N>
tnoremap <C-\><C-N> <Esc>

" Indetation fix rebind
nnoremap <C-I> ==
vnoremap <C-I> ==
" Cludge for 0.7 release that broke <C-I> binding in st terminal.
nnoremap <Tab> ==
vnoremap <Tab> ==

" Better window resizing hotkeys
nnoremap - :res -1<CR>
nnoremap = :res +1<CR>
nnoremap < :vertical res -1<CR>
nnoremap > :vertical res +1<CR>
nnoremap + <C-W>=

" Disable highlighting of searched terms.
nnoremap <C-C> :noh<CR>

" Disable bad indentation highlighting
nnoremap <F12> :match MatchIndentBadIndent //<CR>

" Add make bindings.
nnoremap <leader>m :make<CR>
nnoremap <leader>k :make check<CR>
