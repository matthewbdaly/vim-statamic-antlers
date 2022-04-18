" Vim filetype plugin
" Language:     Antlers (Statamic)
" Maintainer:   Matthew Daly <matthewbdaly@gmail.com>
" Filenames:   *.antlers.html, *.antlers.php

if exists('b:did_ftplugin')
    finish
endif

runtime! ftplugin/html.vim
let b:did_ftplugin = 1

setlocal suffixesadd=.antlers.php,.antlers.html
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal path+=resources/views;
setlocal include=\\w\\@<!@\\%(include\\\|extends\\)
setlocal define=\\w\\@<!@\\%(yield\\\|stack\\)

setlocal commentstring={{#%s#}}
setlocal comments+=s:{{#,m:\ \ \ \ ,e:#}}

if exists('loaded_matchit') && exists('b:match_words')
    " Append to html matchit words
    let b:match_words .= ',' .
                \ '@\%(section\s*([^\,]*)\|if\|unless\|foreach\|forelse\|for\|while\|push\|can\|cannot\|hasSection\|' .
                \     'php\s*(\@!\|verbatim\|component\|slot\|prepend\)' .
                \ ':' .
                \ '@\%(else\|elseif\|empty\|break\|continue\|elsecan\|elsecannot\)\>' .
                \ ':' .
                \ '@\%(end\w\+\|stop\|show\|append\|overwrite\)' .
                \ ',{:},\[:\],(:)'
    let b:match_skip = 'synIDattr(synID(line("."), col("."), 0), "name") !=# "antlersKeyword"'
    let b:match_ignorecase = 0
endif
