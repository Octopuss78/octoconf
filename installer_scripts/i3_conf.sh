#Installing depedencies
#pacman -Syu --no-confirm
#pacman -S kitty neovim i3 zsh i3-gaps i3lock i3blocks yay discord ttf-font-awesome powerline-fonts dmenu zsh flameshot blueman bluetoothctl brightnessctl jq feh meson ninja keepassxc rofi --no-confirm

$TMP1 = tmp_install

cd ..
mkdir $TMP1
cd $TMP1

#i3gaps
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
mkdir -p build && cd build
meson ..
ninja
cd ../../
#zsh
chsh -s $(which zsh)
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

#copy confs
cd ..
cd octoconf
cp -r ./i3 ~/.config/
cp -r ./i3blocks ~/.config/
#cp zshrc ~/.zshrc
#cp kitty.conf ~/.config/kitty

#Activate powerline
#source ~/.zshrc
