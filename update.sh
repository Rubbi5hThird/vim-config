rm -rf bin lib man share nvim-config
mkdir bin lib man share nvim-config

cp ~/.local/share/icons/ ~/.local/share/locale ~/.local/share/nvim/ share/ -rf
cp ~/.local/man/man1 man/ -rf
cp ~/.local/lib/nvim/ lib/ -rf
cp ~/.local/bin/nvim bin/ -rf
cp ~/.config/nvim/colors ~/.config/nvim/init.vim ~/.config/nvim/lua nvim-config/ -rf

tar zcvf nvim-linux64.tgz bin lib man share
rm -rf bin/ lib/ man/ share/
