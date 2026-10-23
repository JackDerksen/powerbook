#
# ~/.zshrc
#

[[ -o interactive ]] || return

########################################
# History
########################################
HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_find_no_dups

########################################
# Homebrew
########################################
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

########################################
# PATH (centralized)
########################################
path=(
  $HOME/bin
  $HOME/.local/bin
  $HOME/.cargo/bin
  /opt/homebrew/opt/rustup/bin
  $path
)

########################################
# Skim colours
########################################
export SKIM_DEFAULT_OPTIONS='--color=bg:#1A191C,current_bg:#2D2B30,fg:#67656F,current:#E2E2E3,matched:#FC808F,matched_bg:#1A191C,current_match:#9BE3ED,current_match_bg:#2D2B30,spinner:#9BE3ED,header:#FC808F,info:#333138,cursor:#9BE3ED,selected:#B4BEFE,prompt:#67656F,border:#222125'

if command -v sk >/dev/null; then
  autoload -Uz compinit
  compinit
  source <(sk --shell zsh --shell-bindings)
fi

########################################
# Colours
########################################
export CLICOLOR=1

########################################
# grep
########################################
if command -v ggrep >/dev/null; then
  alias grep='ggrep --color=auto'
else
  alias grep='grep --color=auto'
fi

########################################
# Keybindings
########################################
bindkey -e
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

########################################
# Aliases
########################################
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

########################################
# Prompt & Navigation
########################################
command -v starship >/dev/null && eval "$(starship init zsh)"
command -v zoxide  >/dev/null && eval "$(zoxide init zsh)"

########################################
# Bun
########################################
export BUN_INSTALL="$HOME/.bun"
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"
path=("$BUN_INSTALL/bin" $path)

########################################
# Autosuggestions
########################################
AUTOSUGGEST_FILE="/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -f $AUTOSUGGEST_FILE ]] && source "$AUTOSUGGEST_FILE"

bindkey '^I' autosuggest-accept
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
