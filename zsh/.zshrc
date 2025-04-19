export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Custom additions
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
eval "$(starship init zsh)"
alias exa='eza'