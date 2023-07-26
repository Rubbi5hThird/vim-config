lua require('init')

" plugin fzf
let g:fzf_layout = { 'down': '30%' }
let g:fzf_preview_window = ['right:50%', 'f3']

function! RipgrepFzfLiteralGlobal(query, fullscreen)
  let command_fmt = 'rg -F --column --line-number --color=always --smart-case  -- %s'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, ]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RgGLitSearch call RipgrepFzfLiteralGlobal(<q-args>, <bang>0)
