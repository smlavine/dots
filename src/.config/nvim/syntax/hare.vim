" Vim syntax file
" Language: Hare

if exists("b:current_syntax")
  finish
endif

syn case match
syn keyword hareKeyword let const fn def type static export defer _
syn keyword hareBranch for return break continue yield
syn keyword hareConditional if else match switch
syn keyword hareLabel case
syn keyword hareBuiltin len offset free alloc assert append abort delete insert
syn keyword hareBuiltin vastart vaarg vaend
syn keyword hareOperator is as
syn match hareType "\vsize((\_\s|//.*)*\()@!"
syn match hareBuiltin "\vsize((\_\s|//.*)*\()@="
syn match harePreProc "^use .*;"
syn match harePreProc "@[a-z]*"
syn match hareOperator "\.\.\." "\.\."

syn region hareString start=+\z(["']\)+ end=+\z1+ skip=+\\\\\|\\\z1+
syn region hareString start=+`+ end=+`+

"adapted from c.vim
"integer number, or floating point number without a dot and with "f".
syn match	hareNumbers		display transparent "\v<\d" contains=hareNumber,hareOctal,hareBinary,hareFloat
syn match	hareNumber		display contained "\v\d+(e[-+]?\d+)?(z|[iu](8|16|32|64)?)?"
"hex number
syn match	hareNumber		display contained "\v0x\x+(z|[iu](8|16|32|64)?)?"
"octal number
syn match	hareOctal		display contained "\v0o\o+(z|[iu](8|16|32|64)?)?"
"binary number
syn match	hareBinary		display contained '\v0b[01]+(z|[iu](8|16|32|64)?)?'
syn match	hareFloat		display contained "\v\d+(e[-+]?\d+)?(f32|f64)"
"floating point number, with dot, optional exponent
syn match	hareFloat		display contained "\v\d+\.\d+(e[-+]?\d+)?(f32|f64)?"

syn match	hareSpaceError		display excludenl "\v\s+$"
syn match	hareSpaceError		display "\v +\t"me=e-1

syn keyword hareTodo contained TODO FIXME XXX
syn region hareComment start="//" end="$" contains=hareTodo,@Spell

syn keyword hareType u8 u16 u32 u64 i8 i16 i32 i64
syn keyword hareType uint int
syn keyword hareType uintptr
syn keyword hareType f32 f64
syn keyword hareType bool
syn keyword hareType char str
syn keyword hareType void
syn keyword hareType struct union
syn keyword hareType enum
syn keyword hareType nullable
syn keyword hareType rune
syn keyword hareType valist
syn keyword hareNull null
syn keyword hareBoolean true false

hi def link hareBinary Number
hi def link hareBoolean Boolean
hi def link hareBranch Repeat
hi def link hareBuiltin Function
hi def link hareComment Comment
hi def link hareConditional Conditional
hi def link hareFloat Number
hi def link hareKeyword Keyword
hi def link hareLabel Label
hi def link hareNull Constant
hi def link hareNumber Number
hi def link hareOctal Number
hi def link hareOperator Operator
hi def link harePreProc PreProc
hi def link hareString String
hi def link hareTodo Todo
hi def link hareType Type

hi def link hareSpaceError Error
autocmd InsertEnter * hi link hareSpaceError NONE
autocmd InsertLeave * hi link hareSpaceError Error

" vim: tabstop=8 shiftwidth=2 expandtab
