#!/usr/bin/env bash
set -e

OS=""
DISTRO=""

detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
  elif [[ -f /etc/os-release ]]; then
    source /etc/os-release
    if [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
      OS="arch"
    elif [[ "$ID" == "fedora" ]]; then
      OS="fedora"
    else
      echo "Unsupported distro: $ID"
      exit 1
    fi
  else
    echo "Could not detect OS."
    exit 1
  fi
}

install_macos() {
  echo ">>> Installing for macOS..."

  if ! command -v brew &>/dev/null; then
    echo ">>> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  brew update

  echo ">>> Installing dependencies..."
  brew install neovim git ripgrep go

  echo ">>> Installing gopls..."
  go install golang.org/x/tools/gopls@latest

  echo ">>> Installing Nerd Font (JetBrainsMono)..."
  brew install --cask font-jetbrains-mono-nerd-font

  echo ""
  echo ">>> macOS install complete!"
  echo "    Set your terminal font to 'JetBrainsMono Nerd Font'"
  echo "    Add Go binaries to PATH: export PATH=\$PATH:\$(go env GOPATH)/bin"
}

install_arch() {
  echo ">>> Installing for Arch Linux..."

  echo ">>> Updating system..."
  sudo pacman -Syu --noconfirm

  echo ">>> Installing dependencies..."
  sudo pacman -S --noconfirm neovim git ripgrep go xclip

  echo ">>> Installing gopls..."
  go install golang.org/x/tools/gopls@latest

  echo ">>> Installing Nerd Font (JetBrainsMono)..."
  sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd

  echo ""
  echo ">>> Arch install complete!"
  echo "    Set your terminal font to 'JetBrainsMono Nerd Font'"
  echo "    Add Go binaries to PATH: export PATH=\$PATH:\$(go env GOPATH)/bin"
}

install_fedora() {
  echo ">>> Installing for Fedora..."

  echo ">>> Updating system..."
  sudo dnf update -y

  echo ">>> Installing dependencies..."
  sudo dnf install -y neovim git ripgrep golang xclip

  echo ">>> Installing gopls..."
  go install golang.org/x/tools/gopls@latest

  echo ">>> Installing Nerd Font (JetBrainsMono)..."
  sudo dnf install -y jetbrains-mono-fonts

  echo ""
  echo ">>> Fedora install complete!"
  echo "    Set your terminal font to 'JetBrainsMono Nerd Font' (or install a nerd font variant manually)"
  echo "    Add Go binaries to PATH: export PATH=\$PATH:\$(go env GOPATH)/bin"
}

copy_config() {
  local config_dir="$HOME/.config/nvim"
  if [[ -d "$config_dir" ]]; then
    echo ""
    read -rp ">>> $config_dir already exists. Overwrite? (y/N): " confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
      echo ">>> Skipping config copy."
      return
    fi
    rm -rf "$config_dir"
  fi
  mkdir -p "$config_dir"
  echo ">>> Created $config_dir"
  echo "    Place your init.lua inside: $config_dir/init.lua"
}

main() {
  detect_os
  case "$OS" in
    macos)  install_macos ;;
    arch)   install_arch ;;
    fedora) install_fedora ;;
  esac
  copy_config
  echo ""
  echo ">>> All done! Open neovim with: nvim"
  echo "    On first launch, plugins will be downloaded automatically."
}

main
