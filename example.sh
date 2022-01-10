#!/bin/sh
#
# An example cat implementation using petopts.sh option parsing.

options="h n v w:"
usage="[-hnv] [-w width] [file ...]"
version="cat version 1.0"

main() {
	[ "$opt_h" ] && usage
	[ "$opt_v" ] && version
	[ "$opt_w" ] &&
		case $arg_w in *[!0-9]*)
			die "invalid width: $arg_w"
		esac

	# Both options enable line numbers.
	if [ "$opt_n" ] || [ "$opt_w" ]; then
		withln=true
	else
		withln=false
	fi

	# Read from stdin if no files are specified.
	[ $# = 0 ] && set /dev/stdin

	for file do
		[ "$file" = - ] &&
			file=/dev/stdin

		! [ -e "$file" ] &&
			die "$file: No such file or directory"

		! [ -r "$file" ] &&
			die "$file: Permission denied"

		ln=1

		while IFS= read -r line || [ "$line" ]; do
			if "$withln"; then
				printf '%*s\t%s\n' "${arg_w:-6}" \
					"$ln" "$line"
				ln=$((ln+1))
			else
				printf '%s\n' "$line"
			fi
		done <"$file"
	done
}

die() { printf '%s: %s\n' "${0##*/}" "$*" >&2; exit 1; }
usage() { printf 'usage: %s %s\n' "${0##*/}" "$usage"; exit; }
version() { printf '%s\n' "$version"; exit; }

for o in $options; do unset "opt_${o%:}"; done

while getopts ":$options" o; do case $o in
	:) die "option requires an argument -- $OPTARG" ;;
	\?) die "unknown option -- $OPTARG" ;;
	*) eval "opt_$o=\$((opt_$o + 1)) arg_$o=\$OPTARG" ;;
esac; done; shift "$((OPTIND - 1))"

main "$@"