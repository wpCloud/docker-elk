#!/usr/bin/zsh
#
# This script installs prezto into a vagrant/*nix box which already has zsh and oh-my-zsh
# installed. It also replaces the prompt color and enables the git prezto module. If
# executed via the suggested command below, also the default shell is changed into zsh.
# BTW, if using this for a vagrant box, be sure to execute the command while ssh'd into
# the box.
#
# Usage: curl -L https://raw-gist-file-address-here.sh | zsh && chsh -s $(which zsh)
#

HOME=/home/vagrant

echo "Cloning prezto"
rm -rf "${ZDOTDIR:-$HOME}/.zprezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

echo "Symlinking all requires zsh dot files"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  targetfile=${ZDOTDIR:-$HOME}/.${rcfile:t}

  rm -f "$targetfile"
  ln -s "$rcfile" "$targetfile"
done

echo "Set default prompt color to blue"
echo "zstyle ':prezto:module:editor:info:keymap:primary' format ' %B%F{blue}❯%F{blue}❯%F{blue}❯%f%b'" \
>> ${ZDOTDIR:-$HOME}/.zshrc

echo "Include git prezto module"
sed -i "s/'prompt'/'prompt' 'git'/" ${ZDOTDIR:-$HOME}/.zpreztorc

echo "All done!"

chsh -s $(which zsh)
