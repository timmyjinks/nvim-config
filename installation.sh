#!/usr/bin/env bash
set -e

OS=""
DISTRO=""

detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
  elif [[ -f /etc/os-release ]]; then
    source /etc/os-release
    OS="$ID"
  else
    echo "Could not detect OS."
    exit 1
  fi
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
  cp init.lua $config_dir
}

copy_config
