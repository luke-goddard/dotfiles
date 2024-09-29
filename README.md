## Fresh Linux install 

This is just the bootstrap installation and default configuration for most machines. The tutorial was written on the tailend of 2024 for Ubuntu Desktop - Thinkpad.

## Install common packages 
I want to tryout fish as a shell as it's got a good vim mode unlike zsh
```
sudo apt-get update
sudo apt-get install htop xclip git vim i3 tmux polybar rofi kitty zsh fish curl ripgrep arandr make cmake ninja-build gettext unzip build-essential nodejs taskwarrior
```
## Install chrome
Don't forget to install vimium
https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb
```
sudo dpkg ./chrome.deb
sudo apt-get install ./chrome.deb
```

## Install Obsidian
```bash
# DO not install via the appimage
# https://obsidian.md/download
sudo dpkg -i ./blah.deb
sudo apt-get install ./blah.deb
```

## Generate SSH keys
Don't forget to add it your GitHub account
```bash
ssh-keygen -t ed25519 -C "l-goddard@protonmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat id_ed25519.pub | xclip -sel clip 
```

## Configure Git
```bash
git config --global user.name "luke-goddard"
git config --global user.email "l-goddard@protonmail.com"
```
## Download Dotfiles
https://github.com/luke-goddard/dotfiles
```bash 
cd $HOME/Documents
mkdir programing
cd programing
git clone git@github.com:luke-goddard/dotfiles.git
cd dotfiles
```
## Configure TMUX
```bash
cp /home/luke/Documents/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
```
## Install i3 
At this point i3 should've been installed. You just need to boot into it. 
Note that the default mod key is the linux modifer, but on some keyboards it makes more sense for alt to be the key
https://faq.i3wm.org/question/2569/set-mod-key-only-as-left-mod-key.1.html

## Removing caps lock
IMPORTANT: Xmodmap does not work with Gnome
Note: Xmod map should already be installed
Depends on the system that you're installing for, so check the dot files readme
```bash
xmodmap xmodmap-config
xbindkeys
```

### Xmodmap at startup
There is lots of faf online about this, but honestly just set it as a cron job
```bash
#/bin/bash
export KEYBOARD_CONF_DIR=/home/luke/Documents/programming/dotfiles/keyboard/thinkpad

/bin/bash $KEYBOARD_CONF_DIR/remap-exta-buttons.sh
/usr/bin/xmodmap $KEYBOARD_CONF_DIR/xmodmap-thinkpad
/usr/bin/xbindkeys
```
Then make sure the script is executable and create a cron job with. `crontab -e`

```cron
@reboot /home/luke/cron-startup.sh
```
I don't think that cron has access to $HOME, so use a full path
# Optional: Configure Fish
```
## Configuring Shell: Oh My Fish
Don't forget to set the mode to vim and check the install path
```bash
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

fish_hybrid_key_bindings

echo /usr/bin/fish | sudo tee -a /etc/shell1s
chsh -s /usr/bin/fish
```
## Installing NeoVim
```
cd /tmp
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

## Configuring NeoVim
```bash
mkdir ~/.config/nvim
cp -r dotfiles/nvim ~/.config/nvim
```

Run neovim again and let Mason do it's thing. Once that has been done you can enable copilot with
`:Copilot auth`

## Installing Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
Once complete let's add it to our shell

```bash
# ~/.config/fish/config.fish
source "$HOME/.cargo/env.fish"  # For fish
```

## Taskwarrior terminal interface

```bash
# Build it
git clone https://github.com/kdheepak/taskwarrior-tui.git 
cd taskwarrior-tui 
cargo build --release

# Install it
cargo install --path .
```


## Finished 🎊
