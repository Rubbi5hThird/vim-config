lua require('init')

" plugin fzf
let g:fzf_layout = { 'down': '30%' }
let g:fzf_preview_window = ['right:50%', 'f3']
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

autocmd Filetype json
  \ let g:indentLine_setConceal = 0 |
  \ let g:vim_json_syntax_conceal = 0

function! RipgrepFzfLiteralGlobal(query, fullscreen)
  let command_fmt = 'rg -F --column --line-number --color=always --smart-case  -- %s'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, ]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RgGLitSearch call RipgrepFzfLiteralGlobal(<q-args>, <bang>0)
hi MatchParen cterm=bold ctermbg=green ctermfg=blue

function! SetTab(size)
  execute "set tabstop=".a:size
  execute "set shiftwidth=".a:size
  execute "set softtabstop=".a:size
  execute "set expandtab"
endfunction
