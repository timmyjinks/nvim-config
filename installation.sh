#!/bin/bash

install_message="installing ripgrep neovim"

if [ "$OSTYPE" = "linux-gnu" ]; then
  echo "$install_message"
  sudo apt install ripgrep
  curl -L -O "https://github.com/neovim/neovim-releases/releases/download/v0.10.1/nvim-linux64.deb"
  sudo apt install ./nvim-linux64.deb
  rm nvim-linux64.deb       # ...
elif [ "$OSTYPE" = "cygwin" ]; then
  echo "$install_message"
  choco install ripgrep neovim make -y
elif [ "$OSTYPE" = "msys" ]; then
  echo "$install_message"
  choco install ripgrep neovim make -y
else
  echo "OS not supported"
fi
