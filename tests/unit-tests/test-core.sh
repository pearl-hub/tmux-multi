#!/usr/bin/env bash
source "$(dirname $0)/../utils/utils.sh"

pearlSetUp
source $PEARL_ROOT/lib/utils/utils.sh
source "$(dirname $0)/../../lib/core.sh"

# Disable the exiterr
set +e

function oneTimeSetUp(){
    setUpUnitTests
}

function oneTimeTearDown(){
    pearlTearDown
}

function setUp(){
    cwdSetUp
    # Suppose we are in a tmux session as default
    TMUX=in-tmux
}

function tearDown(){
    cwdTearDown
}

function test_txum_no_tmux_defined(){
    unset TMUX
    assertCommandFailOnStatus 1 tmux_multi
}

function test_tmux_multi_from_stdin(){
    tmux_command(){
        echo "tmux $@"
    }
    TMUX_CMD=tmux_command
    echo -e "top" | assertCommandSuccess tmux_multi
    assertEquals "$(echo -e "tmux new-window top")" "$(cat $STDOUTF)"
}

function test_tmux_multi_multiple_windows(){
    tmux_command(){
        echo "tmux $@"
    }
    TMUX_CMD=tmux_command
    echo -e "top\ntop\ntop\ntop" | assertCommandSuccess tmux_multi 2
    assertEquals "$(echo -e "tmux new-window top\ntmux split-window top\ntmux select-layout tiled\ntmux new-window top\ntmux split-window top\ntmux select-layout tiled")" "$(cat $STDOUTF)"
}

function test_tmux_multi_different_layout(){
    tmux_command(){
        echo "tmux $@"
    }
    TMUX_CMD=tmux_command
    echo -e "top\ntop" | assertCommandSuccess tmux_multi 6 even-horizontal
    assertEquals "$(echo -e "tmux new-window top\ntmux split-window top\ntmux select-layout even-horizontal")" "$(cat $STDOUTF)"
}

function test_tmux_multi_keep_panes(){
    tmux_command(){
        echo "tmux $@"
    }
    TMUX_CMD=tmux_command
    echo -e "top\ntop" | assertCommandSuccess tmux_multi 6 tiled "" true
    assertEquals "$(echo -e "tmux new-window top; $SHELL\ntmux split-window top; $SHELL\ntmux select-layout tiled")" "$(cat $STDOUTF)"
}

function test_tmux_multi_from_file(){
    echo -e "top\ntop" > myfile
    tmux_command(){
        echo "tmux $@"
    }
    TMUX_CMD=tmux_command
    assertCommandSuccess tmux_multi 6 tiled myfile
    assertEquals "$(echo -e "tmux new-window top\ntmux split-window top\ntmux select-layout tiled")" "$(cat $STDOUTF)"
}

source $(dirname $0)/../utils/shunit2
