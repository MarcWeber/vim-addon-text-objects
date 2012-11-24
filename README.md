This plugin was mostly written by others, many thanks to all of their work!

which objects are supported?

- da, va, ..: delete an argument within (a, b, c) [1]
  dA,: trim arg: remove leading, trailing , and spaces

  Note: Probably there should be a config option about whether spaces after 
  (a, b) vs ( a, b ) should be preferred.

[1]:
implementation copied from: https://github.com/austintaylor/vim-commaobject


TODO: add all of Shuogos work and find more


let scmnr.2100 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-user'}
let scmnr.2716 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-syntax'}
let scmnr.2484 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-indent'}
let scmnr.2355 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-lastpat'}
let scmnr.2276 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-jabraces'}
let scmnr.2619 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-function'}
let scmnr.2275 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-fold'}
let scmnr.2610 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-entire'}
let scmnr.2415 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-diff'}
let scmnr.2101 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-datetime'}
let scmnr.2858 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-fatpack'}
let scmnr.3886 = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-line'}
let scm['textobj-django-template'] = {'type': 'git', 'url': 'git://github.com/kana/vim-textobj-django-template', 'dependencies': {'%2100': {}}}
let scm['textobj-comment'] = {'type': 'git', 'url': 'git://github.com/thinca/vim-textobj-comment'}
let scm['textobj-function-perl'] = {'type': 'git', 'url': 'git://github.com/thinca/vim-textobj-function-perl', 'dependencies': {'%2619': {}}}
let scm['textobj-function-javascript'] = {'type': 'git', 'url': 'git://github.com/thinca/vim-textobj-function-javascript', 'dependencies': {'%2619': {}}}
let scm['textobj-between'] = {'type': 'git', 'url': 'git://github.com/thinca/vim-textobj-between', 'dependencies': {'%2100': {}}}
let scm['textobj-plugins'] = {'type': 'git', 'url': 'git://github.com/thinca/vim-textobj-plugins', 'dependencies': {'%2619': {}, '%2100': {}}}
let scmnr.3382 = {'type': 'git', 'url': 'git://github.com/nelstrom/vim-textobj-rubyblock'}
let scmnr.2999 = {'type': 'git', 'url': 'git://github.com/mjbrownie/django-template-textobjects'}
let scmnr.3000 = {'type': 'git', 'url': 'git://github.com/mjbrownie/html-textobjects'}
let scm['textobj-function-ruby'] = {'type': 'git', 'url': 'git://github.com/t9md/vim-textobj-function-ruby'}
let scmnr.4304 = {'type': 'git', 'url': 'git://github.com/hchbaw/textobj-motionmotion.vim'}
