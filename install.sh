REPLACE_ALL=0
KEEP_BACKUPS=0
QUIET=0

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
function usage {
cat << EOF
usage: $0 options

This script will install these dotfiles into your \$HOME directory

OPTIONS:
   -h      Show this message
   -b      Backup file in the home before linking it
   -q      Disable output status messages
EOF
}

while getopts "bqh?" OPTION
do
     case $OPTION in
         b)
             KEEP_BACKUPS=1
             ;;
         q)
             QUIET=1
             ;;
         h)
             usage
             exit 1
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

function status {
	[[ $QUIET != 1 ]] && echo "$1"
}

function replace_file {
	if [[ $KEEP_BACKUPS != 0 ]]; then
		status "Backing up $1 to $1_bak"
		mv "$1" "$1_bak"
	else
		status "Deleting $1"
		rm -rf "$1"
	fi

	link_file "$1" "$2"
}

function link_file {
	status "Linking $2 -> $1"
	ln -s $2 $1
	status ""
}

for f in `ls -l | awk 'NR!=1 {print $NF}' | grep -v -E "README\.md|install\.sh|.*_private|.*_build"`; do
	# continue;
	file="$f"
	private_file="${file}_private"

	if [[ -f "$DIR/$private_file" ]]; then
		build_file="${f}_build"
		cat "$file" "$private_file" > "$build_file"
		file="$build_file"
	fi

	file_name="$HOME/.$f"

	if [[ -d "$f" ]]; then
		file_name="$HOME/$f"
	fi

	if [[ -e "$file_name" || -L "$file_name" ]]; then
		if [[ "$REPLACE_ALL" == 0 ]]; then
			read -p "Replace $file_name? [(y)es, (n)o, (a)ll, (q)uit]: " replace

			[[ "$replace" == "a" || "$replace" == "all" ]] && REPLACE_ALL=1

			REPLACE=0

			if [[ "$replace" == "q" || "$replace" == "quit" ]]; then
				exit 1;
			elif [[ "$replace" == "n" || "$replace" == "no" ]]; then
				status "Skipping $f";
				continue;
			elif [[ "$REPLACE_ALL" || "$replace" == "y" || "$replace" == "yes" ]]; then
				REPLACE=1
			fi
		else
			REPLACE=1
		fi

		[[ "$REPLACE" ]] && replace_file "$file_name" "$DIR/$file"
	else
		link_file "$file_name" "$DIR/$file"
	fi
done

status 'Installation successful. type "source ~/.bash_profile to kick things into gear (or just close and reopen this terminal window)".'
exit 0;