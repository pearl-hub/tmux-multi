TMUX-MULTI
==========

|Project Status|Communication|
|:-----------:|:-----------:|
|[![Build status](https://api.travis-ci.org/pearl-hub/tmux-multi.png?branch=master)](https://travis-ci.org/pearl-hub/tmux-multi) | [![Join the gitter chat at https://gitter.im/pearl-core/pearl](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/pearl-core/pearl?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) |

**Table of Contents**
- [Description](#description)
- [Quickstart](#quickstart)
- [Installation](#installation)
- [Troubleshooting](#troubleshooting)

Description
===========
- name: `tmux-multi`
- description: Run commands over multiple Tmux panes/windows
- author: Filippo Squillace
- username: fsquillace
- OS compatibility: linux, osx

Quickstart
==========
Given a list of commands from stdin, `tmux-multi` allows to
create multiple Tmux panes for each command:

```sh
echo -e "top\nbash\nssh localhost" | tmux-multi
```

If the number of panes generated exceeds the maximum value
(default 6), `tmux-multi` will create a new window instead.

The Tmux pane containing short lived programs (i.e. `ls`)
will close immediately and you will not be able to see the result.
For this, it is recommended to use the option `--keep-panes`,
for instance:

```sh
echo -e "ls -l\ntop" | tmux-multi --keep-panes
```

Alternatively, you can combine the command you want to run with the handy `watch` command:
```sh
echo -e "watch ls -l\ntop" | tmux-multi
```

To know all `tmux-multi` options: `tmux-multi --help`

Installation
============
This package needs to be installed via [Pearl](https://github.com/pearl-core/pearl) system.

```sh
pearl install tmux-multi
```

Dependencies
------------
The main dependencies are the following:

- [Pearl](https://github.com/pearl-core/pearl)
- [GNU coreutils](https://www.gnu.org/software/coreutils/)

Troubleshooting
===============
This section has been left blank intentionally.
It will be filled up as soon as troubles come in!

