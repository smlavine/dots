nnoremap <leader>l :GoLint<CR>

nnoremap <leader>b :GoBuild<CR>
nnoremap <leader>r :GoRun<CR>
" To provide command-line arguments
nnoremap <leader>e :GoRun .<space>

nnoremap <leader>j :cnext<CR>
nnoremap <leader>k :cprevious<CR>
nnoremap <leader><space> :cclose<CR>

" If there is a local (project-specific) vim file, use it
silent! so .vimlocal
