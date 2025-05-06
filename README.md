 petopts
========================================================================

Portable and simple option parsing, powered by getopts(1p).

> pet /pɛt/ To stroke in a gentle or loving manner.

Unlike most (bash) option parser frameworks, where the complexity can
easily dwarf that of the actual script, petopts is purposefully made as
simple and concise as possible.


 Features
------------------------------------------------------------------------

* Easy to use
* Minimal/simple
* Portable
* No GNU style long options
* No optional parameters
* Count of option occurrences
* Short usage message
* Support `--` argument to indicates the end of the options
* Proper separation of option parsing and handling
* POSIX utility conventions compliance


 Usage
------------------------------------------------------------------------

### tl;dr

1. Copy the content of [petopts.sh](petopts.sh) to the top of a script
2. Change `options`, `usage` and `version`
3. Handle the parsed options and remaining operands

Given `options="a b: c"`, petopts would set `opt_a`, `opt_b` and `opt_c`
to the amount each of the options are supplied (empty if 0). `arg_b`
would contain the option argument of the -b option.


### Details

[petopts.sh](petopts.sh) is supposed to be used at the top of a script.
The following 3 variables have to be adapted:

`options`: A string containing the space separated list of alphanumeric
option characters. If a character is followed by a \<colon>, the option
shall be expected to have an argument.

`usage`: The string printed by the `usage()` function.

`version`: The string printed by the `version()` function.

For each option in the `options` variable, petopts will set
corresponding variables in the form of `opt_*` and `arg_*`, where `*` is
the option character. The `opt_*` variables will hold the number of
occurrences of the options (unset if an option does not occur), while
the `arg_*` variables store the option arguments (empty if an option has
no option argument).

After parsing the options, the positional parameters are shifted until
only operands remain.

For example, to conditionally do something with the option 'a', 'h' and
'v', we could do:

```sh
[ "$opt_h" ] && usage
[ "$opt_v" ] && version
[ "$opt_a" ] && printf 'Option a present with argument: %s\n' "$arg_a"
```

petopts provides the following functions:

`die()`: Prints its arguments using `warn()` and exits the script with
the exit status given by the first argument.

`warn()`: Prints its arguments to stderr, prefixed by the program name.

`usage()`: Prints the content of the `usage` variable and exits the
script with status 0.

`version()`: Prints the content of the `version` variable and exits the
script with status 0.

For a complete script using petopts, check [example.sh](example.sh).


 Usage of eval
------------------------------------------------------------------------

`eval` is considered dangerous because it can execute "dirty" data and
thus allow arbitrary code execution. However, how petopts uses `eval`,
to dynamically set the option variables, is totally safe.


 Limitations
------------------------------------------------------------------------

* No GNU style long options
* No optional parameters
