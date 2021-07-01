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
set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab

" Disable .netrwhist being generated.
let g:netrw_dirhistmax=0

" Disable automatic comment completion.
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" I try to keep my max columns to 80 lines. This lets me know when I go over.
highlight ColorColumn ctermbg=0
let &colorcolumn=join(range(80,80),",")

" When writing Markdown, I prefer to use a 72 column max length. This allows
" me to toggle it quickly.
fun! ToggleColumnWidth()
	if (&colorcolumn == 80)
		let &colorcolumn=join(range(73, 80),",")
	else
		let &colorcolumn=join(range(80,80),",")
	endif
endfun

au BufNewFile,BufRead *.md call ToggleColumnWidth()

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

" Bind swap escape and "terminal escape" in a terminal window
tnoremap <Esc> <C-\><C-N>
tnoremap <C-\><C-N> <Esc>

" Indetation fix rebind
nnoremap <C-I> ==
vnoremap <C-I> ==

" Better window resizing hotkeys
nnoremap - :res -1<CR>
nnoremap = :res +1<CR>
nnoremap < :vertical res -1<CR>
nnoremap > :vertical res +1<CR>
nnoremap + <C-W>=

" Disable highlighting of searched terms.
nnoremap <C-C> :noh<CR>

