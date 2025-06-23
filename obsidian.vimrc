set clipboard=unnamedplus
set tabstop=4

imap jk <Esc>
vmap jk <Esc>

nmap j gj
nmap k gk

nmap H ^
nmap L $
vmap H ^
vmap L $

:exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
" map [[ :surround_wiki
nunmap s
vunmap s
map s" :surround_double_quotes
map s' :surround_single_quotes
map s` :surround_backticks
map sb :surround_brackets
map s( :surround_brackets
map s) :surround_brackets
map s[ :surround_square_brackets
map s[ :surround_square_brackets
map s{ :surround_curly_brackets
map s} :surround_curly_brackets

exmap win_split_vert obcommand workspace:split-vertical
exmap win_split_hor obcommand workspace:split-horizontal

nmap <A-=> :win_split_hor<CR>
nmap <A--> :win_split_vert<CR>

exmap back obcommand app:go-back
nmap <C-o> :back<CR>
exmap forward obcommand app:go-forward
nmap <C-i> :forward<CR>

" Emulate Folding https://vimhelp.org/fold.txt.html#fold-commands
exmap togglefold obcommand editor:toggle-fold
nmap zo :togglefold<CR>
nmap zc :togglefold<CR>
nmap za :togglefold<CR>

exmap unfoldall obcommand editor:unfold-all
nmap zR :unfoldall<CR>

exmap foldall obcommand editor:fold-all
nmap zM :foldall<CR>


exmap tabnext obcommand workspace:next-tab
nmap <Tab> :tabnext<CR>
exmap tabprev obcommand workspace:previous-tab
nmap <S-Tab> :tabprev<CR>

unmap <Space>
exmap commands obcommand command-palette:open
nmap <Space><Space> :commands<CR>