#!/bin/sh

options="a b: h v"
usage="[-ahv] [-b param] [operand ...]"
version="petops example version 6.9"

die() { printf '%s: %s\n' "${0##*/}" "$*" >&2; exit 1; }
usage() { printf 'usage: %s %s\n' "${0##*/}" "$usage"; exit; }
version() { printf '%s\n' "$version"; exit; }

for o in $options; do unset "opt_${o%:}"; done

while getopts ":$options" o; do case $o in
	:) die "option requires an argument -- $OPTARG" ;;
	\?) die "unknown option -- $OPTARG" ;;
	*) eval "opt_$o=\$((opt_$o + 1)) arg_$o=\$OPTARG" ;;
esac; done; shift "$((OPTIND - 1))"
