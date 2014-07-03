"=============================================================================
" FILE: autoload/unite/sources/reading_vimrc/raw_vimrc.vim
" AUTHOR: haya14busa
" Last Change: 04-07-2014.
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

" reading-vimrc/raw_vimrc
let s:source = {
\ 'name' : 'reading-vimrc/raw_vimrc',
\ 'description' : 'raw_vimrc urls',
\ 'type' : 'uri',
\ 'action_table' : {},
\ }

function! unite#sources#reading_vimrc#raw_vimrc#define()
    return s:source
endfunction

function! s:source.gather_candidates(args, context)
    let archives = reading_vimrc#get_archives()
    let candidates = []
    for archive in archives
        " FIXME: It only support first one vimrc.
        let raw_url = substitute(substitute(archive.vimrc[0].url, 'github.com', 'raw.githubusercontent.com', ''),
        \                        '\V/blob/',
        \                        '/',
        \                        '',
        \                        )
        call add(candidates, {
        \   'word' : reading_vimrc#align_word(archive.id, archive.author.name, archive.date),
        \   'kind' : 'uri',
        \   'action__name' : s:source.name,
        \   'action__path': raw_url
        \ })
    endfor
    return candidates
endfunction

" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" __END__  {{{
" vim: expandtab softtabstop=4 shiftwidth=4
" vim: foldmethod=marker
" }}}
