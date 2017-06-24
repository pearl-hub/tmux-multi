# This module contains all functionalities needed for
# handling the txum core.
#
# Dependencies:
# - $PEARL_ROOT/lib/utils/utils.sh
#
# vim: ft=sh

# The maximum number of panes that are possible to have for
# each window
MAX_PPW=6
# Layout can be one of:
# - even-horizontal
# - even-vertical
# - main-horizontal
# - main-vertical
# - tiled
LAYOUT=tiled

DEFAULT_FILE=/dev/stdin

TMUX_CMD="tmux"

SHELL_DEFAULT=${SHELL:-/bin/sh}

function tmux_multi() {
    [[ -z $TMUX ]] && { die "Error: This command needs to run inside a Tmux session."; }

    local max_ppw=${1:-$MAX_PPW}
    local layout=${2:-$LAYOUT}
    local file=${3:-$DEFAULT_FILE}
    local keep_panes=${4:-false}

    local i=0
    while read cmd
    do
        $keep_panes && cmd="$cmd; $SHELL_DEFAULT"
        if [[ $(( $i % $max_ppw )) == 0 ]]; then
            $TMUX_CMD new-window "$cmd"
        else
            $TMUX_CMD split-window "$cmd"
            $TMUX_CMD select-layout $layout
        fi
        i=$((i +1))
    done < $file
}
