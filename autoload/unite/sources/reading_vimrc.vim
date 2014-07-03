"=============================================================================
" FILE: autoload/unite/sources/reading_vimrc.vim
" AUTHOR: haya14busa
" Last Change: 03-07-2014.
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================
scriptencoding utf-8
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

" This scripts is based on https://github.com/kmnk/vim-unite-giti

" Variables
let g:unite#sources#reading_vimrc#MAX_ID_WIDTH = 4
let g:unite#sources#reading_vimrc#MAX_NAME_WIDTH = 15

let s:source = {
\ 'name' : 'reading-vimrc',
\ 'description' : 'reading-vimrc sources',
\ }

" Unite:
function! unite#sources#reading_vimrc#define() "{{{
    let sources = []
    for command in s:get_commands()
        let source = call(s:to_define_func(command), [])
        if type({}) == type(source)
            call add(sources, source)
        elseif type([]) == type(source)
            call extend(sources, source)
        endif
        unlet source
    endfor
    return add(sources, s:source)
endfunction "}}}

function! s:source.gather_candidates(args, context) "{{{
    call unite#print_message('[reading-vimrc] reading-vimrc sources')
    let commands = s:get_commands()

    let candidates = []
    for command in commands
        let c_name = substitute(command, "_", "-", "g")
        call add(candidates, {
        \   'word' : c_name,
        \   'source' : s:source.name,
        \   'kind' : 'source',
        \   'action__source_name' : 'reading-vimrc/' . c_name,
        \ })
    endfor
    return candidates
endfunction "}}}

" Helper:
function! s:get_commands() "{{{
  return map(
\   split(
\     globpath(&runtimepath, 'autoload/unite/sources/reading_vimrc/*.vim'),
\     '\n'
\   ),
\   'fnamemodify(v:val, ":t:r")'
\ )
endfunction "}}}

function! s:to_define_func(command) "{{{
  return 'unite#sources#reading_vimrc#' . a:command . '#define'
endfunction "}}}

" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" __END__  {{{
" vim: expandtab softtabstop=4 shiftwidth=4
" vim: foldmethod=marker
" }}}
