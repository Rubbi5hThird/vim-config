lua require('init')

" plugin fzf
let g:fzf_layout = { 'down': '30%' }
let g:fzf_preview_window = ['right:50%', 'f3']
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

autocmd Filetype json
  \ let g:indentLine_setConceal = 0 |
  \ let g:vim_json_syntax_conceal = 0

function! SetTab(size)
  execute "set tabstop=".a:size
  execute "set shiftwidth=".a:size
  execute "set softtabstop=".a:size
  execute "set expandtab"
endfunction
