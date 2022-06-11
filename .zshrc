# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export LANG=en_IN.UTF-8                                         # system language environment

# dircolors is a GNU utility that's not on macOS by default. With this not
# being used on macOS it means zsh's complete menu won't have colors.
if command -v dircolors > /dev/null 2>&1; then
    if [[ -f ~/.dir_colors ]]; then
        eval "$(dircolors -b ~/.dir_colors)"
    else
        eval "$(dircolors -b)"
    fi
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='/usr/bin/vi'
else
  export EDITOR='/usr/bin/nvim'
fi
#export VISUAL=/usr/bin/nano


## Custom alias
alias ls='ls --color=auto'
alias ll='ls -ahl'
alias llt='ls -alrht'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'
alias dirs='dirs -v'
alias cls='clear'
alias tmux='tmux -u2'
alias dotconfig='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes


# Use neovim for vim if present.
#[ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"
alias vim="nvim" vimdiff="nvim -d"


## Custom functions
# git add, commit and push to the repo
function lazygit() {
    git add .
    git commit -m "$1"
    git push
}


## Options section
unsetopt CASE_GLOB                                              # Case insensitive globbing
setopt NO_BEEP                                                  # No beep
setopt EXTENDED_GLOB                                            # Extended globbing. Allows using regular expressions with *
setopt RC_EXPAND_PARAM                                          # Array expension with parameters
setopt CHECK_JOBS                                               # Warn about running processes when exiting
setopt NUMERIC_GLOB_SORT                                        # Sort filenames numerically when it makes sense
setopt AUTO_CD                                                  # if only directory path is entered, cd there.
setopt PROMPT_SUBST                                             # enable substitution for prompt
setopt INTERACTIVE_COMMENTS                                     # recognize comments


# compinit: auto/tab complete
# colors: prompt colors
# zcalc: zsh calculator
autoload -U compinit colors zcalc
compinit -d
colors

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

export XDG_CONFIG_HOME=$HOME/.config/

# Don't put duplicate lines or lines starting with space in the history.
# Hide sensitive commands by adding a space at the start
# See bash(1) for more options
# export HISTCONTROL=ignoreboth

# Set time stamp for bash commands in history
# Will not work with zsh, look it up for solutions
# export HISTTIMEFORMAT="%Y-%m-%d %T "

# Load histroy config
source ~/.config/zsh/history.zsh

# Load completion config
source ~/.config/zsh/completion.zsh

# Load directories config
source ~/.config/zsh/directories.zsh

# Load functions
source ~/.config/zsh/functions.zsh

# Load functions
source ~/.config/zsh/key-bindings.zsh


## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# Use autosuggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# nvm support
#[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
#source /usr/share/nvm/nvm.sh
#source /usr/share/nvm/bash_completion
#source /usr/share/nvm/install-nvm-exec

# fzf support
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --color=always --exclude .git'
export FZF_DEFAULT_OPTS="--ansi"
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Customized prompt using starship
eval "$(starship init zsh)"
