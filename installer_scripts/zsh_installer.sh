#!/bin/bash
pwd=$(pwd)

echo "[+] Installation fonts"
cp -r ../JetBrainsMono_Font /usr/share/fonts
fc-cache -fv

echo "[+] Cloning repo"
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
cd /home/$USER/.oh-my-zsh/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions




echo "[+] Installation zsh"
cd /home/$USER/.oh-my-zsh/themes/
git clone https://github.com/romkatv/powerlevel10k.git
cd $pwd
#cp zshrc ~/.zshrc
echo "plugins=(git
zsh-syntax-highlighting
zsh-autosuggestions
zsh-completions
)" >> ~/.zshrc
source ~/.zshrc


echo "[+] Installation finished"
