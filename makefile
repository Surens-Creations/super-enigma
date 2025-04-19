# Terminal Upgrade Installer via Make

BREW_PACKAGES = zsh tmux starship fzf bat eza zsh-autosuggestions zsh-syntax-highlighting
CASK_FONTS = font-jetbrains-mono font-fira-code

ZSH_CUSTOM = $(HOME)/.oh-my-zsh/custom
DOTFILES_DIR = $(CURDIR)
CONFIG_DIR = $(HOME)/.config

.PHONY: all install uninstall brew fonts ohmyzsh symlinks platform-check

all: install

install: platform-check brew fonts ohmyzsh symlinks
	@echo "\n✅ All done! Restart your terminal or run: exec zsh"

uninstall:
	@echo "🧼 Uninstalling dotfiles..."
	@rm -f $(HOME)/.zshrc
	@rm -f $(HOME)/.tmux.conf
	@rm -f $(CONFIG_DIR)/starship.toml
	@rm -rf $(HOME)/.tmux/plugins/tpm
	@echo "❌ Removed symlinks and TPM"

platform-check:
	@UNAME_S := $(shell uname -s)
	@echo "🧭 Detected OS: $$(uname -s)"

brew:
	@echo "🔧 Installing Homebrew packages..."
	@brew update
	@brew install $(BREW_PACKAGES)
	@brew tap homebrew/cask-fonts || true

fonts:
	@if [ "$$(uname -s)" = "Darwin" ]; then \
		echo "🔤 Installing fonts..."; \
		brew install --cask $(CASK_FONTS); \
	else \
		echo "🪟 Skipping fonts – not macOS"; \
	fi

ohmyzsh:
	@if [ ! -d "$$HOME/.oh-my-zsh" ]; then \
		echo '💻 Installing Oh My Zsh...'; \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
	fi
	@mkdir -p $(ZSH_CUSTOM)/themes
	@git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $(ZSH_CUSTOM)/themes/powerlevel10k || true

symlinks:
	@echo "🔗 Linking dotfiles..."
	@ln -sf $(DOTFILES_DIR)/zsh/.zshrc $(HOME)/.zshrc
	@ln -sf $(DOTFILES_DIR)/tmux/.tmux.conf $(HOME)/.tmux.conf
	@mkdir -p $(CONFIG_DIR)
	@ln -sf $(DOTFILES_DIR)/starship/starship.toml $(CONFIG_DIR)/starship.toml
	@mkdir -p $(HOME)/.tmux/plugins
	@git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm || true