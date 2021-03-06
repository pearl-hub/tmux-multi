#!/usr/bin/env bash
PKG_ROOT="$(dirname $0)/../.."
source "$PKG_ROOT/tests/bunit/utils/utils.sh"
source "$PKG_ROOT/tests/test-utils/utils.sh"

pearlSetUp
source $PKG_ROOT/bin/tmux-multi -h &> /dev/null

# Disable the exiterr
set +e

function oneTimeSetUp(){
    setUpUnitTests
}

function oneTimeTearDown(){
    pearlTearDown
}

function setUp(){
    :
}

function tearDown(){
    :
}

function cli_wrap(){
    parse_arguments "$@"
    check_cli
    execute_operation
}

function tmux_multi(){
    echo "tmux_multi $@"
}

function test_help(){
    assertCommandSuccess cli_wrap -h
    cat $STDOUTF | grep -q "tmux-multi"
    assertEquals 0 $?
    assertCommandSuccess cli_wrap --help
    cat $STDOUTF | grep -q "tmux-multi"
    assertEquals 0 $?
    assertCommandSuccess cli_wrap help
    cat $STDOUTF | grep -q "tmux-multi"
    assertEquals 0 $?
    assertCommandSuccess cli_wrap h
    cat $STDOUTF | grep -q "tmux-multi"
    assertEquals 0 $?
}

function test_tmux_multi(){
    assertCommandSuccess cli_wrap -m 8 -l even-horizontal -f myfile -k
    assertEquals "$(echo -e "tmux_multi 8 even-horizontal myfile true")" "$(cat $STDOUTF)"
    cat $STDERRF

    assertCommandSuccess cli_wrap --max-panes-per-window 8 --layout even-horizontal --file-commands myfile --keep-panes
    assertEquals "$(echo -e "tmux_multi 8 even-horizontal myfile true")" "$(cat $STDOUTF)"
}

function test_check_cli(){
    assertCommandFail cli_wrap -h -m mymppw
    assertCommandFail cli_wrap -h -l mylayout
    assertCommandFail cli_wrap -h -f myfile
    assertCommandFail cli_wrap myarg
}

source $PKG_ROOT/tests/bunit/utils/shunit2
