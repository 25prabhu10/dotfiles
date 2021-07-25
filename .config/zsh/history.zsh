HISTFILE=~/.cache/.zhistory
HISTSIZE=5000
SAVEHIST=5000
WORDCHARS=${WORDCHARS//\/[&.;]}         # Don't consider certain characters part of the word

# History command configuration
setopt HIST_IGNORE_ALL_DUPS             # If a new command is a duplicate, remove the older one
setopt APPEND_HISTORY                   # Immediately append history instead of overwriting
setopt EXTENDED_HISTORY                 # record timestamp of command in HISTFILE
setopt HIST_IGNORE_SPACE                # ignore commands that start with space
setopt HIST_VERIFY                      # show command with history expansion to user before running it
setopt SHARE_HISTORY                    # share command history data
