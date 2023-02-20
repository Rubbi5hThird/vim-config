gtar cf profile.tar -C $HOME --exclude="*.so" --exclude=".local/share/nvim/backups/"  .config/nvim .config/my_cfg .local/share/nvim/site .oh-my-zsh .zshrc
cp -v ~/.config/nvim/lua/plugins.lua ~/.config/nvim/lua/init.lua ~/.config/nvim/init.vim ./
