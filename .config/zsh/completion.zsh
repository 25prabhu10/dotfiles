zmodload -i zsh/complist

#WORDCHARS=''

unsetopt MENU_COMPLETE   # do not autoselect the first completion entry
unsetopt FLOW_CONTROL
setopt AUTO_MENU         # show completion menu on successive tab press
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# Autocomplete
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'          # Case insensitive tab completion
zstyle ':completion:*' special-dirs true                                                            # Complete . and .. special directories

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 'ow=31;40'                                    # Colored completion (different colors for dirs/files/etc)

#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
#zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"
# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

zstyle '*' single-ignored show
zstyle ':completion:*' rehash true                                                                  # automatically find new executables in path

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
