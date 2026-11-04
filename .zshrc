# # ==============================================================================
# 1. Environment & Path Configurations
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
export VISUAL="nvim"

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
fi

# Pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init - zsh)"
fi

# ==============================================================================
# 2. Oh My Zsh Settings & Plugins
# ==============================================================================
ZSH_THEME="agnoster"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
zstyle ':omz:update' mode reminder

plugins=(
    git
    autojump
    colored-man-pages
    copypath
    command-not-found
    fzf
    history-substring-search
    zsh-autosuggestions
    zsh-syntax-highlighting
    you-should-use
    zsh-bat
    web-search
)

source $ZSH/oh-my-zsh.sh

# ==============================================================================
# 3. History & Deduplication Options
# ==============================================================================
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"

setopt HIST_IGNORE_DUPS         # Ignore consecutive duplicate commands
setopt HIST_IGNORE_ALL_DUPS     # Remove older duplicate entries when a new one is run
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_SPACE        # Do not record commands starting with a space
setopt HIST_SAVE_NO_DUPS        # Do not save duplicate entries to disk
setopt HIST_FIND_NO_DUPS        # Skip duplicates when searching history

# ==============================================================================
# 4. Aliases
# ==============================================================================
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias cl='clear'
alias nVim='sudo -E nvim'
alias sVim='sudoedit'
alias emacs='emacs -nw'
alias vim='vimx'
alias nv='nvim'
alias v='nvim'
alias you='yt-dlp'
alias wininfo="sleep 2 && hyprctl activewindow"

# Display terminal colors matrix
alias tcolor='for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}$(printf "color%-4i" $i)%f" ; (( (i + 1) % 8 == 0 )) && print ; done'

# ==============================================================================
# 5. Functions & Integrations
# ==============================================================================
# Yazi CWD wrapper
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Zoxide (Directory navigation)
if command -v zoxide 1>/dev/null 2>&1; then
    eval "$(zoxide init zsh --cmd j)"
fi
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.local/share/gem/ruby/bin:$PATH"
export PATH="$HOME/ltex-ls-16.0.0/bin/:$PATH"

export GTK_IM_MODULE=simple

export ESCDELAY=25
