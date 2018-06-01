colorscheme molokai

" IMEがONかOFFかでカーソル色を変える
if has('multi_byte_ime') || has('xim')
  highlight Cursor guifg=NONE guibg=White
  highlight CursorIM guifg=NONE guibg=Green
endif

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
au BufRead,BufNew * match ZenkakuSpace /　/

set autoindent

" 半透明化
" gui
" set transparency=0
