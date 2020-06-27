echo 'clear folder'
rm ./.vim* -rf
echo 'copy the vim config'
cp ~/.vim* ./ -rf
cd ./.vim/
echo 'zip the vim config'
zip -r vim.zip ./*
fd -E vim.zip -x rm -rf
echo 'Done'
