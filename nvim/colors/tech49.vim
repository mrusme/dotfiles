" Vim color file
" Converted from Textmate theme Tech49 using Coloration v0.3.3 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Tech49"

hi Cursor ctermfg=0 ctermbg=NONE cterm=NONE guifg=#000000 guibg=NONE gui=NONE
hi Visual ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi CursorLine ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi LineNr ctermfg=59 ctermbg=NONE cterm=NONE guifg=#566766 guibg=NONE gui=NONE
hi VertSplit ctermfg=59 ctermbg=NONE cterm=NONE guifg=#323c3b guibg=NONE gui=NONE
hi MatchParen ctermfg=187 ctermbg=NONE cterm=underline guifg=#d1dbaf guibg=NONE gui=underline
hi StatusLine ctermfg=152 ctermbg=NONE cterm=bold guifg=#accecb guibg=NONE gui=bold
hi StatusLineNC ctermfg=152 ctermbg=NONE cterm=NONE guifg=#accecb guibg=NONE gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=#000000 guibg=NONE gui=NONE
hi PmenuSel ctermfg=0 ctermbg=NONE cterm=NONE guifg=#accecb guibg=NONE gui=NONE
hi IncSearch ctermfg=0 ctermbg=NONE cterm=NONE guifg=#000000 guibg=NONE gui=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=144 ctermbg=NONE cterm=NONE guifg=#9ea485 guibg=NONE gui=NONE
hi Folded ctermfg=59 ctermbg=NONE cterm=NONE guifg=#3f5459 guibg=NONE gui=NONE

hi SpellBad ctermfg=NONE ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=underline
hi Normal ctermfg=152 ctermbg=NONE cterm=NONE guifg=#accecb guibg=NONE gui=NONE
hi Boolean ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi Character ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi Comment ctermfg=59 ctermbg=NONE cterm=NONE guifg=#3f5459 guibg=NONE gui=NONE
hi Conditional ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Define ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi DiffAdd ctermfg=152 ctermbg=NONE cterm=bold guifg=#accecb guibg=NONE gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#830000 guibg=NONE gui=NONE
hi DiffChange ctermfg=152 ctermbg=NONE cterm=NONE guifg=#accecb guibg=NONE gui=NONE
hi DiffText ctermfg=152 ctermbg=NONE cterm=bold guifg=#accecb guibg=NONE gui=bold
hi ErrorMsg ctermfg=88 ctermbg=NONE cterm=NONE guifg=#8a291b guibg=NONE gui=NONE
hi WarningMsg ctermfg=88 ctermbg=NONE cterm=NONE guifg=#8a291b guibg=NONE gui=NONE
hi Float ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi Function ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi Identifier ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi Keyword ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi Label ctermfg=144 ctermbg=NONE cterm=NONE guifg=#9ea485 guibg=NONE gui=NONE
hi NonText ctermfg=23 ctermbg=NONE cterm=NONE guifg=#2d3a3c guibg=NONE gui=NONE
hi Number ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi Operator ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi PreProc ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi Special ctermfg=152 ctermbg=NONE cterm=NONE guifg=#accecb guibg=NONE gui=NONE
hi SpecialKey ctermfg=23 ctermbg=NONE cterm=NONE guifg=#2d3a3c guibg=NONE gui=NONE
hi Statement ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi StorageClass ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi String ctermfg=144 ctermbg=NONE cterm=NONE guifg=#9ea485 guibg=NONE gui=NONE
hi Tag ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi Title ctermfg=152 ctermbg=NONE cterm=bold guifg=#accecb guibg=NONE gui=bold
hi Todo ctermfg=59 ctermbg=NONE cterm=inverse,bold guifg=#3f5459 guibg=NONE gui=inverse,bold
hi Type ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline

hi rubyClass ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi rubyFunction ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=144 ctermbg=NONE cterm=NONE guifg=#9ea485 guibg=NONE gui=NONE
hi rubyConstant ctermfg=195 ctermbg=NONE cterm=bold guifg=#d9fefd guibg=NONE gui=bold
hi rubyStringDelimiter ctermfg=144 ctermbg=NONE cterm=NONE guifg=#9ea485 guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi rubyInclude ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi rubyRegexp ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi rubyEscape ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi rubyControl ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi rubyOperator ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi rubyException ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=195 ctermbg=NONE cterm=bold guifg=#d9fefd guibg=NONE gui=bold
hi rubyRailsARAssociationMethod ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE

hi erubyDelimiter ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi erubyComment ctermfg=59 ctermbg=NONE cterm=NONE guifg=#3f5459 guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE

hi htmlTag ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi htmlEndTag ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi htmlTagName ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi htmlArg ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE

hi javaScriptFunction ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi javaScriptRailsFunction ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

hi yamlKey ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi yamlAnchor ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi yamlAlias ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=144 ctermbg=NONE cterm=NONE guifg=#9ea485 guibg=NONE gui=NONE

hi cssURL ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi cssFunctionName ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi cssColor ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi cssClassName ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi cssValueLength ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

hi pythonClass ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi pythonFunction ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi pythonInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi pythonSymbol ctermfg=144 ctermbg=NONE cterm=NONE guifg=#9ea485 guibg=NONE gui=NONE
hi pythonConstant ctermfg=195 ctermbg=NONE cterm=bold guifg=#d9fefd guibg=NONE gui=bold
hi pythonStringDelimiter ctermfg=144 ctermbg=NONE cterm=NONE guifg=#9ea485 guibg=NONE gui=NONE
hi pythonBlockParameter ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi pythonInstanceVariable ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi pythonInclude ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi pythonGlobalVariable ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi pythonBuiltin ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi pythonRegexp ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi pythonRegexpDelimiter ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi pythonEscape ctermfg=209 ctermbg=NONE cterm=NONE guifg=#ff815c guibg=NONE gui=NONE
hi pythonControl ctermfg=187 ctermbg=NONE cterm=NONE guifg=#d1dbaf guibg=NONE gui=NONE
hi pythonClassVariable ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi pythonOperator ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi pythonException ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi pythonPseudoVariable ctermfg=230 ctermbg=NONE cterm=NONE guifg=#fefedb guibg=NONE gui=NONE
hi pythonRailsUserClass ctermfg=195 ctermbg=NONE cterm=bold guifg=#d9fefd guibg=NONE gui=bold
hi pythonRailsARAssociationMethod ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi pythonRailsARMethod ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi pythonRailsRenderMethod ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE
hi pythonRailsMethod ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78cfde guibg=NONE gui=NONE


hi DiffAdd guifg=black guibg=NONE gui=NONE
hi DiffChange guifg=black guibg=NONE gui=NONE
hi DiffDelete guifg=black guibg=NONE gui=NONE
hi DiffText guifg=black guibg=NONE gui=NONE

hi clear SignifyLineAdd
hi clear SignifyLineChange
hi clear SignifyLineDelete

hi SignifyLineAdd ctermfg=NONE ctermbg=NONE cterm=NONE guibg=NONE guifg=#c4fefd gui=NONE
hi SignifyLineChange ctermfg=NONE ctermbg=NONE cterm=NONE guibg=NONE guifg=#fcffc7 gui=NONE
hi SignifyLineDelete ctermfg=NONE ctermbg=NONE cterm=NONE guibg=NONE guifg=#ff815a gui=NONE

hi Pmenu guibg=NONE guifg=#000000 gui=NONE
hi PmenuSel guibg=NONE guifg=#000000 gui=NONE
hi PmenuSBar guibg=NONE guifg=NONE gui=NONE
hi PmenuThumb guibg=NONE guifg=#000000 gui=NONE

