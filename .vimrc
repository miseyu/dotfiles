set nocompatible               " be iMproved
filetype off


filetype plugin indent on
filetype indent on
syntax on

set number

let file_name = expand("%")
let g:ctrlp_use_migemo = 1
let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 500 " MRUの最大記録数
let g:ctrlp_open_new_file       = 1   " 新規ファイル作成時にタブで開く
nnoremap H b
nnoremap J }
nnoremap K {
nnoremap L w
