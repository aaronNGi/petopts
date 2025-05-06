#!/usr/bin/env bash

readonly options=(a b: h v)
readonly usage="[-ahv] [-b param] [operand ...]"
readonly version="petops example version 6.9"

die() { warn "${@:2}"; exit "$1"; }
warn() { printf '%s: %s\n' "${0##*/}" "$*" >&2; }
usage() { printf 'usage: %s %s\n' "${0##*/}" "$usage"; exit; }
version() { printf '%s\n' "$version"; exit; }

typeset -A arg opt
while getopts ":${options[*]}" o; do case $o in
	:) die 1 "option requires an argument -- $OPTARG" ;;
	\?) die 1 "unknown option -- $OPTARG" ;;
	*) ((opt[$o]++)); arg[$o]=$OPTARG ;;
esac; done; shift "$((OPTIND - 1))"
