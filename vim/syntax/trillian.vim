if exists("b:current_syntax")
  finish
endif

syntax match trilDate /^\[\d\d:\d\d.*\]/
syntax region trilAttrib start=/^\[/ end=/\(: \|$\)/ contains=trilDate
exec 'syntax region trilMe start=/^\[.*\] ' . trillianUserNames . ': / end=/\(^\[\|^Session Close\)\@=/ contains=trilAttrib'
syntax match trilHeader /^Session .*$/

hi link trilAttrib Type
hi link trilDate Identifier
hi link trilHeader Keyword
hi link trilMe Comment

let b:current_syntax = "trillian"
