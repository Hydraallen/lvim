" Enable session loading.
let SessionLoad = 1

" Save current values of 'so' and 'siso', and then set them to 0 during initialization.
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1

" Set the current session file.
let v:this_session=expand("<sfile>:p")

" Silence the 'only' and 'tabonly' commands.
silent only
silent tabonly

" Change the current directory to the home directory.
cd ~/

" Conditionally wipe the buffer if it meets certain criteria.
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif

" Set 'shortmess' options to reduce messages during command-line editing.
set shortmess=aoO

" Add the init.vim file to the buffer list.
badd +0 .config/nvim.user/init.vim

" Perform global argument manipulation commands.
argglobal
%argdel
$argadd .config/nvim.user/init.vim

" Edit the init.vim file.
edit .config/nvim.user/init.vim

" Set window splitting preferences.
set splitbelow splitright

" Switch to the top window.
wincmd t

" Set window minimum height and width.
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1

" Perform additional argument manipulation.
argglobal

" Set local fold options for the current buffer.
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen

" Calculate the line number to position the cursor and move to that line.
let s:l = 336 - ((335 * winheight(0) + 29) / 58)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt

" Jump to line 336 and reset cursor position.
keepjumps 336
normal! 0

" Switch to the first tab.
tabnext 1

" Conditionally wipe the buffer if it exists and is not part of a terminal.
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif

" Unset the temporary variable used for wiping buffers.
unlet! s:wipebuf

" Reset window height, width, and 'shortmess'.
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOFAcI

" Source additional configuration if it exists.
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif

" Restore the original values of 'so' and 'siso'.
let &g:so = s:so_save | let &g:siso = s:siso_save

" Turn off search highlighting.
nohlsearch

" Execute SessionLoadPost autocommands and clean up.
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
