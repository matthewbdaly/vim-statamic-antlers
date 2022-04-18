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

syn region  antlersEcho       matchgroup=antlersDelimiter start="@\@<!{{" end="}}"  contains=@antlersPhp,antlersPhpParenBlock  containedin=ALLBUT,@antlersExempt keepend
syn region  antlersEcho       matchgroup=antlersDelimiter start="{!!" end="!!}"  contains=@antlersPhp,antlersPhpParenBlock  containedin=ALLBUT,@antlersExempt keepend
syn region  antlersComment    matchgroup=antlersDelimiter start="{{#" end="#}}"  contains=antlersTodo  containedin=ALLBUT,@antlersExempt keepend

syn keyword antlersKeyword @if @elseif @foreach @forelse @for @while @can @cannot @elsecan @elsecannot @include
    \ @includeIf @each @inject @extends @section @stack @push @unless @yield @parent @hasSection @break @continue
    \ @unset @lang @choice @component @slot @prepend @json @isset @auth @guest @switch @case @includeFirst @empty
    \ @includeWhen
    \ nextgroup=antlersPhpParenBlock skipwhite containedin=ALLBUT,@antlersExempt

syn keyword antlersKeyword @else @endif @endunless @endfor @endforeach @endforelse @endwhile @endcan
    \ @endcannot @stop @append @endsection @endpush @show @overwrite @verbatim @endverbatim @endcomponent
    \ @endslot @endprepend @endisset @endempty @endauth @endguest @endswitch
    \ containedin=ALLBUT,@antlersExempt

if exists('g:antlers_custom_directives')
    exe "syn keyword antlersKeyword @" . join(g:antlers_custom_directives, ' @') . " nextgroup=antlersPhpParenBlock skipwhite containedin=ALLBUT,@antlersExempt"
endif
if exists('g:antlers_custom_directives_pairs')
    exe "syn keyword antlersKeyword @" . join(keys(g:antlers_custom_directives_pairs), ' @') . " nextgroup=antlersPhpParenBlock skipwhite containedin=ALLBUT,@antlersExempt"
    exe "syn keyword antlersKeyword @" . join(values(g:antlers_custom_directives_pairs), ' @') . " containedin=ALLBUT,@antlersExempt"
endif

syn region  antlersPhpRegion  matchgroup=antlersKeyword start="\<@php\>\s*(\@!" end="\<@endphp\>"  contains=@antlersPhp  containedin=ALLBUT,@antlersExempt keepend
syn match   antlersKeyword "@php\ze\s*(" nextgroup=antlersPhpParenBlock skipwhite containedin=ALLBUT,@antlersExempt

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

let b:current_syntax = 'antlers'

if exists('main_syntax') && main_syntax == 'antlers'
    unlet main_syntax
endif
