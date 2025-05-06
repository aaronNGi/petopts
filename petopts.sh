#!/bin/sh

options="a b: h v"
usage="[-ahv] [-b param] [operand ...]"
version="petops example version 6.9"

die() { rc=$1; shift; warn "$@"; exit "$rc"; }
warn() { printf '%s: %s\n' "${0##*/}" "$*" >&2; }
usage() { printf 'usage: %s %s\n' "${0##*/}" "$usage"; exit; }
version() { printf '%s\n' "$version"; exit; }

for o in $options; do unset "opt_${o%:}"; done

while getopts ":$options" o; do case $o in
	:) die 1 "option requires an argument -- $OPTARG" ;;
	\?) die 1 "unknown option -- $OPTARG" ;;
	*) eval "opt_$o=\$((opt_$o + 1)) arg_$o=\$OPTARG" ;;
esac; done; shift "$((OPTIND - 1))"
