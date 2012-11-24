" original project:  https://github.com/austintaylor/vim-commaobject, code has
" been rewritten partially

fun! s:C()
  return getline(line("."))[col(".") - 1]
endf

fun! s:GetC(pos, col_offset)
  return getline(a:pos[1])[a:pos[2] +  a:col_offset - 1]
endf

fun! s:SynOk()
  return !(synIDattr(synID(line("."), col("."), 0), "name") =~? "string\\|comment")
endf

fun! s:RegexPos(pos)
  return '\%'.a:pos[1].'l\%'.a:pos[2].'c'
endf

fun! commaobject#Find(patterns, direction)
  " always move one char
  let move_at_least_one = "if !s:C() =~ a:patterns.any | exec \"normal \".a:direction == 'b' ? 'h' : 'l' | endif"
  exec move_at_least_one
  let found = 0
  while 1
    if 0 == search(a:patterns.any, (a:direction == 'fwd' ? '' : 'b').'W')
      break
    else
      if s:SynOk()
        let found = 1
        break
      else
        exec move_at_least_one
      endif
    endif
  endwhile
  return found
endf

" returns
" [[pos1, pos2], [pos3, pos4]]
let s:patterns = {
  \ 'fwd_end': '[})\]]',
  \ 'backw_end': '[{([]',
  \ 'seps' : '[,:;]'
  \ }
let s:patterns.any = '\%('.join(values(s:patterns),'\|').'\)'

fun! commaobject#FindAll(patterns, direction)
  let list = []
  " if cursor is on a separator add it to the list on the left
  if s:C() =~ a:patterns.seps && s:SynOk() && a:direction == 'backw'
    call add(list, {'match': 'sep', 'pos': getpos('.')})
  endif

  while commaobject#Find(a:patterns, a:direction)
    let c = s:C()
    if c =~ a:patterns.seps
      call add(list, {'match': 'sep', 'pos': getpos('.')})
    elseif c =~ a:patterns[a:direction.'_end']
      call add(list, {'match': 'end', 'pos' : getpos('.')})
      break
    else
      if a:direction == 'fwd'
        normal %l
      else
        normal %h
      endif
    endif
  endwhile
  return list
endf

fun! commaobject#Positions()
  let patterns = s:patterns
  let c = getpos('.')
  let back = commaobject#FindAll(patterns, 'backw')
  call setpos('.', c)
  return [back, commaobject#FindAll(patterns, 'fwd')]
endf

fun! commaobject#TextObject(type)
  let count_ = v:count

  let pos = commaobject#Positions()
  let lefts = pos[0]
  let rights = pos[1]
  while len(rights) > 1 && count_ > 1
    call remove(rights, 0)
    let count_ -= 1
  endwhile
  if empty(lefts) | return | endif

  " let s_start = s:GetC(lefts[-1].pos, 1) =~ '\s'
  " let s_end   = s:GetC(rights[-1].pos, -1) =~ '\s'

  " left match

  let l = ''
  echo len(lefts)
  if (len(lefts) > 1)
    let l .= '\s*'
  endif
  let l .= s:RegexPos(lefts[0].pos)
  " if not a comma, goto next char:
  let l .= (len(lefts) == 1 ? '.' : '')
  " always select one space if it exists only
  let l .= '\s\?'
  " match next char
  let l .= '.'

  " right match:

  " always select one space if it exists only
  " let r = '\s\?'
  " if not a comma, or first comma goto previous char:
  let r = (len(rights) != 1 || len(lefts) == 1 ? '' : '.')

  let r .= s:RegexPos(rights[0].pos)

  " exec 'normal /'.l."\<cr>"
  " echoe string(getpos('.'))
  " exec 'normal /'.r."\<cr>"
  " echoe string(getpos('.'))
  normal 0|
  call search(l, 'wc'. (len(lefts) == 1 ? 'e' : ''))
  normal v
  call search(r, 'wc')
endf
