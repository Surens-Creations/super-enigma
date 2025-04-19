#!/bin/bash

echo "🔄 Setting up symlinks..."
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
mkdir -p "$HOME/.config"
ln -sf "$HOME/.dotfiles/starship/starship.toml" "$HOME/.config/starship.toml"

echo "✅ Dotfiles linked!"