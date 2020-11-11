" break line for each sentence in latex files.
inoremap .<space> .<ENTER>

set spelllang=en_us spell
nmap <leader>ef :execute "vsplit ~/.config/nvim/after/ftplugin/" . &filetype . ".vim"<ENTER>

" vim tex
map <leader>gm :VimtexToggleMain<ENTER>  " s for stage
