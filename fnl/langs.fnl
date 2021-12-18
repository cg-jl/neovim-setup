(vim.cmd "
augroup Porth
au FileReadPost *.porth set ft=porth
augroup end

augroup LispyC
au FileReadPost *.lc set ft=lispyc
augroup end

 ")
