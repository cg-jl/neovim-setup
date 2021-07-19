if exists("b:current_syntax") 
  finish
endif

syn keyword vmKW write read push pair swap gc assert_allocated print pop halt die
syn region vmString start=+"+ end=+"+
syn match vmConstant "\<\d\+\>"
syn match vmConstant "\<0x\x+\>"
syn region vmComment start=";" end="$"
syn region vmDirective start="%" end=" "
syn match vmMacroVar "#\<\w[\w\d]\*\>"




let b:current_syntax = "vm"

hi def link vmKW Keyword
hi def link vmString String
hi def link vmConstant Number
hi def link vmComment Comment
hi def link vmDirective PreProc
hi def link vmMacroVar Identifier
