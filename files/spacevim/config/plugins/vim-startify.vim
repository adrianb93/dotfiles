let s:NUM = SpaceVim#api#import('data#number')
let s:FILE = SpaceVim#api#import('file')
fu! s:update_logo()
  let g:startify_custom_header = [
    \'    █████  ██████  ██████  ██  █████  ███    ██',
    \'   ██   ██ ██   ██ ██   ██ ██ ██   ██ ████   ██',
    \'   ███████ ██   ██ ██████  ██ ███████ ██ ██  ██',
    \'   ██   ██ ██   ██ ██   ██ ██ ██   ██ ██  ██ ██',
    \'   ██   ██ ██████  ██   ██ ██ ██   ██ ██   ████',
    \'   -        welcome to the escape room        -',
    \'   ██████  ██████   ██████  ██     ██ ███    ██',
    \'   ██   ██ ██   ██ ██    ██ ██     ██ ████   ██',
    \'   ██████  ██████  ██    ██ ██  █  ██ ██ ██  ██',
    \'   ██   ██ ██   ██ ██    ██ ██ ███ ██ ██  ██ ██',
    \'   ██████  ██   ██  ██████   ███ ███  ██   ████',
  \]
endf
let g:startify_session_dir = $HOME .  '/.data/' . ( has('nvim') ? 'nvim' : 'vim' ) . '/session'
let g:startify_files_number = g:spacevim_home_files_number
let g:startify_list_order = [
      \ ['   My most recently used files in the current directory:'],
      \ 'dir',
      \ ['   These are my sessions:'],
      \ 'sessions',
      \ ['   These are my bookmarks:'],
      \ 'bookmarks',
      \ ]
"let g:startify_bookmarks = [ {'c': '~/.vimrc'}, '~/.zshrc', '~/.Brewfile' ]
let g:startify_update_oldfiles = 1
let g:startify_disable_at_vimenter = 1
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
"let g:startify_session_delete_buffers = 0
let g:startify_change_to_dir = 0
"let g:startify_change_to_vcs_root = 0  " vim-rooter has same feature
let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
      \ 'bundle/.*/doc',
      \ ]
augroup startify_map
  au!
  autocmd FileType startify nnoremap <buffer> <F2> <Nop>
  if !exists('g:startify_custom_header')
    autocmd FileType startify call <SID>update_logo()
  endif
  autocmd FileType startify setl nowrap
augroup END

if !exists('g:startify_custom_header')
  call s:update_logo()
endif
call SpaceVim#mapping#space#def('nnoremap', ['a','s'], 'Startify | doautocmd WinEnter', 'fancy start screen',1)

if g:spacevim_enable_tabline_ft_icon || get(g:, 'spacevim_enable_tabline_filetype_icon', 0)
  " the old option g:spacevim_enable_tabline_filetype_icon should also works
  " well

  function! FileIcon(path)
    let icon = s:FILE.fticon(a:path)
    return empty(icon) ? ' ' : icon
  endfunction

  function! StartifyEntryFormat()
    return 'FileIcon(entry_path) ."  ". entry_path'
  endfunction

endif

" vim:set et sw=2:
