" Vim global plugin for completing whole lines generously
" Maintainer:	Barry Arthur <barry.arthur@gmail.com>
" Version:	0.1
" Description:	Complete whole lines from any partiel therein.
" Last Change:	2013-03-13
" License:	Vim License (see :help license)
" Location:	plugin/foist.vim
" Website:	https://github.com/dahu/foist
"
" See foist.txt for help.  This can be accessed by doing:
"
" :helptags ~/.vim/doc
" :help foist

let g:foist_version = '0.1'

" Vimscript Setup: {{{1
" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" Foist User Completion {{{1

function! Foist(term)
  let all_buf_lines = []
  let curbuf = bufnr('%')
  silent bufdo call extend(all_buf_lines, getline(1, '$'))
  exe "buffer " . curbuf
  return filter(all_buf_lines, 'v:val =~ a:term')
endfunction

function! FoistComplete(findstart, base)
  if a:findstart
    return 0
  else
    return Foist(a:base)
  endif
endfunction

set completefunc=FoistComplete

" Teardown:{{{1
"reset &cpo back to users setting
let &cpo = s:save_cpo

" vim: set sw=2 sts=2 et fdm=marker:
