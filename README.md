# Dotfiles

Here lies the dofiles for configuring my Ubuntu system

## Requirements

Before starting ensure you have the following

### Git

```
# install git
sudo apt install git

# create your ssh key. add a password for your passphrase. Add this to your GitHub account so you can later clone the repo
ssh-keygen
```

### Stow

```
# install stow
sudo apt install stow
```

### Zsh

```
# install zsh
sudo apt install zsh

# run this to change the default shell from bash to zsh, and don't forget to reboot for this change to take effect!
chsh -s /bin/zsh
```

### Starship

```
# install starhip
curl -sS https://starship.rs/install.sh | sh
```

## Installation

Clone the repo into your $HOME directory

```
# clone the repo to your $HOME folder
git clone git@github.com:damiang78/dotfiles.git

# install stow
cd dotfiles
stow .
```