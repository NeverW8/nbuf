if exists('g:loaded_nbuf')
  finish
endif
let g:loaded_nbuf = 1

command! NBuf lua require('nbuf').toggle()

if !exists('g:nbuf_no_default_keymap')
  nnoremap <silent> <leader>b :NBuf<CR>
endif
