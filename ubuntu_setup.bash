### Supress apt output
export DEBIAN_FRONTEND=noninteractive

### Update and upgrade
sudo apt -y update
sudo apt -y upgrade

### Install 
sudo apt -y install git
sudo apt -y install zsh

sudo apt -y install vlc
sudo apt -y install libreoffice
sudo apt -y install flatpak

### Flatpak installations
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y --noninteractive flathub com.spotify.Client
sudo flatpak install -y --noninteractive flathub com.discordapp.Discord
sudo flatpak install -y --noninteractive flathub com.teamspeak.TeamSpeak

### Install ohmyzsh
export RUNZSH=no
yes | sudo sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
cp zsh/duellmort.zsh-theme ~/.oh-my-zsh/themes/duellmort.zsh-theme
cp zsh/zshrc ~/.zshrc

