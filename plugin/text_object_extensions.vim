if !exists('g:text_object_extensions') | let g:text_object_extensions = {} | endif | let s:c = g:text_object_extensions

let s:c['commaobject'] = get(s:c, 'commaobject', {'lhs': ',', 'active': 1, 'exec' : [ "map dA, da,:let @* = substitute(substitute(@*, '^,\\s*', '', ''), '\\s*$', '', '')<cr>" ]})

for [k,v] in items(s:c)
  if v.active
    exec 'onoremap <silent>a'. v.lhs .' :<C-u>call '. k .'#TextObject("a")<CR>'
    exec 'onoremap <silent>i'. v.lhs .' :<C-u>call '. k .'#TextObject("i")<CR>'
    exec 'vnoremap <silent>a'. v.lhs .' :<C-u>call '. k .'#TextObject("a")<CR><Esc>gv'
    exec 'vnoremap <silent>i'. v.lhs .' :<C-u>call '. k .'#TextObject("i")<CR><Esc>gv'
  endif
  if has_key(v, 'exec') | for e in v.exec | exec e | endfor | end
endfor
