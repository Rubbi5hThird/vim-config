rm zsh.tar
tar cvf zsh.tar -C $HOME .oh-my-zsh/ .zshrc .ripgreprc .dircolors .batrc
rm vim.tar fzf.tar
echo 'create vim.tar fzf.tar'
tar cvf vim.tar -C $HOME .vim
tar cvf fzf.tar -C $HOME .fzf
cp -v $HOME/.vimrc ./
echo 'done'
