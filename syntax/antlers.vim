" Vim syntax file
" Language:     Antlers (Statamic)
" Maintainer:   Matthew Daly <matthewbdaly@gmail.com>
" Filenames:   *.antlers.html, *.antlers.php

if exists('b:current_syntax')
    finish
endif

if !exists("main_syntax")
    let main_syntax = 'antlers'
endif

runtime! syntax/html.vim
unlet! b:current_syntax
runtime! syntax/php.vim
unlet! b:current_syntax

syn case match
syn clear htmlError

if has('patch-7.4.1142')
    syn iskeyword @,48-57,_,192-255,@-@,:
else
    setlocal iskeyword+=@-@
endif

syn region  antlersEcho       matchgroup=antlersDelimiter start="@{{" end="}}"  contains=@antlersPhp,antlersPhpParenBlock  containedin=ALLBUT,@antlersExempt keepend
syn region  antlersComment    matchgroup=antlersDelimiter start="{{#" end="#}}"  contains=antlersTodo  containedin=ALLBUT,@antlersExempt keepend

syn keyword antlersKeyword if else elseif /if noparse /noparse unless /unless

syn region  antlersPhpRegion  matchgroup=antlersKeyword start="\<@php\>\s*(\@!" end="\<@endphp\>"  contains=@antlersPhp  containedin=ALLBUT,@antlersExempt keepend
syn match   antlersKeyword "@php\ze\s*(" nextgroup=antlersPhpParenBlock skipwhite containedin=ALLBUT,@antlersExempt
syn match antlersOperator "\v:"
syn match antlersOperator "\v\|"

syn region  antlersPhpParenBlock  matchgroup=antlersDelimiter start="\s*(" end=")" contains=@antlersPhp,antlersPhpParenBlock skipwhite contained

syn cluster antlersPhp contains=@phpClTop
syn cluster antlersExempt contains=antlersComment,antlersPhpRegion,antlersPhpParenBlock,@htmlTop

syn cluster htmlPreproc add=antlersEcho,antlersComment,antlersPhpRegion

syn case ignore
syn keyword antlersTodo todo fixme xxx note  contained

hi def link antlersDelimiter      PreProc
hi def link antlersComment        Comment
hi def link antlersTodo           Todo
hi def link antlersKeyword        Statement
hi def link antlersOperator       Normal

let b:current_syntax = 'antlers'

if exists('main_syntax') && main_syntax == 'antlers'
    unlet main_syntax
endif
