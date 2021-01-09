" Much of this isn't original, taken from Vim Wiki or StackOverflow. Cheers!

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

nnoremap <F4> :set rnu!<CR>

set splitbelow
set splitright

set autoindent
set tabstop=4
set shiftwidth=4

" Disable .netrwhist being generated.
let g:netrw_dirhistmax=0

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" I try to keep my max columns to 80 lines. This lets me know when I go over.
highlight ColorColumn ctermbg=0
let &colorcolumn=join(range(80,80),",")

" From StackOverflow
fun! SetupCommandAlias(from, to)
    exec 'cnoreabbrev <expr> '.a:from .' ((getcmdtype() is# ":" && getcmdline()
                \ is# "'.a:from.'")' .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" I often misspell these. Just fix 'em.
call SetupCommandAlias("W", "w")
call SetupCommandAlias("Wq", "wq")
call SetupCommandAlias("Q", "q")
call SetupCommandAlias("wQ", "wq")

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

" Capitalization bindings. Taken from vimwiki.
if (&tildeop)
    nmap gcw guw~l " capitalize word
    nmap gcW guW~l " capitalize WORD
    nmap gciw guiw~l " capitalize inner word
    nmap gciW guiW~l " capitalize inner WORD
    nmap gcis guis~l " capitalize inner sentence
    nmap gc$ gu$~l " capitalize until EOL
    nmap gcgc guu~l " capitalize whole line
    nmap gcc guu~l " capitalize whole line
    vmap gc gu~l " capitalize highlighted text
else
    nmap gcw guw~h
    nmap gcW guW~h
    nmap gciw guiw~h
    nmap gciW guiW~h
    nmap gcis guis~h
    nmap gc$ gu$~h
    nmap gcgc guu~h
    nmap gcc guu~h
    vmap gc gu~h
endif

