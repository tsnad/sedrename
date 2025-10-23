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
	echo 'Usage: [OPTION] [SED ARGUMENT] [DIRECTORY]' 
	printf "\n"
	echo 'Options:	-h, help
		-U, update (only works for $HOME/.local/bin/)
		-q, quiet
		-p, pretend
		-r, recursive
		-n, normalize (for command line use, replaces spaces with underscores,
	       			removes emojis, unicode characters, etc)
		-l, lowerize
		-u, undo (doesnt work with -l, -n, or -r)'
}

# INDIFFERENT FUNCTIONS

whoops() {
	tput setaf 196
	echo ERROR: "$1"
	tput sgr0
	help_opt
	exit 1
}

get_to_dir() {
	IFS=$'\n'

	DIR="$1"
	cd "$DIR" || whoops 'could not cd into directory'
}

get_files() {
	FILES=($(find . -maxdepth 1 -type f -printf "%P\n" | grep -v -P "^\."))
}

update_sedrename() {
	cd "$HOME"/.local/bin/ || \
		whoops "could not cd into $HOME/.local/bin/"
	wget -O "sedrename.sh" "$GITLINK" || \
		whoops 'could not get sedrename'
	chmod u+x sedrename.sh
	exit
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

	printf "\nExample of what would be modified. Nothing was modified. DO NOT WORRY.\n"

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
	INVERSION="$(awk '(NR == 1) {print $0} \
		BEGIN {FS="/"; OFS="/"} \
		(NR == 2) {print $1,$3,$2,$4}' "$LASTCOMMAND")"

	DIR="$(echo "$INVERSION" | head -n 1)"
	SED="$(echo "$INVERSION" | tail -n 1)"

	IFS=$'\n'

	cd "$DIR" || whoops 'could not cd into dir'

	get_files

	for line in "${FILES[@]}"; do
		LINE2="$(echo "$line" | sed $SED)"
		mv $LOUD "$line" "$LINE2"
	done

	save_last_arguments "$DIR" "$SED"

	exit
}

save_last_arguments() {
	if [[ -n $1 ]] && [[ -n $2 ]]; then
		echo -e "$1\n$2\n" > $LASTCOMMAND
	fi
}

# MAIN FUNCTION

GITLINK="https://raw.githubusercontent.com/tsnad/sedrename/refs/heads/master/sedrename.sh"
LASTCOMMAND="/tmp/last_sedrename_command.tmp"
LOUD='-v'

while getopts "hUupqnrl" opt; do
	case "$opt" in
		h) help_opt && exit ;;
		U) update_sedrename ;;
		u) undo_opt ;;
		p) pretend_opt "$3" "$2" ;;
		q) LOUD='' ;;
		n) normalizing_opt "$2" ;;
		l) lowerizing_opt "$2" ;;
		r) recursive_opt "$3" "$2" ;;
		\?) help_opt && exit 1;;
	esac
done

[[ -z $1 ]] && whoops 'missing args'
[[ -z $2 ]] && whoops 'missing args'

shift $(( OPTIND -1 ))
reg_opt "$2" "$1"

