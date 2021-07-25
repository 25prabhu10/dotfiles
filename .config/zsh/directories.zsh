# Changing/making/removing directory
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS                    # Remove duplicate entries
setopt PUSHD_MINUS                          # This reverts the +/- operators.

_comp_options+=(globdots)                   # Include hidden files.
