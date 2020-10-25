" Plugin: tmsvg/pear-tree

augroup dev
  autocmd!
augroup END

" append ";" to end of line
inoremap ;; <ESC>A;

" aapend "," to end of line
inoremap ,, <ESC>A,

" Go to definition
nmap <silent> gd <Plug>(coc-definition)

" Go to type definition (useful when on a variable)
nmap <silent> gy <Plug>(coc-type-definition)

" Go to implementation
nmap <silent> gi <Plug>(coc-implementation)

" Find all references
nmap <silent> gr <Plug>(coc-references)

" Rename class / variable / etc
nmap <leader>rn <Plug>(coc-rename)

" Apply a "quickfix"
nmap <leader>qf <Plug>(coc-fix-current)

" Show possible actions list
nmap <leader>ac <Plug>(coc-codeaction)

" Function text object
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" Class text object
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Show documentation
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Turn on spell check
autocmd dev FileType markdown,gitcommit setlocal spell

" Intelligently decide when to add, remove, and skip character pairs
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" disable dot repeat so that pairs aren't hidden until editing has been
" completed.
let g:pear_tree_repeatable_expand = 0

" Additional pairs to autocomplete
let g:pear_tree_pairs = {
      \ '(': {'closer': ')'},
      \ '[': {'closer': ']'},
      \ '{': {'closer': '}'},
      \ "'": {'closer': "'"},
      \ '"': {'closer': '"'},
      \ '<!--': {'closer': '-->'},
      \ '{{--': {'closer': '--}}'},
      \ }
