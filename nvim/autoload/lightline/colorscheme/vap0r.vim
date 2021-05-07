" ╔════════════════════════════════════════════════════════════════════════════╗
" ║             __   __   ________   ______   ______   ______                  ║
" ║            /_/\ /_/\ /_______/\ /_____/\ /_____/\ /_____/\                 ║
" ║            \:\ \\ \ \\::: _  \ \\:::_ \ \\:::_ \ \\:::_ \ \                ║
" ║             \:\ \\ \ \\::(_)  \ \\:(_) \ \\:\ \ \ \\:(_) ) )_              ║
" ║              \:\_/.:\ \\:: __  \ \\: ___\/ \:\ \ \ \\: __ `\ \             ║
" ║               \ ..::/ / \:.\ \  \ \\ \ \    \:\_\ \ \\ \ `\ \ \            ║
" ║                \___/_(   \__\/\__\/ \_\/     \_____\/ \_\/ \_\/            ║
" ║                                                                            ║
" ║      xn--gckvb8fzb.com * github.com/mrusme * marius@xn--gckvb8fzb.com      ║
" ║                                                                            ║
" ╚════════════════════════════════════════════════════════════════════════════╝
" Filename: autoload/lightline/colorscheme/vap0r.vim

let s:black = [ '#18181E', "NONE" ]
let s:gray = [ '#454548', 244 ]
let s:red = [ '#ff7d78', "NONE" ]
let s:green = [ '#65E0BD', "NONE" ]
let s:yellow = [ '#ffd478', "NONE" ]
let s:blue = [ '#799eff', "NONE" ]
let s:magenta = [ '#ff89d8', "NONE" ]
let s:cyan = [ '#75d5ff', "NONE" ]
let s:white = [ '#cfcfd8', "NONE" ]


let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ [ s:black, s:cyan ], [ s:blue, s:black ] ]
let s:p.normal.middle = [ [ s:blue, s:black ] ]
let s:p.normal.right = [ [ s:magenta, s:black ], [ s:black, s:green ] ]
let s:p.normal.error = [ [ s:magenta, s:black ] ]
let s:p.normal.warning = [ [ s:yellow, s:black ] ]
let s:p.insert.left = [ [ s:black, s:magenta ], [ s:cyan, s:black ] ]
let s:p.visual.left = [ [ s:black, s:yellow ], [ s:yellow, s:black ] ]
let s:p.replace.left = [ [ s:black, s:red ], [ s:red, s:black ] ]
let s:p.inactive.left =  [ [ s:magenta, s:black ], [ s:white, s:black ] ]
let s:p.inactive.middle = [ [ s:gray, s:black ] ]
let s:p.inactive.right = [ [ s:white, s:magenta ], [ s:magenta, s:black ] ]
let s:p.tabline.left = [ [ s:magenta, s:black ] ]
let s:p.tabline.middle = [ [ s:magenta, s:black] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.tabline.tabsel = [ [ s:black, s:magenta ] ]

let g:lightline#colorscheme#vap0r#palette = lightline#colorscheme#flatten(s:p)
