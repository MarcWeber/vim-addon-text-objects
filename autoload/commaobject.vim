" original project:  https://github.com/austintaylor/vim-commaobject

function! s:find(pattern, flags)
  let startcol = col(".")
  let found = search(a:pattern, a:flags, line("."))
  while found && (synIDattr(synID(line("."), col("."), 0), "name") =~? "string\\|comment")
    let found = search(a:pattern, a:flags, line("."))
  endwhile

  " If we crossed an unmatched paren or whatever, find its match and search again
  if a:flags =~ "b"
    let pairpattern = ")\\|]\\|}"
    let pairflags = "bc"
  else
    let pairpattern = "(\\|[\\|{"
    let pairflags = "c"
  endif
  let foundcol = col(".")

  call cursor(line("."), startcol)
  
  let pairfound = search(pairpattern, pairflags, line("."))
  if pairfound && ((pairflags == "bc" && col(".") > foundcol) || (pairflags == "c" && col(".") < foundcol))
    normal! %
    return s:find(a:pattern, a:flags)
  else
    call cursor(line("."), foundcol)
  endif

  return found
endfunction

function! commaobject#TextObject(inner)
  let found = s:find(",\\|(\\|[\\|{", "b")

  if !found
    return
  endif

  if getline(line("."))[col(".") - 1] == ","
    if a:inner == 'i'
      normal! w
    endif
    normal! v
    let found = s:find(",\\|)\\|]\\|}\\| do\\>", "")
    normal! h
  else
    normal! lv
    if a:inner == 'i'
      let found = s:find(",", "")
      normal! h
    else
      let found = s:find(", ", "e")
      if !found
        let found = s:find(",", "")
      endif
    endif
  endif
endfunction

