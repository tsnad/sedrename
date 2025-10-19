#!/usr/bin/env bash
# made by tsnad

#
# make gud
# maketh dank
#

if (( EUID == 0 )); then
	echo 'Renaming root files may cause undesired issues'
	exit 1
fi

# NON FUN FUNCTIONS

help_opt() {
	echo 'Usage: [OPTION] [SED ARGUMENTS] [DIRECTORY]' 
	printf "\n"
	echo 'Options:	-h, help
		-q, quiet
		-p, pretend
		-r, recursive
		-n, normalize (for command line use, replaces spaces with underscores,
	       			removes emojis, unicode characters, etc)
		-l, lowerize
		-u, undo (doesnt work with -l, -n, or -r)'
}

# INDIFFERENT FUNCTIONS

get_to_dir() {
	IFS=$'\n'

	DIR="$1"
	cd "$DIR" || exit 1
}

get_files() {
	FILES=($(find . -maxdepth 1 -type f -printf "%P\n" | grep -v -P "^\."))
}

# FUN FUNCTIONS

reg_opt() {
	get_to_dir "$1"
	get_files

	for line in "${FILES[@]}"; do
		mv $LOUD "$line" "$(echo "$line" | sed "$2")" 
	done

	save_last_arguments "$1" "$2"
	exit
}

pretend_opt() {
	get_to_dir "$1"
	get_files

	for line in "${FILES[@]}"; do
		echo "$line" '-->' "$(echo "$line" | sed "$2")" 
	done

	printf "\n"
	echo 'Example of what would be modified. Nothing was modified. DO NOT WORRY.'

	exit
}

normalizing_opt() {
	get_to_dir "$1"
	get_files

	for line in "${FILES[@]}"; do
		non_space_line=${line// /_}
		mv $LOUD "$line" "$(echo "$non_space_line" | iconv -c -f UTF-8 -t ASCII//TRANSLIT)"
	done

	exit
}

lowerizing_opt() {
	get_to_dir "$1"
	get_files

	for line in "${FILES[@]}"; do
		lower_line="${line,,}"
		mv $LOUD "$line" "$lower_line" 
	done

	exit
}

for_recursive_loop() {
	get_files

	for line in "${FILES[@]}"; do
		mv $LOUD "$line" "$(echo "$line" | sed "$1")" 
	done
}

recursive_opt() {
	get_to_dir "$1"
	for_recursive_loop "$2"

	SUBDIRS=($(find . -type d -printf "%P\n"))

	for SUBDIR in "${SUBDIRS[@]}"; do
		cd "$SUBDIR" || exit 1
		for_recursive_loop "$2"
		cd - &> /dev/null || exit 1
	done

	exit
}

undo_opt() {
	INVERSION=$(awk '(NR == 1) {print $0} \
		BEGIN {FS="/"; OFS="/"} \
		(NR == 2) {print $1,$3,$2,$4}' "$LASTCOMMAND")
	DIR="$(echo "$INVERSION" | head -n 1)"
	SED=$(echo "$INVERSION" | tail -n 1)

	IFS=$'\n'

	cd "$DIR" || exit 1

	get_files

	for line in "${FILES[@]}"; do
		mv $LOUD "$line" "$(echo "$line" | sed "$SED")" 
	done
	exit
}

save_last_arguments() {
	if [[ -n $1 ]] && [[ -n $2 ]]; then
		echo -e "$1\n$2\n" > $LASTCOMMAND
	fi
}

# MAIN FUNCTION

LASTCOMMAND="/tmp/last_sedrename_command.tmp"
LOUD='-v'

while getopts "hupqnrl" opt; do
	case "$opt" in
		h) help_opt && exit ;;
		u) undo_opt ;;
		p) pretend_opt "$3" "$2" ;;
		q) LOUD='' ;;
		n) normalizing_opt "$2" ;;
		l) lowerizing_opt "$2" ;;
		r) recursive_opt "$3" "$2" ;;
		\?) help_opt && exit 1;;
	esac
done

[[ -z $1 ]] && exit 1
[[ -z $2 ]] && exit 1

shift $(( OPTIND -1 ))
reg_opt "$2" "$1"

